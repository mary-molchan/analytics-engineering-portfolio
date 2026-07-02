# Spécification fonctionnelle Power BI : Analyse de la performance financière des apporteurs

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’un rapport Power BI consacré à l’analyse de la performance financière des apporteurs. Aucune dénomination réelle n’est exposée : **ni nom d’organisation, ni source interne, ni workspace confidentiel, ni identifiant métier sensible**.  Les noms d’apporteurs, identifiants, emails, rôles, sources, tables et certaines valeurs affichées ont été anonymisés ou généralisés afin de préserver la confidentialité, tout en conservant la logique fonctionnelle, analytique et décisionnelle du rapport.

---

## 🗂️ Identification du rapport

| Champ | Valeur |
|---|---|
| **Nom du rapport** | Analyse de la performance financière des apporteurs |
| **Code projet** | FPA-DASHBOARD-2025 |
| **Domaine métier** | Assurance / Finance / Performance commerciale des apporteurs |
| **Objectif métier principal** | Piloter la performance des apporteurs, suivre les volumes de contrats, les montants, la part UC, la collecte, la décollecte et les évolutions annuelles. |
| **Public cible** | Direction commerciale, managers réseau, analystes métier, équipes data / BI |
| **Auteur** | Maryna MOLCHAN |
| **Date de création** | 2025-01-01 |
| **Dernière mise à jour** | 2025-11-01 |
| **Statut** | En revue |
| **Confidentialité** | Portfolio public anonymisé |
| **Lien rapport Power BI** | [À compléter] |
| **Lien repository / documentation** | [À compléter] |

---

## 🎯 Contexte et finalité métier

### Contexte

- **Problème métier adressé** : absence d’une vision centralisée, fiable et actualisée de la performance des apporteurs.
- **Situation actuelle** : les données nécessaires au pilotage sont dispersées entre plusieurs sources et nécessitent des consolidations avant analyse.
- **Motivation du projet** : créer une source unique d’analyse de gestion permettant de suivre les apporteurs, leurs volumes, leurs montants, leur collecte / décollecte et les anomalies potentielles.

### Finalité métier

Le rapport permet aux utilisateurs de suivre les indicateurs clés des apporteurs, comprendre les tendances, détecter les écarts significatifs et prioriser les actions commerciales ou opérationnelles.

### Décisions supportées

- Identifier les apporteurs les plus contributeurs.
- Repérer les apporteurs en baisse de performance ou présentant un risque de décollecte.
- Analyser les évolutions annuelles de collecte, décollecte, encours et souscriptions.
- Prioriser les actions de suivi commercial par réseau, segment ou portefeuille.
- Vérifier la fraîcheur des données avant analyse ou partage de résultats.

### Valeur attendue

- Source unique d’analyse sur la performance des apporteurs.
- Réduction du temps de consolidation et de retraitement manuel.
- Meilleure lisibilité des indicateurs financiers et commerciaux.
- Détection plus rapide des anomalies et zones de risque.
- Support fiable à la prise de décision métier.

---

## 👥 Utilisateurs et parties prenantes

| Persona | Rôle | Fréquence d’usage | Besoins principaux |
|---|---|---|---|
| **Direction commerciale** | Pilotage stratégique | Hebdomadaire / Mensuelle | Suivre la performance globale, identifier les tendances et valider les priorités. |
| **Manager réseau** | Pilotage opérationnel | Hebdomadaire | Identifier les apporteurs à fort potentiel ou en difficulté. |
| **Analyste métier** | Analyse détaillée | Quotidienne / Hebdomadaire | Explorer les écarts, comparer les périodes et préparer des synthèses. |
| **Équipe Data / BI** | Support et maintenance | Ponctuelle / À chaque refresh | Vérifier la qualité, la fraîcheur et le statut d’actualisation des données. |

### Parties prenantes

