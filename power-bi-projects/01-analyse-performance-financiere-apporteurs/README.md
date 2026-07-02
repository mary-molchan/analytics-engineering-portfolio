# Projet Power BI : Analyse de la performance financière des apporteurs

## 🔒 Confidentialité et adaptation publique

Ce projet est **entièrement anonymisé et adapté pour une démonstration publique**. Aucune dénomination réelle n'est exposée dans ce repository : **ni noms d’apporteurs, ni codes internes, ni emails, ni rôles techniques réels, ni sources internes, ni données financières sensibles**. Tous les noms techniques, identifiants, valeurs sensibles, labels métier et captures d’écran ont été anonymisés ou généralisés afin de préserver strictement la confidentialité des systèmes et des données internes, tout en conservant la logique fonctionnelle, analytique et décisionnelle du rapport.

## 🗂️ Contexte du projet

> **Domaine** : assurance 
> **Taille de l'organisation** : grand groupe international  
> **Mon rôle** : Data Analytics Engineer  
> **Mon apport** : j'ai conçu, structuré et documenté un dashboard Power BI multi-pages permettant de piloter la performance financière des apporteurs, d’analyser les volumes de contrats, les montants, la part UC, la collecte / décollecte, les évolutions annuelles et le statut d’actualisation des données

## 📌 Public cible

Ce projet est destiné aux équipes métier en charge du pilotage commercial, du suivi des réseaux d’apporteurs et de l’analyse de performance, ainsi qu’aux équipes data / BI responsables de l’alimentation, de la qualité et de la supervision des données. Il vise à fournir une vision centralisée, fiable et actualisée de la performance des apporteurs afin de soutenir la prise de décision métier, le suivi opérationnel et l’identification rapide des points d’attention.

## 🎯 Objectifs métier du projet

Ce dashboard répond à un besoin de pilotage financier et commercial des apporteurs, en consolidant les principaux indicateurs de performance dans une interface Power BI claire, filtrable et exploitable.

- Suivre le nombre d’apporteurs, de réseaux, de contrats et de souscriptions.
- Analyser les montants financiers associés aux contrats et aux encours.
- Suivre la part UC dans le périmètre analysé.
- Comparer la collecte, la décollecte et l’encours sur plusieurs années.
- Identifier les apporteurs les plus contributeurs.
- Détecter les écarts significatifs entre collecte et décollecte.
- Mettre en évidence les zones de risque ou les situations nécessitant une analyse complémentaire.
- Vérifier la fraîcheur des données et le statut de la dernière actualisation du rapport.

## ⚙️ Objectifs techniques du projet

- Construire un dashboard Power BI multi-pages clair, structuré et maintenable
- Mettre en place un modèle sémantique adapté à l’analyse des apporteurs
- Centraliser les indicateurs métier dans des mesures DAX documentées
- Structurer une navigation simple entre les pages du rapport
- Mettre en œuvre des filtres interactifs pour l’analyse par apporteur, segment, portefeuille et réseau
- Intégrer une page dédiée à la supervision de l’actualisation des données
- Exposer les métadonnées de refresh : timestamp, statut, durée, partition traitée, utilisateur et rôle
- Documenter la logique fonctionnelle et technique du projet pour faciliter la maintenance et l’évolution

## 🧩 Méthodes et approche technique

L’approche repose sur une séparation claire entre la préparation des données, le modèle analytique, la restitution visuelle et le suivi opérationnel de l’actualisation.

- **Power BI Desktop / Service** pour la conception, la publication et la consultation du rapport
- **Modèle sémantique Power BI** structuré autour des dimensions et faits nécessaires au pilotage
- **Mesures DAX** pour les KPIs, ratios, variations annuelles et calculs filtrables
- **Filtres interactifs** pour l’analyse par apporteur, code, segmentation, portefeuille et réseau
- **Pages analytiques dédiées** : synthèse, performance, écarts, actualisation
- **Connexion à des données préparées dans Snowflake** via des procédures stockées et tables de synthèse
- **Journalisation du refresh** afin d’exposer le statut de mise à jour dans le rapport
- **Anonymisation complète** des éléments sensibles pour une version portfolio publique

## 🧭 Structure du rapport

Le dashboard est organisé en 4 pages principales, chacune répondant à un besoin fonctionnel spécifique.

| Page | Rôle | Objectif |
|---|---|---|
| **Liste des apporteurs** | Vue de synthèse et référentiel filtrable | Consulter les apporteurs, leurs volumes, montants, réseaux, segments et indicateurs clés. |
| **Performance des apporteurs** | Analyse annuelle et diagnostic financier | Comparer collecte, décollecte, encours, souscriptions et variations entre années. |
| **Écart collecte / décollecte** | Détection des écarts significatifs | Identifier les apporteurs avec écarts positifs ou négatifs importants. |
| **Actualisation du rapport** | Supervision du refresh | Suivre la dernière actualisation, le statut, la partition traitée et les éventuelles erreurs. |

## 📊 Pages et visualisations principales

### 1. Liste des apporteurs

Cette page fournit une vision centralisée de la base des apporteurs avec des KPIs globaux et filtrables.

