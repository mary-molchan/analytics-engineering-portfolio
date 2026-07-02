# Spécification fonctionnelle Power BI : Audit et extraction des adhérents sur 5 ans

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’un rapport Power BI dédié à la recherche, au contrôle et à l’extraction des données adhérents. Aucune dénomination réelle n’est exposée : **ni nom d’organisation, ni source interne, ni workspace confidentiel, ni donnée métier sensible**.  Les noms d’adhérents, identifiants, numéros de contrats, emails, téléphones, adresses, intermédiaires, sources et règles internes ont été anonymisés ou généralisés afin de préserver la confidentialité tout en conservant une logique représentative d’un contexte professionnel.

---

## 🗂️ Identification du rapport

| Champ | Valeur |
|---|---|
| **Nom du rapport** | Audit et extraction des adhérents sur 5 ans |
| **Code projet** | `Audit_extraction_adherents_5_ans` |
| **Domaine métier** | Assurance / Distribution courtiers / Pilotage adhérents |
| **Objectif métier principal** | Rechercher, contrôler, consulter en détail et extraire des données adhérents sur une fenêtre historique de 5 ans. |
| **Public cible** | Gestionnaires adhérents, responsables réseau, analystes reporting, équipe BI / Data |
| **Auteur** | Maryna MOLCHAN |
| **Date de création** | 2026-06-10 |
| **Dernière mise à jour** | 2026-06-25 |
| **Statut** | En revue |
| **Confidentialité** | Portfolio public anonymisé |
| **Lien rapport Power BI** | [À compléter] |
| **Lien repository / documentation** | [À compléter] |

---

## 🎯 Contexte et finalité métier

### Contexte

- **Problème métier adressé** : difficulté à retrouver rapidement un adhérent, vérifier ses informations, contrôler ses contrats et produire une extraction fiable selon des critères métier.
- **Situation actuelle** : les équipes doivent naviguer entre plusieurs vues ou réaliser des extractions manuelles non standardisées.
- **Motivation du projet** : fournir un point d’entrée unique pour rechercher un adhérent, consulter son détail et préparer une extraction Excel contrôlée.

### Finalité métier

Le rapport doit permettre aux utilisateurs de rechercher rapidement un adhérent, vérifier ses informations de contact, contrôler ses contrats associés, suivre la fraîcheur des données et extraire un fichier filtré exploitable par les équipes opérationnelles.

### Décisions supportées

- Identifier rapidement un adhérent à partir de critères simples.
- Vérifier les informations de contact avant une action opérationnelle.
- Contrôler les contrats associés à un adhérent.
- Préparer une extraction Excel selon un périmètre filtré.
- Vérifier si les données sont à jour avant utilisation.

### Valeur attendue

- Réduction du temps de recherche adhérent.
- Standardisation des extractions opérationnelles.
- Meilleure fiabilité des listes exportées.
- Amélioration de la qualité de contactabilité.
- Vision centralisée des informations adhérent, contrat, adresse et intermédiaire.

---

## 👥 Utilisateurs et parties prenantes

| Persona | Rôle | Fréquence d’usage | Besoins principaux |
|---|---|---|---|
| **Gestionnaire adhérents** | Opérations | Quotidienne | Rechercher un adhérent, vérifier ses coordonnées, consulter ses contrats, exporter une liste. |
| **Responsable réseau courtiers** | Pilotage opérationnel | Hebdomadaire | Suivre les volumes adhérents, filtrer par origine, département ou périmètre. |
| **Analyste reporting** | Analyse et contrôle | Quotidienne / Hebdomadaire | Contrôler les compteurs, les partitions, la qualité des données et les extractions. |
| **Équipe BI / Data** | Support et maintenance | Ponctuelle / À chaque refresh | Maintenir le rapport, vérifier la cohérence des données et gérer les évolutions. |

### Parties prenantes

| Partie prenante | Responsabilité |
|---|---|
| **Sponsor métier** | Valide les objectifs métier et les priorités du rapport. |
| **Product Owner / Business Owner** | Définit le besoin, les règles métier et les critères d’acceptation. |
| **Équipe Data / BI** | Conçoit, développe, publie et maintient le rapport. |
| **Gouvernance data** | Valide les règles de confidentialité, d’accès et d’usage des données. |
| **Utilisateurs finaux** | Consultent le rapport, réalisent les recherches et produisent les extractions. |

