# Audit et extraction des adhérents sur 5 ans

## 🔒 Confidentialité et adaptation publique

Ce projet est **entièrement anonymisé et adapté pour une démonstration publique**. Aucune dénomination réelle n'est exposée dans ce repository : **ni noms d’adhérents, ni numéros de contrats réels, ni emails, ni téléphones, ni adresses, ni sources internes, ni identifiants métier sensibles**. Tous les noms techniques, labels métier, données personnelles, captures d’écran et éléments sensibles ont été remplacés par des appellations génériques ou des données fictives afin de préserver strictement la confidentialité des systèmes et des données internes.

## 🗂️ Contexte du projet

> **Domaine** : assurance / distribution courtiers  
> **Taille de l'organisation** : grand groupe international  
> **Mon rôle** : Data Analytics Engineer
> **Mon apport** : j'ai conçu, structuré et documenté un dashboard Power BI opérationnel permettant de rechercher des adhérents, consulter leurs informations détaillées, contrôler la fraîcheur des données et préparer une extraction Excel filtrée sur une fenêtre historique de 5 ans.

## 📌 Public cible

Ce projet est destiné aux équipes métier en charge du suivi des adhérents, aux gestionnaires opérationnels, aux responsables de pilotage réseau courtiers, ainsi qu’aux équipes BI / Data responsables de l’alimentation, de la qualité et de la diffusion des reportings. Il vise à fournir un outil simple, fiable et actionnable pour retrouver rapidement un adhérent, vérifier ses informations de contact et de contrat, puis produire une extraction Excel conforme au périmètre filtré.

## 🎯 Objectifs métier du projet

Ce dashboard répond à un besoin opérationnel de recherche, de contrôle et d’extraction des données adhérents, en centralisant les informations clés dans une interface Power BI structurée et facilement exploitable.

- Rechercher rapidement un adhérent par nom, prénom, numéro d’adhérent ou numéro de contrat
- Consulter les informations principales d’un adhérent : identité, contact, adresse, contrat et intermédiaire
- Filtrer les adhérents par période, département, origine ou existence d’email
- Contrôler le volume de lignes avant extraction
- Vérifier la partition de données utilisée et la date de mise à jour
- Standardiser les extractions Excel métier à partir d’un layout contrôlé
- Réduire le temps de recherche et de préparation des fichiers opérationnels
- Fiabiliser l’usage quotidien du reporting adhérents

## ⚙️ Objectifs techniques du projet

Pour répondre au besoin métier décrit ci-dessus, ce projet s’appuie sur un modèle Power BI simple, orienté recherche et extraction, alimenté par une table consolidée d’adhérents.

- Construire un dashboard Power BI clair, structuré et maintenable
- Organiser un parcours utilisateur en 3 étapes : recherche, détail, extraction
- Exploiter une table consolidée contenant les informations adhérent, contrat, adresse, produit et intermédiaire
- Mettre en place des filtres métier adaptés à un usage opérationnel
- Garantir la cohérence entre les pages de recherche, de détail et d’extraction
- Afficher des indicateurs de contrôle : nombre d’adhérents, compteur de lignes, partition à jour, date de mise à jour
- Préparer une table exportable vers Excel avec un format lisible
- Documenter la logique fonctionnelle et technique du rapport pour faciliter la maintenance et l’évolution

## 🧩 Méthodes et approche technique

L’approche technique repose sur une restitution Power BI orientée usage métier, avec une table principale consolidée, des filtres ciblés et des pages spécialisées selon le parcours utilisateur.

- **Power BI Desktop / Service** pour la conception, la publication et la consultation du rapport
- **Table de reporting consolidée** pour centraliser les données adhérents, contrats, adresses et intermédiaires
- **Modèle sémantique simple** basé sur une table principale dénormalisée, adaptée à la recherche et à l’extraction
- **Mesures DAX** pour les compteurs, la volumétrie, la partition à jour et la date de mise à jour
- **Filtres interactifs** pour la recherche par identité, contrat, période, département, origine et existence d’email
- **Navigation guidée** entre la recherche, le détail adhérent et l’extraction
- **Page d’extraction dédiée** avec manuel utilisateur intégré et contrôle du nombre de lignes
- **Anonymisation complète** des informations personnelles et sensibles pour une version portfolio publique

## 🔄 Logique du dashboard

Le rapport suit une logique simple et opérationnelle, depuis la recherche d’un adhérent jusqu’à l’export d’un fichier Excel filtré.

1. Ouvrir la page **Recherche des adhérents**
2. Appliquer les filtres nécessaires : période, nom, prénom, numéro d’adhérent, numéro de contrat, département, origine ou existence d’email
3. Identifier l’adhérent recherché dans la table principale
4. Ouvrir la page **Informations détaillées sur l’adhérent** pour consulter l’identité, l’adresse, le contact, les contrats et l’intermédiaire associé
5. Accéder à la page **Extraction des adhérents dans un fichier Excel**
6. Appliquer les filtres d’extraction : département, origine d’adhérent, existence email
7. Vérifier le compteur de lignes, la partition à jour et la date de mise à jour
8. Exporter les données avec l’option Power BI **Data with current layout**