| Partie prenante | Responsabilité |
|---|---|
| **Sponsor métier** | Valide les objectifs métier et les priorités d’analyse. |
| **Business Owner** | Définit les règles métier, les indicateurs et les critères d’acceptation. |
| **Équipe Data / BI** | Conçoit, développe, documente et maintient le rapport. |
| **Utilisateurs finaux** | Consultent le rapport et remontent les besoins d’évolution. |

---

## 📌 Périmètre fonctionnel

### Inclus dans cette version

- Analyse des apporteurs sur le périmètre de performance financière.
- Suivi des volumes : nombre d’apporteurs, réseaux, contrats, souscriptions.
- Suivi des montants : montant des contrats, encours, collecte, décollecte.
- Analyse de la part UC.
- Comparaison annuelle sur les années disponibles.
- Identification des écarts positifs et négatifs entre collecte et décollecte.
- Supervision du processus d’actualisation du rapport.
- Quatre pages Power BI :
  - Liste des apporteurs
  - Performance des apporteurs
  - Écart collecte / décollecte
  - Actualisation du rapport

### Exclu de cette version

- Interface de gestion ou modification des apporteurs.
- Saisie manuelle de données dans Power BI.
- Prédiction automatique de performance future.
- Analyse CRM détaillée hors périmètre apporteurs.
- Application mobile dédiée.
- Gestion opérationnelle des actions commerciales dans le rapport.

---

## ❓ Questions métier couvertes

Le rapport répond aux questions suivantes :

- Combien d’apporteurs, de réseaux et de contrats sont présents dans le périmètre ?
- Quel est le montant total des contrats et quelle est la part UC ?
- Quels apporteurs concentrent les plus gros volumes ou montants ?
- Comment évoluent la collecte, la décollecte, l’encours et les souscriptions dans le temps ?
- Quels apporteurs présentent les écarts les plus favorables entre collecte et décollecte ?
- Quels apporteurs présentent les écarts les plus défavorables et doivent être surveillés ?
- Les dernières données disponibles ont-elles bien été actualisées ?
- Quelle partition de données est actuellement traitée dans le rapport ?

---

## 📊 Indicateurs et KPIs métier

| KPI | Définition métier | Logique de calcul | Granularité | Fréquence de mise à jour |
|---|---|---|---|---|
| **Nombre d’apporteurs** | Nombre d’apporteurs présents dans le périmètre analysé. | Comptage distinct des codes apporteurs. | Global, filtre, année, segment, réseau | Mensuelle / selon refresh |
| **Nombre de réseaux** | Nombre de réseaux de distribution représentés. | Comptage distinct des réseaux. | Global, filtre | Mensuelle / selon refresh |
| **Nombre de contrats** | Volume total de contrats rattachés aux apporteurs. | Somme des contrats. | Global, apporteur, segment, réseau | Mensuelle / selon refresh |
| **Montant des contrats** | Montant financier total des contrats. | Somme des montants en euros. | Global, apporteur, segment, réseau | Mensuelle / selon refresh |
| **Part UC** | Part des unités de compte dans l’encours ou les montants suivis. | Montant UC / montant total. | Global, apporteur, filtre | Mensuelle / selon refresh |
| **Collecte** | Montant total des flux entrants. | Somme des montants de collecte. | Année, apporteur, segment | Mensuelle / selon refresh |
| **Décollecte** | Montant total des flux sortants. | Somme des montants de décollecte. | Année, apporteur, segment | Mensuelle / selon refresh |
| **Écart collecte / décollecte** | Différence ou ratio entre collecte et décollecte. | Collecte comparée à la décollecte. | Année, apporteur | Mensuelle / selon refresh |
| **EA / Encours** | Encours total associé aux apporteurs. | Somme des encours. | Année, apporteur, global | Mensuelle / selon refresh |
| **Variation annuelle** | Évolution d’un indicateur entre deux années. | Comparaison N vs N-1 en pourcentage. | Année, KPI | Mensuelle / selon refresh |

### Règles métier transverses