---

## 📌 Périmètre fonctionnel

### Inclus dans cette version

- Recherche multicritère d’adhérents.
- Consultation d’une liste d’adhérents filtrable.
- Accès à une page détail adhérent.
- Consultation des informations d’identité, contact, adresse, contrat et intermédiaire.
- Préparation d’une extraction Excel selon filtres métier.
- Contrôle du volume de lignes exportables.
- Affichage de la partition et de la date de mise à jour.
- Suivi des indicateurs simples de volumétrie et de contactabilité.
- Fenêtre historique de 5 ans.
- Trois pages Power BI :
  - Recherche des adhérents
  - Informations détaillées sur l’adhérent
  - Extraction des adhérents dans un fichier Excel

### Exclu de cette version

- Modification des données source depuis Power BI.
- Envoi automatique de campagnes.
- Workflow de validation métier intégré.
- Gestion des sinistres, cotisations ou facturation.
- Prédiction avancée ou scoring machine learning.
- Automatisation complète de l’export Excel par bouton.
- Mobile layout optimisé.

---

## ❓ Questions métier couvertes

Le rapport est conçu pour répondre à des questions opérationnelles concrètes :

- Combien d’adhérents sont visibles dans le périmètre filtré ?
- Quelle est la partition de données actuellement affichée ?
- Les données affichées sont-elles à jour ?
- Comment retrouver rapidement un adhérent par nom, prénom, numéro d’adhérent ou numéro de contrat ?
- Quelles sont les informations de contact, adresse et contrat d’un adhérent ?
- Quels adhérents peuvent être extraits selon département, origine ou existence d’email ?
- Le volume de lignes à exporter respecte-t-il la limite opérationnelle ?
- Les informations sont-elles suffisamment complètes pour une action métier ?

---

## 📊 Indicateurs et KPIs métier

| KPI | Définition métier | Logique de calcul | Granularité | Fréquence de mise à jour |
|---|---|---|---|---|
| **Nombre d’adhérents** | Volume distinct des adhérents visibles sous filtres. | Comptage distinct des identifiants adhérents. | Rapport / filtres actifs | À chaque refresh |
| **Compteur de lignes** | Nombre de lignes disponibles pour extraction. | Comptage des lignes du jeu filtré. | Page extraction | À chaque filtre |
| **Partition à jour** | Partition temporelle du lot courant. | Valeur maximale de la partition au format `YYYYMM`. | Global / filtre actif | À chaque refresh |
| **Date de mise à jour** | Date du dernier rafraîchissement disponible. | Date maximale de mise à jour chargée. | Global / filtre actif | À chaque refresh |
| **Taux email présent** | Part des adhérents avec email renseigné. | Nombre d’adhérents avec email / nombre total d’adhérents. | Rapport / filtre actif | À chaque refresh |
| **Nombre de contrats** | Volume de contrats associés aux adhérents. | Comptage distinct des numéros de contrat. | Adhérent / filtre actif | À chaque refresh |

### Règles métier transverses

- Tous les compteurs se recalculent selon le contexte de filtre actif.
- Le filtre le plus spécifique, comme numéro d’adhérent ou numéro de contrat, prime sur les filtres généraux.
- Les filtres ont une valeur par défaut `All`, sauf contexte opérationnel particulier.
- Les identifiants adhérent et contrat doivent rester au format texte.
- L’extraction se fait via l’option Power BI **Data with current layout**.
- La limite opérationnelle d’export est fixée à `150 000` lignes.
- En cas d’absence de résultat, les visuels doivent rester lisibles et indiquer que le périmètre filtré ne retourne aucune donnée.

---

## 🧭 Structure du rapport

| Ordre | Page | Rôle de la page | Public cible | Statut |
|---|---|---|---|---|
| 1 | **Recherche des adhérents** | Rechercher et filtrer les adhérents dans une table principale. | Gestionnaires, responsables réseau, analystes | Done |
| 2 | **Informations détaillées sur l’adhérent** | Consulter la fiche détaillée d’un adhérent sélectionné. | Gestionnaires adhérents | Done |
| 3 | **Extraction des adhérents dans un fichier Excel** | Préparer une extraction Excel contrôlée selon filtres métier. | Opérations, analystes | Done |

