/*********************************************************************************************
 *  Reporting Adherents Courtiers
 *  (DDL + DML pour alimentation Power BI)
 *
 *  PRESENTATION DU PROJET :
 *    Ce script cree et alimente une table physique de reporting sur les adherents
 *    du perimetre de distribution courtiers.
 *    La procedure stockee consolide les donnees adherent, contrat, convocation
 *    et courtier avec une logique incrementale et une fenetre historique maitrisee.
 *
 *  OBJECTIF METIER :
 *    - Fournir un jeu de donnees stable et exploitable pour le pilotage.
 *    - Reduire le cout de recalcul en ne chargeant que les partitions manquantes.
 *    - Maintenir une fenetre glissante de 5 ans.
 *    - Soutenir l'analyse de productivite du reseau de courtiers.
 *
 *  CODE PERIMETRE :
 *    - PERIM_COURTIER_ASTER
 *
 *  FLUX GENERAL :
 *    1) Creation de la table cible RPT_ADHERENTS_COURTIERS.
 *    2) Suppression automatique des partitions hors perimetre temporel.
 *    3) Insertion des partitions eligibles absentes uniquement.
 *    4) Enrichissement des donnees via jointures LEFT.
 *    5) Application de controles qualite (code postal/departement).
 *
 *  NOTE CONFIDENTIALITE :
 *    Ce script est anonymise pour diffusion technique.
 *    Aucun nom reel de warehouse, base, schema, table, vue ou libelle interne.
 *
 *  DATE DE CREATION : 2026-06-10
 ********************************************************************************************/

---------------------------------
-- 0) Configuration de session
---------------------------------
USE WAREHOUSE "WH_ANALYSE_PARTAGE";
USE DATABASE "BD_ASSURANCE_DEMO";
USE SCHEMA "SC_PILOTAGE_COURTIERS";
ALTER SESSION SET QUOTED_IDENTIFIERS_IGNORE_CASE = TRUE;

---------------------------------
-- 1) Creation de la table cible
---------------------------------
CREATE TABLE IF NOT EXISTS BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS (
    ID_ADHERENT                     VARCHAR,  -- identifiant metier unique de l'adherent
    LIB_CIVILITE                    VARCHAR,  -- civilite normalisee issue du code source
    NOM_ADHERENT                    VARCHAR,  -- nom de famille de l'adherent
    PRENOM_ADHERENT                 VARCHAR,  -- prenom de l'adherent
    ADRESSE_LIGNE_1                 VARCHAR,  -- ligne principale d'adresse postale
    COMPLEMENT_ADRESSE              VARCHAR,  -- complement d'adresse (batiment, etage, etc.)
    VILLE                           VARCHAR,  -- ville issue du referentiel adherent
    CODE_POSTAL                     VARCHAR,  -- code postal sur 5 chiffres
    CODE_DEPARTEMENT                VARCHAR,  -- code departement derive des 2 premiers chiffres du code postal
    COMMUNE                         VARCHAR,  -- commune/quartier issue de la source convocation
    EMAIL_ADHERENT                  VARCHAR,  -- adresse email de l'adherent
    IND_EMAIL_PRESENT               VARCHAR,  -- indicateur Oui/Non selon presence d'un email
    TELEPHONE_ADHERENT              VARCHAR,  -- numero de telephone de l'adherent
    NUMERO_CONTRAT                  VARCHAR,  -- identifiant du contrat associe a l'adherent
    TYPE_PRODUIT                    VARCHAR,  -- famille/type de produit
    LIB_PRODUIT_ASSURANCE           VARCHAR,  -- libelle detaille du produit d'assurance
    DATE_EFFET_CONTRAT              DATE,     -- date d'effet du contrat
    DATE_FIN_CONTRAT                DATE,     -- date de fin du contrat (si disponible)
    STATUT_CONTRAT                  VARCHAR,  -- statut du contrat (actif/inactif ou equivalent source)
    ORIGINE_CONTRAT                 VARCHAR,  -- origine/canal/systeme source du contrat
    NOM_COURTIER                    VARCHAR,  -- nom affiche du courtier
    EMAIL_COURTIER                  VARCHAR,  -- email du courtier
    TELEPHONE_COURTIER              VARCHAR,  -- telephone prioritaire du courtier (fixe puis mobile)
    INDICATEUR_NPAI                 VARCHAR,  -- indicateur NPAI (courrier non distribuable)
    BUREAU_DISTRIBUTION             VARCHAR,  -- bureau ou agence de distribution
    CODE_PERIMETRE                  VARCHAR,  -- code fonctionnel de perimetre
    CLE_PARTITION                   VARCHAR,  -- cle technique de partition au format YYYYMM
    DATE_DERNIER_RAFRAICHISSEMENT   DATE      -- date de chargement dans la couche reporting
);

