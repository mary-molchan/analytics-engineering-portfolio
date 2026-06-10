/*
===============================================================================
FICHIER: sp_calc_app_stats.sql
PROJET: Analyse apporteurs
OBJET: Creation d'une procedure stockee Snowflake pour constituer la liste des
       apporteurs avec contrats en vie et indicateurs d'encours associes.

ENTREE:
- dt_partition NUMBER : partition de reference (format AAAAMM).
- table_path STRING : table cible de sortie (nom pleinement qualifie).

SORTIE:
- Table physique avec les colonnes:
  codapp, libnomapp, codcompagnie, codportefeuille, reseaudistrib,
  date_debut, nb_contrats, nb_contrats_retraite, nb_contrats_vie,
  ea, ea_pct_euro, ea_pct_uc, ea_uc, ea_eu, date_calcul.

EXEMPLE D'APPEL:
CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats(
  202505,
  'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.LIST_APPORT'
);

PRE-REQUIS:
- Le script initialization.sql doit etre execute avant cette procedure.
- Les variables de session source (contrat, situatcontr, typesituat, etc.)
  sont attendues et reutilisees pour eviter la duplication de configuration.

IMPORTANT - CONFIDENTIALITE:
LES NOMS DE BASES, SCHEMAS, WAREHOUSES ET AUTRES IDENTIFIANTS CORPORATE
SONT DEANONYMISES / GENERALISES A DES FINS DE CONFIDENTIALITE.
CE SCRIPT EST FOURNI UNIQUEMENT POUR REVUE TECHNIQUE ET PRESENTATION.
===============================================================================
*/