---

## 📄 Page 1 — Recherche des adhérents

### Objectif de la page

Offrir une vue de recherche rapide permettant de retrouver un adhérent, consulter ses informations principales et préparer le passage vers la page de détail.

### Questions métier traitées

- Quel adhérent correspond aux critères de recherche ?
- Quel est son nom, prénom, email, numéro d’adhérent et numéro de contrat ?
- Combien d’adhérents correspondent au périmètre filtré ?
- Quelle partition temporelle est consultée ?
- Quels filtres permettent d’affiner la recherche ?

### Décisions supportées

- Identifier rapidement l’adhérent à traiter.
- Valider le bon numéro d’adhérent ou de contrat.
- Vérifier la présence d’un email.
- Passer à une consultation détaillée de la fiche adhérent.
- Préparer un périmètre d’extraction plus ciblé.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `AnnéeMois` | Rapport | Partition la plus récente | Contrôle la période visible. |
| `Nom adhérent` | Page | Vide | Recherche textuelle par nom. |
| `Prénom adhérent` | Page | Vide | Recherche textuelle par prénom. |
| `Origine d’adhérent` | Rapport | All | Filtre par origine ou canal. |
| `Numéro d’adhérent` | Page | Vide | Recherche exacte sur l’identifiant adhérent. |
| `Numéro de contrat` | Page | Vide | Recherche exacte sur le contrat. |
| `Département` | Rapport | All | Filtre géographique. |
| `Existence email` | Rapport | All | Filtre Oui / Non selon présence email. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V1-01` | Table | Afficher la liste des adhérents correspondant aux filtres. | Champs identité, contact et contrat | Nom, prénom, ville, email, numéro adhérent, numéro contrat |
| `V1-02` | Carte KPI | Afficher le volume d’adhérents sous filtres. | Nombre d’adhérents | Contexte filtré |
| `V1-03` | Panneau de filtres | Affiner la recherche. | Filtres métier | Période, identité, origine, contrat, département, email |

### Règles de gestion de la page

- La table principale est filtrée automatiquement par les slicers.
- Le compteur d’adhérents se met à jour selon le contexte filtré.
- Le tri par défaut peut être effectué par nom d’adhérent.
- Les colonnes principales restent visibles pour faciliter la recherche.
- La page détail est accessible après sélection d’un adhérent.
- En cas de filtre incompatible, la table devient vide et le compteur passe à zéro.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter une recherche multicritère tolérante aux fautes. | Accélérer la recherche opérationnelle. |
| Moyenne | Ajouter un bouton de réinitialisation des filtres. | Simplifier l’expérience utilisateur. |
| Moyenne | Ajouter un indicateur de complétude contact. | Mieux qualifier les fiches adhérents. |

---

## 📄 Page 2 — Informations détaillées sur l’adhérent

### Objectif de la page

Afficher une fiche complète d’un adhérent sélectionné, incluant ses informations personnelles, son adresse, ses contrats et les informations liées à l’intermédiaire.

### Questions métier traitées

- Quel est l’adhérent sélectionné ?
- Quelles sont ses coordonnées principales ?
- Quelle est son adresse ?
- Quels contrats sont associés à cet adhérent ?
- Quel intermédiaire est rattaché au contrat ?
- Le contrat est-il actif ou inactif ?

### Décisions supportées

- Vérifier les informations avant prise de contact.
- Contrôler la cohérence de l’adresse et de l’indicateur NPAI.
- Identifier les contrats associés à l’adhérent.
- Vérifier l’origine du contrat et l’intermédiaire.
- Orienter le traitement opérationnel ou la demande utilisateur.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `AnnéeMois` | Rapport / Page | All | Filtre le contexte temporel du détail. |
| `Numéro d’adhérent` | Contexte de navigation | Valeur transmise depuis la page Recherche | Clé principale de la fiche. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V2-01` | Carte | Identifier l’adhérent actuellement consulté. | Adhérent sélectionné | Numéro adhérent |
| `V2-02` | Tableau attribut / valeur | Afficher les informations personnelles. | Téléphone, prénom, email, nom, civilité | Attribut adhérent |
| `V2-03` | Tableau attribut / valeur | Afficher les informations d’adresse. | Adresse, code postal, bureau, commune, NPAI | Adresse adhérent |
| `V2-04` | Table | Afficher les contrats associés. | Contrat, produit, dates, statut, origine, intermédiaire | Numéro contrat |

