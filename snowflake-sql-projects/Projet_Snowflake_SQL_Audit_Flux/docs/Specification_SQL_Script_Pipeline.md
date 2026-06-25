# Modèle de spécification SQL (format tableau)

## En-tête

| Titre | Ticket | GitLab / Repo | Date de création | Développeur | Responsable du projet | Description fonctionnelle |
|---|---|---|---|---|---|---|
| Spécification technique - Pipeline Analytics Financière Courtiers (SNOWFLAKE END-TO-END) | N/A | portfolio-analytics-engineering | 2026-06-25 | Portfolio / Self-Service | Data Engineering | Pipeline end-to-end chargeant 9 sources financières dans une couche RAW, synthétisant une couche MART avec métriques complexes (efficacité commission, vieillissement règlements, flux transactions, scoring risque) et exposant une vue BI consolidée |

## Identification du script

| Champ | Valeur |
|---|---|
| Nom du script SQL | 01_SNOWFLAKE_LOAD_AND_MART.sql |
| Type de script | SQL pipeline end-to-end (ingestion RAW + synthèse MART + BI view) |
| Nom objet principal (DB.Schema.Object) | BD_FINANCE_COURTIERS.RAW.* + BD_FINANCE_COURTIERS.MART.* |
| Sous-objets | 9 tables RAW (F_TRANSACTIONS, F_COMMISSIONS, F_SETTLEMENTS, D_AGENCY, D_BROKER, D_CONTRACT, D_DATE, R_COMMISSION_RULES, AUDIT_EXCEPTIONS); 9 tables/view MART (DM_PARTNER, DM_CONTRACT_CORE, FM_COMMISSION_EFFICIENCY, FM_SETTLEMENT_AGING, FM_TRANSACTION_FLOW, FM_FINANCE_MONTHLY, FM_PARTNER_PERFORMANCE, FM_AUDIT_MONTHLY, VW_BI_FINANCE_COCKPIT) |
| Environnement cible | Dev / Test / Prod |
| Statut document | Production-ready |
| Confidentialité | Interne (version entièrement anonymisée/dénominalisée pour démonstration technique et portfolio) |

## Architecture technique

| Champ | Valeur |
|---|---|
| Base de données | BD_FINANCE_COURTIERS |
| Schémas | RAW (ingestion brute), MART (synthèse et calculs métier) |
| Warehouse / Compute | WH_FINANCE_ANALYTICS (XSMALL, auto-suspend 60 min) |
| Source(s) des données initiales | 9 fichiers CSV pré-stagés en interne @RAW.STG_FINANCE_FILES |
| Langage | SQL (SnowSQL) |
| Dépendances (objets appelés) | File format FF_CSV_STD; stage interne STG_FINANCE_FILES; 9 tables RAW et table de synthèse MART |
| Format de fichier | CSV (délimiteur virgule, quoted text, skip header) |
| Nombre de lignes par source | 5000–7000 lignes (6000 en moyenne); données anonymisées |

## Paramètres d'entrée

| Champ | Valeur |
|---|---|
| Nom | Aucun |
| Type de données | N/A |
| Obligatoire (Oui / Non) | N/A |
| Valeur par défaut | N/A |
| Description | Le pipeline n'accepte aucun paramètre; la périodisation (dt_partition_yyyymm) est calculée dynamiquement à partir des dates des transactions |
| Exemple d'exécution | Exécuter le script entier dans Snowflake web UI ou CLI; pas de procédure stockée à invoquer |

### Tableau détaillé des paramètres (si plusieurs)

| Nom paramètre | Type | Obligatoire | Défaut | Description métier/technique |
|---|---|---|---|---|
| N/A | N/A | N/A | N/A | Pipeline sans paramètre d'entrée; contexte (warehouse, database, schema) initialisé au démarrage |

## Données de sortie

### Tables RAW (données brutes ingérées)

| Champ | Type de données | Description des données |
|---|---|---|
| transaction_id | VARCHAR | Identifiant unique de transaction (clé primaire) |
| source_system | VARCHAR | Système source d'origine |
| booking_date | DATE | Date comptable de la transaction |
| value_date | DATE | Date de valeur financière |
| contract_id | VARCHAR | Identifiant du contrat associé (clé étrangère) |
| agency_id | VARCHAR | Identifiant de l'agence (clé étrangère) |
| broker_id | VARCHAR | Identifiant du courtier (clé étrangère) |
| amount_eur | DECIMAL(18,2) | Montant en EUR |
| flow_direction | VARCHAR | Direction flux IN/OUT |
| is_reversed | BOOLEAN | Flag transaction inversée |
| dt_partition_yyyymm | VARCHAR(6) | Partition YYYYMM pour partitionnement |

