# Pipeline SQL de reporting adhérents courtiers

## 🔒 Confidentialité et adaptation publique

Ce projet est **entièrement anonymisé et adapté pour une démonstration publique**. Aucune dénomination réelle n'est exposée dans ce repository : **ni bases de données, ni schémas, ni tables, ni warehouses, ni référentiels internes, ni labels métier sensibles**. Tous les noms techniques, objets sources, codes de périmètre et éléments sensibles ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

## 🗂️ Contexte du projet

> **Domaine** : assurance / finance 
> **Taille de l'organisation** : grand groupe international  
> **Mon rôle** : Data Analytics Engineer  
> **Mon apport** : j'ai conçu, structuré et documenté une procédure SQL Snowflake permettant d’alimenter une table physique de reporting adhérents courtiers, avec chargement incrémental, fenêtre historique maîtrisée et contrôles de fiabilité pour les reportings décisionnels.

## 📌 Public cible

Ce projet est destiné aux équipes métier en charge de la distribution, du pilotage commercial, des réseaux de courtiers et du contrôle de gestion, ainsi qu’aux équipes data responsables de la préparation des datasets de reporting. Il vise à fournir une base analytique fiable pour suivre les volumes d’adhérents, consolider les informations contrats et fiabiliser les analyses de productivité des courtiers.

## 🎯 Objectifs métier du projet

Ce projet répond à un besoin de pilotage du périmètre courtiers, en consolidant les données adhérents, contrats, convocations et courtiers dans une table de reporting stable et directement exploitable.

- Suivre le volume d’adhérents rattachés au périmètre courtiers.
- Analyser l’évolution des adhérents, contrats et informations de contact dans le temps.
- Identifier les segments, bureaux ou réseaux concentrant les principaux volumes.
- Disposer d’une vision consolidée des adhérents et de leurs contrats.
- Fiabiliser les reportings Power BI avec une base de données préparée, contrôlée et historisée.
- Soutenir l’analyse de la productivité commerciale des courtiers.

## ⚙️ Objectifs techniques du projet

Pour répondre au besoin de reporting métier décrit ci-dessus, ce projet vise à industrialiser l’alimentation d’une table physique de synthèse dans Snowflake.

- Structurer une alimentation SQL fiable, lisible et maintenable pour le reporting adhérents.
- Industrialiser le chargement incrémental des partitions utiles.
- Nettoyer automatiquement l’historique hors périmètre de conservation.
- Standardiser l’enrichissement des données issues des sources adhérent, convocation et courtier.
- Contrôler l’existence des partitions déjà chargées afin d’éviter les doublons.
- Produire une table de reporting directement exploitable dans Power BI.

## 🧩 Méthodes et approche technique

L’approche technique repose sur une procédure stockée dédiée au rafraîchissement d’une table cible, avec normalisation des sources, chargement incrémental et contrôles de cohérence.

- Procédure stockée SQL dédiée au rafraîchissement de la table cible.
- CTE de normalisation pour stabiliser les sources de référence avant jointure.
- Insertion incrémentalisée avec contrôle d’existence des partitions déjà chargées.
- Filtrage dynamique des partitions pour maintenir une fenêtre glissante de 5 ans.
- Contrôles qualité sur les codes postaux et la cohérence des données chargées.
- Bloc de tests SQL pour vérifier structure, volumétrie, complétude et intégrité du périmètre.

## 🔄 Logique du code

Le code suit une séquence d’exécution standardisée, depuis l’initialisation du contexte Snowflake jusqu’à l’insertion contrôlée des nouvelles partitions dans la table de reporting.

1. Initialiser le contexte de session Snowflake.
2. Créer la table cible si elle n’existe pas.
3. Supprimer les partitions obsolètes hors fenêtre historique.
4. Normaliser les sources adhérent, convocation et courtier.
5. Identifier les partitions utiles non encore chargées.
6. Insérer uniquement les partitions manquantes dans la table de reporting.
7. Exécuter les contrôles SQL de structure, volumétrie, complétude et cohérence.

## 🔢 Ordre d'exécution

| Étape | Script | Description |
|---|---|---|
| 1 | [`sql/Script_Reporting_Adherents_Courtiers.sql`](sql/Script_Reporting_Adherents_Courtiers.sql) | Procédure SQL de reporting adhérents courtiers : création de la table cible, nettoyage de l’historique, normalisation des sources, chargement incrémental et contrôles qualité. |

## 📚 Documentation

La documentation technique du projet décrit la logique de la procédure stockée, les sources mobilisées, les règles de transformation, les contrôles intégrés et les principes de chargement incrémental.

#### 1. Spécification technique du reporting adhérents courtiers

[`Specification_SQL_Script_Reporting_Adherents_Courtiers.md`](docs)  
Spécification technique détaillée du script SQL : objectif du traitement, structure de la table cible, logique de normalisation, règles de chargement incrémental, gestion de l’historique et contrôles qualité.

## 💡 Valeur apportée

Ce projet apporte de la valeur à la fois sur le plan technique, opérationnel et décisionnel, en rendant le reporting adhérents courtiers plus fiable, plus performant et plus simple à exploiter.

- **Alimentation plus performante** : table physique de synthèse plus efficace qu’une vue recalculée en permanence.
- **Reporting Power BI simplifié** : structure de données préparée, consolidée et directement exploitable côté BI.
- **Fiabilité renforcée** : chargement incrémental contrôlé, gestion de l’historique et vérification des partitions.
- **Lisibilité technique améliorée** : logique SQL explicite, organisée et documentée.
- **Qualité des analyses renforcée** : contrôles sur la volumétrie, la complétude et la cohérence du périmètre.
- **Maintenabilité facilitée** : documentation alignée avec le code pour simplifier la reprise, l’évolution et le transfert de connaissance.
