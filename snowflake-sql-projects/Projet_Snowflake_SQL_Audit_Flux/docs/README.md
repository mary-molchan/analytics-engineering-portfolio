# Spécification technique : Pipeline SQL d’audit des flux et d’analytics financière courtiers

## 🔒 Confidentialité et adaptation publique

Ce document décrit une **version anonymisée et adaptée pour démonstration publique** d’un pipeline SQL Snowflake. Aucune dénomination réelle n’est exposée : **ni base de données interne, ni schéma réel, ni table réelle, ni warehouse, ni référentiel métier sensible**. Les noms techniques, objets, sources, règles métier et exemples de données ont été remplacés par des appellations génériques afin de préserver strictement la confidentialité des systèmes et des données internes.

---

## 🗂️ Identification du script

Cette section identifie le script principal, son rôle fonctionnel et son périmètre d’exécution dans le projet.

| Champ | Valeur |
|---|---|
| **Projet** | Pipeline SQL d’audit des flux et d’analytics financière courtiers |
| **Script SQL principal** | [`01_SNOWFLAKE_LOAD_AND_MART.sql`](../sql/01_SNOWFLAKE_LOAD_AND_MART.sql) |
| **Type de script** | Pipeline SQL end-to-end : ingestion RAW, synthèse MART, exposition BI |
| **Technologie principale** | Snowflake SQL |
| **Statut du document** | Version portfolio public |
| **Objectif fonctionnel** | Charger plusieurs sources financières, structurer une couche RAW, produire une couche MART analytique et exposer une vue consolidée pour le reporting BI. |
| **Périmètre métier** | Transactions, commissions, règlements, partenaires, contrats, règles de commission et exceptions d’audit. |
| **Objet principal** | Construction d’une chaîne analytique complète depuis les fichiers sources jusqu’à une vue BI consolidée. |

---

## 🏗️ Architecture technique

L’architecture repose sur une séparation claire entre ingestion brute, transformation métier, agrégation analytique et exposition BI.

| Couche | Rôle |
|---|---|
| **Staging** | Réception des fichiers sources avant ingestion dans Snowflake. |
| **RAW** | Stockage des données brutes standardisées après chargement. |
| **MART** | Création des dimensions, faits, agrégats, KPIs et flags de risque. |
| **BI View** | Exposition d’une vue consolidée directement exploitable pour Power BI ou tout outil BI. |

### Objets techniques principaux

| Objet | Description |
|---|---|
| **Warehouse** | Warehouse analytique dédié à l’exécution du pipeline. |
| **File format** | Format de fichier standardisé pour l’ingestion. |
| **Stage interne** | Zone Snowflake utilisée pour charger les fichiers sources. |
| **Tables RAW** | Tables de réception des données financières brutes. |
| **Tables MART** | Tables de synthèse, dimensions, faits et indicateurs métier. |
| **Vue BI** | Vue finale consolidant les indicateurs financiers, les flags de risque et les informations partenaires. |

---

## 📥 Sources de données

Le pipeline repose sur plusieurs sources financières anonymisées couvrant les flux transactionnels, les commissions, les règlements, les contrats, les partenaires et les exceptions d’audit.

> Dans le repository portfolio, les fichiers sources peuvent être fournis sous forme Excel.  
> Dans une logique Snowflake, ils sont destinés à être exportés ou pré-stagés dans un format compatible avec l’ingestion SQL.

| Source | Rôle métier |
|---|---|
| `F_TRANSACTIONS` | Transactions financières, flux entrants / sortants, reversals et partitions mensuelles. |
| `F_COMMISSIONS` | Commissions attendues, commissions payées, ajustements et exceptions. |
| `F_SETTLEMENTS` | Règlements, montants dus, montants payés, résidus et retards. |
| `D_AGENCY` | Référentiel des agences avec informations historisées. |
| `D_BROKER` | Référentiel des courtiers avec informations de statut et d’éligibilité. |
| `D_CONTRACT` | Référentiel des contrats, produits, statuts et niveaux de prime. |
| `D_DATE` | Calendrier analytique et fiscal. |
| `R_COMMISSION_RULES` | Règles de commission utilisées pour l’analyse de performance. |
| `AUDIT_EXCEPTIONS` | Exceptions et écarts détectés nécessitant analyse ou audit. |

---

## 📤 Données produites

Le pipeline produit une couche MART structurée autour de dimensions, tables de faits, agrégats mensuels et vue BI consolidée.

### Dimensions

| Table | Grain | Usage |
|---|---|---|
| `DM_PARTNER` | Agence / courtier | Enrichissement des partenaires avec flags d’éligibilité et de risque. |
| `DM_CONTRACT_CORE` | Contrat | Dimension contrat avec statut, famille produit et catégorisation premium. |

### Tables de faits et agrégats

