/* =====================================================================
   File: 02_snowflake_stored_procedure_script.sql
   Project: Spec-Driven Workflow for Snowflake SQL Stored Procedure Creation
   Phase: 04_sql_implementation

   Purpose:
   - Template for a Snowflake SQL / Snowflake Scripting stored procedure.
   - Implements a controlled data load into a target table.
   - Supports target object checks, optional creation, existing data checks,
     source preparation, transformation logic, DML execution, audit logging,
     error handling, and execution status return.

   Important:
   - This is a template and must be completed from the validated
     Procedure Design Specification.
   - Do not execute in DEV / TEST / PROD until all TODO sections are resolved.
   - Do not use destructive DML such as DELETE, TRUNCATE, or full reload unless
     explicitly confirmed in the Procedure Design Specification.
   - Do not keep unqualified object names unless session context is controlled.
   - Prefer explicit column lists and deterministic logic.
   ===================================================================== */


/* =====================================================================
   1. Session Initialization

   Use these statements only when role, warehouse, database, and schema are
   confirmed for the target environment.

   Keep them commented if the procedure will be deployed through CI/CD,
   Snowflake change management, or another controlled deployment process.
   ===================================================================== */

-- USE ROLE <ROLE_NAME>;
-- USE WAREHOUSE <WAREHOUSE_NAME>;
-- USE DATABASE <DATABASE_NAME>;
-- USE SCHEMA <SCHEMA_NAME>;


/* =====================================================================
   2. Optional Session Parameters

   Enable only if confirmed by platform standards.

   Notes:
   - Do not change AUTOCOMMIT inside a stored procedure.
   - Keep date / timestamp formats explicit in query logic when required.
   ===================================================================== */

-- ALTER SESSION SET QUERY_TAG = 'SP_<PROCEDURE_NAME>_DEPLOYMENT';
-- ALTER SESSION SET TIMEZONE = 'UTC';


/* =====================================================================
   3. Optional Prerequisites

   Use this section only if object creation outside the procedure is approved.

   Recommended approach:
   - Create permanent objects through controlled deployment scripts.
   - Avoid DDL inside the procedure unless explicitly required.
   - DDL statements can implicitly commit transactions in Snowflake.
   ===================================================================== */

-- ---------------------------------------------------------------------
-- 3.1 Optional target table DDL
-- ---------------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE> (
--     <TARGET_KEY_COLUMN>        <DATA_TYPE>      NOT NULL,
--     <TARGET_ATTRIBUTE_COLUMN>  <DATA_TYPE>,
--     <TARGET_MEASURE_COLUMN>    <DATA_TYPE>,
--     LOAD_TIMESTAMP             TIMESTAMP_NTZ    DEFAULT CURRENT_TIMESTAMP(),
--     BATCH_ID                   STRING,
--     PROCEDURE_RUN_ID           STRING,
--     SOURCE_SYSTEM              STRING
-- );

-- ---------------------------------------------------------------------
-- 3.2 Optional audit table DDL
-- ---------------------------------------------------------------------
-- CREATE TABLE IF NOT EXISTS <AUDIT_DATABASE>.<AUDIT_SCHEMA>.<AUDIT_TABLE> (
--     PROCEDURE_RUN_ID   STRING,
--     PROCEDURE_NAME     STRING,
--     BATCH_ID           STRING,
--     LOAD_MODE          STRING,
--     START_TIMESTAMP    TIMESTAMP_NTZ,
--     END_TIMESTAMP      TIMESTAMP_NTZ,
--     EXECUTION_STATUS   STRING,
--     SOURCE_ROW_COUNT   NUMBER,
--     ROWS_INSERTED      NUMBER,
--     ROWS_UPDATED       NUMBER,
--     ROWS_DELETED       NUMBER,
--     ERROR_CODE         STRING,
--     ERROR_STATE        STRING,
--     ERROR_MESSAGE      STRING
-- );