--------------------------------------------------
-- 2) Creation de la procedure de rafraichissement
--------------------------------------------------
CREATE OR REPLACE PROCEDURE BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.PS_RAFRAICHIR_ADHERENTS_COURTIERS()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
BEGIN
    -------------------------------------------------------
    -- ETAPE 1 : Suppression des partitions obsolete
    -- Etape autonome: calcule dynamiquement le perimetre
    -- temporel valide et purge les partitions hors fenetre.
    -- La table reste ainsi limitee a 5 ans glissants.
    --------------------------------------------------------
    DELETE FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
    WHERE CLE_PARTITION NOT IN (
        SELECT DISTINCT DT_PARTITION
        FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT
        WHERE DT_PARTITION LIKE TO_CHAR(YEAR(CURRENT_DATE)) || '%'
          AND DT_PARTITION <= TO_CHAR(YEAR(CURRENT_DATE)) || LPAD(MONTH(CURRENT_DATE), 2, '0')
        UNION
        SELECT TO_CHAR(YEAR(CURRENT_DATE) - 1) || '02'
        UNION
        SELECT TO_CHAR(YEAR(CURRENT_DATE) - 2) || '02'
        UNION
        SELECT TO_CHAR(YEAR(CURRENT_DATE) - 3) || '02'
        UNION
        SELECT TO_CHAR(YEAR(CURRENT_DATE) - 4) || '02'
    );

    --------------------------------------------------------------------
    -- ETAPE 2 : Insertion des partitions manquantes
    -- 1) Ne retient que les partitions absentes de la cible
    -- 2) Applique le perimetre temporel dynamique
    -- 3) Normalise les sources de reference a une ligne par cle metier
    -- 4) Enrichit le perimetre contrat via des jointures maitrisees
    -- 5) Applique les controles qualite avant insertion
    --
    -- Pourquoi ces CTE ?
    -- Les sources de reference peuvent contenir plusieurs lignes pour une meme cle metier
    -- (historique, doublons fonctionnels, variantes de saisie, etc.).
    -- Les CTE ci-dessous servent donc a "stabiliser" chaque source en la ramenant
    -- a une ligne par identifiant avant les jointures avec le perimetre contrat.
    -- Cela permet de limiter les duplications en sortie et de rendre le chargement
    -- plus deterministe et plus lisible.
    --------------------------------------------------------------------
    INSERT INTO BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
    WITH src_adherent AS (
        -- src_adherent : normaliser la source adherent a une seule ligne par NUMADHERENT.
        --
        -- Objectif :
        -- - conserver un enregistrement representatif par adherent,
        -- - appliquer en amont les controles qualite sur le code postal,
        -- - eviter qu'une multiplicite de lignes adherent ne duplique les contrats
        --   lors de la jointure avec la table source principale.
        SELECT
            NUMADHERENT,
            MAX(CDCIVILITE) AS CDCIVILITE,
            MAX(NOM) AS NOM,
            MAX(PRENOM) AS PRENOM,
            MAX(ADRESSE1) AS ADRESSE1,
            MAX(VILLE) AS VILLE,
            MAX(CDPOSTAL) AS CDPOSTAL,
            MAX(EMAIL) AS EMAIL,
            MAX(NUMTEL) AS NUMTEL,
            MAX(SOURCE) AS SOURCE,
            MAX(CDINTERMEDIAIRE) AS CDINTERMEDIAIRE
        FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_ADHERENT
        WHERE REGEXP_LIKE(CDPOSTAL, '^[0-9]{5}$')
          AND SUBSTR(CDPOSTAL, 1, 2) BETWEEN '01' AND '98'
        GROUP BY NUMADHERENT
    ),
    src_convocation AS (
                -- src_convocation : condenser les informations de convocation a une ligne par adherent (N_ADH).
                --
                -- Objectif :
                -- - recuperer les attributs utiles au reporting (commune, bureau, NPAI),
                -- - supprimer l'effet de multiplicite potentielle des convocations,
                -- - enrichir la sortie sans changer le grain metier du resultat final.
        SELECT
            N_ADH,
            MAX(COMPLEMENT) AS COMPLEMENT,
            MAX(COMMUNE) AS COMMUNE,
            MAX(INDIC_NPAI) AS INDIC_NPAI,
            MAX(BUREAU) AS BUREAU
        FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_CONVOCATION
        GROUP BY N_ADH
    ),
    src_courtier AS (
        -- src_courtier : stabiliser le referentiel courtier a une ligne par code d'intermediaire.
        --
        -- Objectif :
        -- - fiabiliser les informations de contact du courtier,
        -- - choisir une representation unique avant jointure,
        -- - eviter les duplications si le referentiel contient plusieurs lignes
        --   pour un meme CDINTERMEDIAIRE.
        SELECT
            CDINTERMEDIAIRE,
            MAX(LIBELLE) AS LIBELLE,
            MAX(MAIL) AS MAIL,
            MAX(TELFIXE) AS TELFIXE,
            MAX(TELMOBILE) AS TELMOBILE
        FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.R_COURTIER
        GROUP BY CDINTERMEDIAIRE
    )
    SELECT
        K.NUMADHERENT AS ID_ADHERENT,
        -- Traduire le code civilite source en libelle metier lisible.
        -- Ici, `01` est interprete comme `M.` et `02` comme `MME`.
        -- Toute autre valeur est laissee a NULL pour eviter d'inventer
        -- une civilite lorsque le code source est absent, inconnu ou non standard.
        CASE
            WHEN A.CDCIVILITE = '01' THEN 'M.'
            WHEN A.CDCIVILITE = '02' THEN 'MME'
            ELSE NULL
        END AS LIB_CIVILITE,
        A.NOM AS NOM_ADHERENT,
        A.PRENOM AS PRENOM_ADHERENT,
        A.ADRESSE1 AS ADRESSE_LIGNE_1,
        C.COMPLEMENT AS COMPLEMENT_ADRESSE,
        A.VILLE AS VILLE,
        A.CDPOSTAL AS CODE_POSTAL,
        SUBSTR(A.CDPOSTAL, 1, 2) AS CODE_DEPARTEMENT,
        C.COMMUNE AS COMMUNE,
        A.EMAIL AS EMAIL_ADHERENT,
        -- Transformer l'information email en indicateur simple Oui/Non
        -- pour faciliter les filtres, KPI et analyses de contactabilite.
        CASE
            WHEN A.EMAIL IS NULL OR A.EMAIL = '' THEN 'Non'
            ELSE 'Oui'
        END AS IND_EMAIL_PRESENT,
        A.NUMTEL AS TELEPHONE_ADHERENT,
        K.NUCONTRA AS NUMERO_CONTRAT,
        K.TYPEPRODUIT AS TYPE_PRODUIT,
        K.NOMPRODUIT AS LIB_PRODUIT_ASSURANCE,
        TO_DATE(K.DTEFFET) AS DATE_EFFET_CONTRAT,
        TO_DATE(K.DTFINCONTRA) AS DATE_FIN_CONTRAT,
        K.STATUT AS STATUT_CONTRAT,
        A.SOURCE AS ORIGINE_CONTRAT,
        I.LIBELLE AS NOM_COURTIER,
        I.MAIL AS EMAIL_COURTIER,
        -- Selectionner un numero de telephone courtier prioritaire.
        -- La regle appliquee privilegie le telephone fixe lorsqu'il est renseigne,
        -- puis bascule sur le mobile si le fixe est absent ou vide.
        -- Si aucun des deux n'est disponible, la valeur reste a NULL.
        CASE
            WHEN I.TELFIXE IS NOT NULL AND I.TELFIXE <> '' THEN I.TELFIXE
            WHEN I.TELMOBILE IS NOT NULL AND I.TELMOBILE <> '' THEN I.TELMOBILE
            ELSE NULL
        END AS TELEPHONE_COURTIER,
        C.INDIC_NPAI AS INDICATEUR_NPAI,
        C.BUREAU AS BUREAU_DISTRIBUTION,
        'PERIM_COURTIER_ASTER' AS CODE_PERIMETRE,
        K.DT_PARTITION AS CLE_PARTITION,
        CURRENT_DATE() AS DATE_DERNIER_RAFRAICHISSEMENT
    FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT K
    JOIN src_adherent A
        ON A.NUMADHERENT = K.NUMADHERENT
    LEFT JOIN src_convocation C
        ON K.NUMADHERENT = C.N_ADH
    LEFT JOIN src_courtier I
        ON A.CDINTERMEDIAIRE = I.CDINTERMEDIAIRE
    -- Controle incremental : on n'insere une partition que si elle n'existe pas
    -- deja dans la table cible. Cette verification evite de recharger inutilement
    -- une partition deja alimentee et limite le cout de recalcul mensuel.
    WHERE NOT EXISTS (
            SELECT 1
            FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS cible
            WHERE cible.CLE_PARTITION = K.DT_PARTITION
        )
            -- Definition du perimetre historique a conserver dans le reporting.
            --
            -- Regle appliquee :
            -- - conserver toutes les partitions disponibles de l'annee courante,
            --   depuis janvier jusqu'au mois courant inclus ;
            -- - conserver ensuite un point d'historique annuel pour chacune des
            --   4 annees precedentes, materialise ici par la partition de fevrier (`02`).
            --
            -- Ce mecanisme permet de maintenir une vision glissante sur 5 ans,
            -- tout en limitant le volume stocke et le cout de recalcul.
      AND K.DT_PARTITION IN (
            SELECT DISTINCT DT_PARTITION
            FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT
            WHERE DT_PARTITION LIKE TO_CHAR(YEAR(CURRENT_DATE)) || '%'
              AND DT_PARTITION <= TO_CHAR(YEAR(CURRENT_DATE)) || LPAD(MONTH(CURRENT_DATE), 2, '0')
            UNION
            SELECT TO_CHAR(YEAR(CURRENT_DATE) - 1) || '02'
            UNION
            SELECT TO_CHAR(YEAR(CURRENT_DATE) - 2) || '02'
            UNION
            SELECT TO_CHAR(YEAR(CURRENT_DATE) - 3) || '02'
            UNION
            SELECT TO_CHAR(YEAR(CURRENT_DATE) - 4) || '02'
                );

    RETURN 'Rafraichissement termine : ' || TO_CHAR(CURRENT_TIMESTAMP());