| Table | Grain | Usage |
|---|---|---|
| `FM_COMMISSION_EFFICIENCY` | Mois × contrat | Calcul de l’efficacité des commissions : ratio de paiement, ajustements, exceptions. |
| `FM_SETTLEMENT_AGING` | Mois × contrat | Analyse du vieillissement des règlements, taux de recouvrement, résidus et retards. |
| `FM_TRANSACTION_FLOW` | Mois × contrat | Analyse des flux entrants, sortants, flux nets et reversals. |
| `FM_AUDIT_MONTHLY` | Mois × contrat | Agrégation des exceptions d’audit et classification du risque d’audit. |
| `FM_FINANCE_MONTHLY` | Mois × agence × courtier × contrat | Table de faits principale consolidant KPIs financiers et flags de risque. |
| `FM_PARTNER_PERFORMANCE` | Partenaire | Agrégation des indicateurs au niveau partenaire avec classification du risque. |

### Vue BI

| Vue | Usage |
|---|---|
| `VW_BI_FINANCE_COCKPIT` | Vue consolidée destinée au reporting BI, regroupant les KPIs financiers, les flags de risque, les ratings d’audit et les agrégats partenaires. |

---

## ⚙️ Paramètres d’entrée

Le script est conçu comme un pipeline SQL autonome, sans paramètre d’entrée explicite.

| Élément | Description |
|---|---|
| **Paramètres utilisateur** | Aucun paramètre manuel requis. |
| **Périodisation** | Calculée dynamiquement à partir des dates et partitions disponibles dans les données. |
| **Contexte d’exécution** | Initialisé au démarrage du script : warehouse, database, schemas, file format et stage. |
| **Mode d’exécution** | Exécution complète du script dans Snowflake Web UI, SnowSQL ou un outil compatible. |

---

## 🔄 Logique d’implémentation

Le pipeline suit une séquence end-to-end, depuis l’initialisation Snowflake jusqu’à la création d’une vue BI consolidée.

1. Initialiser le contexte Snowflake : warehouse, database, schemas RAW et MART.
2. Créer le file format et le stage interne pour l’ingestion.
3. Créer les tables RAW nécessaires au chargement des sources.
4. Charger les sources financières dans la couche RAW.
5. Construire les dimensions analytiques :
   - `DM_PARTNER`
   - `DM_CONTRACT_CORE`
6. Calculer les agrégats métier intermédiaires :
   - `FM_COMMISSION_EFFICIENCY`
   - `FM_SETTLEMENT_AGING`
   - `FM_TRANSACTION_FLOW`
   - `FM_AUDIT_MONTHLY`
7. Construire la table de faits principale `FM_FINANCE_MONTHLY`.
8. Calculer les flags de risque et le score composite.
9. Agréger les indicateurs au niveau partenaire avec `FM_PARTNER_PERFORMANCE`.
10. Exposer la vue finale `VW_BI_FINANCE_COCKPIT`.
11. Exécuter les contrôles qualité sur les volumes, les distributions et les champs clés.

---

## 🧮 Règles de calcul et de transformation

Les règles de calcul structurent les principaux indicateurs financiers, les flags de risque et les classifications utilisées dans la couche MART.

| Règle | Description | Sortie impactée |
|---|---|---|
| **Commission payout ratio** | Ratio entre commission payée et commission attendue, avec protection contre la division par zéro. | `commission_payout_ratio_pct` |
| **Collection rate** | Ratio entre montant payé et montant dû. | `collection_rate_pct` |
| **Reversal rate** | Part des transactions inversées dans le total des transactions. | `reversal_rate_pct` |
| **Commission issue flag** | Flag actif si des commissions sont en attente ou en exception. | `has_commission_issues_flag` |
| **Residual risk flag** | Flag actif si le niveau de résidu dépasse un seuil métier. | `has_high_residual_flag` |
| **Overdue risk flag** | Flag actif si le taux de règlements en retard dépasse un seuil métier. | `has_overdue_risk_flag` |
| **Reversal risk flag** | Flag actif si le taux de reversal dépasse un seuil métier. | `has_high_reversal_flag` |
| **Total risk flags** | Somme des flags binaires pour obtenir un score composite de risque. | `total_risk_flags` |
| **Partner risk level** | Classification du partenaire selon le niveau maximal de risque observé. | `partner_risk_level` |
| **Premium tier** | Catégorisation du contrat selon le montant de prime. | `premium_tier` |
| **Partition mensuelle** | Construction d’une clé de partition mensuelle au format `YYYYMM`. | `dt_partition_yyyymm` |

---

## ✅ Contrôles qualité et validation

Les contrôles qualité permettent de vérifier que les données chargées, transformées et exposées restent cohérentes, complètes et exploitables pour le reporting.

