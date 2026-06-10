
/*
===============================================================================
FICHIER: sp_calc_collect_app.sql
PROJET: Analyse apporteurs
OBJET: Creation d'une procedure stockee Snowflake pour calculer les collectes
       et decollectes des contrats actifs par apporteur et par partition.

ENTREE:
- dt_partition INT : partition de traitement (format AAAAMM).
- res_table_path STRING : table cible de sortie (nom pleinement qualifie).
- agi STRING : conserve pour compatibilite d'appel (selection env geree par initialization.sql).

SORTIE:
- Table de resultats alimentee par MERGE avec les colonnes:
  codapp, collecte, decollecte, ea, annee, mois, codevecompta,
  dt_partition, date_calcul.

REMARQUES:
- Le calcul exclut les flux nuls et les operations annulees/annulantes.
- Les montants sont consolides par apporteur, annee, mois et type d'evenement.
- La procedure met a jour les lignes existantes et insere les nouvelles.
- Les codes d'evenements comptables utilises pour le filtrage sont egalement
  deanonimises/generalises pour publication.

EXEMPLE D'APPEL:
CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app(
  202504,
  'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SYN_SEI_COLLECTE',
  'PRD'
);

PRE-REQUIS:
- Le script initialization.sql doit etre execute avant cette procedure.
- Les variables de session source (lignecptcapi, compteclient, operation,
  contr_ea_j, hierappcontr, codapp_scope) sont attendues.

IMPORTANT - CONFIDENTIALITE:
LES NOMS DE BASES, SCHEMAS, WAREHOUSES ET AUTRES IDENTIFIANTS CORPORATE
SONT DEANONYMISES / GENERALISES A DES FINS DE CONFIDENTIALITE.
CE SCRIPT EST FOURNI UNIQUEMENT POUR REVUE TECHNIQUE ET PRESENTATION.
===============================================================================
*/
CREATE OR REPLACE PROCEDURE DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app(
    dt_partition INT,
    res_table_path STRING,
    agi STRING
  ) RETURNS
   STRING 
   LANGUAGE SQL 
   EXECUTE AS CALLER --Pour pouvoir utiliser les variables de session
  AS 
  $$
  DECLARE 

  current_date DATE DEFAULT CURRENT_DATE(); -- Variable pour stocker la date actuelle

  BEGIN 

  -- Création de la table de sortie si elle n'existe pas
  CREATE TRANSIENT TABLE IF NOT EXISTS identifier(:res_table_path) (
    codapp STRING,                         -- Code unique de l'apporteur (dimension de regroupement principale).
    collecte FLOAT,                        -- Montant total des flux entrants (collectes) pour la cle d'agregation.
    decollecte FLOAT,                      -- Montant total des flux sortants (decollectes) pour la cle d'agregation.
    ea FLOAT,                              -- Encours consolide (actifs) rattache a l'apporteur sur la periode.
    annee INT,                             -- Annee de reference de l'operation (derivee de datcrea ou dt_partition).
    mois INT,                              -- Mois de reference de l'operation (1-12).
    codevecompta STRING,                   -- Code evenement comptable (liste anonymisee, ex.: EVT_COL_01, EVT_DEC_03).
    dt_partition INT,                      -- Partition technique de traitement (format AAAAMM).
    date_calcul DATE DEFAULT current_date  -- Date d'execution du calcul chargee dans la table cible.
  );

  -- Construire une table temporaire de flux elementaires avant consolidation.
  -- Le CTE "raw_ops" calcule d'abord les montants techniques, puis la projection finale
  -- derive les montants metier (collecte/decollecte) selon le sens du flux.
  CREATE OR REPLACE TEMP TABLE tmp_flux AS
  WITH raw_ops AS (
    SELECT
      l.numcontrat,
      YEAR(cct.datcrea) AS annee,
      MONTH(cct.datcrea) AS mois,
      -- Identifiant operationnel (mouvement comptable) pour exclusion des annulations.
      cct.numcptcli AS numoperat,
      cct.codevecompta,
      cct.datcrea,
      -- Variation comptable de l'operation (signe = sens du flux).
      cct.mtcptcr - cct.mtcptdb AS mt_operation,
      -- Somme des lignes de capitalisation rattachees a l'operation.
      SUM(l.mtcrcapi - l.mtdbcapi) AS mt_ligne,
      cnt.codapp,
      cct.dt_partition
    FROM identifier($compteclient) cct
    JOIN identifier($lignecptcapi) l
      ON l.numopecapi = cct.numcptcli
     AND l.dt_partition = :dt_partition
    JOIN identifier($hierappcontr) cnt
      ON cct.numcontrat = cnt.numcontrat
     AND cnt.dt_partition = :dt_partition
    WHERE TRUE
      -- Filtre strict de partition pour coherence temporelle des jointures.
      AND cct.dt_partition = :dt_partition
      AND (cct.mtcptcr - cct.mtcptdb) <> 0 -- Eliminer les flux nuls.
      -- Types de mouvements retenus dans le perimetre metier collecte/decollecte.
      -- IMPORTANT: liste de codes generalisee/deanonimisee pour diffusion publique.
      AND cct.nummvtcptcli IN (1, 2)
      AND TRIM(cct.codevecompta) IN (
        'EVT_COL_01', 'EVT_COL_02', 'EVT_COL_03', 'EVT_COL_04', 'EVT_COL_05',
        'EVT_DEC_01', 'EVT_DEC_02', 'EVT_DEC_03', 'EVT_DEC_04', 'EVT_DEC_05', 'EVT_DEC_06'
      )
      -- Limite de periode: annee de transaction comprise entre 2022 et l'annee de dt_partition.
      AND YEAR(cct.datcrea) <= FLOOR(:dt_partition / 100)
      AND YEAR(cct.datcrea) >= 2022
      -- Filtre ponctuel applique via variable de session (optionnel).
      AND (NULLIF($codapp_scope, '') IS NULL OR cnt.codapp = $codapp_scope)
    GROUP BY
      l.numcontrat,
      cnt.codapp,
      cct.numcptcli,
      cct.codevecompta,
      cct.datcrea,
      cct.dt_partition,
      cct.mtcptcr,
      cct.mtcptdb
  )
  SELECT
    numcontrat,
    annee,
    mois,
    numoperat,
    codevecompta,
    datcrea,
    -- Type flux derive du signe du mouvement comptable.
    CASE
      WHEN mt_operation < 0 THEN 'sortant'
      WHEN mt_operation > 0 THEN 'entrant'
      ELSE 'flux null'
    END AS type_flux,
    -- Montant brut:
    -- entrant => mouvement comptable;
    -- sortant => somme des lignes de capitalisation.
    CASE
      WHEN mt_operation > 0 THEN mt_operation
      ELSE mt_ligne
    END AS mt_brut,
    -- Montant net (complementaire du montant brut selon le sens du flux).
    CASE
      WHEN mt_operation > 0 THEN mt_ligne
      ELSE mt_operation
    END AS mt_net,
    codapp,
    -- Colonnes initialisees, alimentees ensuite dans l'etape MERGE.
    0.00 AS collecte,
    0.00 AS decollecte,
    dt_partition
  FROM raw_ops;

    -- Supprimer les opérations annulées
  DELETE FROM tmp_flux
  USING identifier($operation)  o2
  WHERE tmp_flux.numoperat = o2.numopeann AND o2.numopeann <> 0
  AND o2.dt_partition = :dt_partition;

  -- Supprimer les opérations annulantes
  DELETE FROM tmp_flux
  USING identifier($operation) o2
  WHERE tmp_flux.numoperat = o2.numoperat AND o2.numopeann <> 0
  AND o2.dt_partition = :dt_partition;

