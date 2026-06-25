# Projet Snowflake SQL - Audit Flux & Analytics Financière Courtiers. Version anonymisée pour portfolio public.

## Vue d'ensemble

Ce projet présente une implémentation SQL industrialisée pour alimenter un pipeline analytique complet dans Snowflake.

Il repose sur une architecture end-to-end ingérant **9 sources de données financières** dans une couche RAW, puis synthétisant une couche MART avec des calculs métier complexes : efficacité de commission, vieillissement des règlements, flux de transactions, scoring de risque et suivi des exceptions d’audit.

Le pipeline expose une vue BI consolidée destinée à l’analytics et au reporting.

---

## Dimension métier

Ce projet s'adresse aux équipes métier **Finance** et **Risk Management** : pilotage commercial, analyse des portefeuilles, contrôle de gestion, ainsi qu'aux équipes data en charge de la préparation des datasets de reporting et analytics.

Il sert à répondre à des questions de pilotage essentielles :

- Quelle est la performance de commission par partenaire, agence ou courtier ?
- Comment évolue le vieillissement des règlements et quels risques de liquidité existent ?
- Quel est le score de risque global par contrat et partenaire ?
- Quelles anomalies et exceptions nécessitent un audit ?

Concrètement, il fournit une base fiable pour :

- suivre les KPIs opérationnels mensuels : taux d'efficacité, taux de recouvrement, taux de reversal ;
- disposer d'une vision consolidée des transactions, commissions et règlements par partenaire ;
- scorer automatiquement le risque à partir de 4 critères : commission, résidus, retards de paiement, reversals ;
- alimenter des dashboards Power BI avec un chargement fiable, structuré et traçable.

Dans le secteur financier, ce type de dispositif est important car il permet de relier la qualité des données transactionnelles, la performance commerciale et le profil de risque des partenaires. Il soutient ainsi le pilotage des réseaux de distribution, l'analyse des performances et la prise de décision à partir d'un socle de données stabilisé.

---

## Objectifs du projet

- Structurer une alimentation SQL fiable, lisible et maintenable pour le reporting financier end-to-end.
- Ingérer 9 sources de données depuis des fichiers Excel dans une couche RAW standardisée.
- Synthétiser une couche MART avec des calculs KPI complexes et des flags de risque.
- Implémenter un système de scoring de risque composite.
- Exposer une vue BI consolidée pour l'analytics sans logique de calcul côté client.
- Garantir la traçabilité et la qualité des données avec des validations et contrôles.
- Documenter la logique technique et métier du pipeline.

---

## Méthodes et approche technique

- **Architecture 3 couches** : Staging → RAW → MART.
- **Tables de dimensions et de faits** avec logique historisée.
- **SCD Type 2** : `valid_from`, `valid_to`, `is_current`.
- **Agrégation mensuelle** sur partitions `dt_partition_yyyymm`.
- **Scoring composite** : 4 flags binaires → `total_risk_flags`, sur une échelle de 0 à 4.
- **Joins complets via keyset** pour garantir la complétude des données.
- **Calculs de KPI** avec normalisations, gestion des divisions par zéro et traitement des valeurs nulles.
- **Contrôles qualité** sur les volumes, distributions de KPI et anomalies détectées.

---

## Logique du pipeline

1. Initialiser le contexte Snowflake : warehouse, database, schemas RAW et MART, file format.
2. Créer l'infrastructure : stage interne, tables RAW et structures de chargement.
3. Charger les données depuis les fichiers sources.
4. Synthétiser les intermédiaires MART :
   - `DM_PARTNER` : enrichissement broker / agency avec flags d'éligibilité et de risque ;
   - `DM_CONTRACT_CORE` : dimension contrat avec flags et catégorisation premium ;
   - `FM_COMMISSION_EFFICIENCY` : métriques mensuelles de commission ;
   - `FM_SETTLEMENT_AGING` : métriques mensuelles de règlement ;
   - `FM_TRANSACTION_FLOW` : métriques mensuelles de flux ;
   - `FM_AUDIT_MONTHLY` : agrégation des exceptions par contrat.