END;
$$;

---------------------------------
-- 3) Execution de la procedure
---------------------------------
CALL BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.PS_RAFRAICHIR_ADHERENTS_COURTIERS();

/*********************************************************************************************
 *  4) BLOC UNIFIE DE TESTS ET CONTROLES
 *
 *  Convention :
 *    - TEST-XX : identifiant unique du controle.
 *    - RESULTAT ATTENDU : interpretation attendue.
 ********************************************************************************************/

-- TEST-01 : Lecture rapide de la table cible
SELECT *
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
LIMIT 100;

-- TEST-02 : Nombre total de lignes
SELECT COUNT(*) AS NB_LIGNES
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS;

-- TEST-03 : Verification de structure
-- RESULTAT ATTENDU : structure conforme (colonnes attendues).
DESC TABLE BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS;

-- TEST-04 : Partitions presentes en cible
-- RESULTAT ATTENDU : uniquement des partitions dans le perimetre.
SELECT DISTINCT CLE_PARTITION
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
ORDER BY CLE_PARTITION;

-- TEST-05 : Volumetrie par partition
-- RESULTAT ATTENDU : repartition coherente et CLE_PARTITION non vide.
SELECT CLE_PARTITION, COUNT(*) AS NB_LIGNES
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
GROUP BY CLE_PARTITION
ORDER BY CLE_PARTITION;