/* =====================================================================
   4. Stored Procedure Definition

   Replace placeholders using the validated Procedure Design Specification.

   Design decisions to confirm before execution:
   - Procedure name and schema.
   - Parameters and default values.
   - Return type.
   - EXECUTE AS CALLER or EXECUTE AS OWNER.
   - Load mode behavior.
   - Target table behavior.
   - DML strategy: INSERT, MERGE, reload, or validate only.
   ===================================================================== */

CREATE OR REPLACE PROCEDURE <PROCEDURE_DATABASE>.<PROCEDURE_SCHEMA>.<PROCEDURE_NAME>(
      P_LOAD_MODE      STRING DEFAULT 'MERGE'
    , P_LOAD_DATE      DATE   DEFAULT NULL
    , P_BATCH_ID       STRING DEFAULT NULL
    , P_FORCE_RELOAD   BOOLEAN DEFAULT FALSE
)
RETURNS VARIANT
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
    /* -----------------------------------------------------------------
       Execution metadata
       ----------------------------------------------------------------- */
    V_PROCEDURE_NAME       STRING        DEFAULT '<PROCEDURE_DATABASE>.<PROCEDURE_SCHEMA>.<PROCEDURE_NAME>';
    V_PROCEDURE_RUN_ID     STRING        DEFAULT UUID_STRING();
    V_BATCH_ID             STRING        DEFAULT COALESCE(P_BATCH_ID, UUID_STRING());
    V_START_TIMESTAMP      TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP();
    V_END_TIMESTAMP        TIMESTAMP_NTZ;
    V_STATUS               STRING        DEFAULT 'STARTED';
    V_MESSAGE              STRING        DEFAULT NULL;

    /* -----------------------------------------------------------------
       Counters
       Capture SQLROWCOUNT immediately after DML statements.
       ----------------------------------------------------------------- */
    V_SOURCE_ROW_COUNT     NUMBER        DEFAULT 0;
    V_TARGET_ROW_COUNT     NUMBER        DEFAULT 0;
    V_ROWS_INSERTED        NUMBER        DEFAULT 0;
    V_ROWS_UPDATED         NUMBER        DEFAULT 0;
    V_ROWS_DELETED         NUMBER        DEFAULT 0;
    V_ROWS_MERGED          NUMBER        DEFAULT 0;

    /* -----------------------------------------------------------------
       Object state checks
       ----------------------------------------------------------------- */
    V_TARGET_EXISTS        NUMBER        DEFAULT 0;
    V_SOURCE_READY         BOOLEAN       DEFAULT TRUE;

    /* -----------------------------------------------------------------
       Error metadata
       ----------------------------------------------------------------- */
    V_ERROR_CODE           STRING        DEFAULT NULL;
    V_ERROR_STATE          STRING        DEFAULT NULL;
    V_ERROR_MESSAGE        STRING        DEFAULT NULL;

