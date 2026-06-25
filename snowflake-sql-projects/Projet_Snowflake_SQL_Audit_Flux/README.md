# Projet Snowflake SQL - Pipeline Analytics Financière Courtiers (version portfolio)

## Vue d'ensemble

Ce projet présente une implémentation SQL industrialisée pour alimenter un pipeline analytique complet dans Snowflake. Il repose sur une architecture end-to-end ingérant 9 sources de données financières dans une couche RAW, puis synthétisant une couche MART avec des calculs métier complexes (efficacité de commission, vieillissement des règlements, flux de transactions, scoring de risque). Le pipeline expose une vue BI consolidée pour l'analytics et le reporting.

## Dimension métier (pourquoi et pour qui)

Ce projet s'adresse aux équipes métier Finance et Risk Management (pilotage commercial, analyse des portefeuilles, contrôle de gestion) ainsi qu'aux équipes data en charge de la préparation des datasets de reporting et analytics.

Il sert à répondre à des questions de pilotage essentielles :

- Quel est la performance de commission par partenaire (agence/courtier) ?
- Comment évolue le vieillissement des règlements et quels risques de liquidité existe-t-il ?
- Quel est le score de risque global par contrat et partenaire ?
- Quelles anomalies et exceptions nécessitent un audit ?

Concrètement, il fournit une base fiable pour :