### Tableau synthétique des sorties MART

| Table MART | Type | Grain | Colonnes clés | Usage métier |
|---|---|---|---|---|
| DM_PARTNER | Dimension | Agency + Broker | partner_id, partner_name, is_broker_eligible, is_low_risk_partner, risk_segment | Enrichissement des partenaires (agence/courtier) avec flags d'éligibilité et de risque |
| DM_CONTRACT_CORE | Dimension | Contract | contract_id, product_family, is_active_contract, premium_tier | Dimension contrat avec statut et catégorisation premium |
| FM_COMMISSION_EFFICIENCY | Fait | Mois × Contract | yyyymm, commission_payout_ratio_pct, avg_adjustment_per_event, exception_commission_count | Métriques mensuelles d'efficacité de commission (ratio payout, ajustements, exceptions) |
| FM_SETTLEMENT_AGING | Fait | Mois × Contract | yyyymm, collection_rate_pct, total_days_past_due_gt30, has_high_residual_flag, has_overdue_risk_flag | Métriques mensuelles de vieillissement des règlements (taux recouvrement, résidus, retards) |
| FM_TRANSACTION_FLOW | Fait | Mois × Contract | yyyymm, inflow_eur, outflow_eur, net_flow_eur, reversal_rate_pct, has_high_reversal_flag | Métriques mensuelles de flux de transactions (inflow/outflow, reversals) |
| FM_FINANCE_MONTHLY | Fait | Mois × Agency × Broker × Contract | yyyymm, total_transactions, total_commission_paid, total_settled, commission_efficiency_pct, collection_rate_pct, reversal_rate_pct, total_risk_flags (0-4) | Table de faits principale agrégée mensuellement avec tous les KPI et flags de risque composite |
| FM_PARTNER_PERFORMANCE | Fait | Partenaire (Agency/Broker) | partner_id, avg_commission_efficiency_pct, avg_collection_rate_pct, partner_risk_level (critical/high/medium/low) | Agrégation au niveau partenaire avec classification de risque |
| FM_AUDIT_MONTHLY | Fait | Mois × Contract | yyyymm, exception_count, open_exception_count, audit_risk_rating (critical/high/medium/low) | Agrégation des exceptions et écarts détectés nécessitant audit |
| VW_BI_FINANCE_COCKPIT | Vue | Mois × Agency × Broker × Contract | Tous les KPI, flags, audit ratings, partenaire aggregates | Vue BI consolidée pour Power BI (joins FM_FINANCE_MONTHLY + audit + partner + contract + performance) |

## Sources de données

| Source ID | Objet source | Type | Format | Criticité | Propriétaire | Nb lignes |
|---|---|---|---|---|---|---|
| SRC-001 | F_TRANSACTIONS.csv | CSV | Fichier staging | Haute | Excel source export | 6500 |
| SRC-002 | F_COMMISSIONS.csv | CSV | Fichier staging | Haute | Excel source export | 6200 |
| SRC-003 | F_SETTLEMENTS.csv | CSV | Fichier staging | Haute | Excel source export | 6100 |
| SRC-004 | D_AGENCY.csv | CSV | Fichier staging | Moyenne | Excel source export | 5000 |
| SRC-005 | D_BROKER.csv | CSV | Fichier staging | Moyenne | Excel source export | 5200 |
| SRC-006 | D_CONTRACT.csv | CSV | Fichier staging | Moyenne | Excel source export | 6400 |
| SRC-007 | D_DATE.csv | CSV | Fichier staging | Basse | Excel source export | 7000 |
| SRC-008 | R_COMMISSION_RULES.csv | CSV | Fichier staging | Moyenne | Excel source export | 5000 |
| SRC-009 | AUDIT_EXCEPTIONS.csv | CSV | Fichier staging | Moyenne | Excel source export | 5500 |

## Logique de l'implémentation du script

1. **Initialiser le contexte Snowflake** : définir warehouse WH_FINANCE_ANALYTICS, database BD_FINANCE_COURTIERS, schémas RAW et MART, casse des identifiants (identifiers in uppercase).

