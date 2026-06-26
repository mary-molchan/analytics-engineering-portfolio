# Spécification technique : Pipeline SQL de reporting adhérents courtiers

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’une procédure stockée SQL Snowflake intégrée au projet **Pipeline SQL de reporting adhérents courtiers**. Aucune dénomination réelle n’est exposée : **ni base de données interne, ni schéma réel, ni table réelle, ni warehouse, ni référentiel métier sensible**. Les noms techniques, objets sources, codes de périmètre, labels métier et exemples ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

---

## 🗂️ Identification du script

Cette section identifie la procédure stockée, son rôle dans le projet et son périmètre fonctionnel.

| Champ | Valeur |
|---|---|
| **Projet** | Pipeline SQL de reporting adhérents courtiers |
| **Script SQL** | [`Script_Reporting_Adherents_Courtiers.sql`](../sql/Script_Reporting_Adherents_Courtiers.sql) |
| **Type de script** | Procédure stockée SQL |
| **Nom de la procédure** | `PS_RAFRAICHIR_ADHERENTS_COURTIERS` |
| **Technologie principale** | Snowflake SQL |
| **Objet principal** | Rafraîchissement d’une table physique de reporting adhérents sur le périmètre courtiers |
| **Table cible** | `RPT_ADHERENTS_COURTIERS` |
| **Statut du document** | Version portfolio public |
| **Objectif fonctionnel** | Alimenter une table de synthèse fiable et historisée pour le reporting des adhérents rattachés au périmètre courtiers, avec chargement incrémental, contrôle des partitions et normalisation des données sources. |

---

## 🏗️ Architecture technique

L’architecture repose sur une procédure stockée dédiée au rafraîchissement d’une table physique de reporting, afin d’éviter les recalculs permanents côté BI.

| Élément | Description |
|---|---|
| **Couche source** | Vues et référentiels relatifs aux contrats, adhérents, convocations et courtiers. |
| **Couche de normalisation** | CTE de stabilisation des sources afin de limiter les doublons et standardiser les données avant jointure. |
| **Couche cible** | Table physique `RPT_ADHERENTS_COURTIERS` alimentée uniquement sur les partitions utiles. |
| **Mode d’exécution** | Appel d’une procédure stockée sans paramètre. |
| **Stratégie temporelle** | Fenêtre historique glissante de 5 ans avec purge dynamique des partitions obsolètes. |
| **Stratégie d’alimentation** | Chargement incrémental par `CLE_PARTITION`, avec insertion uniquement des partitions absentes de la table cible. |

### Objets techniques principaux

| Objet | Rôle |
|---|---|
| `PS_RAFRAICHIR_ADHERENTS_COURTIERS` | Procédure stockée principale de rafraîchissement du reporting. |
| `RPT_ADHERENTS_COURTIERS` | Table cible de reporting adhérents courtiers. |
| `src_adherent` | CTE de normalisation des données adhérents. |
| `src_convocation` | CTE de normalisation des données de convocation. |
| `src_courtier` | CTE de stabilisation du référentiel courtier. |
| `CLE_PARTITION` | Clé technique de partition au format `AAAAMM`. |

---

## 📥 Sources de données

La procédure mobilise plusieurs sources anonymisées afin de consolider les informations relatives aux contrats, aux adhérents, aux convocations et aux courtiers.

| Source | Rôle fonctionnel |
|---|---|
| `V_CONTRAT` | Source principale des contrats et partitions de reporting. |
| `V_ADHERENT` | Source des informations adhérents : identité, adresse, email, téléphone et code postal. |
| `V_CONVOCATION` | Source complémentaire permettant d’enrichir les données avec la commune ou des informations de convocation. |
| `R_COURTIER` | Référentiel des courtiers, utilisé pour enrichir les contrats avec les informations de distribution. |
| `RPT_ADHERENTS_COURTIERS` | Table cible alimentée par la procédure. |

---

## 📤 Données produites

La procédure produit une table de reporting consolidée au niveau adhérent / contrat / courtier, directement exploitable pour les analyses décisionnelles et les dashboards Power BI.

| Champ | Description |
|---|---|
| `ID_ADHERENT` | Identifiant métier unique de l’adhérent. |
| `LIB_CIVILITE` | Civilité normalisée issue du code source. |
| `NOM_ADHERENT` | Nom de l’adhérent. |
| `PRENOM_ADHERENT` | Prénom de l’adhérent. |
| `ADRESSE_LIGNE_1` | Adresse principale de l’adhérent. |
| `COMPLEMENT_ADRESSE` | Complément d’adresse. |
| `VILLE` | Ville de l’adhérent. |
| `CODE_POSTAL` | Code postal validé sur 5 chiffres. |
| `CODE_DEPARTEMENT` | Code département dérivé du code postal. |
| `COMMUNE` | Commune issue des données de convocation. |
| `EMAIL_ADHERENT` | Adresse email de l’adhérent. |
| `IND_EMAIL_PRESENT` | Indicateur Oui / Non de présence email. |
| `TELEPHONE_ADHERENT` | Téléphone de l’adhérent. |
| `NUMERO_CONTRAT` | Numéro du contrat. |
| `TYPE_PRODUIT` | Type ou famille de produit. |
| `LIB_PRODUIT_ASSURANCE` | Libellé du produit d’assurance. |
| `DATE_EFFET_CONTRAT` | Date d’effet du contrat. |
| `DATE_FIN_CONTRAT` | Date de fin du contrat. |
| `STATUT_CONTRAT` | Statut du contrat. |
| `ORIGINE_CONTRAT` | Origine ou canal du contrat. |
| `NOM_COURTIER` | Nom du courtier associé. |
| `EMAIL_COURTIER` | Email du courtier. |
| `TELEPHONE_COURTIER` | Téléphone prioritaire du courtier. |
| `INDICATEUR_NPAI` | Indicateur courrier non distribuable. |
| `BUREAU_DISTRIBUTION` | Bureau ou agence de distribution. |
| `CODE_PERIMETRE` | Code de périmètre anonymisé pour segmentation aval. |
| `CLE_PARTITION` | Clé de partition au format `AAAAMM`. |
| `DATE_DERNIER_RAFRAICHISSEMENT` | Date de chargement ou de rafraîchissement de la ligne. |

---

## ⚙️ Paramètres d’entrée

La procédure ne prend aucun paramètre d’entrée explicite. Le périmètre temporel et les partitions à traiter sont calculés dynamiquement à l’exécution.

| Élément | Description |
|---|---|
| **Paramètres utilisateur** | Aucun paramètre manuel requis. |
| **Périmètre temporel** | Calculé dynamiquement à partir des partitions disponibles et de la fenêtre historique conservée. |
| **Fenêtre historique** | Conservation des partitions utiles sur une fenêtre glissante de 5 ans. |
| **Mode d’exécution** | Appel direct de la procédure stockée. |

### Exemple d’appel

```sql
CALL BD_ASSURANCE_ANALYTICS.SC_PILOTAGE_COURTIERS.PS_RAFRAICHIR_ADHERENTS_COURTIERS();