### Règles de gestion de la page

- La page est conçue comme une page de détail.
- Elle peut être masquée dans la navigation principale et ouverte depuis la page Recherche.
- Le contexte de l’adhérent sélectionné filtre tous les blocs de la page.
- Si aucun adhérent n’est sélectionné, un message doit inviter l’utilisateur à revenir à la page Recherche.
- Les contrats sont triés par date d’effet décroissante lorsque cette information est disponible.
- Les champs vides restent affichables afin de ne pas casser la structure de la fiche.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter un indicateur de complétude de la fiche adhérent. | Rendre visible la qualité de la donnée. |
| Moyenne | Ajouter un historique des modifications adhérent. | Améliorer la traçabilité. |
| Moyenne | Ajouter une alerte sur les contrats inactifs ou les informations manquantes. | Faciliter le diagnostic opérationnel. |

---

## 📄 Page 3 — Extraction des adhérents dans un fichier Excel

### Objectif de la page

Permettre à l’utilisateur de préparer une extraction Excel fiable, filtrée et contrôlée, en vérifiant le volume de lignes, la partition à jour et la date de mise à jour.

### Questions métier traitées

- Combien de lignes seront extraites ?
- Le volume d’extraction respecte-t-il la limite autorisée ?
- Quelle partition est utilisée ?
- Quelle est la date de mise à jour des données ?
- Quels filtres doivent être appliqués avant export ?
- La table affichée correspond-elle au fichier attendu ?

### Décisions supportées

- Lancer l’export Excel ou affiner les filtres.
- Réduire le volume extrait pour respecter la limite opérationnelle.
- Produire une liste exploitable par département, origine ou présence email.
- Vérifier la fraîcheur des données avant transmission ou usage opérationnel.

### Filtres et interactions

| Filtre / slicer | Portée | Valeur par défaut | Commentaire |
|---|---|---|---|
| `Département` | Page | All | Cible géographique de l’extraction. |
| `Origine d’adhérent` | Page | All | Filtre par origine ou canal. |
| `Existence email` | Page | All | Filtre selon présence d’un email. |

### Visualisations clés

| Visual | Type | Objectif analytique | KPI / mesures | Dimensions |
|---|---|---|---|---|
| `V3-01` | Zone texte | Expliquer la procédure d’export. | N/A | Manuel utilisateur |
| `V3-02` | Carte KPI | Contrôler le volume exportable. | Compteur de lignes | Contexte filtré |
| `V3-03` | Carte KPI | Vérifier la partition à jour. | Partition maximale | Partition |
| `V3-04` | Carte KPI | Vérifier la fraîcheur des données. | Date de mise à jour | Date |
| `V3-05` | Table exportable | Afficher les lignes à exporter. | Champs adhérent, adresse, produit, email, téléphone | Ligne adhérent |

### Règles de gestion de la page

- Les slicers filtrent simultanément le compteur, la partition, la date de mise à jour et la table.
- L’utilisateur doit vérifier le compteur de lignes avant export.
- La taille maximale recommandée pour l’extraction est de `150 000` lignes.
- Le fichier est extrait depuis le visuel table via l’option Power BI **Data with current layout**.
- En cas de dépassement de seuil, l’utilisateur doit affiner les filtres avant extraction.
- En cas d’absence de résultat, le compteur affiche zéro et l’export n’est pas pertinent.

### Améliorations envisagées

| Priorité | Amélioration | Valeur attendue |
|---|---|---|
| Haute | Ajouter une alerte visuelle si le compteur dépasse `150 000` lignes. | Réduire les erreurs d’export. |
| Moyenne | Ajouter un bouton de réinitialisation des filtres. | Faciliter la préparation de l’extraction. |
| Moyenne | Ajouter un préfiltre par partition la plus récente. | Accélérer l’usage opérationnel. |