5. Créer la table de faits principale `FM_FINANCE_MONTHLY`.
6. Calculer les flags et le score de risque.
7. Agréger au niveau partenaire avec `FM_PARTNER_PERFORMANCE`.
8. Exposer la vue BI `VW_BI_FINANCE_COCKPIT`.
9. Valider la qualité des données et la cohérence des indicateurs.

---

## Script d'exécution

| Script | Description |
|---|---|
| [`01_SNOWFLAKE_LOAD_AND_MART.sql`](sql/01_SNOWFLAKE_LOAD_AND_MART.sql) | Pipeline SQL end-to-end chargeant les 9 sources, créant les couches RAW et MART, calculant les KPIs métier et exposant une vue BI consolidée. |

---

## Documentation technique

| Document | Description |
|---|---|
| [`Specification_SQL_Script_Pipeline.md`](docs/Specification_SQL_Script_Pipeline.md) | Spécification technique détaillée du pipeline SQL : architecture, étapes de traitement, tables créées, logique de calcul, contrôles qualité et hypothèses métier. |

---

## Fichiers de données sources

Les fichiers sources sont stockés dans le dossier [`sources/`](sources/).

| Fichier | Description |
|---|---|
| [`F_TRANSACTIONS.xlsx`](sources/F_TRANSACTIONS.xlsx) | Transactions avec direction des flux, reversals et partitionnement mensuel. |
| [`F_COMMISSIONS.xlsx`](sources/F_COMMISSIONS.xlsx) | Commissions attendues, commissions payées, ajustements et exceptions. |
| [`F_SETTLEMENTS.xlsx`](sources/F_SETTLEMENTS.xlsx) | Montants dus, payés, résiduels, statuts et retards de règlement. |
| [`D_AGENCY.xlsx`](sources/D_AGENCY.xlsx) | Dimension agences avec historique de type SCD. |
| [`D_BROKER.xlsx`](sources/D_BROKER.xlsx) | Dimension courtiers avec historique de type SCD. |
| [`D_CONTRACT.xlsx`](sources/D_CONTRACT.xlsx) | Dimension contrats avec informations contractuelles et catégorisation. |
| [`D_DATE.xlsx`](sources/D_DATE.xlsx) | Dimension calendrier fiscal avec jours ouvrables et jours fériés. |
| [`R_COMMISSION_RULES.xlsx`](sources/R_COMMISSION_RULES.xlsx) | Référentiel des règles de commission avec conditions et efficacité. |
| [`AUDIT_EXCEPTIONS.xlsx`](sources/AUDIT_EXCEPTIONS.xlsx) | Exceptions et écarts détectés nécessitant analyse ou audit. |

---

## Valeur apportée

- **Performance** : tables synthétisées pré-calculées, plus rapides qu'une vue recalculée à chaque requête.
- **Transparence métier** : logique de calcul explicite, documentée et auditable.
- **Complétude des données** : joins complets limitant les pertes d'information.
- **Scoring de risque robuste** : système composite fondé sur 4 dimensions de risque.
- **Readiness BI** : vue consolidée prête pour Power BI sans transformation côté client.
- **Validation continue** : contrôles qualité intégrés pour détecter les anomalies à chaque chargement.
- **Maintenabilité** : séparation claire entre sources, logique SQL, documentation et couche analytique.

---

## Compétences démontrées

- Snowflake SQL
- Data warehousing
- Architecture RAW / MART
- Modélisation dimensionnelle
- Tables de faits et dimensions
- SCD Type 2
- Data quality checks
- KPI engineering
- Risk scoring
- Pipeline SQL end-to-end
- Documentation technique
- Préparation de données pour BI
- Structuration de projet analytics engineering

---

## Confidentialité et adaptation publique

> Ce projet est **entièrement dénominalisé et adapté pour une démonstration publique**.
>
> Aucune dénomination réelle n'est exposée dans ce repository : ni bases de données, ni schémas, ni tables, ni warehouses, ni référentiels internes, ni labels métier sensibles.
>
> Tous les noms techniques utilisés dans ce projet sont génériques et représentatifs d'une architecture standard.
>
> Toutes les données dans les fichiers Excel sont synthétiques et anonymisées : identifiants masqués, montants et dates randomisés, absence de correspondance avec des entités réelles.
>
> Le code SQL et la documentation reflètent une approche de production complète : architecture, patterns, calculs métier, gouvernance et contrôles qualité, sans exposition de système interne.