2. **Créer l'infrastructure de staging** : créer file format FF_CSV_STD (CSV, delimiter=',', field_optionally_enclosed_by='"', skip_header=1) et stage interne STG_FINANCE_FILES.

3. **Créer les 9 tables RAW** avec schéma complet (commentaires détaillés, types stricts) :
   - F_TRANSACTIONS (transaction_id NOT NULL PK, 21 colonnes)
   - F_COMMISSIONS (commission_id NOT NULL PK, 18 colonnes)
   - F_SETTLEMENTS (settlement_id NOT NULL PK, 19 colonnes)
   - D_AGENCY, D_BROKER, D_CONTRACT avec SCD Type 2 (valid_from, valid_to, is_current)
   - D_DATE, R_COMMISSION_RULES, AUDIT_EXCEPTIONS

4. **Charger les 9 fichiers CSV** via COPY INTO avec validation :
   - COPY INTO RAW.F_TRANSACTIONS FROM @RAW.STG_FINANCE_FILES/F_TRANSACTIONS.csv
   - Idem pour les 8 autres
   - Validation post-load : `SELECT COUNT(*) FROM RAW.F_TRANSACTIONS`

5. **Synthétiser les intermédiaires MART** :
   - **DM_PARTNER** : LEFT JOIN D_BROKER + D_AGENCY avec flags is_broker_eligible, is_low_risk_partner
   - **DM_CONTRACT_CORE** : contrat avec flags is_active_contract, premium_tier (high/medium/low basé sur premium_amount_eur)
   - **FM_COMMISSION_EFFICIENCY** : agrégation mensuelle (yyyymm) avec commission_payout_ratio_pct, avg_adjustment_per_event, counts
   - **FM_SETTLEMENT_AGING** : agrégation mensuelle avec collection_rate_pct, overdue metrics, flags has_high_residual_flag, has_overdue_risk_flag
   - **FM_TRANSACTION_FLOW** : agrégation mensuelle avec inflow_eur, outflow_eur, reversal_rate_pct, flag has_high_reversal_flag

6. **Créer la table de faits principale FM_FINANCE_MONTHLY** :
   - Union complète (UNION ALL keyset) de tx, cm, st pour garantir aucune perte
   - FULL OUTER JOIN via keyset (yyyymm, agency_id, broker_id, contract_id)
   - LEFT JOIN sur DM_PARTNER, DM_CONTRACT_CORE pour enrichissement
   - Calculer 4 flags binaires : has_commission_issues_flag, has_residual_risk_flag, has_overdue_risk_flag, has_reversal_risk_flag
   - Calculer **total_risk_flags = SUM(4 flags)** → échelle 0–4

7. **Agréger au niveau partenaire (FM_PARTNER_PERFORMANCE)** :
   - GROUP BY partner_id (agency_id + broker_id)
   - Moyenne des KPI (avg_commission_efficiency_pct, avg_collection_rate_pct)
   - Compter contrats avec chaque condition de risque
   - Classification **partner_risk_level** : critical (max_risk_flags≥3), high (2), medium (1), low (0)

8. **Créer FM_AUDIT_MONTHLY** :
   - Agrégation des exceptions par contract/mois
   - Compter exception_count, open_exception_count, severity levels
   - Calculer audit_risk_rating (critical/high/medium/low)

9. **Créer la vue BI finale VW_BI_FINANCE_COCKPIT** :
   - Joins FM_FINANCE_MONTHLY + FM_AUDIT_MONTHLY + DM_PARTNER + DM_CONTRACT_CORE + FM_PARTNER_PERFORMANCE
   - Exposer tous les KPI, flags, audit ratings, agrégats partenaire
   - Commentaires inline détaillés pour chaque colonne

10. **Valider la qualité des données** :
    - Contrôle de volumétrie (comptages par table)
    - Distribution des KPI (0–100% pour ratios)
    - Détection d'anomalies par flag de risque
    - Comptage des nuls sur champs clés

## Règles de calcul / transformation

