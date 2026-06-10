/*
===============================================================================
FICHIER: sp_orchestrate_apporteurs.sql
PROJET: Analyse apporteurs
OBJET: Procedure stockee orchestratrice pour executer la chaine de mise a jour
       des donnees apporteurs via:
       1) sp_calc_collect_app
       2) sp_calc_app_stats

ENTREE:
- Aucun parametre (partition calculee automatiquement au format AAAAMM).

SORTIE:
- TABLE(
    timestamp_exec TIMESTAMP_LTZ,
    statut VARCHAR,
    duree_execution VARCHAR,
    execute_par VARCHAR,
    role_actif VARCHAR,
    periode_traitee NUMBER(38,0)
  )

IMPORTANT - CONFIDENTIALITE:
LES NOMS DE BASES, SCHEMAS, WAREHOUSES ET AUTRES IDENTIFIANTS CORPORATE
SONT DEANONYMISES / GENERALISES A DES FINS DE CONFIDENTIALITE.
CE SCRIPT EST FOURNI UNIQUEMENT POUR REVUE TECHNIQUE ET PRESENTATION.
===============================================================================
*/

-- Contexte de deploiement de la procedure
-- Ces commandes s'appliquent au script de creation (DDL) lui-meme.
USE WAREHOUSE WH_SHARED_ANALYTICS;
USE DATABASE DEV_DB_INSURANCE;
USE SCHEMA SC_SYNTH_INSURANCE;
ALTER SESSION SET QUOTED_IDENTIFIERS_IGNORE_CASE = TRUE;

CREATE OR REPLACE PROCEDURE DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SP_MAJ_APPORT_PARTCALC()
RETURNS TABLE (
  timestamp_exec TIMESTAMP_LTZ,   -- Horodatage de fin d'execution.
  statut VARCHAR,                 -- Statut global (succes/erreur fonctionnelle).
  duree_execution VARCHAR,        -- Duree lisible au format "X min Y sec".
  execute_par VARCHAR,            -- Utilisateur Snowflake ayant lance la procedure.
  role_actif VARCHAR,             -- Role actif pendant l'execution.
  periode_traitee NUMBER(38,0)    -- Partition effectivement traitee (AAAAMM).
)
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
  -- Tables cibles de la chaine (synthese).
    syn_collecte_table_path STRING DEFAULT 'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SYN_SEI_COLLECTE';
    syn_apporteur_table_path STRING DEFAULT 'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.LIST_APPORT';

  -- Variables techniques de journalisation et controle.
    start_time TIMESTAMP_LTZ;
    end_time TIMESTAMP_LTZ;
  calculated_partition NUMBER; -- Partition calculee automatiquement sur la date courante.
  data_exists NUMBER;          -- Presence des donnees source pour la partition cible.
  res RESULTSET;               -- Table de retour exposee au caller.
BEGIN
    -- 0) Calcul automatique de la partition (mois courant, format AAAAMM).
    calculated_partition := YEAR(CURRENT_DATE()) * 100 + MONTH(CURRENT_DATE());

  -- 1) Contexte et variables partagees (equivalent initialization, dans la session d'execution).
  -- Important: les procedures filles utilisent ces variables de session via identifier($var).
    EXECUTE IMMEDIATE 'USE DATABASE DEV_DB_INSURANCE';
    EXECUTE IMMEDIATE 'USE SCHEMA SC_SYNTH_INSURANCE';

  -- Parametres de pilotage: env = source PRD/REC, codapp_scope = filtre optionnel.
    SET env = 'PRD';
    SET codapp_scope = '';
  -- Prefixes de schemas source par environnement.
    SET db_schema_prod = 'corelake.prd_insurance.v_contracts_t_';
    SET db_schema_rec = 'corelake.rec_insurance.v_contracts_t_';
    SET db_schema_path = '';

    -- Selection du prefixe source sans EXECUTE IMMEDIATE pour eviter un conflit
    -- de delimiters avec le bloc principal de la procedure.
    IF ($env = 'REC') THEN
      SET db_schema_path = $db_schema_rec;
    ELSE
      SET db_schema_path = $db_schema_prod;
    END IF;

    -- Resolution centralisee des tables source (mutualisees pour les 2 procedures filles).
    SET lignecptcapi = $db_schema_path || 'lignecptcapi';
    SET contrat = $db_schema_path || 'contrat';
    SET compteclient = $db_schema_path || 'compteclient';
    SET situatcontr = $db_schema_path || 'situatcontr';
    SET typesituat = $db_schema_path || 'typesituat';
    SET operation = $db_schema_path || 'operation';
    SET hierappcontr = $db_schema_path || 'hierappcontr';
    SET apporteur = $db_schema_path || 'apporteur';
    SET reseaudistrib = $db_schema_path || 'reseaudistrib';
    SET produit = $db_schema_path || 'produit';
    SET contrgael_ea_j = $db_schema_path || 'contrgael_ea_j';
    SET contr_ea_j = $db_schema_path || 'contr_ea_j';

    -- 2) Validation source: presence de donnees pour la partition calculee.
    -- Si aucune donnee source n'est disponible, on arrete l'orchestration proprement.
    SELECT COUNT(*)
      INTO :data_exists
      FROM identifier($apporteur)
     WHERE dt_partition = :calculated_partition;

    IF (data_exists = 0) THEN
        -- Retour d'erreur fonctionnelle sans lancer les calculs metier.
        res := (
          SELECT
            CURRENT_TIMESTAMP()::TIMESTAMP_LTZ AS timestamp_exec,
            ('ERREUR: Aucune donnee source pour la partition ' || :calculated_partition::VARCHAR)::VARCHAR AS statut,
            '0 sec'::VARCHAR AS duree_execution,
            CURRENT_USER()::VARCHAR AS execute_par,
            CURRENT_ROLE()::VARCHAR AS role_actif,
            (:calculated_partition - 1)::NUMBER(38,0) AS periode_traitee
        );
        RETURN TABLE(res);
    END IF;

    -- 3) Demarrage du chronometre.
    start_time := CURRENT_TIMESTAMP();

    -- 4) Orchestration des 2 procedures metier.
    -- Ordre volontaire:
    --   a) calcul des collectes/decollectes (base de perimetre actif),
    --   b) calcul de la liste/indicateurs apporteurs.
    CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app(
      :calculated_partition,
      :syn_collecte_table_path,
      $env
    );

    CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats(
      :calculated_partition,
      :syn_apporteur_table_path
    );

    -- 5) Fin et retour du statut d'execution.
    -- On consolide ici les metadonnees techniques utiles au monitoring.
    end_time := CURRENT_TIMESTAMP();

    res := (
      SELECT
        :end_time::TIMESTAMP_LTZ AS timestamp_exec,
        'SUCCES COMPLET'::VARCHAR AS statut,
        CONCAT(
          FLOOR(DATEDIFF('second', :start_time, :end_time) / 60), ' min ',
          MOD(DATEDIFF('second', :start_time, :end_time), 60), ' sec'
        )::VARCHAR AS duree_execution,
        CURRENT_USER()::VARCHAR AS execute_par,
        CURRENT_ROLE()::VARCHAR AS role_actif,
        :calculated_partition::NUMBER(38,0) AS periode_traitee
    );

    -- Retour final au format table pour compatibilite avec les usages BI/monitoring.
    RETURN TABLE(res);
END;
$$;

-- Appel de demonstration
CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SP_MAJ_APPORT_PARTCALC();