- Les indicateurs sont calculés sur le périmètre filtré par l’utilisateur.
- Les années disponibles dans le rapport servent de base aux comparaisons annuelles.
- Les montants sont affichés en euros.
- Les valeurs nulles ou manquantes sont conservées uniquement si elles restent interprétables.
- En cas d’absence de données sur la partition courante, la dernière partition valide reste visible.
- Les filtres doivent permettre une lecture globale par défaut, puis une analyse ciblée par apporteur, réseau, segment ou portefeuille.

---

## 🧭 Structure du rapport

| Ordre | Page | Rôle de la page | Public cible | Statut |
|---|---|---|---|---|
| 1 | **Liste des apporteurs** | Vue de synthèse et consultation détaillée du référentiel apporteurs. | Tous utilisateurs | Done |
| 2 | **Performance des apporteurs** | Analyse annuelle de la performance financière. | Direction, managers, analystes | Done |
| 3 | **Écart collecte / décollecte** | Identification des écarts favorables et défavorables. | Managers, analystes, contrôle | Done |
| 4 | **Actualisation du rapport** | Supervision du statut de mise à jour des données. | Data / BI, support, managers | Done |

---

## 📄 Page 1 — Liste des apporteurs

### Objectif de la page

Fournir une vue centralisée et filtrable de la base des apporteurs, avec les indicateurs clés de volume, de réseau, de contrats, de montants et de part UC.

### Questions métier traitées

- Quels sont les volumes globaux d’apporteurs, de réseaux et de contrats ?
- Quels apporteurs représentent les principaux montants ?
- Comment filtrer les apporteurs par segment, réseau ou portefeuille ?
- Quelle est la composition du périmètre analysé ?

### Décisions supportées

- Identifier les apporteurs les plus importants.
- Cibler un apporteur ou un segment pour analyse.
- Préparer une analyse de performance plus détaillée.
- Prioriser les réseaux ou portefeuilles à suivre.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `LIBNOMAPP` | Page | All | Filtre par nom d’apporteur. |
| `CODAPP` | Page | All | Filtre par code apporteur. |
| `SEGMENTATION` | Page | All | Filtre par segment métier. |
| `CODPORTEFEUILLE` | Page | All | Filtre par portefeuille. |
| `RESEAUDISTRIB` | Page | All | Filtre par réseau de distribution. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V1-01` | Cartes KPI | Afficher les indicateurs clés globaux de l’année. | Nombre d’apporteurs, réseaux, contrats, montant, part UC | Année |
| `V1-02` | Slicers | Permettre l’analyse ciblée. | Filtres métier | Apporteur, code, segment, portefeuille, réseau |
| `V1-03` | Table détaillée | Consulter la liste des apporteurs avec leurs attributs et indicateurs. | Contrats, souscriptions, encours | Apporteur, réseau, segment |
| `V1-04` | Cartes KPI filtrables | Recalculer les indicateurs selon les filtres appliqués. | Nombre d’apporteurs, réseaux, contrats, montant, part UC | Périmètre filtré |

### Règles de gestion de la page

- Les KPIs du haut donnent une vision globale de l’année.
- Les KPIs du bas se recalculent selon les filtres appliqués.
- La table est triable par les colonnes principales.
- Les filtres peuvent être combinés pour isoler un apporteur, un réseau, un segment ou un portefeuille.
- Si aucun filtre n’est appliqué, le rapport affiche l’ensemble du périmètre.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Moyenne | Ajouter un drill-through vers une page détail apporteur. | Faciliter l’analyse individuelle. |
| Moyenne | Ajouter un indicateur de rang ou Top N. | Identifier plus rapidement les principaux apporteurs. |
| Basse | Ajouter un export guidé des listes filtrées. | Faciliter le partage opérationnel. |

---

## 📄 Page 2 — Performance des apporteurs

### Objectif de la page

Analyser la performance financière des apporteurs par année, avec une lecture consolidée de la collecte, de la décollecte, de l’encours, des souscriptions et des variations interannuelles.

### Questions métier traitées

- Comment évolue la performance des apporteurs d’une année sur l’autre ?
- Quels apporteurs ou segments contribuent le plus à la collecte ?
- Quelle est la dynamique de décollecte ?
- Comment évoluent l’encours et les souscriptions ?
- Quels indicateurs progressent ou se dégradent entre deux années ?

### Décisions supportées

- Identifier les apporteurs en croissance ou en recul.
- Prioriser les analyses sur les variations les plus significatives.
- Suivre l’équilibre entre collecte, décollecte et encours.
- Préparer des synthèses pour la direction ou les managers réseau.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `ANNEE` | Page | Année courante ou All | Filtre la période d’analyse. |
| `LIBNOMAPP` | Page | All | Filtre par nom d’apporteur. |
| `CODAPP` | Page | All | Filtre par code apporteur. |
| `SEGMENTATION` | Page | All | Filtre par segment métier. |
| Sélecteur d’année | Page | Année sélectionnée | Permet de basculer rapidement entre les années disponibles. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V2-01` | Cartes KPI | Suivre la performance financière globale de l’année sélectionnée. | EA total, collecte totale, décollecte totale | Année |
| `V2-02` | Carte KPI | Afficher le nombre d’apporteurs dans le périmètre filtré. | Nombre d’apporteurs | Filtres actifs |
| `V2-03` | Table de variation | Comparer les indicateurs entre années. | Collecte, décollecte, collecte nette, EA | Période comparée |
| `V2-04` | Table détaillée | Analyser la performance par apporteur et par année. | Collecte, décollecte, écart, EA, souscriptions | Apporteur, année |
| `V2-05` | Graphique combiné | Visualiser l’évolution collecte / décollecte dans le temps. | Collecte, décollecte, souscriptions, clôtures | Année |
| `V2-06` | Graphique combiné | Suivre l’évolution de l’encours total. | EA, souscriptions, clôtures | Année |