- Suivre les KPIs opérationnels mensuels (taux d'efficacité, taux de recouvrement, taux de reversal).
- Disposer d'une vision consolidée des transactions, commissions et règlements par partenaire.
- Scorer automatiquement le risque à partir de 4 critères (commission, résidus, retards de paiement, reversals).
- Alimenter les dashboards Power BI avec un chargement fiable et traçable.

Dans le secteur financier, ce type de dispositif est important car il permet de relier la qualité des données transactionnelles, la performance commerciale et le profil de risque des partenaires. Il soutient ainsi le pilotage des réseaux de distribution, l'analyse des performances et la prise de décision à partir d'un socle de données stabilisé.

## Objectif du projet

- Structurer une alimentation SQL fiable, lisible et maintenable pour le reporting financier end-to-end.
- Ingérer 9 sources de données depuis des fichiers CSV dans une couche RAW standardisée.
- Synthétiser une couche MART avec des calculs KPI complexes et des flags de risque.
- Implémenter un système de scoring de risque composite (agrégation de 4 critères binaires).
- Exposer une vue BI consolidée pour l'analytics sans logique de calcul côté client.
- Garantir la traçabilité et la qualité des données avec des validations et contrôles.

## Méthodes et approche technique

- **Architecture 3 couches** : Staging (CSV) → RAW (ingestion brute) → MART (synthèse et calculs métier)
- **Tables de dimension et de faits** avec historique (SCD Type 2 : valid_from, valid_to, is_current)
- **Agrégation mensuelle** sur partitions dt_partition_yyyymm pour performance
- **Système de scoring composite** : 4 flags binaires (commission_issues, residual_risk, overdue_risk, reversal_risk) → total_risk_flags (échelle 0-4)
- **Joins complets via UNION ALL keyset** pour garantir la complétude des données
- **Calculs de KPI** avec normalisations (taux en %), gestion des divisions par zéro (NULLIF), coalesce pour les NULL
- **Validations de qualité** sur les volumes, les distributions de KPI, les anomalies détectées par flag de risque

## Logique du code

1. **Initialiser le contexte Snowflake** : warehouse, database, schemas (RAW et MART), file format CSV.
2. **Créer l'infrastructure** : stage interne STG_FINANCE_FILES, 9 tables RAW avec colonnes commentées.
3. **Charger les données** : COPY INTO depuis CSV avec validation post-load.
4. **Synthétiser les intermédiaires MART** :
   - DM_PARTNER : enrichissement broker/agency avec flags d'éligibilité et de risque
   - DM_CONTRACT_CORE : dimension contrat avec flags et catégorisation premium
   - FM_COMMISSION_EFFICIENCY : métriques mensuelles de commission (ratio payout, ajustements, exceptions)
   - FM_SETTLEMENT_AGING : métriques mensuelles de règlement (taux de recouvrement, résidus, retards)
   - FM_TRANSACTION_FLOW : métriques mensuelles de flux (inflow/outflow, reversals)
   - FM_AUDIT_MONTHLY : agrégation des exceptions par contrat
5. **Synthétiser la table de faits principale** : FM_FINANCE_MONTHLY (union complète de tous les flux avec calcul des flags et du score de risque)
6. **Agréger au niveau partenaire** : FM_PARTNER_PERFORMANCE (moyennes, classification de risque)
7. **Exposer la vue BI** : VW_BI_FINANCE_COCKPIT (joins finaux pour analytics sans logique côté client)
8. **Valider la qualité** : contrôles de volumétrie, distributions de KPI, anomalies par critère de risque.

## Scripts pour exécution

[`01_SNOWFLAKE_LOAD_AND_MART.sql`](01_SNOWFLAKE_LOAD_AND_MART.sql) : Pipeline end-to-end (~1200 lignes, commenté en détail) chargeant les 9 sources et synthétisant la couche MART avec tous les calculs métier.

## Documentation du script

- [`DATA_DICTIONARY.xlsx`](DATA_DICTIONARY.xlsx) : Dictionnaire exhaustif des 169 colonnes des 9 tables sources avec descriptions, types, rôles (PK/FK/BK)
- [`SEMANTIC_MODEL_POWERBI.xlsx`](SEMANTIC_MODEL_POWERBI.xlsx) : Spécification du modèle sémantique (9 tables, 19 relations actives, 6 rôles de date, 8 mesures DAX, règles de gouvernance)
- [`SEMANTIC_MODEL_POWERBI.drawio`](SEMANTIC_MODEL_POWERBI.drawio) : Diagramme ERD visuel (dimensions bleu, faits orange, 19 relations actives + 5 relations optionnelles)

## Fichiers de données

9 fichiers Excel anonymisés et de qualité production (6000–7000 lignes chacun) :
- **F_TRANSACTIONS.xlsx** (6500 lignes) : transactions avec direction flux, reversals, partitionnement mensuel
- **F_COMMISSIONS.xlsx** (6200 lignes) : commissions attendues/payées, ajustements, exceptions
- **F_SETTLEMENTS.xlsx** (6100 lignes) : montants dus/payés/résiduels, statuts, retards
- **D_AGENCY.xlsx** (5000 lignes) : dimensions agences avec historique SCD Type 2
- **D_BROKER.xlsx** (5200 lignes) : dimensions courtiers avec historique SCD Type 2
- **D_CONTRACT.xlsx** (6400 lignes) : dimensions contrats avec historique SCD Type 2
- **D_DATE.xlsx** (7000 lignes) : calendrier fiscal avec jours ouvrables et jours fériés
- **R_COMMISSION_RULES.xlsx** (5000 lignes) : règles de commission avec conditions et efficacité
- **AUDIT_EXCEPTIONS.xlsx** (5500 lignes) : exceptions et écarts détectés nécessitant audit

## Valeur apportée

- **Performance** : Tables synthétisées pré-calculées bien plus rapides qu'une vue recalculée à chaque requête.
- **Transparence métier** : Logique de calcul explicite et documentée, facilement auditable et maintenable.
- **Complétude des données** : Joins complets garantissent aucune perte d'informations même en cas de données manquantes.
- **Scoring de risque robuste** : Système composite (4 dimensions) plus fiable qu'un indicateur unique.
- **Readiness BI** : Vue consolidée VW_BI_FINANCE_COCKPIT prête pour Power BI sans transformation côté client.
- **Validation continue** : Contrôles de qualité intégrés détectent les anomalies à chaque chargement.

## Confidentialité et adaptation publique

> Ce projet est **entièrement dénominalisé et adapté pour une démonstration publique**.
> 
> Aucune dénomination réelle n'est exposée dans ce repository : **ni bases de données, ni schémas, ni tables, ni warehouses, ni référentiels internes, ni labels métier sensibles**.
> 
> Tous les noms techniques (F_TRANSACTIONS, D_AGENCY, FM_COMMISSION_EFFICIENCY, VW_BI_FINANCE_COCKPIT, etc.) sont génériques et représentatifs d'une architecture standard.
> 
> Toutes les données dans les 9 fichiers Excel sont synthétiques et anonymisées : identifiants masqués (tax_id_masked, phone_masked, bank_account_masked), montants et dates randomisés, pas de correspondance avec des entités réelles.
> 
> Le code SQL et la documentation reflètent une approche de production complète : architecture, patterns, calculs métier, gouvernance — utile pour portfolio et démonstration technique, sans exposition de système interne.