-- Création la procédure stockée
--------------------------------
CREATE OR REPLACE PROCEDURE DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats(
    dt_partition NUMBER,
    table_path STRING -- chemin vers la table à créer
    )
    RETURNS STRING 
    LANGUAGE SQL 
    EXECUTE AS CALLER
  AS 
  $$
  BEGIN
    
    -- Création de la table de sortie si elle n'existe pas  
    CREATE OR REPLACE TRANSIENT TABLE identifier(:table_path) (
        codapp VARCHAR(16777216),               -- Code de l'apporteur
        libnomapp VARCHAR(16777216),            -- Nom de l'apporteur
        codcompagnie VARCHAR(16777216),         -- Code de la compagnie
        codportefeuille VARCHAR(16777216),      -- Code du portefeuille
        reseaudistrib VARCHAR(16777216),        -- Réseau de distribution
        date_debut DATE,                        -- Extrait uniquement la date du format Timestamp_NTZ
        nb_contrats NUMBER(18,0),               -- Nombre total de contrats
        nb_contrats_retraite NUMBER(18,0),      -- Nombre de contrats de retraite
        nb_contrats_vie NUMBER(18,0),           -- Nombre de contrats de vie
        ea NUMBER(38,2),                        -- Montant total de l'encours
        ea_pct_euro NUMBER(38,2),               -- Pourcentage de l'encours en euros
        ea_pct_uc NUMBER(38,2),                 -- Pourcentage de l'encours en unités de compte
        ea_uc NUMBER(38,2),                     -- Montant total de l'encours en unités de compte
        ea_eu NUMBER(38,2),                     -- Montant total de l'encours en euros
        date_calcul DATE DEFAULT CURRENT_DATE   -- Date actuelle de calcul
     );

    -- Insérer les données dans la table de sortie
    INSERT INTO identifier(:table_path)
    -- CTE: calcul des encours par contrat, distingues entre euro et UC.
    WITH ea_by_type AS (
        SELECT DISTINCT
            cnt.numcontrat,
        -- Encours euro (mode de gestion = 1).
            SUM(CASE WHEN ea.enummodges = 1 THEN ea.mttotalfr ELSE 0 END) AS mttotalfr_euro,
        -- Encours unite de compte (mode de gestion = 2).
            SUM(CASE WHEN ea.enummodges = 2 THEN ea.mttotalfr ELSE 0 END) AS mttotalfr_uc,
        -- Encours global tous modes confondus.
            SUM(ea.mttotalfr) AS mttotalfr_global,
            p.codcompagnie
        FROM identifier($contrgael_ea_j) AS ea
      -- Jointure contrat pour rattacher l'encours au contrat de reference.
        JOIN identifier($contrat) AS cnt ON cnt.numcontrat = ea.numcontrat
      -- Jointures de situation et typologie pour filtrer uniquement les contrats en vie.
        LEFT JOIN identifier($situatcontr) AS s ON s.numcontrat = cnt.numcontrat
        LEFT JOIN identifier($typesituat) AS t ON t.codtypsituat = s.codtypsituat
      -- Jointure produit pour recuperer la compagnie associee.
        LEFT JOIN identifier($produit) AS p ON p.codproduit = cnt.codproduit
      -- Filtre de partition pour garantir la coherence temporelle de l'ensemble des sources.
        WHERE ea.dt_partition = :dt_partition
          AND cnt.dt_partition = :dt_partition
          AND t.dt_partition = :dt_partition
          AND s.dt_partition = :dt_partition
          AND p.dt_partition = :dt_partition
          AND t.indetatcontr = 2 -- Contrat en vie
        -- Contrat actif a la date du jour ou date de fin conventionnelle ouverte (annee 1830).
          AND (current_date BETWEEN datdebsituat AND datfinsituat OR YEAR(datfinsituat) = 1830)
        GROUP BY cnt.numcontrat, p.codcompagnie
    )
    -- Agregation finale par apporteur pour produire les indicateurs de volumetrie et d'encours.
    SELECT 
        TRIM(h.codapp) AS codapp,
        TRIM(app.libnomapp) AS libnomapp,
        TRIM(app.codcompagnie) AS codcompagnie,
        TRIM(codportefeuille) AS codportefeuille,
        TRIM(distr.libreseaudistrib) AS reseaudistrib,
        TO_DATE(app.datdebapp) AS date_debut,
        COUNT(cnt.numcontrat) AS nb_contrats,
        COUNT(DISTINCT CASE WHEN cnt.codcompagnie = 'RETRAITE' THEN cnt.numcontrat END) AS nb_contrats_retraite,
        COUNT(DISTINCT CASE WHEN cnt.codcompagnie != 'RETRAITE' THEN cnt.numcontrat END) AS nb_contrats_vie,
        ROUND(SUM(mttotalfr_global), 2) AS ea,
        ROUND(SUM(mttotalfr_euro) / SUM(mttotalfr_global) * 100, 2) AS ea_pct_euro,
        ROUND(SUM(mttotalfr_uc) / SUM(mttotalfr_global) * 100, 2) AS ea_pct_uc,
        ROUND(SUM(mttotalfr_uc), 2) AS ea_uc,
        ROUND(SUM(mttotalfr_euro), 2) AS ea_eu,
        CURRENT_DATE() AS date_calcul
    FROM ea_by_type cnt
    -- Rattachement du contrat a la hierarchie apporteur et aux dimensions descriptives.
    LEFT JOIN identifier($hierappcontr) AS h ON h.numcontrat = cnt.numcontrat
    LEFT JOIN identifier($apporteur) AS app ON h.codapp = app.codapp
    LEFT JOIN identifier($reseaudistrib) AS distr ON distr.codreseaudistrib = app.codreseaudistrib
      -- Selection du niveau principal de hierarchie apporteur/beneficiaire.
      WHERE numordhiera = 1
      AND numordbenef = 0
      -- Conservation des liens hierarchiques actifs.
      AND (current_date BETWEEN datdebhierar AND datfinhierar OR YEAR(datfinhierar) = 1830)
      -- Alignement de partition sur les dimensions de sortie.
      AND h.dt_partition = :dt_partition
      AND app.dt_partition = :dt_partition
      AND distr.dt_partition = :dt_partition
    GROUP BY h.codapp, app.libnomapp, app.codcompagnie, codportefeuille, distr.libreseaudistrib, TO_DATE(app.datdebapp), CURRENT_DATE();

-- Message de retour standard pour tracer le succes d'alimentation de la table cible.
RETURN 'Le tableau ' || table_path || ' a été mis à jour avec succès';

END;
$$;

-- Appel de procédure avec paramètres d'entrée
CALL DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.sp_calc_app_stats(202505, 'DEV_DB_INSURANCE.SC_SYNTH_INSURANCE.LIST_APPORT');