### Règles de gestion de la page

- Les comparaisons annuelles sont calculées uniquement lorsque les deux périodes sont disponibles.
- Les variations positives et négatives sont différenciées visuellement.
- Les montants sont affichés en euros, avec une granularité adaptée aux volumes.
- Les graphiques combinent montants et volumes pour permettre une lecture croisée.
- Les filtres de table permettent d’isoler rapidement un apporteur, un segment ou une année.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter un indicateur de contribution à la croissance globale. | Mieux identifier les apporteurs moteurs. |
| Moyenne | Ajouter un benchmark par réseau ou segment. | Comparer un apporteur à son groupe de référence. |
| Moyenne | Ajouter une page tooltip pour expliquer les variations fortes. | Rendre l’analyse plus autonome. |

---

## 📄 Page 3 — Écart collecte / décollecte

### Objectif de la page

Identifier les apporteurs présentant les écarts les plus significatifs entre collecte et décollecte, afin de distinguer les contributions positives des situations défavorables à surveiller.

### Questions métier traitées

- Quels apporteurs présentent un écart positif important ?
- Quels apporteurs présentent un écart négatif important ?
- Quels cas doivent être analysés en priorité ?
- Les écarts sont-ils concentrés sur certains apporteurs ou répartis dans le réseau ?

### Décisions supportées