## 🧭 Structure du rapport

| Page | Rôle | Objectif |
|---|---|---|
| **Recherche des adhérents** | Recherche et filtrage opérationnel | Retrouver rapidement un adhérent et consulter les informations principales du périmètre filtré. |
| **Informations détaillées sur l’adhérent** | Consultation détaillée | Visualiser la fiche complète d’un adhérent : identité, contact, adresse, contrats et intermédiaire. |
| **Extraction des adhérents dans un fichier Excel** | Préparation de l’export | Préparer une extraction Excel filtrée avec contrôle du volume, de la partition et de la date de mise à jour. |

## 📊 Pages et visualisations principales

### 1. Recherche des adhérents

Cette page sert de point d’entrée principal pour retrouver un adhérent et contrôler rapidement les informations disponibles.

- Table principale avec nom, prénom, ville, email, numéro d’adhérent et numéro de contrat.
- Carte KPI indiquant le nombre d’adhérents dans le périmètre filtré.
- Filtres de recherche : AnnéeMois, nom, prénom, origine, numéro d’adhérent, numéro de contrat, département, existence email.
- Navigation vers la page détail adhérent.

<img width="1306" height="735" alt="1к" src="https://github.com/user-attachments/assets/1a163f2a-bb79-461a-b867-6408b8cb1d81" />


### 2. Informations détaillées sur l’adhérent

Cette page affiche une fiche détaillée pour l’adhérent sélectionné.

- Carte avec le numéro d’adhérent actuel
- Filtre AnnéeMois
- Bloc **Information Adhérents** : téléphone, prénom, email, nom, civilité
- Bloc **Adresse Adhérent** : voie, code postal, bureau distributeur, complément d’adresse, commune, indicateur NPAI
- Bloc **Informations contrats** : numéro de contrat, année / mois, type de produit, produit d’assurance, dates, statut, origine, intermédiaire

<img width="1253" height="706" alt="2к" src="https://github.com/user-attachments/assets/4060f49c-fa65-4a46-ae38-5365e4ffa703" />


### 3. Extraction des adhérents dans un fichier Excel

Cette page prépare l’export Excel des données adhérents selon un périmètre filtré.

- Manuel d’extraction intégré dans le rapport
- Filtres : département, origine d’adhérent, existence email
- Carte KPI : compteur de lignes
- Carte KPI : partition à jour
- Carte KPI : date de mise à jour
- Table exportable contenant les informations adhérent, adresse, produit, email et téléphone
- Rappel de la limite opérationnelle d’extraction

<img width="1253" height="702" alt="3к" src="https://github.com/user-attachments/assets/34875c4e-7823-4483-b18b-f190368f7f9e" />


## 🔁 Actualisation et contrôle des données

Le rapport expose des informations permettant de vérifier la fraîcheur et l’exploitabilité des données avant consultation ou extraction.

- Affichage de la partition technique utilisée
- Affichage de la date de mise à jour
- Contrôle du volume de lignes avant export
- Filtrage sur une fenêtre historique de 5 ans
- Usage recommandé de filtres pour limiter les extractions trop volumineuses
- Préparation d’un export Excel conforme au layout affiché dans Power BI

## 📚 Documentation

La documentation du projet est organisée autour des spécifications fonctionnelles, techniques, des captures du rapport et du fichier Power BI.

- [**Spécification fonctionnelle Power BI**](Specification_fonctionnelle_dashboard_Power_BI.md) - description du besoin métier, des utilisateurs, des pages, des filtres, des visualisations, des règles de gestion et des critères d’acceptation.

- [**Spécification technique Power BI**](Specification_technique_dashboard_Power_BI.md) - description des sources, du modèle sémantique, des transformations, des mesures DAX, du refresh, de la sécurité et des contrôles techniques.


## 💡 Valeur apportée

Ce projet apporte de la valeur à la fois sur le plan opérationnel, analytique et documentaire, en transformant un besoin de recherche et d’extraction en un outil Power BI clair, fiable et réutilisable.

- **Recherche plus rapide** : accès direct aux adhérents via des filtres opérationnels
- **Vision détaillée centralisée** : consultation des informations adhérent, adresse, contrat et intermédiaire dans une seule fiche
- **Extraction standardisée** : préparation d’un fichier Excel selon un périmètre filtré et contrôlé
- **Meilleure qualité d’usage** : compteur de lignes, partition et date de mise à jour visibles avant export
- **Réduction des retraitements manuels** : données prêtes à consulter ou extraire depuis le rapport
- **Parcours utilisateur simple** : recherche → détail → extraction
- **Maintenabilité renforcée** : documentation fonctionnelle et technique alignée avec le rapport
- **Version portfolio sécurisée** : anonymisation complète des données personnelles et informations sensibles

## 🛠️ Compétences démontrées

- Power BI Desktop
- Power BI Service
- Modélisation sémantique
- DAX
- Power Query
- Data visualization
- UX analytique
- Recherche multicritère
- Préparation d’extractions Excel
- Data quality checks
- Contrôle de fraîcheur des données
- Documentation fonctionnelle
- Documentation technique
- Anonymisation de données personnelles
- Reporting opérationnel
- Analyse métier assurance / distribution