-- TEST-06 : Adherents uniques par partition
-- RESULTAT ATTENDU : coherence metier avec les attendus de pilotage.
SELECT CLE_PARTITION, COUNT(DISTINCT ID_ADHERENT) AS NB_ADHERENTS_UNIQUES
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
GROUP BY CLE_PARTITION
ORDER BY CLE_PARTITION;

-- TEST-07 : Controle partitions hors perimetre
-- RESULTAT ATTENDU : 0 ligne.
WITH partitions_attendues AS (
    SELECT DISTINCT DT_PARTITION AS CLE_PARTITION
    FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT
    WHERE DT_PARTITION LIKE TO_CHAR(YEAR(CURRENT_DATE)) || '%'
      AND DT_PARTITION <= TO_CHAR(YEAR(CURRENT_DATE)) || LPAD(MONTH(CURRENT_DATE), 2, '0')
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 1) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 2) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 3) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 4) || '02'
)
SELECT DISTINCT t.CLE_PARTITION AS PARTITION_HORS_PERIMETRE
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS t
LEFT JOIN partitions_attendues e
    ON t.CLE_PARTITION = e.CLE_PARTITION
WHERE e.CLE_PARTITION IS NULL;

-- TEST-08 : Controle des doublons complets
-- RESULTAT ATTENDU : NB_DOUBLONS_COMPLETS = 0.
SELECT
    COALESCE(SUM(CNT) - COUNT(*), 0) AS NB_DOUBLONS_COMPLETS
