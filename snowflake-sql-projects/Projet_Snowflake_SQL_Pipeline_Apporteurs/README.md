# Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs *(version anonymisée pour portfolio public)*

Ce projet presente une implementation SQL industrialisee pour le pilotage des indicateurs apporteurs dans Snowflake: calcul des collectes/decollectes, consolidation des encours et orchestration complete du traitement.

## Dimension metier (pourquoi et pour qui)
Ce projet s'adresse aux equipes metier Assurance (distribution, pilotage commercial, finance/controle de gestion) ainsi qu'aux equipes data qui alimentent les reportings decisionnels.

Il sert a repondre a des questions essentielles de pilotage:
- Quels apporteurs contribuent le plus a la collecte nette?
- Quelle est la dynamique collecte/decollecte par periode?
- Comment evoluent les encours associes aux portefeuilles distribues?

Concretement, il fournit une base fiable pour:
- Suivre la performance commerciale des reseaux d'apporteurs.
- Detecter les signaux de ralentissement ou de risque (hausse des decollectes).
- Prioriser les actions de developpement, d'animation reseau et de retention client.

Dans le secteur de l'assurance, ce type d'analyse est strategique car il relie directement la production commerciale, la stabilite des encours et la qualite du portefeuille dans le temps. Il contribue donc a une meilleure allocation des efforts commerciaux, a la maitrise des risques business et a la prise de decision fondee sur des indicateurs consolides.

## Objectif du projet
- Structurer un pipeline analytique fiable, lisible et maintenable.
- Centraliser l'initialisation technique (variables de session, chemins sources/cibles).
- Supprimer la logique dupliquee entre procedures.
- Standardiser l'execution via une procedure orchestratrice avec controle de statut.

## Methodes et approche technique
- Procedures stockees SQL modulaires (specialisation par responsabilite).
- CTE pour clarifier les etapes de transformation.
- MERGE/UPDATE pour charger et synchroniser les tables cibles.
- Filtrage par partition (AAAAMM) pour un traitement incremental et coherent.
- Verification prealable des donnees sources avant execution metier.
- Journalisation de sortie (statut, duree, utilisateur, role, periode traitee).

## Logique du code
1. Initialiser le contexte d'execution et les variables partagees.
2. Calculer la periode de traitement et valider la presence des donnees sources.
3. Executer le calcul des flux collecte/decollecte par apporteur.
4. Executer le calcul des statistiques apporteurs et des indicateurs d'encours.
5. Retourner un resultat d'orchestration exploitable pour le suivi.

## Execution Order

| Step | Script | Description |
|---|---|---|
| 1 | [`sql/01_initialization.sql`](sql/01_initialization.sql) | Initialisation les objets, tables ou paramètres de base de données requis. |
| 2 | [`sql/02_sp_calc_app_stats.sql`](sql/02_sp_calc_app_stats.sql) | Une procédure stockée permettant de collecter une liste d'apporteurs. |
| 3 | [`sql/03_sp_calc_collect_app.sql`](sql/03_sp_calc_collect_app.sql) | Une procédure stockée de calcul des indicateurs financiers des apporteurs. |
| 4 | [`sql/04_sp_orchestrate_apporteurs.sql`](sql/04_sp_orchestrate_apporteurs.sql) | Une procédure stockée orchestrée permettant des mises à jour rapides des données. |

## Documentation

| Document | Description |
|---|---|
| [`docs/specifications/02_sp_calc_app_stats_specification.md`](docs/specifications/02_sp_calc_app_stats_specification.md) | Spécifications techniques pour la création d'une procédure stockée permettant de collecter une liste d'apporteurs. |
| [`docs/specifications/03_sp_calc_collect_app_specification.md`](docs/specifications/03_sp_calc_collect_app_specification.md) | Spécifications techniques pour la création d'une procédure stockée de calcul des indicateurs financiers des apporteurs. |
| [`docs/specifications/04_sp_orchestrate_apporteurs_specification.md`](docs/specifications/04_sp_orchestrate_apporteurs_specification.md) | Spécifications techniques pour la création d'une procédure stockée orchestrée permettant des mises à jour rapides des données. |

## Valeur apportee
- Reduction de la complexite operationnelle grace a une architecture modulaire.
- Meilleure maintenabilite du code (moins de duplication, plus de lisibilite).
- Execution robuste avec controles explicites et sortie standardisee.
- Documentation technique alignee avec le code pour faciliter la reprise.

## Confidentialite et adaptation publique
> Ce projet est **entierement deanonimise et adapte pour une demonstration publique**.
>
> Aucune denomination reelle n'est exposee dans ce repository: **ni bases de donnees, ni schemas, ni tables, ni warehouses, ni identifiants metier internes**.
>
> Tous les noms techniques et codes ont ete remplaces par des appellations generiques afin de preserver strictement la confidentialite des systemes et des donnees internes.