BEGIN

    /* =================================================================
       5. Parameter Validation
       ================================================================= */

    IF (P_LOAD_MODE IS NULL OR UPPER(P_LOAD_MODE) NOT IN ('APPEND', 'MERGE', 'RELOAD', 'VALIDATE_ONLY')) THEN
        RETURN OBJECT_CONSTRUCT(
              'status', 'FAILED'
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'error_message', 'Invalid P_LOAD_MODE. Allowed values: APPEND, MERGE, RELOAD, VALIDATE_ONLY.'
        );
    END IF;

    /* TODO:
       Add additional parameter validation if confirmed:
       - P_LOAD_DATE required for incremental load.
       - P_FORCE_RELOAD required for destructive reload.
       - P_SOURCE_SYSTEM required for source filtering.
    */


    /* =================================================================
       6. Source Object Validation

       Replace placeholder logic with confirmed source availability checks.
       Avoid inventing source objects.
       ================================================================= */

    /* Example:
       SELECT COUNT(*)
         INTO :V_SOURCE_ROW_COUNT
       FROM <SOURCE_DATABASE>.<SOURCE_SCHEMA>.<SOURCE_TABLE>
       WHERE <OPTIONAL_FILTER_COLUMN> = <OPTIONAL_FILTER_VALUE>;
    */

    -- TODO: Confirm source object names and source readiness checks.

    V_SOURCE_READY := TRUE;


    /* =================================================================
       7. Target Object Existence Check

       Use INFORMATION_SCHEMA only when database/schema/table names are fixed.
       For dynamic object names, use IDENTIFIER() / EXECUTE IMMEDIATE only if
       dynamic SQL is explicitly approved.
       ================================================================= */

    SELECT COUNT(*)
      INTO :V_TARGET_EXISTS
    FROM <TARGET_DATABASE>.INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = '<TARGET_SCHEMA>'
      AND TABLE_NAME = '<TARGET_TABLE>';

    IF (V_TARGET_EXISTS = 0) THEN

        /* -------------------------------------------------------------
           Option A — fail if target table must already exist
           ------------------------------------------------------------- */
        -- RETURN OBJECT_CONSTRUCT(
        --       'status', 'FAILED'
        --     , 'procedure_name', V_PROCEDURE_NAME
        --     , 'procedure_run_id', V_PROCEDURE_RUN_ID
        --     , 'batch_id', V_BATCH_ID
        --     , 'error_message', 'Target table does not exist.'
        -- );

        /* -------------------------------------------------------------
           Option B — create target table if explicitly confirmed
           Warning: DDL may implicitly commit transactions.
           ------------------------------------------------------------- */
        -- CREATE TABLE IF NOT EXISTS <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE> (
        --     <TARGET_KEY_COLUMN>        <DATA_TYPE>      NOT NULL,
        --     <TARGET_ATTRIBUTE_COLUMN>  <DATA_TYPE>,
        --     <TARGET_MEASURE_COLUMN>    <DATA_TYPE>,
        --     LOAD_TIMESTAMP             TIMESTAMP_NTZ    DEFAULT CURRENT_TIMESTAMP(),
        --     BATCH_ID                   STRING,
        --     PROCEDURE_RUN_ID           STRING,
        --     SOURCE_SYSTEM              STRING
        -- );

        -- TODO: Choose Option A or Option B based on the validated design.
        RETURN OBJECT_CONSTRUCT(
              'status', 'FAILED'
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'error_message', 'TODO: Target table behavior is not confirmed.'
        );

    END IF;


    /* =================================================================
       8. Existing Target Data Check
       ================================================================= */

    SELECT COUNT(*)
      INTO :V_TARGET_ROW_COUNT
    FROM <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE>;

    IF (V_TARGET_ROW_COUNT > 0 AND UPPER(P_LOAD_MODE) = 'APPEND') THEN
        /* TODO:
           Confirm whether APPEND is allowed when target already contains data.
           If duplicate prevention is required, APPEND may be unsafe.
        */
        NULL;
    END IF;

    IF (V_TARGET_ROW_COUNT > 0 AND UPPER(P_LOAD_MODE) = 'RELOAD' AND P_FORCE_RELOAD = FALSE) THEN
        RETURN OBJECT_CONSTRUCT(
              'status', 'FAILED'
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'target_row_count', V_TARGET_ROW_COUNT
            , 'error_message', 'Reload requested but P_FORCE_RELOAD is FALSE.'
        );
    END IF;


    /* =================================================================
       9. Validate-Only Mode

       Use this mode to confirm source and target readiness without changing data.
       ================================================================= */

    IF (UPPER(P_LOAD_MODE) = 'VALIDATE_ONLY') THEN
        V_STATUS := 'VALIDATED';
        V_END_TIMESTAMP := CURRENT_TIMESTAMP();

        RETURN OBJECT_CONSTRUCT(
              'status', V_STATUS
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'load_mode', P_LOAD_MODE
            , 'source_ready', V_SOURCE_READY
            , 'target_exists', V_TARGET_EXISTS
            , 'target_row_count', V_TARGET_ROW_COUNT
            , 'start_timestamp', V_START_TIMESTAMP
            , 'end_timestamp', V_END_TIMESTAMP
        );
    END IF;


    /* =================================================================
       10. DML Transaction Scope

       Keep DDL outside this explicit transaction when possible.
       Do not include CREATE / ALTER / DROP statements inside this transaction.
       ================================================================= */

    BEGIN TRANSACTION;


    /* =================================================================
       11. Source Preparation, Mapping, and Transformation

       Replace placeholders with confirmed mapping from:
       - Data Contract and Mapping
       - Procedure Design Specification

       Requirements:
       - Do not use SELECT *.
       - Use explicit column lists.
       - Use deterministic deduplication when needed.
       - Apply filters as early as possible.
       ================================================================= */

    /* -----------------------------------------------------------------
       Recommended pattern:
       1. source_filtered
       2. source_joined
       3. source_transformed
       4. source_deduplicated
       5. final_dataset
       ----------------------------------------------------------------- */

    /* =================================================================
       12. DML Strategy

       Keep only the confirmed strategy:
       - APPEND
       - MERGE
       - RELOAD
       Remove non-applicable branches before production deployment.
       ================================================================= */


    /* -----------------------------------------------------------------
       12.1 APPEND strategy
       ----------------------------------------------------------------- */
    IF (UPPER(P_LOAD_MODE) = 'APPEND') THEN

        INSERT INTO <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE> (
              <TARGET_KEY_COLUMN>
            , <TARGET_ATTRIBUTE_COLUMN>
            , <TARGET_MEASURE_COLUMN>
            , LOAD_TIMESTAMP
            , BATCH_ID
            , PROCEDURE_RUN_ID
            , SOURCE_SYSTEM
        )
        WITH SOURCE_FILTERED AS (
            SELECT
                  <SOURCE_KEY_COLUMN>
                , <SOURCE_ATTRIBUTE_COLUMN>
                , <SOURCE_MEASURE_COLUMN>
                -- TODO: Add only confirmed source columns.
            FROM <SOURCE_DATABASE>.<SOURCE_SCHEMA>.<SOURCE_TABLE>
            WHERE 1 = 1
              -- TODO: Add confirmed filters.
              -- AND <SOURCE_DATE_COLUMN> = :P_LOAD_DATE
        ),
        SOURCE_TRANSFORMED AS (
            SELECT
                  <SOURCE_KEY_COLUMN>       AS <TARGET_KEY_COLUMN>
                , <SOURCE_ATTRIBUTE_COLUMN> AS <TARGET_ATTRIBUTE_COLUMN>
                , <SOURCE_MEASURE_COLUMN>   AS <TARGET_MEASURE_COLUMN>
                , CURRENT_TIMESTAMP()       AS LOAD_TIMESTAMP
                , :V_BATCH_ID               AS BATCH_ID
                , :V_PROCEDURE_RUN_ID       AS PROCEDURE_RUN_ID
                , '<SOURCE_SYSTEM>'         AS SOURCE_SYSTEM
            FROM SOURCE_FILTERED
        )
        SELECT
              <TARGET_KEY_COLUMN>
            , <TARGET_ATTRIBUTE_COLUMN>
            , <TARGET_MEASURE_COLUMN>
            , LOAD_TIMESTAMP
            , BATCH_ID
            , PROCEDURE_RUN_ID
            , SOURCE_SYSTEM
        FROM SOURCE_TRANSFORMED;

        V_ROWS_INSERTED := SQLROWCOUNT;

    END IF;


    /* -----------------------------------------------------------------
       12.2 MERGE strategy
       ----------------------------------------------------------------- */
    IF (UPPER(P_LOAD_MODE) = 'MERGE') THEN

        MERGE INTO <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE> AS TGT
        USING (
            WITH SOURCE_FILTERED AS (
                SELECT
                      <SOURCE_KEY_COLUMN>
                    , <SOURCE_ATTRIBUTE_COLUMN>
                    , <SOURCE_MEASURE_COLUMN>
                    -- TODO: Add only confirmed source columns.
                FROM <SOURCE_DATABASE>.<SOURCE_SCHEMA>.<SOURCE_TABLE>
                WHERE 1 = 1
                  -- TODO: Add confirmed filters.
                  -- AND <SOURCE_DATE_COLUMN> = :P_LOAD_DATE
            ),
            SOURCE_TRANSFORMED AS (
                SELECT
                      <SOURCE_KEY_COLUMN>       AS <TARGET_KEY_COLUMN>
                    , <SOURCE_ATTRIBUTE_COLUMN> AS <TARGET_ATTRIBUTE_COLUMN>
                    , <SOURCE_MEASURE_COLUMN>   AS <TARGET_MEASURE_COLUMN>
                    , CURRENT_TIMESTAMP()       AS LOAD_TIMESTAMP
                    , :V_BATCH_ID               AS BATCH_ID
                    , :V_PROCEDURE_RUN_ID       AS PROCEDURE_RUN_ID
                    , '<SOURCE_SYSTEM>'         AS SOURCE_SYSTEM
                FROM SOURCE_FILTERED
            ),
            SOURCE_DEDUPLICATED AS (
                SELECT *
                FROM SOURCE_TRANSFORMED
                QUALIFY ROW_NUMBER() OVER (
                    PARTITION BY <TARGET_KEY_COLUMN>
                    ORDER BY LOAD_TIMESTAMP DESC
                ) = 1
            )
            SELECT
                  <TARGET_KEY_COLUMN>
                , <TARGET_ATTRIBUTE_COLUMN>
                , <TARGET_MEASURE_COLUMN>
                , LOAD_TIMESTAMP
                , BATCH_ID
                , PROCEDURE_RUN_ID
                , SOURCE_SYSTEM
            FROM SOURCE_DEDUPLICATED
        ) AS SRC
        ON TGT.<TARGET_KEY_COLUMN> = SRC.<TARGET_KEY_COLUMN>

        WHEN MATCHED THEN UPDATE SET
              TGT.<TARGET_ATTRIBUTE_COLUMN> = SRC.<TARGET_ATTRIBUTE_COLUMN>
            , TGT.<TARGET_MEASURE_COLUMN>   = SRC.<TARGET_MEASURE_COLUMN>
            , TGT.LOAD_TIMESTAMP            = SRC.LOAD_TIMESTAMP
            , TGT.BATCH_ID                  = SRC.BATCH_ID
            , TGT.PROCEDURE_RUN_ID          = SRC.PROCEDURE_RUN_ID
            , TGT.SOURCE_SYSTEM             = SRC.SOURCE_SYSTEM

        WHEN NOT MATCHED THEN INSERT (
              <TARGET_KEY_COLUMN>
            , <TARGET_ATTRIBUTE_COLUMN>
            , <TARGET_MEASURE_COLUMN>
            , LOAD_TIMESTAMP
            , BATCH_ID
            , PROCEDURE_RUN_ID
            , SOURCE_SYSTEM
        )
        VALUES (
              SRC.<TARGET_KEY_COLUMN>
            , SRC.<TARGET_ATTRIBUTE_COLUMN>
            , SRC.<TARGET_MEASURE_COLUMN>
            , SRC.LOAD_TIMESTAMP
            , SRC.BATCH_ID
            , SRC.PROCEDURE_RUN_ID
            , SRC.SOURCE_SYSTEM
        );

        V_ROWS_MERGED := SQLROWCOUNT;

    END IF;


    /* -----------------------------------------------------------------
       12.3 RELOAD strategy

       Keep disabled unless explicitly confirmed.
       Prefer DELETE scoped by partition/date/business key over full TRUNCATE
       unless full reload is approved.
       ----------------------------------------------------------------- */
    IF (UPPER(P_LOAD_MODE) = 'RELOAD') THEN

        IF (P_FORCE_RELOAD = FALSE) THEN
            ROLLBACK;

            RETURN OBJECT_CONSTRUCT(
                  'status', 'FAILED'
                , 'procedure_name', V_PROCEDURE_NAME
                , 'procedure_run_id', V_PROCEDURE_RUN_ID
                , 'batch_id', V_BATCH_ID
                , 'error_message', 'Reload mode requires P_FORCE_RELOAD = TRUE.'
            );
        END IF;

        /* TODO:
           Replace with confirmed reload strategy.

           Example safer scoped delete:
           DELETE FROM <TARGET_DATABASE>.<TARGET_SCHEMA>.<TARGET_TABLE>
           WHERE <PARTITION_OR_LOAD_DATE_COLUMN> = :P_LOAD_DATE;

           V_ROWS_DELETED := SQLROWCOUNT;

           Then INSERT explicit mapped records.
        */

        ROLLBACK;

        RETURN OBJECT_CONSTRUCT(
              'status', 'FAILED'
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'error_message', 'TODO: Reload strategy is not implemented because destructive behavior is not confirmed.'
        );

    END IF;


    /* =================================================================
       13. Commit DML Transaction
       ================================================================= */

    COMMIT;


    /* =================================================================
       14. Optional Audit Logging

       Enable only if audit table and fields are confirmed.
       Keep SQLROWCOUNT captures before audit insert.
       ================================================================= */

    -- INSERT INTO <AUDIT_DATABASE>.<AUDIT_SCHEMA>.<AUDIT_TABLE> (
    --       PROCEDURE_RUN_ID
    --     , PROCEDURE_NAME
    --     , BATCH_ID
    --     , LOAD_MODE
    --     , START_TIMESTAMP
    --     , END_TIMESTAMP
    --     , EXECUTION_STATUS
    --     , SOURCE_ROW_COUNT
    --     , ROWS_INSERTED
    --     , ROWS_UPDATED
    --     , ROWS_DELETED
    --     , ERROR_CODE
    --     , ERROR_STATE
    --     , ERROR_MESSAGE
    -- )
    -- SELECT
    --       :V_PROCEDURE_RUN_ID
    --     , :V_PROCEDURE_NAME
    --     , :V_BATCH_ID
    --     , :P_LOAD_MODE
    --     , :V_START_TIMESTAMP
    --     , CURRENT_TIMESTAMP()
    --     , 'SUCCESS'
    --     , :V_SOURCE_ROW_COUNT
    --     , :V_ROWS_INSERTED
    --     , :V_ROWS_UPDATED
    --     , :V_ROWS_DELETED
    --     , NULL
    --     , NULL
    --     , NULL;


    /* =================================================================
       15. Return Success Status
       ================================================================= */

    V_STATUS := 'SUCCESS';
    V_END_TIMESTAMP := CURRENT_TIMESTAMP();

    RETURN OBJECT_CONSTRUCT(
          'status', V_STATUS
        , 'procedure_name', V_PROCEDURE_NAME
        , 'procedure_run_id', V_PROCEDURE_RUN_ID
        , 'batch_id', V_BATCH_ID
        , 'load_mode', P_LOAD_MODE
        , 'source_row_count', V_SOURCE_ROW_COUNT
        , 'target_row_count_before_load', V_TARGET_ROW_COUNT
        , 'rows_inserted', V_ROWS_INSERTED
        , 'rows_updated', V_ROWS_UPDATED
        , 'rows_deleted', V_ROWS_DELETED
        , 'rows_merged', V_ROWS_MERGED
        , 'start_timestamp', V_START_TIMESTAMP
        , 'end_timestamp', V_END_TIMESTAMP
        , 'message', 'Stored procedure completed successfully.'
    );


