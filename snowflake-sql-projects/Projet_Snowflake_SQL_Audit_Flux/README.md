# Pipeline SQL d’audit des flux et d’analytics financière courtiers

## 🔒 Confidentialité et adaptation publique

Ce projet est **entièrement anonymisé et adapté pour une démonstration publique**. Aucune dénomination réelle n'est exposée dans ce repository : **ni bases de données, ni schémas, ni tables, ni warehouses, ni référentiels internes, ni labels métier sensibles**. Tous les noms techniques, fichiers, structures et éléments sensibles ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

## 🗂️ Contexte du projet

> **Domaine** : assurance / finance
> **Taille de l'organisation** : grand groupe international  
> **Mon rôle** : Data Analytics Engineer  
> **Mon apport** : j'ai conçu, structuré et documenté un pipeline SQL Snowflake end-to-end permettant d’ingérer 9 sources financières, de construire une couche MART analytique, de calculer des KPIs de performance et de risque, puis d’exposer une vue BI consolidée pour le reporting décisionnel.

## 📌 Public cible

Ce projet est destiné aux équipes métier Finance, Risk Management, pilotage commercial et contrôle de gestion, ainsi qu’aux équipes data responsables de la préparation des datasets de reporting et d’analytics. Il vise à fournir une base analytique fiable pour suivre la performance financière des partenaires, analyser les flux, détecter les anomalies et soutenir la prise de décision.

## 🎯 Objectifs métier du projet

Ce projet répond à un besoin de pilotage financier des courtiers et partenaires, en consolidant les transactions, commissions, règlements, exceptions d’audit et indicateurs de risque dans une base fiable pour l’analyse décisionnelle.

- Mesurer la performance de commission par partenaire, agence ou courtier.
- Suivre l’évolution des règlements, des retards et des risques de liquidité.
- Consolider les transactions, commissions et règlements dans une vision analytique unique.
- Calculer un score de risque global par contrat et partenaire.
- Identifier les anomalies, exceptions et situations nécessitant un audit.
- Alimenter des dashboards BI avec des indicateurs fiables, traçables et pré-calculés.

## ⚙️ Objectifs techniques du projet

Pour répondre au besoin de pilotage métier décrit ci-dessus, ce projet vise à industrialiser la préparation des données financières dans Snowflake, depuis l’ingestion des sources jusqu’à la création d’une vue BI consolidée.

- Structurer une alimentation SQL fiable, lisible et maintenable pour le reporting financier end-to-end.
- Ingérer 9 sources de données financières dans une couche RAW standardisée.
- Synthétiser une couche MART avec des calculs KPI complexes et des flags de risque.
- Implémenter un système de scoring de risque composite fondé sur plusieurs critères métier.
- Exposer une vue BI consolidée pour l’analytics sans logique de calcul côté client.
- Garantir la traçabilité et la qualité des données avec des validations et contrôles.
- Documenter la logique technique et métier du pipeline.

## 🧩 Méthodes et approche technique

L’approche technique repose sur une architecture analytique en plusieurs couches, afin de séparer l’ingestion brute, les transformations métier, les agrégations et l’exposition BI.

- Architecture 3 couches : Staging → RAW → MART.
- Tables de dimensions et de faits avec logique historisée.
- Gestion de l’historique avec SCD Type 2 : `valid_from`, `valid_to`, `is_current`.
- Agrégation mensuelle sur partitions `dt_partition_yyyymm`.
- Scoring composite : 4 flags binaires consolidés dans `total_risk_flags`, sur une échelle de 0 à 4.
- Joins complets via keyset pour garantir la complétude des données.
- Calculs de KPI avec normalisations, gestion des divisions par zéro et traitement des valeurs nulles.
- Contrôles qualité sur les volumes, distributions de KPI et anomalies détectées.

## 🔄 Logique du code

Le code suit une séquence d’exécution end-to-end, depuis l’initialisation du contexte Snowflake jusqu’à l’exposition d’une vue BI consolidée et exploitable pour le reporting.

1. Initialiser le contexte Snowflake : warehouse, database, schemas RAW et MART, file format.
2. Créer l’infrastructure technique : stage interne, tables RAW et structures de chargement.
3. Charger les données depuis les fichiers sources.
4. Synthétiser les intermédiaires MART :
   - `DM_PARTNER` : enrichissement broker / agency avec flags d’éligibilité et de risque ;
   - `DM_CONTRACT_CORE` : dimension contrat avec flags et catégorisation premium ;
   - `FM_COMMISSION_EFFICIENCY` : métriques mensuelles de commission ;
   - `FM_SETTLEMENT_AGING` : métriques mensuelles de règlement ;
   - `FM_TRANSACTION_FLOW` : métriques mensuelles de flux ;
   - `FM_AUDIT_MONTHLY` : agrégation des exceptions par contrat.
5. Créer la table de faits principale `FM_FINANCE_MONTHLY`.
6. Calculer les flags métier et le score de risque.
7. Agréger les indicateurs au niveau partenaire avec `FM_PARTNER_PERFORMANCE`.
8. Exposer la vue BI `VW_BI_FINANCE_COCKPIT`.
9. Valider la qualité des données et la cohérence des indicateurs.

## 🔢 Ordre d'exécution

| Étape | Script | Description |
|---|---|---|
| 1 | [`sql/01_SNOWFLAKE_LOAD_AND_MART.sql`](sql/01_SNOWFLAKE_LOAD_AND_MART.sql) | Pipeline SQL end-to-end chargeant les 9 sources, créant les couches RAW et MART, calculant les KPIs métier et exposant une vue BI consolidée. |

## 📚 Documentation

La documentation technique du projet décrit l’architecture du pipeline, les étapes de traitement, les tables créées, la logique de calcul, les contrôles qualité et les hypothèses métier.

#### 1. Spécification technique du pipeline SQL

[`Specification_SQL_Script_Pipeline.md`](docs/Specification_SQL_Script_Pipeline.md)  
Spécification technique détaillée du pipeline SQL : architecture, étapes de traitement, tables créées, logique de calcul, contrôles qualité, scoring de risque et hypothèses métier.

## 📂 Fichiers de données sources

Les fichiers sources sont stockés dans le dossier [`sources/`](sources/). Ils représentent des données financières synthétiques, anonymisées et adaptées pour une démonstration publique.

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

## 💡 Valeur apportée

Ce projet apporte de la valeur à la fois sur le plan technique, opérationnel et décisionnel, en rendant le pipeline financier plus performant, plus transparent et plus facilement exploitable pour le reporting.

- **Performance renforcée** : tables synthétisées pré-calculées, plus rapides qu’une vue recalculée à chaque requête.
- **Transparence métier** : logique de calcul explicite, documentée et auditable.
- **Complétude des données** : joins complets limitant les pertes d’information entre les différents flux.
- **Scoring de risque robuste** : système composite fondé sur plusieurs dimensions de risque.
- **Readiness BI** : vue consolidée prête pour Power BI sans transformation côté client.
- **Validation continue** : contrôles qualité intégrés pour détecter les anomalies à chaque chargement.
- **Maintenabilité renforcée** : séparation claire entre sources, logique SQL, documentation et couche analytique.