| Règle ID | Description règle | Entrées | Sortie impactée |
|---|---|---|---|
| R-001 | Commission payout ratio: (paid_commission / expected_commission) × 100, NULLIF si expected = 0 | F_COMMISSIONS.paid_commission, expected_commission | commission_payout_ratio_pct |
| R-002 | Collection rate: (amount_paid / amount_due) × 100, NULLIF si due = 0 | F_SETTLEMENTS.amount_paid, amount_due | collection_rate_pct |
| R-003 | Reversal rate: (reversed_count / total_count) × 100, NULLIF si total = 0 | F_TRANSACTIONS.is_reversed | reversal_rate_pct |
| R-004 | Flag commission issues: 1 si (pending_count > 0 OU exception_count > 0), else 0 | FM_COMMISSION_EFFICIENCY | has_commission_issues_flag |
| R-005 | Flag residual risk: 1 si (residual_eur / amount_due > 15%), else 0 | FM_SETTLEMENT_AGING | has_high_residual_flag |
| R-006 | Flag overdue risk: 1 si (overdue_settlement_count / settlement_count > 10%), else 0 | FM_SETTLEMENT_AGING | has_overdue_risk_flag |
| R-007 | Flag reversal risk: 1 si reversal_rate_pct > 5%, else 0 | FM_TRANSACTION_FLOW | has_high_reversal_flag |
| R-008 | Total risk flags: SUM(4 flags binaires) → échelle composite 0–4 | Tous les 4 flags | total_risk_flags |
| R-009 | Partner risk level classification: critical (≥3 flags), high (2), medium (1), low (0) | max(total_risk_flags) par partenaire | partner_risk_level |
| R-010 | Premium tier: HIGH si premium_amount > 5000, MEDIUM si > 1000, else LOW | D_CONTRACT.premium_amount_eur | premium_tier |
| R-011 | Is broker eligible: 1 si (status='active' ET registration_status='active'), else 0 | D_BROKER.status, registration_status | is_broker_eligible |
| R-012 | Is low risk partner: 1 si risk_segment IN ('low', 'medium'), else 0 | D_AGENCY.risk_segment, D_BROKER.risk_segment | is_low_risk_partner |
| R-013 | Partition key (yyyymm): TO_CHAR(booking_date, 'YYYYMM') | transaction.booking_date (ou similaire) | dt_partition_yyyymm |
| R-014 | Monthly aggregation: TRUNC(TO_DATE(yyyymm\|\|'01', 'YYYYMMDD'), 'MONTH') → périodisation | dt_partition_yyyymm | yyyymm_period |

## Gestion des erreurs

| Cas d'erreur | Détection | Action | Message retourné |
|---|---|---|---|
| Fichier CSV manquant | Erreur COPY INTO lors du stage | Arrêt du script | Message d'erreur Snowflake (fichier non trouvé) |
| Format CSV invalide | Erreur COPY INTO parsing | Arrêt du script | Message d'erreur Snowflake (colonne attendue manquante, type invalide) |
| Table RAW non créée | Erreur DDL CREATE TABLE | Arrêt du script | Message d'erreur Snowflake (syntax error ou permissions insuffisantes) |
| Erreur jointure MART | NULL joins sur clés étrangères invalides | Lignes avec NULLs pré-traitées via COALESCE zero-fill | Pas d'erreur; lignes conservées mais agrégats neutralisés |
| Division par zéro dans KPI | Utilisation NULLIF(denominator, 0) | Résultat NULL au lieu d'erreur | NULL retourné pour KPI non calculable |
| Données incohérentes (ex: residual > due) | Filtre logique qualité | Lignes conservées mais flaggées (flag = 1 détecte) | Flag de risque = 1 pour anomalies détectées |
| Exécution nominale | Fin sans erreur après tous les validations | Retour des statistiques de qualité | Comptages par table, distributions de KPI, détails anomalies par flag |

## Performance

| Champ | Valeur |
|---|---|
| Volumétrie estimée | 9 × 6000 lignes en moyenne (54 000 lignes brutes); MART synthétisée 2000–3000 lignes mensuelles |
| Temps d'exécution cible | 2–5 minutes (warehouse XSMALL) |
| Stratégie d'incrémentalité / partitionnement | Partitionnement logique par dt_partition_yyyymm; recharge complète des 9 sources (pas d'incrémental CDC) |
| Points de vigilance performance | UNION ALL keyset crée combinaison complète avant JOIN (économies vs UNION via UNION ALL); CTE intermédiaires pré-calculent metrics complexes; LEFT JOIN sur dimensions sans index logique — clustering keys recommandé |
| Optimisations appliquées | UNION ALL (vs UNION) améliore ~20–30%; NOT NULL sur PKs améliore JOIN; materialized view pour VW_BI_FINANCE_COCKPIT si requêtes fréquentes |