---

## 🔎 Filtres et expérience utilisateur globale

| Élément | Description |
|---|---|
| **Filtres globaux** | AnnéeMois, origine adhérent, département, existence email. |
| **Filtres de recherche** | Nom, prénom, numéro adhérent, numéro de contrat. |
| **Navigation** | Boutons de navigation entre Recherche, Extraction et Détail adhérent. |
| **Drill-down** | Non prioritaire. |
| **Drill-through / navigation détail** | Oui, de la page Recherche vers la page Détail adhérent. |
| **Tooltips personnalisés** | Non prioritaire dans cette version. |
| **Filtres synchronisés** | Oui, selon la logique de page. |
| **Responsive / mobile layout** | Non prévu ; usage desktop prioritaire. |

### Principes UX appliqués

- Parcours simple : recherche → détail → extraction.
- Filtres visibles et compréhensibles.
- Tables larges adaptées à un usage opérationnel.
- Cartes KPI utilisées pour contrôler les volumes et la fraîcheur.
- Page d’extraction accompagnée d’un manuel utilisateur intégré.
- Thème visuel cohérent entre les pages.
- Priorité donnée à la lisibilité et à la rapidité d’usage plutôt qu’à la complexité visuelle.

---

## ✅ Critères d’acceptation métier

| ID | Critère | Priorité |
|---|---|---|
| `AC-001` | La recherche adhérent multicritère fonctionne correctement. | Haute |
| `AC-002` | La navigation vers la page détail conserve le contexte de l’adhérent sélectionné. | Haute |
| `AC-003` | La page détail affiche les informations personnelles, adresse et contrats du bon adhérent. | Haute |
| `AC-004` | La page extraction affiche un compteur de lignes cohérent avec les filtres appliqués. | Haute |
| `AC-005` | L’export Excel respecte le layout courant et le périmètre filtré. | Haute |
| `AC-006` | La partition et la date de mise à jour sont visibles avant extraction. | Haute |
| `AC-007` | Aucun terme interne sensible n’est visible dans la version portfolio. | Haute |
| `AC-008` | La navigation est claire pour les utilisateurs opérationnels. | Moyenne |

---

## 🧪 Scénarios de validation fonctionnelle

| ID | Page | Scénario | Résultat attendu |
|---|---|---|---|
| `TF-001` | Recherche des adhérents | Filtrer par nom et AnnéeMois. | La table et le compteur se mettent à jour. |
| `TF-002` | Recherche des adhérents | Filtrer par numéro d’adhérent. | Une fiche ou un périmètre adhérent cohérent est retourné. |
| `TF-003` | Recherche des adhérents | Sélectionner un adhérent et ouvrir le détail. | La page détail affiche le bon adhérent. |
| `TF-004` | Informations détaillées | Vérifier les blocs identité, adresse et contrat. | Les informations correspondent à l’adhérent sélectionné. |
| `TF-005` | Extraction des adhérents | Filtrer par département et existence email. | Le compteur et la table d’extraction sont filtrés. |
| `TF-006` | Extraction des adhérents | Vérifier la partition et la date de mise à jour. | Les informations de fraîcheur sont affichées. |
| `TF-007` | Extraction des adhérents | Exporter avec Data with current layout. | Le fichier Excel correspond au contexte filtré. |
| `TF-008` | Toutes pages | Tester un cas sans données. | Le rapport reste lisible et ne présente pas d’erreur bloquante. |

---

## 🛡️ Accès au rapport et gouvernance

| Population | Type d’accès | Canal d’accès | Commentaire |
|---|---|---|---|
| **Gestionnaires adhérents** | Viewer | Power BI App | Recherche, consultation et extraction contrôlée. |
| **Responsables réseau** | Viewer | Power BI App | Suivi du périmètre autorisé et extraction selon besoin. |
| **Analystes reporting** | Viewer / Contributor | App / Workspace | Contrôle des données et support aux utilisateurs. |
| **Équipe BI** | Contributor | Workspace | Maintenance et évolution du rapport. |
| **Admin BI** | Admin | Workspace | Publication, gouvernance et gestion des accès. |