EXCEPTION
    WHEN OTHER THEN

        V_STATUS := 'FAILED';
        V_END_TIMESTAMP := CURRENT_TIMESTAMP();
        V_ERROR_CODE := SQLCODE;
        V_ERROR_STATE := SQLSTATE;
        V_ERROR_MESSAGE := SQLERRM;

        /* Roll back only the explicit DML transaction if still active.
           If failure happened outside transaction scope, review behavior manually.
        */
        ROLLBACK;

        /* Optional failure audit logging.
           Enable only if audit table and fields are confirmed.
        */
        -- INSERT INTO <AUDIT_DATABASE>.<AUDIT_SCHEMA>.<AUDIT_TABLE> (
        --       PROCEDURE_RUN_ID
        --     , PROCEDURE_NAME
        --     , BATCH_ID
        --     , LOAD_MODE
        --     , START_TIMESTAMP
        --     , END_TIMESTAMP
        --     , EXECUTION_STATUS
        --     , SOURCE_ROW_COUNT
        --     , ROWS_INSERTED
        --     , ROWS_UPDATED
        --     , ROWS_DELETED
        --     , ERROR_CODE
        --     , ERROR_STATE
        --     , ERROR_MESSAGE
        -- )
        -- SELECT
        --       :V_PROCEDURE_RUN_ID
        --     , :V_PROCEDURE_NAME
        --     , :V_BATCH_ID
        --     , :P_LOAD_MODE
        --     , :V_START_TIMESTAMP
        --     , :V_END_TIMESTAMP
        --     , :V_STATUS
        --     , :V_SOURCE_ROW_COUNT
        --     , :V_ROWS_INSERTED
        --     , :V_ROWS_UPDATED
        --     , :V_ROWS_DELETED
        --     , :V_ERROR_CODE
        --     , :V_ERROR_STATE
        --     , :V_ERROR_MESSAGE;

        RETURN OBJECT_CONSTRUCT(
              'status', V_STATUS
            , 'procedure_name', V_PROCEDURE_NAME
            , 'procedure_run_id', V_PROCEDURE_RUN_ID
            , 'batch_id', V_BATCH_ID
            , 'load_mode', P_LOAD_MODE
            , 'error_code', V_ERROR_CODE
            , 'error_state', V_ERROR_STATE
            , 'error_message', V_ERROR_MESSAGE
            , 'source_row_count', V_SOURCE_ROW_COUNT
            , 'target_row_count_before_load', V_TARGET_ROW_COUNT
            , 'rows_inserted', V_ROWS_INSERTED
            , 'rows_updated', V_ROWS_UPDATED
            , 'rows_deleted', V_ROWS_DELETED
            , 'rows_merged', V_ROWS_MERGED
            , 'start_timestamp', V_START_TIMESTAMP
            , 'end_timestamp', V_END_TIMESTAMP
        );