- Cartes KPI : nombre d’apporteurs, nombre de réseaux, nombre de contrats, montant des contrats, part UC
- Filtres : nom apporteur, code apporteur, segmentation, portefeuille, réseau de distribution
- Table détaillée : apporteur, code, segmentation, hiérarchie, réseau, contrats, souscriptions, encours
- KPIs filtrables recalculés selon les sélections utilisateur

<img width="1263" height="800" alt="1 - Copy" src="https://github.com/user-attachments/assets/42c8fd1c-06eb-4980-9a19-479a484cc3e5" />
 

### 2. Performance des apporteurs

Cette page permet d’analyser la performance financière des apporteurs dans le temps.

- Sélecteur d’année
- KPIs : EA total, collecte totale, décollecte totale, nombre d’apporteurs filtrable
- Table de performance par apporteur et par année
- Tableau de variation entre années
- Graphique d’évolution collecte / décollecte
- Graphique d’évolution de l’encours total

<img width="1262" height="793" alt="2 - Copy" src="https://github.com/user-attachments/assets/904d0495-fcdd-4b1c-a7d3-675694932ad2" />
 

### 3. Écart collecte / décollecte

Cette page met en évidence les écarts les plus significatifs entre collecte et décollecte.

- Filtre par année
- KPI : nombre d’apporteurs par année
- Graphique des écarts positifs : apporteurs avec collecte supérieure à la décollecte
- Graphique des écarts négatifs : apporteurs avec décollecte supérieure à la collecte
- Classement visuel des cas les plus marqués pour prioriser l’analyse

<img width="1257" height="795" alt="3 - Copy" src="https://github.com/user-attachments/assets/bbacee5e-950e-488b-a053-531e13801665" />


### 4. Actualisation du rapport

Cette page donne de la visibilité sur la fraîcheur des données et le statut du dernier refresh.

- Date et heure de la dernière actualisation
- Statut de la dernière actualisation
- Durée d’exécution du script
- Dernière partition traitée
- Responsable de la dernière actualisation
- Rôle actif lors de l’exécution
- Bloc explicatif sur l’algorithme de mise à jour
- Remarques importantes sur les erreurs, partitions et précautions d’usage

<img width="1263" height="797" alt="4 - Copy" src="https://github.com/user-attachments/assets/d6756593-9938-4010-8c15-4eeebd719240" />

## 🔄 Logique fonctionnelle du rapport

Le rapport suit un parcours utilisateur simple : partir d’une vision globale, analyser la performance, identifier les écarts, puis vérifier la fraîcheur des données.

1. Consulter la liste des apporteurs et les KPIs globaux
2. Filtrer le périmètre par apporteur, segment, portefeuille ou réseau
3. Analyser la performance annuelle : collecte, décollecte, encours et variations
4. Identifier les écarts favorables ou défavorables entre collecte et décollecte
5. Vérifier le statut de la dernière actualisation avant toute prise de décision
6. Utiliser les résultats pour prioriser les actions commerciales ou les analyses complémentaires

## 🔁 Actualisation des données

Le rapport s’appuie sur un processus d’actualisation contrôlé, alimenté par des traitements Snowflake et exposé dans Power BI via une page dédiée.

- Calcul automatique de la partition de traitement
- Exécution de procédures stockées côté Snowflake
- Mise à jour des tables de synthèse utilisées par le rapport
- Récupération des métadonnées d’exécution
- Affichage du statut de refresh dans le dashboard
- Conservation des dernières données valides en cas d’absence de données pour la partition courante

La page **Actualisation du rapport** permet aux utilisateurs de vérifier rapidement si les données affichées sont récentes, cohérentes et exploitables.

## 📚 Documentation

[`Spécification fonctionnelle Power BI`](docs/specification_fonctionnelle_powerbi_analyse_performance_apporteurs.md) - description du besoin métier, des utilisateurs, des KPIs, des pages, des filtres, des visualisations et des critères d’acceptation


## 💡 Valeur apportée

Ce projet apporte de la valeur à la fois sur le plan métier, analytique et opérationnel, en transformant des données dispersées en un outil de pilotage clair, interactif et fiable.

- **Vision consolidée** : centralisation des indicateurs clés de performance des apporteurs.
- **Pilotage amélioré** : suivi des volumes, montants, collecte, décollecte, encours et part UC.
- **Analyse plus rapide** : filtres interactifs et pages dédiées pour passer de la synthèse au détail.
- **Détection des écarts** : identification visuelle des situations favorables ou défavorables.
- **Meilleure confiance dans les données** : page dédiée à la fraîcheur et au statut d’actualisation.
- **Réduction du retraitement manuel** : indicateurs préparés et disponibles dans une interface unique.
- **Maintenabilité renforcée** : documentation fonctionnelle et technique alignée avec le rapport.
- **Version portfolio sécurisée** : anonymisation complète des informations sensibles.

## 🛠️ Compétences démontrées

- Power BI Desktop
- Power BI Service
- Modélisation sémantique
- DAX
- Power Query
- Data visualization
- KPI design
- UX analytique
- Analyse financière
- Analyse de performance commerciale
- Snowflake SQL
- Procédures stockées
- Refresh monitoring
- Data quality checks
- Documentation fonctionnelle
- Documentation technique
- Anonymisation de données sensibles