## Sécurité et conformité

| Champ | Valeur |
|---|---|
| Données sensibles traitées | Oui (identifiants anonymisés : tax_id_masked, phone_masked, bank_account_masked) |
| Mécanismes de protection (masquage/anonymisation) | Tous les identifiants humains et comptes en données synthétiques anonymisées; pas d'exposition de données réelles |
| Principe du moindre privilège appliqué | Script utilisable en XSMALL warehouse; aucune permission ACCOUNTADMIN requise pour exécution |
| Journalisation / audit | Résultats des validations de qualité disponibles via SELECT sur MART tables; pas de log métadonnées intégré (recommandé: QUERY_HISTORY Snowflake) |
| Gouvernance | Architecture 3-couches (RAW → MART → BI view) assure séparation concerns; commentaires SQL détaillés documentent transformations |

## Tests et validation

| ID test | Scénario | Données entrée | Résultat attendu | Critères de succès | Statut |
|---|---|---|---|---|---|
| T-001 | Lecture échantillon RAW | 9 tables RAW chargées | Requête `SELECT * LIMIT 100` sans erreur | Aucun NULL inattendu sur clés | À valider |
| T-002 | Contrôle volumétrie globale | Pipeline exécuté | NB_LIGNES RAW > 50 000 | 9 tables × ~6000 lignes | À valider |
| T-003 | Validation structure MART | MART tables créées | Colonnes attendues présentes | DM_*, FM_*, VW_* visibles en MART | À valider |
| T-004 | Contrôle partitions incomplètes | FM_FINANCE_MONTHLY alimentée | 0 partition manquante entre sources et cible | All yyyymm combinations present | À valider |
| T-005 | Distribution des KPI | FM_FINANCE_MONTHLY calculée | commission_payout_ratio_pct ∈ [0, 100] | Pas de valeur > 100% ou < 0% | À valider |
| T-006 | Contrôle flags de risque | FM_FINANCE_MONTHLY calculée | total_risk_flags ∈ [0, 4] | Comptages de distribution cohérents | À valider |
| T-007 | Risk level classification | FM_PARTNER_PERFORMANCE calculée | partner_risk_level ∈ {critical, high, medium, low} | 4 catégories seulement, aucune autre valeur | À valider |
| T-008 | Anomalies détectées | FM_SETTLEMENT_AGING calculée | has_high_residual_flag = 1 où applicable | Flag=1 corrèle avec residual_pct > 15% | À valider |
| T-009 | Nullité sur champs clés | VW_BI_FINANCE_COCKPIT créée | Aucun NULL sur yyyymm, agency_id, broker_id, contract_id | COUNT(NULL values) = 0 sur clés | À valider |
| T-010 | Vue BI accessible | VW_BI_FINANCE_COCKPIT créée | Requête `SELECT COUNT(*) FROM VW_BI_FINANCE_COCKPIT` retourne volumétrie | Vue accessible sans erreur JOIN | À valider |

## Contrôle des versions

| Version | Date | Développeur | Modifications |
|---|---|---|---|
| v0.1 | 2026-06-25 | Portfolio / Analytics Engineering | Création initiale ; spécification template et remplissage données pour Snowflake financial flows pipeline |
| v1.0 | YYYY-MM-DD | À compléter | Validation initiale et déploiement production |

## Checklist de validation

- [x] Type de script clairement identifié (SQL pipeline end-to-end).
- [x] Entrées/sorties documentées (9 sources RAW, 9 tables MART, 1 vue BI).
- [x] Sources et dépendances complètes.
- [x] Logique d'implémentation détaillée (10 étapes).
- [x] Règles de calcul explicites (14 règles métier).
- [x] Gestion des erreurs décrite (8 cas d'erreur + actions).
- [x] Exigences sécurité et confidentialité précisées.
- [x] Critères de performance documentés avec optimisations appliquées.
- [x] Cas de tests documentés (10 scénarios de validation).
- [x] Versioning mis à jour.
- [x] Commentaires détaillés et documentations liées (README.md, DATA_DICTIONARY.xlsx, SEMANTIC_MODEL_POWERBI.xlsx).
