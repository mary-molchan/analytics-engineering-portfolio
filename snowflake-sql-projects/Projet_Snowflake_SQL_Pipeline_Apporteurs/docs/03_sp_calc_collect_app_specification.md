# Spécification technique : Procédure `sp_calc_collect_app`

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’une procédure stockée SQL Snowflake intégrée au projet **Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs**. Aucune dénomination réelle n’est exposée : **ni base de données interne, ni schéma réel, ni table réelle, ni warehouse, ni identifiant métier sensible**.  
Les noms techniques, objets sources, chemins, codes événements et exemples ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

---

## 🗂️ Identification du script

Cette section identifie la procédure stockée, son rôle dans le pipeline et son périmètre fonctionnel.

| Champ | Valeur |
|---|---|
| **Projet** | Pipeline SQL de préparation des données pour l’analyse de la performance financière des apporteurs |
| **Script SQL** | [`03_sp_calc_collect_app.sql`](../../sql/03_sp_calc_collect_app.sql) |
| **Type de script** | Procédure stockée SQL |
| **Nom de la procédure** | `sp_calc_collect_app` |
| **Technologie principale** | Snowflake SQL |
| **Objet principal** | Calcul des collectes, décollectes et encours consolidés par apporteur |
| **Script prérequis** | [`01_initialization.sql`](../../sql/01_initialization.sql) |
| **Dépendance optionnelle** | Variable de session `codapp_scope` pour limiter le traitement à un apporteur spécifique |
| **Statut du document** | Version portfolio public |
| **Objectif fonctionnel** | Produire une table de synthèse des flux financiers par apporteur, période et événement comptable, afin d’alimenter les reportings décisionnels sur la performance des réseaux d’apporteurs. |

---

## 🏗️ Architecture technique

La procédure s’inscrit dans un pipeline SQL modulaire, où les calculs de flux financiers sont séparés de l’initialisation technique et de l’orchestration globale.

| Élément | Description |
|---|---|
| **Couche source** | Tables relatives aux comptes clients, mouvements financiers, opérations, hiérarchie apporteur et encours. |
| **Couche de calcul** | CTE de préparation des mouvements, classification des flux et agrégation par apporteur. |
| **Couche cible** | Table de synthèse alimentée via le paramètre `res_table_path`. |
| **Mode d’exécution** | Appel de procédure stockée avec partition de traitement, table cible et paramètre de compatibilité. |
| **Dépendance principale** | Variables de session et chemins d’objets initialisés dans le script `01_initialization.sql`. |
| **Filtrage optionnel** | Possibilité de restreindre le périmètre via `codapp_scope`. |

### Objets techniques principaux

| Objet | Rôle |
|---|---|
| `sp_calc_collect_app` | Procédure stockée de calcul des collectes et décollectes par apporteur. |
| `dt_partition` | Partition de référence au format `AAAAMM`. |
| `res_table_path` | Chemin pleinement qualifié de la table cible. |
| `agi` | Paramètre conservé pour compatibilité d’appel. |
| `tmp_flux` | Structure intermédiaire utilisée pour préparer les flux avant agrégation. |
| `raw_ops` | CTE de préparation des opérations et mouvements financiers. |

---

## 📥 Sources de données

La procédure mobilise plusieurs sources anonymisées afin de consolider les flux financiers, les opérations et le rattachement aux apporteurs.

| Source | Rôle fonctionnel |
|---|---|
| `compteclient` | Source des mouvements financiers et montants d’opération. |
| `lignecptcapi` | Lignes de capitalisation associées aux opérations. |
| `hierappcontr` | Hiérarchie de rattachement entre contrats et apporteurs. |
| `operation` | Référentiel des opérations, utilisé notamment pour exclure les opérations annulées ou annulantes. |
| `contr_ea_j` | Source des encours consolidés par contrat et période. |

---

## 📤 Données produites

La procédure produit une table de sortie consolidée permettant de suivre les collectes, décollectes et encours par apporteur et période.

| Champ | Description |
|---|---|
| `codapp` | Code de l’apporteur. |
| `collecte` | Montant total des flux entrants. |
| `decollecte` | Montant total des flux sortants. |
| `ea` | Encours consolidé associé à l’apporteur. |
| `annee` | Année de référence du flux. |
| `mois` | Mois de référence du flux. |
| `codevecompta` | Code événement comptable anonymisé ou généralisé. |
| `dt_partition` | Partition technique de traitement. |
| `date_calcul` | Date d’exécution du calcul. |

---

## ⚙️ Paramètres d’entrée

La procédure prend trois paramètres obligatoires : une partition de traitement, une table cible et un paramètre conservé pour compatibilité.

| Paramètre | Type | Obligatoire | Description |
|---|---|---|---|
| `dt_partition` | `INT` | Oui | Partition de traitement au format `AAAAMM`. |
| `res_table_path` | `STRING` | Oui | Chemin pleinement qualifié de la table cible à créer ou alimenter. |
| `agi` | `STRING` | Oui | Paramètre conservé pour compatibilité d’appel, sans rôle métier central dans la logique documentée. |

### Exemple d’appel

```sql
CALL BD_ASSURANCE_ANALYTICS.SC_SYNTH_ASSURANCE.sp_calc_collect_app(
    202504,
    'BD_ASSURANCE_ANALYTICS.SC_SYNTH_ASSURANCE.SYN_SEI_COLLECTE',
    'PRD'
);