END;
$$;


/* =====================================================================
   16. Optional Example Calls

   Keep commented until parameters and environment are confirmed.
   ===================================================================== */

-- CALL <PROCEDURE_DATABASE>.<PROCEDURE_SCHEMA>.<PROCEDURE_NAME>(
--       P_LOAD_MODE    => 'VALIDATE_ONLY'
--     , P_LOAD_DATE    => CURRENT_DATE()
--     , P_BATCH_ID     => 'MANUAL_TEST_001'
--     , P_FORCE_RELOAD => FALSE
-- );

-- CALL <PROCEDURE_DATABASE>.<PROCEDURE_SCHEMA>.<PROCEDURE_NAME>(
--       P_LOAD_MODE    => 'MERGE'
--     , P_LOAD_DATE    => CURRENT_DATE()
--     , P_BATCH_ID     => 'BATCH_001'
--     , P_FORCE_RELOAD => FALSE
-- );


/* =====================================================================
   17. Manual Review Checklist Before Execution

   Confirm before running:
   - All placeholders are replaced.
   - Session context is correct or intentionally omitted.
   - Procedure name and schema are correct.
   - EXECUTE AS CALLER / OWNER is confirmed.
   - Parameters match the Procedure Design Specification.
   - Target object behavior is confirmed.
   - Existing target data behavior is confirmed.
   - DDL inside procedure is removed or explicitly approved.
   - Destructive DML is removed or explicitly approved.
   - Source-to-target mapping is complete.
   - All INSERT / MERGE statements use explicit column lists.
   - No production DML uses SELECT *.
   - Deduplication logic is deterministic.
   - Idempotency behavior is understood.
   - Error handling is acceptable.
   - Audit logging is enabled only if audit object exists.
   - Security privileges are confirmed.
   - Script has passed code review and validation in DEV / TEST.
   ===================================================================== */