-- Fusionner les donnees calculees dans la table cible (upsert).
MERGE INTO identifier(:res_table_path) AS cible 
USING (
  -- Agréger les données temporaires par code apporteur, année et partition
  SELECT codapp,
    annee,
    mois,
    dt_partition,
    codevecompta,
    -- Calculer le montant total des collectes (flux entrants)
    SUM(
      CASE
        type_flux
        -- Les flux entrants alimentent la collecte.
        WHEN 'entrant' THEN mt_brut
        ELSE 0.00
      END
    ) AS collecte,
    -- Calculer le montant total des décollectes (flux sortants)
    SUM(
      CASE
        type_flux
        -- Les flux sortants alimentent la decollecte.
        WHEN 'sortant' THEN mt_net
        ELSE 0.00
      END
    ) AS decollecte,
    current_date AS date_calcul
  FROM tmp_flux 
  GROUP BY codapp,
    annee,
    mois,
    codevecompta,
    dt_partition
) AS source 
-- Condition de correspondance entre la table cible et la source
ON  cible.codapp = source.codapp
AND cible.annee = source.annee
AND cible.mois = source.mois
AND cible.codevecompta = source.codevecompta
WHEN MATCHED THEN
-- Mettre à jour les collectes, décollectes et la date de calcul si une correspondance est trouvée
UPDATE
SET collecte = source.collecte,
  decollecte = source.decollecte,
  date_calcul = source.date_calcul,
  dt_partition = source.dt_partition
WHEN NOT MATCHED THEN
-- Insérer de nouvelles données si aucune correspondance n'est trouvée
INSERT (
    codapp,
    annee,
    mois,
    codevecompta,
    dt_partition,
    collecte,
    decollecte,
    date_calcul
  )
VALUES (
    source.codapp,
    source.annee,
    source.mois,
    source.codevecompta,
    source.dt_partition,
    source.collecte,
    source.decollecte,
    source.date_calcul
  );

-- Enrichir la table cible avec l'encours (ea) calcule sur la table d'encours journaliere.
UPDATE identifier(:res_table_path) res
SET ea = aggregated.total_ea
FROM (
  SELECT
  h.codapp,
    -- Deriver annee/mois depuis la partition pour alignement avec la granularite cible.
    FLOOR(ea.dt_partition/100) AS annee, 
    mod(ea.dt_partition, 100) AS mois,
  -- Encours consolide par apporteur et par partition.
    SUM(ea.mttotalfr) AS total_ea
  FROM identifier($contr_ea_j) ea
  LEFT JOIN identifier($hierappcontr) h
    ON ea.numcontrat = h.numcontrat AND h.dt_partition = ea.dt_partition
    WHERE true
       AND    numordhiera = 1
    AND numordbenef = 0
    AND (
    current_date BETWEEN datdebhierar AND h.datfinhierar
    OR YEAR(h.datfinhierar) = 1830) 
  GROUP BY h.codapp, ea.dt_partition
) AS aggregated
WHERE res.codapp = aggregated.codapp
  AND res.annee = aggregated.annee
  AND res.mois = aggregated.mois;

-- Retour applicatif standard pour tracer le succes de la procedure.
Return 'Table des collectes est  mise à jour avec succès.';
END;

$$;

-- Appel de demonstration (contexte portfolio / revue technique)
CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_collect_app(
  202504,
  'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.SYN_SEI_COLLECTE',
  'PRD'
);

