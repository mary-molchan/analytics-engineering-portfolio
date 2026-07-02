# Spécification technique Power BI: Audit et extraction des adhérents sur 5 ans

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’un rapport Power BI et de son modèle sémantique. Aucune dénomination réelle n’est exposée : **ni source interne, ni base de données réelle, ni workspace confidentiel, ni identifiant métier sensible**. Les noms techniques, sources, champs, règles métier, identifiants adhérents, numéros de contrats, emails, téléphones, adresses et exemples ont été remplacés par des appellations génériques afin de préserver la confidentialité des systèmes et des données.

---

## 🗂️ Identification du rapport

| Champ | Valeur |
|---|---|
| **Nom du rapport** | Audit et extraction des adhérents sur 5 ans |
| **Code projet** | `Audit_extraction_adherents_5_ans` |
| **Domaine métier** | Assurance / Adhérents / Distribution courtiers / Audit opérationnel |
| **Objectif du rapport** | Permettre la recherche, le contrôle, la consultation détaillée et l’extraction maîtrisée des données adhérents sur une fenêtre historique de 5 ans. |
| **Auteur** | Maryna MOLCHAN |
| **Date de création** | 2026-06-10 |
| **Dernière mise à jour** | 2026-06-25 |
| **Statut** | En revue |
| **Confidentialité** | Portfolio public anonymisé |
| **Fichier Power BI** | [Lien vers `.pbix`] |
| **Repository** | [Lien GitHub / SharePoint / OneDrive] |

---

## 🎯 Objectif technique

Le rapport vise à fournir une solution Power BI fiable, lisible et maintenable pour rechercher, auditer et extraire des données adhérents à partir d’un modèle consolidé.

### Objectifs principaux

- Structurer un rapport Power BI orienté recherche, audit et extraction.
- Préparer un dataset adhérents exploitable dans Power BI à partir d’une table consolidée.
- Centraliser les champs adhérent, contrat, adresse, contact, produit et intermédiaire.
- Permettre une recherche multicritère sur les adhérents et contrats.
- Fournir une page de détail pour vérifier les informations d’un adhérent sélectionné.
- Préparer une extraction Excel contrôlée avec filtres et compteur de lignes.
- Garantir la cohérence des données affichées entre recherche, détail et extraction.
- Documenter les sources, transformations, contrôles qualité et règles de rafraîchissement.

---

## 📌 Périmètre technique

### Inclus dans cette version

- Source de données consolidée des adhérents.
- Fenêtre historique de 5 ans via partition mensuelle.
- Préparation des données adhérents, contrats, adresses, produits et intermédiaires.
- Modèle sémantique Power BI basé sur une table principale dénormalisée.
- Filtres de recherche et d’extraction.
- Pages de recherche, détail adhérent et export Excel.
- Mesures de volumétrie et indicateurs techniques simples.
- Contrôles qualité sur champs clés, partitions, emails et codes postaux.
- Documentation des règles d’accès et de confidentialité.

### Exclu de cette version

- Modification ou correction des données source depuis Power BI.
- Workflow de validation métier intégré dans le rapport.
- Historisation fine des changements au niveau attribut adhérent.
- Automatisation native de l’export Excel depuis un bouton Power BI.
- Mobile layout optimisé.
- RLS avancée par portefeuille ou réseau dans la version portfolio.

---

## 🏗️ Architecture technique

| Couche | Rôle |
|---|---|
| **Sources** | Données adhérents, contrats, adresses, convocations, produits et intermédiaires préparées en amont. |
| **Préparation des données** | Nettoyage, typage, filtrage, normalisation et consolidation des informations adhérents. |
| **Modèle sémantique** | Table principale d’audit, mesures de volumétrie, champs de recherche et filtres. |
| **Rapport Power BI** | Pages de recherche, détail adhérent et extraction Excel. |
| **Power BI Service** | Publication, refresh, partage, sécurité et consultation contrôlée. |

### Flux logique

```text
Sources adhérents / contrats / courtiers
        ↓
Table consolidée d’audit adhérents
        ↓
Modèle sémantique Power BI
        ↓
Pages Recherche / Détail / Extraction
        ↓
Consultation, contrôle et export Excel