| Contrôle | Objectif |
|---|---|
| **Contrôle de volumétrie** | Vérifier que les tables RAW et MART contiennent les volumes attendus. |
| **Contrôle des partitions** | Vérifier que les périodes attendues sont présentes dans les tables de faits. |
| **Contrôle des clés** | Identifier les valeurs nulles ou incohérentes sur les champs clés. |
| **Contrôle des ratios** | Vérifier que les KPIs en pourcentage restent dans des plages cohérentes. |
| **Contrôle des flags** | Vérifier que les flags de risque sont bien bornés et interprétables. |
| **Contrôle de la vue BI** | S’assurer que la vue finale est accessible et retourne une volumétrie cohérente. |

---

## ⚠️ Gestion des erreurs

La gestion des erreurs repose sur les mécanismes Snowflake natifs, complétés par des contrôles SQL et des protections dans les calculs.

| Cas | Détection | Gestion |
|---|---|---|
| Fichier source manquant | Erreur lors du chargement depuis le stage. | Arrêt du traitement et message Snowflake. |
| Format de fichier invalide | Erreur de parsing ou de typage. | Arrêt du chargement concerné. |
| Objet technique absent | Erreur DDL ou dépendance non créée. | Arrêt du script jusqu’à correction. |
| Division par zéro | Utilisation de `NULLIF`. | Retour d’une valeur `NULL` au lieu d’une erreur. |
| Jointures incomplètes | Valeurs nulles sur certaines clés de jointure. | Conservation des lignes avec neutralisation ou flag selon le cas. |
| Données incohérentes | Détection via règles de contrôle. | Signalement par flag ou contrôle qualité. |

---

## ⚡ Performance

Le pipeline est conçu pour réduire les recalculs côté BI et améliorer les temps de réponse grâce à des tables pré-calculées.

| Élément | Description |
|---|---|
| **Volumétrie cible** | Plusieurs milliers de lignes par source, consolidées dans des tables MART plus compactes. |
| **Stratégie d’optimisation** | Pré-calcul des KPIs dans les tables MART plutôt que recalcul dans les rapports. |
| **Partitionnement logique** | Utilisation de partitions mensuelles pour structurer les traitements analytiques. |
| **Joins maîtrisés** | Construction d’un keyset pour limiter les pertes d’information entre flux. |
| **Point de vigilance** | Prévoir clustering, matérialisation ou optimisation supplémentaire si les volumes augmentent fortement. |

---

## 🛡️ Sécurité et conformité

Le projet est conçu pour démonstration portfolio, sans exposition de données réelles ni d’éléments techniques internes.

| Aspect | Mesure appliquée |
|---|---|
| **Données sensibles** | Données synthétiques, anonymisées ou masquées. |
| **Noms techniques** | Remplacés par des noms génériques. |
| **Référentiels internes** | Non exposés. |
| **Principe de moindre privilège** | Le script ne nécessite pas de privilèges d’administration globale. |
| **Gouvernance** | Séparation des couches RAW, MART et BI pour clarifier les responsabilités. |
| **Auditabilité** | Logique SQL documentée et contrôles qualité explicités. |

---

## 🧪 Plan de tests

Les tests visent à valider la structure, la volumétrie, la cohérence métier et la disponibilité de la vue finale.

| ID | Test | Résultat attendu |
|---|---|---|
| `T-001` | Vérification du chargement RAW | Les sources sont chargées sans erreur. |
| `T-002` | Contrôle de volumétrie globale | Les volumes chargés sont cohérents avec les sources attendues. |
| `T-003` | Vérification de la structure MART | Les tables MART et la vue BI sont créées. |
| `T-004` | Contrôle des partitions | Les partitions mensuelles attendues sont présentes. |
| `T-005` | Validation des KPIs | Les ratios restent dans des plages cohérentes. |
| `T-006` | Validation du score de risque | `total_risk_flags` reste compris entre 0 et 4. |
| `T-007` | Validation des classifications | Les niveaux de risque restent dans les catégories attendues. |
| `T-008` | Contrôle des champs clés | Les champs clés de la vue BI ne présentent pas de nullité critique. |
| `T-009` | Accessibilité de la vue BI | La vue finale retourne un résultat exploitable. |

---

## 🧾 Contrôle des versions

| Version | Date | Description |
|---|---|---|
| `v0.1` | 2026-06-25 | Création initiale de la spécification technique. |
| `v1.0` | À compléter | Version stabilisée pour démonstration portfolio. |

---

## 📌 Checklist de validation

- [x] Le rôle du script est clairement identifié.
- [x] Les sources de données sont documentées.
- [x] Les tables RAW, MART et la vue BI sont décrites.
- [x] Les règles de calcul principales sont explicitées.
- [x] Les contrôles qualité sont listés.
- [x] Les cas d’erreur sont documentés.
- [x] Les principes de sécurité et d’anonymisation sont précisés.
- [x] Les tests de validation sont structurés.
- [x] Le document est aligné avec la version portfolio publique du projet.
