# Projet Snowflake SQL - Reporting Adherents Courtiers (version portfolio)

## Vue d'ensemble
Ce projet presente une implementation SQL industrialisee pour alimenter un reporting adherents centre sur le perimetre des courtiers dans Snowflake. Il repose sur une procedure stockee chargeant une table physique de synthese a partir des donnees contrat, adherent, convocation et courtier, avec une logique incrementalisee et une fenetre historique maitrisee.

## Dimension metier (pourquoi et pour qui)
Ce projet s'adresse aux equipes metier Assurance (distribution, pilotage commercial, reseaux de courtiers, controle de gestion) ainsi qu'aux equipes data en charge de la preparation des datasets de reporting.

Il sert a repondre a des questions de pilotage essentielles:
- Quel est le volume d'adherents rattaches au perimetre courtiers?
- Comment evoluent les adherents, contrats et informations de contact dans le temps?
- Quels segments ou bureaux de distribution concentrent les principaux volumes?

Concretement, il fournit une base fiable pour:
- Suivre la productivite du reseau de courtiers.
- Disposer d'une vision consolidee des adherents et de leurs contrats.
- Fiabiliser les reportings Power BI avec un chargement incremental et controle.

Dans le secteur de l'assurance, ce type de dispositif est important car il permet de relier la qualite des donnees clients, la production commerciale et la performance des canaux de distribution. Il soutient ainsi le pilotage des reseaux, l'analyse des portefeuilles et la prise de decision a partir d'un socle de donnees stabilise.

## Objectif du projet
- Structurer une alimentation SQL fiable, lisible et maintenable pour le reporting adherents.
- Industrialiser le chargement incremental des partitions utiles.
- Nettoyer automatiquement l'historique hors perimetre de conservation.
- Standardiser l'enrichissement des donnees issues des sources adherent, convocation et courtier.

## Methodes et approche technique
- Procedure stockee SQL dediee au rafraichissement de la table cible.
- CTE de normalisation pour stabiliser les sources de reference avant jointure.
- Insertion incrementalisee avec controle d'existence des partitions deja chargees.
- Filtrage dynamique des partitions pour maintenir une fenetre glissante de 5 ans.
- Controles qualite sur les codes postaux et la coherence des donnees chargees.
- Bloc de tests SQL pour verifier structure, volumetrie, completude et integrite du perimetre.

## Logique du code
1. Initialiser le contexte de session Snowflake.
2. Creer la table cible si elle n'existe pas.
3. Supprimer les partitions obsoletes hors fenetre historique.
4. Normaliser les sources adherent, convocation et courtier.
5. Inserer les partitions manquantes uniquement dans la table de reporting.

## Script pour execution
[`Script_Reporting_Adherents_Courtiers`](sql/Script_Reporting_Adherents_Courtiers.sql)

## Documentation du script
[`Specification_SQL_Script_Reporting_Adherents_Courtiers`](docs/Specification_SQL_Script_Reporting_Adherents_Courtiers.md)

## Valeur apportee
- Alimentation plus performante qu'une vue recalculee en permanence.
- Structure de donnees plus simple a exploiter dans Power BI.
- Meilleure lisibilite technique grace a une logique explicite et documentee.
- Renforcement de la fiabilite des analyses de productivite des courtiers.

## Confidentialite et adaptation publique
> Ce projet est **entierement deanonimise et adapte pour une demonstration publique**.
>
> Aucune denomination reelle n'est exposee dans ce repository: **ni bases de donnees, ni schemas, ni tables, ni warehouses, ni referentiels internes, ni labels metier sensibles**.
>
> Tous les noms techniques, objets sources et codes de perimetre ont ete remplaces par des appellations generiques afin de preserver strictement la confidentialite des systemes et des donnees internes.
