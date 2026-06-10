/*
===============================================================================
FICHIER: initialization.sql
PROJET: Analyse apporteurs
OBJET: Initialiser le contexte d'execution Snowflake et preparer les variables
       d'environnement et les tables source utilisees dans les scripts suivants.

USAGE:
- Ce script doit etre execute avant les etapes de collecte/transformation.
- Il definit le warehouse, la base, le schema, les bornes temporelles et
  les chemins de tables selon l'environnement cible.

PARAMETRES CLES:
- env: definit l'environnement cible (REC ou PRD).
- dt_partition / datcrea_min / datcrea_max: filtres temporels de traitement.
- codapp_scope: filtrage optionnel d'un apporteur cible pour les tests.

CHANGELOG:
- 2026-06-10: deanonimisation des identifiants techniques pour presentation,
  ajout de commentaires de contexte, harmonisation du format de date,
  nettoyage des commentaires internes non pertinents.

IMPORTANT - CONFIDENTIALITE:
LES NOMS DE BASES, SCHEMAS, WAREHOUSES ET AUTRES IDENTIFIANTS CORPORATE
SONT DEANONYMISES / GENERALISES A DES FINS DE CONFIDENTIALITE.
CE SCRIPT EST FOURNI UNIQUEMENT POUR REVUE TECHNIQUE ET PRESENTATION.
===============================================================================
*/

--------------------------------
-- DÉFINIR LE CONTEXTE
--------------------------------
-- Selection du warehouse de calcul pour l'execution du script.
USE WAREHOUSE WH_SHARED_ANALYTICS;


-- Base et schema de travail pour la preparation des donnees de synthese.
SET database = 'DEV_DB_INSURANCE';
SET schema = 'SC_SYNTH_INSURANCE';

-- Application dynamique du contexte (evite les hardcodes multiples).
USE DATABASE identifier($database);
USE SCHEMA identifier($schema);


--------------------------------
-- PARAMÈTRES DE SESSION
--------------------------------
-- Rend les identifiants entre guillemets non sensibles a la casse.
ALTER SESSION SET QUOTED_IDENTIFIERS_IGNORE_CASE = TRUE;

--------------------------------
-- DÉFINIR LES VARIABLES
--------------------------------
-- Partition fonctionnelle (format AAAAMM) pour les traitements periodiques.
SET dt_partition = 202504;
-- Bornes minimales et maximales de date de creation pour le perimetre extrait.
SET datcrea_min = '2025-01-01';
SET datcrea_max = '2025-01-05';

-- Horodatage courant de session pour tracer/referencer l'execution.
SET current_date = getdate();
-- Filtre ponctuel pour les tests de controle (valeur anonymisee pour diffusion publique;
-- laisser '' pour traitement global sans filtre apporteur).
SET codapp_scope = 'APP_DEMO_001';

--------------------------------
-- PARAMÈTRES OUTPUT
--------------------------------
-- Tables de sortie standard pour les deux procedures.
SET list_apport_table = $database || '.' || $schema || '.LIST_APPORT';
SET syn_sei_collecte_table = $database || '.' || $schema || '.SYN_SEI_COLLECTE';

--------------------------------
-- DÉFINIR LES ENVIRONNEMENTS
--------------------------------
-- Prefixes techniques des objets source selon l'environnement.
SET db_schema_prod = 'corelake.prd_insurance.v_contracts_t_';
SET db_schema_rec = 'corelake.rec_insurance.v_contracts_t_';
-- Variable resolue dynamiquement selon la valeur de env.
SET db_schema_path = '';
-- Environnement actif (REC ou PRD).
SET env = 'PRD';
EXECUTE IMMEDIATE
$$
BEGIN
  -- Selection conditionnelle du prefixe de tables source.
  IF ($env = 'REC') THEN
    SET db_schema_path = $db_schema_rec;
  ELSE
    SET db_schema_path = $db_schema_prod;
  END IF;
END;
$$;

--------------------------------
-- DÉFINIR LES TABLES INPUT
--------------------------------
-- Construction des references completes des tables sources (mutualisees).
SET lignecptcapi = $db_schema_path || 'lignecptcapi';    -- Lignes de capitalisation par operation (detail des montants techniques debit/credit).
SET contrat = $db_schema_path || 'contrat';              -- Referentiel contrats (identifiants contrat, rattachements produit/compagnie, metadonnees).
SET compteclient = $db_schema_path || 'compteclient';    -- Mouvements de compte client (dates, evenements comptables, montants, numero operation).
SET situatcontr = $db_schema_path || 'situatcontr';      -- Historique des situations de contrat (etat dans le temps, bornes de validite).
SET typesituat= $db_schema_path || 'typesituat';         -- Typologie des situations de contrat (codes et indicateurs d'etat, ex. contrat en vie).
SET dossierpre = $db_schema_path || 'dossierpre';        -- Donnees dossier/prestation utilisees pour enrichissements metier (si besoin de perimetre).
SET tresattente = $db_schema_path || 'tresattente';      -- Ecritures/flux en attente de traitement (table de travail technique selon cas).
SET operation = $db_schema_path || 'operation';          -- Referentiel des operations (annulees/annulantes, liens de compensation).
SET hierappcontr = $db_schema_path || 'hierappcontr';    -- Hierarchie contrat -> apporteur avec ordre, role beneficiaire et validite temporelle.
SET apporteur = $db_schema_path || 'apporteur';          -- Referentiel apporteurs (identite, libelle, attributs de portefeuille).
SET reseaudistrib = $db_schema_path || 'reseaudistrib';  -- Referentiel reseau de distribution (codes reseau, libelles commerciaux).
SET produit = $db_schema_path || 'produit';              -- Referentiel produits (codification produit, compagnie, attributs de segmentation).
SET contrgael_ea_j = $db_schema_path || 'contrgael_ea_j';-- Encours journalier par contrat pour calcul des montants euro/UC et ratios.
SET contr_ea_j = $db_schema_path || 'contr_ea_j';        -- Encours journalier par contrat utilise pour l'enrichissement EA des collectes.

--------------------------------
-- CHECKLIST DE PRE-EXECUTION
--------------------------------
-- 1) Executer ce script avant les scripts de creation de procedures.
-- 2) Verifier env/dt_partition/codapp_scope selon le besoin de demonstration.
-- 3) Lancer ensuite les procedures avec les tables de sortie ci-dessous:
--    CALL ...sp_calc_app_stats($dt_partition, $list_apport_table);
--    CALL ...sp_calc_collect_app($dt_partition, $syn_sei_collecte_table, $env);