FROM (
    SELECT COUNT(*) AS CNT
    FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
    GROUP BY
        ID_ADHERENT,
        LIB_CIVILITE,
        NOM_ADHERENT,
        PRENOM_ADHERENT,
        ADRESSE_LIGNE_1,
        COMPLEMENT_ADRESSE,
        VILLE,
        CODE_POSTAL,
        CODE_DEPARTEMENT,
        COMMUNE,
        EMAIL_ADHERENT,
        IND_EMAIL_PRESENT,
        TELEPHONE_ADHERENT,
        NUMERO_CONTRAT,
        TYPE_PRODUIT,
        LIB_PRODUIT_ASSURANCE,
        DATE_EFFET_CONTRAT,
        DATE_FIN_CONTRAT,
        STATUT_CONTRAT,
        ORIGINE_CONTRAT,
        NOM_COURTIER,
        EMAIL_COURTIER,
        TELEPHONE_COURTIER,
        INDICATEUR_NPAI,
        BUREAU_DISTRIBUTION,
        CODE_PERIMETRE,
        CLE_PARTITION
) grouped
WHERE CNT > 1;

-- TEST-09 : Doublons sur la cle metier
-- RESULTAT ATTENDU : 0 ligne.
SELECT
    ID_ADHERENT,
    NUMERO_CONTRAT,
    CLE_PARTITION,
    COUNT(*) AS NB_LIGNES
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
GROUP BY ID_ADHERENT, NUMERO_CONTRAT, CLE_PARTITION
HAVING COUNT(*) > 1
ORDER BY NB_LIGNES DESC;

-- TEST-10 : Completude incrementale
-- RESULTAT ATTENDU : 0 ligne manquante en cible.
WITH partitions_attendues AS (
    SELECT DISTINCT DT_PARTITION AS CLE_PARTITION
    FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT
    WHERE DT_PARTITION LIKE TO_CHAR(YEAR(CURRENT_DATE)) || '%'
      AND DT_PARTITION <= TO_CHAR(YEAR(CURRENT_DATE)) || LPAD(MONTH(CURRENT_DATE), 2, '0')
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 1) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 2) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 3) || '02'
    UNION
    SELECT TO_CHAR(YEAR(CURRENT_DATE) - 4) || '02'
)
SELECT e.CLE_PARTITION AS PARTITION_MANQUANTE_CIBLE
FROM partitions_attendues e
LEFT JOIN (
    SELECT DISTINCT CLE_PARTITION
    FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
) t
    ON e.CLE_PARTITION = t.CLE_PARTITION
WHERE t.CLE_PARTITION IS NULL;

-- TEST-11 : Controle des champs cles a NULL
-- RESULTAT ATTENDU : compteurs a 0 (ou justification metier).
SELECT
    COUNT_IF(ID_ADHERENT IS NULL) AS NB_NULL_ID_ADHERENT,
    COUNT_IF(NUMERO_CONTRAT IS NULL) AS NB_NULL_NUMERO_CONTRAT,
    COUNT_IF(CLE_PARTITION IS NULL) AS NB_NULL_CLE_PARTITION,
    COUNT_IF(NOM_ADHERENT IS NULL) AS NB_NULL_NOM_ADHERENT,
    COUNT_IF(PRENOM_ADHERENT IS NULL) AS NB_NULL_PRENOM_ADHERENT
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS;

-- TEST-12 : Observabilite des partitions sources
-- RESULTAT ATTENDU : comparaison possible de la fraicheur des sources.
SELECT 'ADHERENT' AS TABLE_SOURCE, DT_PARTITION, COUNT(*) AS NB_LIGNES
FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_ADHERENT
GROUP BY DT_PARTITION
UNION ALL
SELECT 'CONVOCATION' AS TABLE_SOURCE, DT_PARTITION, COUNT(*) AS NB_LIGNES
FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.V_CONVOCATION
GROUP BY DT_PARTITION
UNION ALL
SELECT 'COURTIER' AS TABLE_SOURCE, DT_PARTITION, COUNT(*) AS NB_LIGNES
FROM BD_INTEG_DEMO.SC_DIFFUSION_ASSURANCE.R_COURTIER
GROUP BY DT_PARTITION
UNION ALL
SELECT 'CONTRAT' AS TABLE_SOURCE, DT_PARTITION, COUNT(*) AS NB_LIGNES
FROM LAC_DONNEES_DEMO.PRD_ASSURANCE_DEMO.V_CONTRAT
GROUP BY DT_PARTITION
ORDER BY TABLE_SOURCE, DT_PARTITION;

-- TEST-13 : Integrite du code perimetre
-- RESULTAT ATTENDU : une seule valeur = 'PERIM_COURTIER_ASTER'.
SELECT CODE_PERIMETRE, COUNT(*) AS NB_LIGNES
FROM BD_ASSURANCE_DEMO.SC_PILOTAGE_COURTIERS.RPT_ADHERENTS_COURTIERS
GROUP BY CODE_PERIMETRE
ORDER BY NB_LIGNES DESC;