- Prioriser les actions commerciales sur les zones à risque.
- Identifier les apporteurs leaders ou à fort potentiel.
- Détecter les situations de décollecte importante.
- Orienter les investigations métier vers les cas extrêmes.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `ANNEE` | Page | Année sélectionnée | Permet de sélectionner la période d’analyse. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V3-01` | Carte KPI | Afficher le nombre d’apporteurs pour l’année sélectionnée. | Nombre d’apporteurs | Année |
| `V3-02` | Bar chart horizontal | Identifier les écarts positifs significatifs. | Écart collecte / décollecte positif | Apporteur |
| `V3-03` | Bar chart horizontal | Identifier les écarts négatifs significatifs. | Écart collecte / décollecte négatif | Apporteur |

### Règles de gestion de la page

- Les écarts positifs correspondent aux cas où la collecte dépasse fortement la décollecte.
- Les écarts négatifs correspondent aux cas où la décollecte dépasse fortement la collecte.
- Un seuil d’affichage est appliqué afin de concentrer l’analyse sur les écarts significatifs.
- Les barres sont triées pour faire ressortir les cas les plus marqués.
- Le vert est utilisé pour les écarts favorables, le rouge pour les écarts défavorables.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter un accès direct au détail de l’apporteur depuis le graphique. | Accélérer l’analyse des cas sensibles. |
| Moyenne | Ajouter un filtre segment ou réseau. | Mieux contextualiser les écarts. |
| Basse | Ajouter un commentaire automatique sur les plus forts écarts. | Faciliter la lecture métier. |

---

## 📄 Page 4 — Actualisation du rapport

### Objectif de la page

Donner de la visibilité sur le statut d’actualisation du rapport, la fraîcheur des données et le fonctionnement du processus de mise à jour.

### Questions métier traitées

- Quand le rapport a-t-il été actualisé pour la dernière fois ?
- Le dernier refresh s’est-il terminé correctement ?
- Quelle partition de données a été traitée ?
- Qui a déclenché ou exécuté la dernière actualisation ?
- Les données affichées sont-elles récentes et fiables ?

### Décisions supportées

- Décider si le rapport peut être utilisé pour analyse ou diffusion.
- Identifier rapidement un problème de refresh ou de partition.
- Alerter l’équipe data / BI en cas d’erreur.
- Éviter l’utilisation de données obsolètes.

### Filtres et interactions

Cette page ne contient pas de filtres métier interactifs classiques.  
Elle s’appuie sur des métadonnées de suivi issues du processus d’actualisation.

### Visualisations clés

| Visual | Type | Objectif analytique | Information affichée | Source fonctionnelle |
|---|---|---|---|---|
| `V4-01` | Carte | Afficher la date et l’heure de la dernière actualisation. | Timestamp du dernier refresh | Logs d’actualisation |
| `V4-02` | Carte | Afficher le statut du dernier refresh. | OK / ERROR / PENDING | Logs d’actualisation |
| `V4-03` | Carte | Afficher la durée d’exécution. | Durée du script | Logs d’actualisation |
| `V4-04` | Carte | Afficher la dernière partition traitée. | Partition disponible ou traitée | Logs d’actualisation |
| `V4-05` | Carte | Afficher le responsable de l’exécution. | Utilisateur anonymisé | Logs d’actualisation |
| `V4-06` | Carte | Afficher le rôle actif. | Rôle technique anonymisé | Logs d’actualisation |
| `V4-07` | Bloc texte | Expliquer le processus de mise à jour. | Algorithme de refresh | Documentation projet |
| `V4-08` | Bloc texte | Afficher les remarques et avertissements. | Points d’attention refresh | Documentation projet |

### Règles de gestion de la page

- Le statut OK indique que la dernière actualisation s’est terminée correctement.
- Le statut ERROR signale une erreur ou une absence de données pour la partition courante.
- Si les données de la partition courante sont absentes, le rapport conserve les dernières données valides disponibles.
- La page indique la partition utilisée pour permettre à l’utilisateur de vérifier la fraîcheur des données.
- Les remarques importantes expliquent les limites d’actualisation et les précautions d’usage.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter une alerte visuelle plus forte en cas d’erreur. | Réduire le risque d’usage de données obsolètes. |
| Moyenne | Ajouter l’historique des dernières actualisations. | Faciliter le suivi opérationnel. |
| Moyenne | Ajouter un lien vers un runbook de refresh. | Accélérer la résolution d’incident. |

---

## 🔎 Filtres et expérience utilisateur globale

| Élément | Description |
|---|---|
| **Filtres globaux** | Année, apporteur, code apporteur, segmentation, portefeuille, réseau de distribution. |
| **Navigation** | Boutons de navigation en haut du rapport vers les quatre pages. |
| **Drill-down** | Limité aux visuels et tables concernés. |
| **Drill-through** | Non prioritaire dans cette version. |
| **Tooltips personnalisés** | Possibles sur les indicateurs et graphiques principaux. |
| **Filtres synchronisés** | Utilisés selon la logique de page. |
| **Responsive / mobile layout** | Non prévu dans cette version. |

### Principes UX appliqués

- Navigation simple entre les pages principales.
- Lecture du plus synthétique au plus détaillé.
- Mise en avant des KPIs prioritaires.
- Distinction visuelle claire entre performance positive et négative.
- Couleurs cohérentes : rouge pour les alertes ou écarts défavorables, vert pour les écarts favorables.
- Présence d’une page dédiée à la fraîcheur des données afin de renforcer la confiance utilisateur.

---

## ✅ Critères d’acceptation métier

| ID | Critère | Priorité |
|---|---|---|
| `AC-001` | Les KPIs principaux des apporteurs sont visibles dès la page d’accueil. | Haute |
| `AC-002` | Les utilisateurs peuvent filtrer les données par apporteur, code, segment, portefeuille et réseau. | Haute |
| `AC-003` | La performance annuelle est lisible à travers les KPIs, tables et graphiques. | Haute |
| `AC-004` | Les écarts collecte / décollecte positifs et négatifs sont clairement distingués. | Haute |
| `AC-005` | La page d’actualisation permet de vérifier la fraîcheur des données. | Haute |
| `AC-006` | Les résultats affichés sont cohérents avec les données de référence. | Haute |
| `AC-007` | La navigation entre les pages est claire et intuitive. | Moyenne |
| `AC-008` | La documentation permet de comprendre le rôle de chaque page. | Moyenne |

---

## 🧪 Scénarios de validation fonctionnelle

| ID | Page | Scénario | Résultat attendu |
|---|---|---|---|
| `TF-001` | Liste des apporteurs | Vérifier l’affichage des KPIs globaux. | Les KPIs sont visibles, lisibles et cohérents. |
| `TF-002` | Liste des apporteurs | Appliquer un filtre sur un apporteur. | La table et les KPIs filtrables se mettent à jour. |
| `TF-003` | Performance des apporteurs | Sélectionner une année. | Les KPIs, tables et graphiques reflètent l’année sélectionnée. |
| `TF-004` | Performance des apporteurs | Comparer deux périodes. | Les variations interannuelles sont cohérentes. |
| `TF-005` | Écart collecte / décollecte | Sélectionner une année. | Les deux graphiques affichent les écarts positifs et négatifs correspondants. |
| `TF-006` | Écart collecte / décollecte | Vérifier le seuil d’affichage des écarts. | Seuls les cas significatifs apparaissent. |
| `TF-007` | Actualisation du rapport | Consulter le statut du dernier refresh. | Le statut, la partition, la durée et le timestamp sont affichés. |
| `TF-008` | Toutes pages | Tester un cas sans données. | Le rapport reste lisible et ne présente pas d’erreur bloquante. |

---

## 🛡️ Accès au rapport et gouvernance

| Population | Type d’accès | Canal d’accès | Commentaire |
|---|---|---|---|
| **Direction commerciale** | Viewer / Member selon contexte | Power BI App / Workspace | Vue consolidée sur l’ensemble du périmètre. |
| **Managers réseau** | Viewer | Power BI App | Consultation des indicateurs et analyses. |
| **Analystes métier** | Viewer / Contributor | Workspace / App | Analyse détaillée et préparation de synthèses. |
| **Équipe Data / BI** | Contributor / Member | Workspace | Maintenance, refresh, support et évolution du rapport. |

### Règles fonctionnelles d’accès

- Accès accordé aux populations métier autorisées.
- Partage privilégié via Power BI App lorsque possible.
- Les droits d’édition sont limités aux équipes responsables du rapport.
- Les données sensibles restent anonymisées dans la version portfolio.
- Une segmentation des accès peut être envisagée si le rapport est diffusé à plusieurs niveaux métier.

---

## 🚀 Adoption et accompagnement utilisateur

- Communication de mise à disposition : message interne ou présentation aux utilisateurs cibles.
- Guide utilisateur : description des pages, filtres et KPIs principaux.
- Session de présentation : recommandée pour expliquer la logique de collecte / décollecte et d’actualisation.
- Support utilisateur : assuré par l’équipe data / BI ou le référent projet.
- Indicateurs d’adoption : nombre de consultations, utilisateurs actifs, fréquence d’usage, retours utilisateurs.

---

## ⚠️ Risques fonctionnels et points d’attention

| Risque | Impact métier | Mitigation |
|---|---|---|
| Données de la partition courante non disponibles | Risque d’analyse sur une période non actualisée. | Affichage du statut, de la partition traitée et conservation des dernières données valides. |
| Mauvaise interprétation de la décollecte | Risque de lecture incorrecte de la performance. | Documentation des indicateurs et séparation claire collecte / décollecte. |
| Écarts extrêmes mal contextualisés | Risque de conclusions trop rapides. | Analyse complémentaire par apporteur, segment ou réseau. |
| Filtres combinés trop restrictifs | Résultat vide ou incomplet. | Prévoir un comportement clair en cas d’absence de données. |
| Définitions KPI non stabilisées | Incohérence entre utilisateurs. | Validation métier des définitions et documentation des règles. |

---

## 🧾 Contrôle des versions

| Version | Date | Auteur | Modifications | Statut |
|---|---|---|---|---|
| `v0.1` | 2025-11-01 | Maryna MOLCHAN | Création initiale de la spécification fonctionnelle. | Brouillon |
| `v1.0` | À compléter | Maryna MOLCHAN | Validation fonctionnelle initiale. | En attente |

---

## 📚 Glossaire métier et annexes

| Terme | Définition |
|---|---|
| **Apporteur** | Intermédiaire ou partenaire contribuant à la distribution des contrats. |
| **Collecte** | Flux financier entrant sur le périmètre analysé. |
| **Décollecte** | Flux financier sortant sur le périmètre analysé. |
| **Écart collecte / décollecte** | Différence ou ratio permettant d’évaluer l’équilibre entre flux entrants et sortants. |
| **EA / Encours** | Montant total d’encours associé aux contrats ou apporteurs. |
| **UC** | Unités de compte, utilisées dans l’analyse de la composition des encours. |
| **Partition** | Période technique de données utilisée pour l’actualisation du rapport. |
| **Refresh** | Processus d’actualisation des données du rapport. |

### Annexes

- Lien vers le rapport Power BI : [À compléter]
- Lien vers l’app Power BI : [À compléter]
- Lien vers les screenshots des pages : [À compléter]
- Lien vers la documentation technique : [À compléter]
- Lien vers les spécifications SQL associées : [À compléter]

---

## 📌 Checklist de validation fonctionnelle

- [x] La finalité métier est clairement décrite.
- [x] Les utilisateurs cibles sont identifiés.
- [x] Les questions métier sont documentées.
- [x] Les KPIs et définitions métier sont décrits.
- [x] Toutes les pages sont documentées.
- [x] Les filtres et interactions sont précisés.
- [x] Les visualisations clés sont décrites.
- [x] Les règles de gestion sont explicitées.
- [x] Les critères d’acceptation sont définis.
- [x] Les scénarios de validation fonctionnelle sont documentés.
- [x] Les accès et règles de gouvernance sont précisés.
- [x] La documentation est prête pour une version portfolio anonymisée.