### Règles fonctionnelles d’accès

- Accès accordé selon les populations métier autorisées.
- Partage privilégié via Power BI App.
- Droits d’édition limités à l’équipe BI.
- Segmentation possible par bureau, distributeur ou département selon les rôles.
- Données sensibles anonymisées dans la version portfolio.
- Validation des droits avant diffusion aux utilisateurs finaux.

---

## 🚀 Adoption et accompagnement utilisateur

- Communication de mise à disposition : annonce métier ou présentation en réunion.
- Guide utilisateur : parcours simple **Recherche → Détail → Extraction**.
- Manuel d’extraction intégré directement dans la page dédiée.
- Session de prise en main recommandée : 30 minutes par équipe.
- Support utilisateur : équipe BI / Data ou référent métier.
- Indicateurs d’adoption : nombre de consultations, nombre d’extractions, fréquence d’usage, consultation de la page détail.

---

## ⚠️ Risques fonctionnels et points d’attention

| Risque | Impact métier | Mitigation |
|---|---|---|
| Mauvais filtrage avant extraction | Extraction incomplète ou non conforme au besoin. | Vérifier les filtres, le compteur de lignes et l’aperçu avant export. |
| Dépassement de la limite d’export | Export impossible ou fichier incomplet. | Afficher le compteur de lignes et recommander l’affinage des filtres. |
| Données personnelles exposées | Risque de confidentialité élevé. | Limiter les accès, anonymiser la version portfolio, appliquer la gouvernance data. |
| Incohérence entre recherche et détail | Mauvais adhérent affiché. | Tester systématiquement la navigation et le contexte transmis. |
| Données source incomplètes | Fiche adhérent partielle. | Contrôles qualité sur champs clés, email, adresse et contrat. |
| Mauvaise interprétation de la partition | Usage de données non à jour. | Afficher clairement la partition et la date de mise à jour. |

---

## 🧾 Contrôle des versions

| Version | Date | Auteur | Modifications | Statut |
|---|---|---|---|---|
| `v0.1` | 2026-06-10 | Maryna MOLCHAN | Création initiale de la spécification fonctionnelle. | Brouillon |
| `v0.9` | 2026-06-25 | Maryna MOLCHAN | Adaptation complète sur la base du rapport 3 pages. | En revue |
| `v1.0` | À compléter | Maryna MOLCHAN | Validation fonctionnelle finale. | Validé |

---

## 📚 Glossaire métier et annexes

| Terme | Définition |
|---|---|
| **Adhérent** | Personne rattachée à un contrat dans le périmètre analysé. |
| **Intermédiaire** | Acteur de distribution ou courtier rattaché au contrat adhérent. |
| **Partition** | Période technique de chargement au format `YYYYMM`. |
| **NPAI** | Indicateur signalant un courrier non distribuable ou une adresse à surveiller. |
| **Existence email** | Indicateur Oui / Non indiquant si un email adhérent est renseigné. |
| **Export Excel** | Extraction manuelle des lignes filtrées depuis un visuel Power BI. |
| **Data with current layout** | Option Power BI permettant d’exporter les données selon la mise en page actuelle du visuel. |

### Annexes

- Lien vers le rapport Power BI : [À compléter]
- Lien vers l’app Power BI : [À compléter]
- Lien vers les screenshots : [À compléter]
- Lien vers la documentation technique : [À compléter]
- Lien vers la source portfolio : `AUDIT_ADHERENTS_DATA.xlsx`
- Note de confidentialité : version portfolio entièrement anonymisée.

---

## 📌 Checklist de validation fonctionnelle

- [x] La finalité métier est clairement décrite.
- [x] Les utilisateurs cibles sont identifiés.
- [x] Les questions métier sont documentées.
- [x] Les KPIs et définitions métier sont validés.
- [x] Toutes les pages sont documentées.
- [x] Les filtres et interactions sont précisés.
- [x] Les visualisations clés sont décrites.
- [x] Les règles de gestion sont explicitées.
- [x] Les critères d’acceptation sont définis.
- [x] Les scénarios de validation fonctionnelle sont documentés.
- [x] Les accès et règles de gouvernance sont précisés.
- [x] La documentation est prête pour le portfolio.