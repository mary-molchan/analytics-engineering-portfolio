# Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs

## 🔒 Confidentialité et adaptation publique

Ce projet est **entièrement anonymisé et adapté pour une démonstration publique**. Aucune dénomination réelle n'est exposée dans ce repository : **ni bases de données, ni schémas, ni tables, ni warehouses, ni identifiants métier internes**. Tous les noms techniques, référentiels et éléments sensibles ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

## 🗂️ Contexte du projet

> **Domaine** : assurance / finance  
> **Taille de l'organisation** : grand groupe international  
> **Mon rôle** : Data Analytics Engineer  
> **Mon apport** : j'ai conçu, structuré et documenté un pipeline SQL Snowflake modulaire pour préparer les données de performance financière des apporteurs, automatiser les calculs de collecte / décollecte et fiabiliser l'alimentation des reportings décisionnels.

## 📌 Public cible

Ce projet est destiné aux équipes métier en charge de la distribution, du pilotage commercial et du contrôle de gestion, ainsi qu’aux équipes data responsables de l’alimentation des reportings décisionnels. Il vise à fournir une base analytique fiable pour suivre la performance des réseaux d’apporteurs et soutenir la prise de décision métier.

## 🎯 Objectifs métier du projet

Ce projet répond à un besoin de pilotage commercial des réseaux d’apporteurs, en consolidant les indicateurs de collecte, décollecte et encours dans une base fiable pour l’analyse décisionnelle.

- Identifier les apporteurs qui contribuent le plus à la collecte nette.
- Suivre la dynamique de collecte et de décollecte par période.
- Analyser l’évolution des encours associés aux portefeuilles distribués.
- Détecter les signaux de ralentissement commercial ou de risque business.
- Prioriser les actions d’animation réseau, de développement commercial et de rétention client.
- Fournir aux équipes métier des indicateurs consolidés pour soutenir la prise de décision.

## ⚙️ Objectifs techniques du projet

Pour répondre au besoin de pilotage métier décrit ci-dessus, ce projet vise à industrialiser la préparation des données apporteurs dans Snowflake.

- Structurer un pipeline analytique fiable, lisible et maintenable.
- Centraliser l'initialisation technique : variables de session, paramètres d'exécution, chemins sources et cibles.
- Supprimer la logique dupliquée entre les procédures SQL.
- Standardiser l'exécution via une procédure orchestratrice avec contrôle de statut.
- Fiabiliser le calcul des indicateurs de collecte, décollecte et encours.
- Produire une base de données consolidée, directement exploitable pour le reporting décisionnel.

## 🧩 Méthodes et approche technique

L’approche technique repose sur une structuration modulaire du traitement SQL afin de rendre le pipeline plus lisible, maintenable et contrôlable.

- Procédures stockées SQL modulaires, spécialisées par responsabilité.
- CTE pour clarifier les étapes de transformation.
- MERGE / UPDATE pour charger et synchroniser les tables cibles.
- Filtrage par partition `AAAAMM` pour un traitement incrémental et cohérent.
- Vérification préalable des données sources avant exécution métier.
- Journalisation de sortie : statut, durée, utilisateur, rôle, période traitée.

## 🔄 Logique du code

Le code suit une séquence d’exécution standardisée, depuis l’initialisation du contexte jusqu’au retour d’un résultat d’orchestration exploitable pour le suivi.

1. Initialiser le contexte d'exécution et les variables partagées.
2. Calculer la période de traitement et valider la présence des données sources.
3. Exécuter le calcul des flux de collecte / décollecte par apporteur.
4. Exécuter le calcul des statistiques apporteurs et des indicateurs d'encours.
5. Retourner un résultat d'orchestration exploitable pour le suivi.

## 🔢 Ordre d'exécution

| Étape | Script | Description |
|---|---|---|
| 1 | [`sql/01_initialization.sql`](sql/01_initialization.sql) | Initialise les objets, tables et paramètres techniques requis. |
| 2 | [`sql/02_sp_calc_app_stats.sql`](sql/02_sp_calc_app_stats.sql) | Collecte et structure la liste des apporteurs nécessaires au traitement analytique. |
| 3 | [`sql/03_sp_calc_collect_app.sql`](sql/03_sp_calc_collect_app.sql) | Calcule les indicateurs financiers des apporteurs : collecte, décollecte, encours et statistiques associées. |
| 4 | [`sql/04_sp_orchestrate_apporteurs.sql`](sql/04_sp_orchestrate_apporteurs.sql) | Orchestre l'exécution du pipeline et standardise les mises à jour rapides des données. |

## 📚 Documentation

La documentation technique du projet est organisée autour des principales procédures stockées du pipeline.  
Chaque document décrit le rôle de la procédure, sa logique de traitement, ses paramètres, ses contrôles et sa contribution au flux global.

#### 1. Collecte des apporteurs

[`02_sp_calc_app_stats_specification.md`](docs/specifications/02_sp_calc_app_stats_specification.md)  
Spécifications techniques pour la création d'une procédure stockée permettant de collecter et structurer la liste des apporteurs nécessaires au traitement analytique.

#### 2. Calcul des indicateurs financiers

[`03_sp_calc_collect_app_specification.md`](docs/specifications/03_sp_calc_collect_app_specification.md)  
Spécifications techniques pour la création d'une procédure stockée dédiée au calcul des indicateurs financiers des apporteurs : collecte, décollecte, encours et statistiques associées.

#### 3. Orchestration du pipeline

[`04_sp_orchestrate_apporteurs_specification.md`](docs/specifications/04_sp_orchestrate_apporteurs_specification.md)  
Spécifications techniques pour la création d'une procédure stockée orchestrée, permettant de standardiser l'exécution du pipeline, contrôler les statuts et accélérer les mises à jour des données.

## 💡 Valeur apportée

Ce projet apporte de la valeur à la fois sur le plan technique, opérationnel et décisionnel, en rendant le pipeline plus fiable, plus lisible et plus facilement réutilisable.

- **Complexité opérationnelle réduite** : architecture modulaire séparant l’initialisation, les calculs métier et l’orchestration.
- **Maintenabilité renforcée** : logique SQL factorisée, moins de duplication et meilleure lisibilité du code.
- **Exécution fiabilisée** : contrôles explicites, validation des données sources et sortie d’exécution standardisée.
- **Reporting plus stable** : préparation cohérente des indicateurs de collecte, décollecte et encours pour les reportings décisionnels.
- **Reprise facilitée** : documentation technique alignée avec le code afin de simplifier la maintenance, l’évolution et le transfert de connaissance.
