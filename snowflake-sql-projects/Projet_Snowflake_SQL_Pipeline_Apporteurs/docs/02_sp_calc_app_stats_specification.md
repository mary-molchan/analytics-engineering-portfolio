# Spécification technique : Procédure `sp_calc_app_stats`

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’une procédure stockée SQL Snowflake intégrée au projet **Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs**. Aucune dénomination réelle n’est exposée : **ni base de données interne, ni schéma réel, ni table réelle, ni warehouse, ni identifiant métier sensible**. Les noms techniques, objets sources, chemins, codes métier et exemples ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

---

## 🗂️ Identification du script

Cette section identifie la procédure stockée, son rôle dans le pipeline et son périmètre fonctionnel.

| Champ | Valeur |
|---|---|
| **Projet** | Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs |
| **Script SQL** | [`02_sp_calc_app_stats.sql`](../../sql/02_sp_calc_app_stats.sql) |
| **Type de script** | Procédure stockée SQL |
| **Nom de la procédure** | `sp_calc_app_stats` |
| **Technologie principale** | Snowflake SQL |
| **Objet principal** | Calcul et alimentation d’une table de synthèse des apporteurs avec indicateurs d’encours |
| **Script prérequis** | [`01_initialization.sql`](../../sql/01_initialization.sql) |
| **Statut du document** | Version portfolio public |
| **Objectif fonctionnel** | Produire une liste consolidée des apporteurs, enrichie avec des volumes de contrats et des indicateurs d’encours exploitables pour le reporting décisionnel. |

---

## 🏗️ Architecture technique

La procédure s’inscrit dans un pipeline SQL modulaire, où l’initialisation du contexte est séparée des calculs métier et de l’orchestration globale.

| Élément | Description |
|---|---|
| **Couche source** | Tables de référence et tables transactionnelles relatives aux contrats, situations, produits, encours et apporteurs. |
| **Couche de calcul** | CTE de préparation et d’agrégation des encours par type de support. |
| **Couche cible** | Table de synthèse des apporteurs, créée ou alimentée dynamiquement via le paramètre `table_path`. |
| **Mode d’exécution** | Appel de procédure stockée avec partition de référence et table cible pleinement qualifiée. |
| **Dépendance principale** | Variables de session et chemins d’objets initialisés dans le script `01_initialization.sql`. |

### Objets techniques principaux

| Objet | Rôle |
|---|---|
| `sp_calc_app_stats` | Procédure stockée de calcul des statistiques apporteurs. |
| `dt_partition` | Partition de référence au format `AAAAMM`. |
| `table_path` | Chemin pleinement qualifié de la table cible à créer ou alimenter. |
| `ea_by_type` | CTE intermédiaire calculant les encours par contrat et par type de support. |

---

## 📥 Sources de données

La procédure mobilise plusieurs sources anonymisées afin de consolider les informations relatives aux contrats, aux encours et à la hiérarchie des apporteurs.

| Source | Rôle fonctionnel |
|---|---|
| `contrgael_ea_j` | Source des encours par contrat et type de support. |
| `contrat` | Référentiel des contrats. |
| `situatcontr` | Situation courante ou historique des contrats. |
| `typesituat` | Référentiel des types de situation contractuelle. |
| `produit` | Référentiel produit permettant de qualifier les contrats. |
| `hierappcontr` | Hiérarchie de rattachement entre contrats et apporteurs. |
| `apporteur` | Référentiel des apporteurs. |
| `reseaudistrib` | Référentiel des réseaux de distribution. |

---

## 📤 Données produites

La procédure produit une table de sortie consolidée au niveau apporteur, enrichie avec des volumes de contrats et des indicateurs d’encours.

| Champ | Description |
|---|---|
| `codapp` | Code de l’apporteur. |
| `libnomapp` | Nom ou libellé de l’apporteur. |
| `codcompagnie` | Code de compagnie associé au périmètre de contrats. |
| `codportefeuille` | Code portefeuille. |
| `reseaudistrib` | Libellé du réseau de distribution. |
| `date_debut` | Date de début du rattachement ou de l’activité apporteur. |
| `nb_contrats` | Nombre total de contrats rattachés à l’apporteur. |
| `nb_contrats_retraite` | Nombre de contrats retraite. |
| `nb_contrats_vie` | Nombre de contrats vie. |
| `ea` | Encours total. |
| `ea_pct_euro` | Part de l’encours en support euro. |
| `ea_pct_uc` | Part de l’encours en unités de compte. |
| `ea_uc` | Montant d’encours en unités de compte. |
| `ea_eu` | Montant d’encours en support euro. |
| `date_calcul` | Date de calcul des indicateurs. |

---

## ⚙️ Paramètres d’entrée

La procédure prend deux paramètres obligatoires : une partition de traitement et une table cible.

| Paramètre | Type | Obligatoire | Description |
|---|---|---|---|
| `dt_partition` | `NUMBER` | Oui | Partition de référence des données source au format `AAAAMM`. |
| `table_path` | `STRING` | Oui | Chemin pleinement qualifié de la table de sortie à créer ou alimenter. |

### Exemple d’appel

```sql
CALL BD_ASSURANCE_ANALYTICS.SC_SYNTH_ASSURANCE.sp_calc_app_stats(
    202505,
    'BD_ASSURANCE_ANALYTICS.SC_SYNTH_ASSURANCE.LIST_APPORT'
);
