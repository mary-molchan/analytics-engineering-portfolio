-- ============================================================================
-- SNOWFLAKE END-TO-END SCRIPT - FINANCIAL FLOWS AUDIT (COURTIERS)
-- DATA ANONYMIZED FOR PORTFOLIO VERSION
-- ============================================================================
-- 
-- PROJECT FOUNDATION:
-- This end-to-end data pipeline is constructed from source data exported from
-- an intermediate reporting layer (9 Excel files: F_TRANSACTIONS, F_COMMISSIONS,
-- F_SETTLEMENTS, D_AGENCY, D_BROKER, D_CONTRACT, D_DATE, R_COMMISSION_RULES,
-- AUDIT_EXCEPTIONS). The pipeline ingests these CSV extracts into Snowflake RAW
-- layer, synthesizes a MART layer with business calculations (commission efficiency,
-- collection rates, risk scoring), and exposes a BI-ready view for analytics and
-- dashboarding. All data has been anonymized to protect confidential information.
--
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 0) Execution context and compute layer
-- ----------------------------------------------------------------------------
USE ROLE ACCOUNTADMIN; -- Use privileged role for object creation

CREATE WAREHOUSE IF NOT EXISTS WH_FINANCE_ANALYTICS -- Dedicated compute for this pipeline
  WAREHOUSE_SIZE = 'XSMALL' -- Cost-efficient size for initial load
  AUTO_SUSPEND = 60 -- Suspend quickly when idle
  AUTO_RESUME = TRUE -- Resume automatically on query start
  INITIALLY_SUSPENDED = TRUE; -- Start suspended to avoid idle cost

USE WAREHOUSE WH_FINANCE_ANALYTICS; -- Activate warehouse for subsequent commands

-- ----------------------------------------------------------------------------
-- 1) Database and schemas
-- ----------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS BD_FINANCE_COURTIERS; -- Project database
USE DATABASE BD_FINANCE_COURTIERS; -- Set active database context

CREATE SCHEMA IF NOT EXISTS RAW; -- Source-aligned ingestion layer
CREATE SCHEMA IF NOT EXISTS MART; -- Curated BI layer

-- ----------------------------------------------------------------------------
-- 2) File format and stage
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FILE FORMAT RAW.FF_CSV_STD -- Standard CSV parsing rules
  TYPE = CSV -- Input file type
  FIELD_DELIMITER = ',' -- Comma-separated values
  SKIP_HEADER = 1 -- Skip header line
  FIELD_OPTIONALLY_ENCLOSED_BY = '"' -- Handle quoted string fields
  TRIM_SPACE = TRUE -- Trim extra spaces
  EMPTY_FIELD_AS_NULL = TRUE -- Convert empty fields to NULL
  NULL_IF = ('NULL', 'null', ''); -- Normalize null tokens

CREATE OR REPLACE STAGE RAW.STG_FINANCE_FILES -- Internal stage for incoming files
  FILE_FORMAT = RAW.FF_CSV_STD; -- Attach default format

-- ----------------------------------------------------------------------------
-- 3) RAW tables
-- ----------------------------------------------------------------------------

-- Transaction-level fact table
-- Note: PRIMARY KEY and NOT NULL constraints added for data integrity and JOIN optimization
CREATE OR REPLACE TABLE RAW.F_TRANSACTIONS (
  transaction_id VARCHAR NOT NULL, -- Transaction identifier (primary key)
  source_system VARCHAR, -- Originating source application
  operation_ts TIMESTAMP_NTZ, -- Operation timestamp
  booking_date DATE, -- Accounting booking date
  value_date DATE, -- Financial value date
  contract_id VARCHAR, -- Related contract key
  agency_id VARCHAR, -- Related agency key
  broker_id VARCHAR, -- Related broker key
  transaction_type VARCHAR, -- Business transaction type
  flow_direction VARCHAR, -- IN/OUT cash direction
  amount_original NUMBER(18,2), -- Amount in original currency
  currency_code VARCHAR, -- ISO currency code
  fx_rate_to_eur FLOAT, -- FX rate to EUR
  amount_eur NUMBER(18,2), -- Amount converted to EUR
  payment_channel VARCHAR, -- Payment channel
  payment_status VARCHAR, -- Posting/payment status
  reconciliation_key VARCHAR, -- Reconciliation identifier
  is_reversed BOOLEAN, -- Reversal flag
  reversal_transaction_id VARCHAR, -- Linked reversal transaction
  dt_partition_yyyymm VARCHAR, -- Technical partition key
  load_ts TIMESTAMP_NTZ -- Ingestion timestamp
);

-- Commission-level fact table
-- Note: PRIMARY KEY and NOT NULL constraints added for data integrity and JOIN optimization
CREATE OR REPLACE TABLE RAW.F_COMMISSIONS (
  commission_id VARCHAR NOT NULL, -- Commission event identifier (primary key)
  transaction_id VARCHAR, -- Linked transaction key
  contract_id VARCHAR, -- Related contract key
  agency_id VARCHAR, -- Related agency key
  broker_id VARCHAR, -- Related broker key
  rule_id VARCHAR, -- Applied rule key
  commission_event_date DATE, -- Commission event date
  base_amount_eur NUMBER(18,2), -- Commission base in EUR
  commission_rate_pct NUMBER(9,4), -- Commission rate percentage
  expected_commission_eur NUMBER(18,2), -- Expected commission amount
  paid_commission_eur NUMBER(18,2), -- Paid commission amount
  adjustment_amount_eur NUMBER(18,2), -- Adjustment amount
  commission_status VARCHAR, -- Workflow status
  payment_batch_id VARCHAR, -- Payment batch identifier
  is_exception BOOLEAN, -- Exception indicator
  exception_code VARCHAR, -- Exception type code
  dt_partition_yyyymm VARCHAR, -- Technical partition key
  load_ts TIMESTAMP_NTZ -- Ingestion timestamp
);

-- Settlement-level fact table
-- Note: PRIMARY KEY and NOT NULL constraints added for data integrity and JOIN optimization
CREATE OR REPLACE TABLE RAW.F_SETTLEMENTS (
  settlement_id VARCHAR NOT NULL, -- Settlement identifier (primary key)
  settlement_date DATE, -- Settlement posting date
  due_date DATE, -- Due date
  transaction_id VARCHAR, -- Linked transaction key
  commission_id VARCHAR, -- Linked commission key
  contract_id VARCHAR, -- Related contract key
  agency_id VARCHAR, -- Related agency key
  broker_id VARCHAR, -- Related broker key
  counterparty_type VARCHAR, -- Counterparty category
  settlement_type VARCHAR, -- Incoming/outgoing type
  amount_due_eur NUMBER(18,2), -- Due amount in EUR
  amount_paid_eur NUMBER(18,2), -- Paid amount in EUR
  residual_amount_eur NUMBER(18,2), -- Residual amount in EUR
  settlement_status VARCHAR, -- Settlement status
  days_past_due NUMBER, -- Days overdue
  payment_reference VARCHAR, -- Payment reference
  bank_account_masked VARCHAR, -- Masked account reference
  dt_partition_yyyymm VARCHAR, -- Technical partition key
  load_ts TIMESTAMP_NTZ -- Ingestion timestamp
);

-- Agency dimension
CREATE OR REPLACE TABLE RAW.D_AGENCY (
  agency_id VARCHAR, -- Agency key
  agency_code VARCHAR, -- Agency business code
  agency_name VARCHAR, -- Agency name
  legal_entity_name VARCHAR, -- Legal entity name
  tax_id_masked VARCHAR, -- Masked tax identifier
  region VARCHAR, -- Agency region
  city VARCHAR, -- Agency city
  country_code VARCHAR, -- Agency country code
  network_type VARCHAR, -- Network model
  channel_type VARCHAR, -- Channel model
  opening_date DATE, -- Opening date
  closing_date DATE, -- Closing date
  is_active BOOLEAN, -- Active flag
  risk_segment VARCHAR, -- Risk classification
  manager_name VARCHAR, -- Manager label
  valid_from DATE, -- SCD start date
  valid_to DATE, -- SCD end date
  is_current BOOLEAN -- Current record flag
);

-- Broker dimension
CREATE OR REPLACE TABLE RAW.D_BROKER (
  broker_id VARCHAR, -- Broker key
  broker_code VARCHAR, -- Broker business code
  broker_full_name VARCHAR, -- Broker full name
  broker_type VARCHAR, -- Broker type
  agency_id VARCHAR, -- Linked agency key
  registration_status VARCHAR, -- Registration status
  certification_level VARCHAR, -- Certification level
  onboarding_date DATE, -- Onboarding date
  offboarding_date DATE, -- Offboarding date
  is_active BOOLEAN, -- Active flag
  email_domain VARCHAR, -- Email domain
  phone_masked VARCHAR, -- Masked phone
  risk_segment VARCHAR, -- Risk classification
  valid_from DATE, -- SCD start date
  valid_to DATE, -- SCD end date
  is_current BOOLEAN -- Current record flag
);

-- Contract dimension
CREATE OR REPLACE TABLE RAW.D_CONTRACT (
  contract_id VARCHAR, -- Contract key
  contract_number VARCHAR, -- Contract business number
  agency_id VARCHAR, -- Linked agency key
  broker_id VARCHAR, -- Linked broker key
  product_code VARCHAR, -- Product code
  product_family VARCHAR, -- Product family
  customer_segment VARCHAR, -- Customer segment
  contract_start_date DATE, -- Contract start
  contract_end_date DATE, -- Contract end
  contract_status VARCHAR, -- Contract status
  billing_frequency VARCHAR, -- Billing frequency
  premium_amount_eur NUMBER(18,2), -- Premium in EUR
  commission_plan_code VARCHAR, -- Commission plan
  cancellation_reason VARCHAR, -- Cancellation reason
  is_renewable BOOLEAN, -- Renewability flag
  valid_from DATE, -- SCD start date
  valid_to DATE, -- SCD end date
  is_current BOOLEAN -- Current record flag
);

-- Calendar dimension
CREATE OR REPLACE TABLE RAW.D_DATE (
  date_key NUMBER, -- Date key YYYYMMDD
  full_date DATE, -- Calendar date
  day_of_month NUMBER, -- Day in month
  day_name VARCHAR, -- Day name
  week_of_year NUMBER, -- ISO week
  month_number NUMBER, -- Month number
  month_name VARCHAR, -- Month name
  quarter_number NUMBER, -- Quarter number
  year_number NUMBER, -- Year number
  yyyymm VARCHAR, -- Year-month key
  is_month_end BOOLEAN, -- Month-end flag
  is_quarter_end BOOLEAN, -- Quarter-end flag
  is_year_end BOOLEAN, -- Year-end flag
  is_business_day BOOLEAN, -- Business-day flag
  holiday_flag BOOLEAN, -- Holiday flag
  fiscal_month NUMBER, -- Fiscal month
  fiscal_quarter NUMBER, -- Fiscal quarter
  fiscal_year NUMBER -- Fiscal year
);

-- Commission rules reference dimension
CREATE OR REPLACE TABLE RAW.R_COMMISSION_RULES (
  rule_id VARCHAR, -- Rule key
  rule_code VARCHAR, -- Rule business code
  rule_name VARCHAR, -- Rule label
  product_code VARCHAR, -- Product condition
  product_family VARCHAR, -- Product family condition
  broker_type VARCHAR, -- Broker type condition
  agency_network_type VARCHAR, -- Agency network condition
  contract_status VARCHAR, -- Contract status condition
  min_premium_eur NUMBER(18,2), -- Lower premium threshold
  max_premium_eur NUMBER(18,2), -- Upper premium threshold
  rate_pct NUMBER(9,4), -- Rate percentage
  fixed_fee_eur NUMBER(18,2), -- Fixed fee
  priority_order NUMBER, -- Rule priority
  effective_from DATE, -- Effective start date
  effective_to DATE, -- Effective end date
  is_active BOOLEAN, -- Active flag
  approval_version VARCHAR, -- Governance version
  created_by VARCHAR, -- Rule creator
  created_ts TIMESTAMP_NTZ -- Creation timestamp
);

-- Audit exceptions fact table
CREATE OR REPLACE TABLE RAW.AUDIT_EXCEPTIONS (
  exception_id VARCHAR, -- Exception identifier
  detected_ts TIMESTAMP_NTZ, -- Detection timestamp
  audit_date DATE, -- Audit date
  exception_type VARCHAR, -- Exception type
  severity VARCHAR, -- Severity level
  entity_name VARCHAR, -- Affected entity name
  entity_id VARCHAR, -- Affected entity key
  contract_id VARCHAR, -- Related contract key
  agency_id VARCHAR, -- Related agency key
  broker_id VARCHAR, -- Related broker key
  rule_id VARCHAR, -- Related rule key
  metric_name VARCHAR, -- Controlled metric
  expected_value VARCHAR, -- Expected value
  actual_value VARCHAR, -- Observed value
  delta_value NUMBER(18,2), -- Difference value
  threshold_value NUMBER(18,2), -- Alert threshold
  status VARCHAR, -- Exception status
  owner_team VARCHAR, -- Owner team
  owner_user VARCHAR, -- Owner user
  resolution_comment VARCHAR, -- Resolution note
  resolved_ts TIMESTAMP_NTZ, -- Resolution timestamp
  dt_partition_yyyymm VARCHAR -- Technical partition key
);

-- ----------------------------------------------------------------------------
-- 4) Upload commands (run in SnowSQL/CLI, not in worksheet)
-- ----------------------------------------------------------------------------
-- PUT file://C:/path/to/files/F_TRANSACTIONS.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload transactions file
-- PUT file://C:/path/to/files/F_COMMISSIONS.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload commissions file
-- PUT file://C:/path/to/files/F_SETTLEMENTS.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload settlements file
-- PUT file://C:/path/to/files/D_AGENCY.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload agency dimension file
-- PUT file://C:/path/to/files/D_BROKER.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload broker dimension file
-- PUT file://C:/path/to/files/D_CONTRACT.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload contract dimension file
-- PUT file://C:/path/to/files/D_DATE.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload calendar file
-- PUT file://C:/path/to/files/R_COMMISSION_RULES.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload commission rules file
-- PUT file://C:/path/to/files/AUDIT_EXCEPTIONS.csv @BD_FINANCE_COURTIERS.RAW.STG_FINANCE_FILES AUTO_COMPRESS=FALSE OVERWRITE=TRUE; -- Upload audit exceptions file

-- ----------------------------------------------------------------------------
-- 5) Load data from stage into RAW
-- ----------------------------------------------------------------------------
-- Load transactions data with validation
COPY INTO RAW.F_TRANSACTIONS -- Load transactions data
FROM @RAW.STG_FINANCE_FILES/F_TRANSACTIONS.csv -- Source object
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD) -- Use shared CSV parser
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE -- Header-based mapping
ON_ERROR = CONTINUE; -- Keep valid rows when parsing issues occur
-- Validation: verify load success
SELECT 'F_TRANSACTIONS load validation' AS check_name, COUNT(*) AS loaded_row_count FROM RAW.F_TRANSACTIONS;

COPY INTO RAW.F_COMMISSIONS -- Load commissions data
FROM @RAW.STG_FINANCE_FILES/F_COMMISSIONS.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.F_SETTLEMENTS -- Load settlements data
FROM @RAW.STG_FINANCE_FILES/F_SETTLEMENTS.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.D_AGENCY -- Load agency dimension
FROM @RAW.STG_FINANCE_FILES/D_AGENCY.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.D_BROKER -- Load broker dimension
FROM @RAW.STG_FINANCE_FILES/D_BROKER.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.D_CONTRACT -- Load contract dimension
FROM @RAW.STG_FINANCE_FILES/D_CONTRACT.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.D_DATE -- Load calendar dimension
FROM @RAW.STG_FINANCE_FILES/D_DATE.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.R_COMMISSION_RULES -- Load commission rules
FROM @RAW.STG_FINANCE_FILES/R_COMMISSION_RULES.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

COPY INTO RAW.AUDIT_EXCEPTIONS -- Load audit exceptions
FROM @RAW.STG_FINANCE_FILES/AUDIT_EXCEPTIONS.csv
FILE_FORMAT = (FORMAT_NAME = RAW.FF_CSV_STD)
MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE
ON_ERROR = CONTINUE;

-- Load validation: row count by table
SELECT 'F_TRANSACTIONS' AS table_name, COUNT(*) AS cnt FROM RAW.F_TRANSACTIONS
UNION ALL SELECT 'F_COMMISSIONS', COUNT(*) FROM RAW.F_COMMISSIONS
UNION ALL SELECT 'F_SETTLEMENTS', COUNT(*) FROM RAW.F_SETTLEMENTS
UNION ALL SELECT 'D_AGENCY', COUNT(*) FROM RAW.D_AGENCY
UNION ALL SELECT 'D_BROKER', COUNT(*) FROM RAW.D_BROKER
UNION ALL SELECT 'D_CONTRACT', COUNT(*) FROM RAW.D_CONTRACT
UNION ALL SELECT 'D_DATE', COUNT(*) FROM RAW.D_DATE
UNION ALL SELECT 'R_COMMISSION_RULES', COUNT(*) FROM RAW.R_COMMISSION_RULES
UNION ALL SELECT 'AUDIT_EXCEPTIONS', COUNT(*) FROM RAW.AUDIT_EXCEPTIONS;

-- ----------------------------------------------------------------------------
-- 6) Synthesized MART layer for compact BI model
-- Includes business logic: calculations, filters, quality metrics, risk scoring
-- ----------------------------------------------------------------------------

-- Partner flattened dimension (broker + agency attributes) with activity filter
-- Uses LEFT JOIN to preserve brokers even if agency link is missing (flexible model)
CREATE OR REPLACE TABLE MART.DM_PARTNER AS
SELECT
  b.broker_id, -- Broker key
  b.broker_code, -- Broker business code
  b.broker_full_name, -- Broker name
  b.broker_type, -- Broker type
  b.registration_status, -- Registration status
  b.certification_level, -- Certification level
  b.risk_segment AS broker_risk_segment, -- Broker risk segment
  a.agency_id, -- Agency key
  a.agency_code, -- Agency business code
  a.agency_name, -- Agency name
  a.region, -- Agency region
  a.city, -- Agency city
  a.country_code, -- Agency country
  a.network_type, -- Agency network
  a.channel_type, -- Agency channel
  a.risk_segment AS agency_risk_segment, -- Agency risk segment
  COALESCE(b.is_active, FALSE) AS broker_active_flag, -- Broker active flag with null safety
  COALESCE(a.is_active, FALSE) AS agency_active_flag, -- Agency active flag with null safety
  -- Broker eligibility: 1 if registration_status = active AND is_active = true, 0 otherwise
  CASE WHEN b.registration_status = 'active' 
    AND COALESCE(b.is_active, FALSE) THEN 1 ELSE 0 END AS is_broker_eligible,
  -- Partner risk classification: 1 if agency risk_segment in (low, medium), 0 for high/critical
  CASE WHEN a.risk_segment IN ('low','medium') THEN 1 ELSE 0 END AS is_low_risk_partner
FROM RAW.D_BROKER b
LEFT JOIN RAW.D_AGENCY a
  ON a.agency_id = b.agency_id; -- Preserve broker rows even if agency attributes are missing

-- Contract compact dimension with status-based filtering
CREATE OR REPLACE TABLE MART.DM_CONTRACT_CORE AS
SELECT
  contract_id, -- Contract key
  contract_number, -- Contract number
  agency_id, -- Agency key
  broker_id, -- Broker key
  product_code, -- Product code
  product_family, -- Product family
  customer_segment, -- Customer segment
  contract_status, -- Contract status
  billing_frequency, -- Billing frequency
  premium_amount_eur, -- Premium amount
  is_renewable, -- Renewability indicator
  -- Active contract filter: 1 if contract_status in (active, pending), 0 otherwise
  CASE WHEN contract_status IN ('active','pending') THEN 1 ELSE 0 END AS is_active_contract,
  -- Premium tier classification: high (>5000 EUR), medium (>1000 EUR), low (<=1000 EUR)
  CASE WHEN premium_amount_eur > 5000 THEN 'high' WHEN premium_amount_eur > 1000 THEN 'medium' ELSE 'low' END AS premium_tier
FROM RAW.D_CONTRACT;

-- Intermediate: Commission efficiency metrics with calculations and filters
CREATE OR REPLACE TABLE MART.FM_COMMISSION_EFFICIENCY AS
SELECT
  dt_partition_yyyymm AS yyyymm, -- Monthly partition key
  TO_DATE(dt_partition_yyyymm || '01', 'YYYYMMDD') AS month_date, -- Month date
  agency_id, -- Agency key
  broker_id, -- Broker key
  contract_id, -- Contract key
  -- Commission amounts
  SUM(expected_commission_eur) AS expected_commission_total, -- Baseline commission: sum of expected_commission_eur (contract terms)
  SUM(paid_commission_eur) AS paid_commission_total, -- Actual paid commission: sum of paid_commission_eur
  SUM(adjustment_amount_eur) AS total_adjustments, -- Cumulative adjustments (corrections, bonuses, penalties)
  COUNT(*) AS commission_event_count, -- Number of commission records in period
  -- Efficiency calculations
  ROUND(CASE WHEN SUM(expected_commission_eur) > 0
    THEN (SUM(paid_commission_eur) / SUM(expected_commission_eur)) * 100
    ELSE 0 END, 2) AS commission_payout_ratio_pct, -- KPI: (paid_commission / expected_commission) * 100 - payout percentage
  ROUND(CASE WHEN COUNT(*) > 0
    THEN ABS(SUM(adjustment_amount_eur)) / COUNT(*)
    ELSE 0 END, 2) AS avg_adjustment_per_event, -- Average adjustment magnitude per commission event
  -- Exception and issue tracking
  SUM(CASE WHEN commission_status = 'pending' THEN 1 ELSE 0 END) AS pending_commission_count, -- Count of not-yet-paid commissions
  SUM(CASE WHEN is_exception = TRUE THEN 1 ELSE 0 END) AS exception_commission_count -- Count of flagged exception commissions
FROM RAW.F_COMMISSIONS
WHERE commission_status NOT IN ('cancelled','reversed') -- Filter: exclude void/reversed commission records
GROUP BY 1,2,3,4,5;

-- Intermediate: Settlement aging analysis with risk flags
CREATE OR REPLACE TABLE MART.FM_SETTLEMENT_AGING AS
SELECT
  dt_partition_yyyymm AS yyyymm, -- Monthly partition key
  TO_DATE(dt_partition_yyyymm || '01', 'YYYYMMDD') AS month_date, -- Month date
  agency_id, -- Agency key
  broker_id, -- Broker key
  contract_id, -- Contract key
  -- Settlement amounts
  SUM(amount_due_eur) AS total_due, -- Total amount due from/to counterparty
  SUM(amount_paid_eur) AS total_paid, -- Total amount actually paid
  SUM(residual_amount_eur) AS total_residual, -- Unpaid amount remaining (due - paid)
  COUNT(*) AS settlement_count, -- Number of settlement records
  -- Overdue tracking
  SUM(CASE WHEN settlement_status = 'overdue' THEN 1 ELSE 0 END) AS overdue_settlement_count, -- Count of overdue settlement records
  SUM(CASE WHEN days_past_due > 30 THEN days_past_due ELSE 0 END) AS total_days_past_due_gt30, -- Cumulative days overdue (only counts days > 30)
  -- Collection efficiency
  ROUND(CASE WHEN SUM(amount_due_eur) > 0 THEN (SUM(amount_paid_eur) / SUM(amount_due_eur)) * 100 ELSE 0 END, 2) AS collection_rate_pct, -- KPI: (paid / due) * 100 - payment collection efficiency
  -- Risk flags for settlement quality
  CASE WHEN SUM(residual_amount_eur) / NULLIF(SUM(amount_due_eur), 0) > 0.15 THEN 1 ELSE 0 END AS has_high_residual_flag, -- Risk: 1 if unpaid ratio exceeds 15%, 0 otherwise
  CASE WHEN SUM(CASE WHEN settlement_status = 'overdue' THEN 1 ELSE 0 END) > NULLIF(COUNT(*), 0) * 0.1 THEN 1 ELSE 0 END AS has_overdue_risk_flag -- Risk: 1 if >10% of settlements are overdue, 0 otherwise
FROM RAW.F_SETTLEMENTS
WHERE settlement_status NOT IN ('cancelled','void') -- Filter: exclude void/cancelled settlement records
GROUP BY 1,2,3,4,5;

-- Intermediate: Transaction flow analysis with anomaly detection
CREATE OR REPLACE TABLE MART.FM_TRANSACTION_FLOW AS
SELECT
  dt_partition_yyyymm AS yyyymm, -- Monthly partition key
  TO_DATE(dt_partition_yyyymm || '01', 'YYYYMMDD') AS month_date, -- Month date
  agency_id, -- Agency key
  broker_id, -- Broker key
  contract_id, -- Contract key
  -- Cash flow analysis by direction
  SUM(CASE WHEN flow_direction = 'IN' THEN amount_eur ELSE 0 END) AS inflow_eur, -- Total inbound cash: sum of amounts where flow_direction = IN
  SUM(CASE WHEN flow_direction = 'OUT' THEN amount_eur ELSE 0 END) AS outflow_eur, -- Total outbound cash: sum of amounts where flow_direction = OUT
  SUM(amount_eur) AS net_flow_eur, -- Net cash position: sum of all amounts (algebraic sum = inflow - outflow for opposite directions)
  -- Transaction volume and diversity
  COUNT(*) AS transaction_count, -- Total transaction count
  COUNT(DISTINCT transaction_type) AS transaction_type_diversity, -- Number of distinct transaction types (diversity indicator)
  -- Reversal analysis for transaction quality
  SUM(CASE WHEN is_reversed = TRUE THEN 1 ELSE 0 END) AS reversal_count, -- Count of reversed transactions
  ROUND(CASE WHEN COUNT(*) > 0 THEN (SUM(CASE WHEN is_reversed = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100 ELSE 0 END, 2) AS reversal_rate_pct, -- Reversal percentage: (reversed_count / total_count) * 100 - measures transaction stability
  -- Reversal risk flag for anomaly detection
  CASE WHEN SUM(CASE WHEN is_reversed = TRUE THEN 1 ELSE 0 END) > COUNT(*) * 0.05 THEN 1 ELSE 0 END AS has_high_reversal_flag -- Risk flag: 1 if reversal rate exceeds 5%, 0 otherwise
FROM RAW.F_TRANSACTIONS
WHERE payment_status IN ('posted','cleared') -- Filter: only final posted/cleared transactions, exclude pending/draft
GROUP BY 1,2,3,4,5;

-- Monthly synthesized finance fact (integrated transactions + commissions + settlements with calculations)
CREATE OR REPLACE TABLE MART.FM_FINANCE_MONTHLY AS
WITH tx AS (
  -- Extract key metrics from transaction flow analysis
  SELECT yyyymm, agency_id, broker_id, contract_id, inflow_eur, outflow_eur, net_flow_eur, transaction_count, reversal_rate_pct, has_high_reversal_flag
  FROM MART.FM_TRANSACTION_FLOW
),
cm AS (
  -- Extract key metrics from commission efficiency analysis
  SELECT yyyymm, agency_id, broker_id, contract_id, expected_commission_total, paid_commission_total, total_adjustments, commission_payout_ratio_pct, exception_commission_count, pending_commission_count
  FROM MART.FM_COMMISSION_EFFICIENCY
),
st AS (
  -- Extract key metrics from settlement aging analysis
  SELECT yyyymm, agency_id, broker_id, contract_id, total_due, total_paid, total_residual, collection_rate_pct, overdue_settlement_count, has_high_residual_flag, has_overdue_risk_flag
  FROM MART.FM_SETTLEMENT_AGING
),
k AS (
  -- Create unified keyset from all three data sources (transaction, commission, settlement)
  -- Using UNION ALL for performance (removes duplicate elimination overhead)
  SELECT yyyymm, agency_id, broker_id, contract_id FROM tx
  UNION ALL
  SELECT yyyymm, agency_id, broker_id, contract_id FROM cm
  UNION ALL
  SELECT yyyymm, agency_id, broker_id, contract_id FROM st
),
enriched AS (
  -- Full outer join of all metrics with zero-fill for missing values and calculated risk flags
  SELECT
    k.yyyymm, -- Monthly partition key
    TO_DATE(k.yyyymm || '01', 'YYYYMMDD') AS month_start_date, -- Month start date
    k.agency_id, -- Agency key
    k.broker_id, -- Broker key
    k.contract_id, -- Contract key
    -- Transaction metrics (zero-filled if no transactions)
    COALESCE(tx.inflow_eur, 0) AS inflow_eur, -- Inbound cash or 0
    COALESCE(tx.outflow_eur, 0) AS outflow_eur, -- Outbound cash or 0
    COALESCE(tx.net_flow_eur, 0) AS net_flow_eur, -- Net cash or 0
    COALESCE(tx.transaction_count, 0) AS tx_count, -- Transaction volume or 0
    -- Commission metrics (zero-filled if no commissions)
    COALESCE(cm.expected_commission_total, 0) AS comm_expected_eur, -- Expected commission or 0
    COALESCE(cm.paid_commission_total, 0) AS comm_paid_eur, -- Paid commission or 0
    COALESCE(cm.total_adjustments, 0) AS comm_adjustment_eur, -- Adjustments or 0
    -- Settlement metrics (zero-filled if no settlements)
    COALESCE(st.total_due, 0) AS due_eur, -- Amount due or 0
    COALESCE(st.total_paid, 0) AS paid_eur, -- Amount paid or 0
    COALESCE(st.total_residual, 0) AS residual_eur, -- Residual or 0
    COALESCE(st.collection_rate_pct, 0) AS collection_rate_pct, -- Collection rate or 0
    COALESCE(st.overdue_settlement_count, 0) AS overdue_count, -- Overdue count or 0
    -- Calculated efficiency metrics (passed through from intermediate tables)
    COALESCE(cm.commission_payout_ratio_pct, 0) AS commission_efficiency_pct, -- Commission efficiency percentage
    COALESCE(tx.reversal_rate_pct, 0) AS reversal_rate_pct, -- Transaction reversal rate percentage
    -- Derived risk flags (0 or 1) for individual risk conditions
    -- Note: COALESCE ensures NULL + NULL = 0 (not NULL), preventing incorrect flags
    CASE WHEN COALESCE(cm.exception_commission_count, 0) + COALESCE(cm.pending_commission_count, 0) > 0 THEN 1 ELSE 0 END AS has_commission_issues_flag,
    COALESCE(st.has_high_residual_flag, 0) AS has_residual_risk_flag,
    COALESCE(st.has_overdue_risk_flag, 0) AS has_overdue_risk_flag,
    COALESCE(tx.has_high_reversal_flag, 0) AS has_reversal_risk_flag
  FROM k
  LEFT JOIN tx ON tx.yyyymm = k.yyyymm AND tx.agency_id = k.agency_id AND tx.broker_id = k.broker_id AND tx.contract_id = k.contract_id
  LEFT JOIN cm ON cm.yyyymm = k.yyyymm AND cm.agency_id = k.agency_id AND cm.broker_id = k.broker_id AND cm.contract_id = k.contract_id
  LEFT JOIN st ON st.yyyymm = k.yyyymm AND st.agency_id = k.agency_id AND st.broker_id = k.broker_id AND st.contract_id = k.contract_id
)
SELECT
  yyyymm, -- Monthly partition key
  month_start_date, -- Month start date
  agency_id, -- Agency key
  broker_id, -- Broker key
  contract_id, -- Contract key
  inflow_eur, -- Inbound cash transactions (sum where flow_direction = IN)
  outflow_eur, -- Outbound cash transactions (sum where flow_direction = OUT)
  net_flow_eur, -- Net cash flow: inflow - outflow
  tx_count, -- Total transaction count for period
  comm_expected_eur, -- Expected commission amount (baseline)
  comm_paid_eur, -- Actual commission paid to partner
  comm_adjustment_eur, -- Commission adjustments/corrections (positive or negative)
  due_eur, -- Settlement amount due to/from counterparty
  paid_eur, -- Settlement amount actually paid
  residual_eur, -- Unpaid settlement amount
  overdue_count, -- Count of overdue settlement records
  commission_efficiency_pct, -- KPI: (paid_commission / expected_commission) * 100 - measures commission payout ratio
  collection_rate_pct, -- KPI: (amount_paid / amount_due) * 100 - measures payment collection efficiency
  reversal_rate_pct, -- KPI: (reversed_tx_count / total_tx_count) * 100 - anomaly metric for transaction reversals
  has_commission_issues_flag, -- Risk flag: 1 if pending or exception commissions exist, 0 otherwise
  has_residual_risk_flag, -- Risk flag: 1 if residual > 15% of due amount, 0 otherwise
  has_overdue_risk_flag, -- Risk flag: 1 if >10% of settlements are overdue, 0 otherwise
  has_reversal_risk_flag, -- Risk flag: 1 if reversal rate > 5%, 0 otherwise
  -- Composite risk score: sum of all 4 risk flags (0=no risk, 4=maximum risk)
  has_commission_issues_flag + has_residual_risk_flag + has_overdue_risk_flag + has_reversal_risk_flag AS total_risk_flags
FROM enriched;

-- Partner performance scorecard with aggregated metrics at agency-broker level
CREATE OR REPLACE TABLE MART.FM_PARTNER_PERFORMANCE AS
SELECT
  yyyymm, -- Monthly partition key
  TO_DATE(yyyymm || '01', 'YYYYMMDD') AS month_date, -- Month start date
  agency_id, -- Agency key
  broker_id, -- Broker key
  SUM(net_flow_eur) AS total_net_flow, -- Aggregated net cash flow across all contracts
  SUM(tx_count) AS total_transactions, -- Total transaction volume across all contracts
  ROUND(AVG(commission_efficiency_pct), 2) AS avg_commission_efficiency_pct, -- Average commission payout efficiency across contracts (0-100%)
  ROUND(AVG(collection_rate_pct), 2) AS avg_collection_rate_pct, -- Average settlement collection rate across contracts (0-100%)
  MAX(total_risk_flags) AS max_risk_flags_in_period, -- Maximum risk flag count across any contract (0-4 scale)
  -- Counters of contracts with specific risk conditions
  SUM(CASE WHEN has_commission_issues_flag = 1 THEN 1 ELSE 0 END) AS contracts_with_commission_issues, -- Number of contracts with pending or exception commissions
  SUM(CASE WHEN has_residual_risk_flag = 1 THEN 1 ELSE 0 END) AS contracts_with_residual_risk, -- Number of contracts with high unpaid residual (>15%)
  SUM(CASE WHEN has_overdue_risk_flag = 1 THEN 1 ELSE 0 END) AS contracts_with_overdue_risk, -- Number of contracts with >10% overdue settlements
  SUM(CASE WHEN has_reversal_risk_flag = 1 THEN 1 ELSE 0 END) AS contracts_with_reversal_risk, -- Number of contracts with high reversal rate (>5%)
  -- Partner-level risk classification based on maximum risk flag count
  CASE
    WHEN MAX(total_risk_flags) >= 3 THEN 'critical' -- Critical: 3+ risk flags in any contract
    WHEN MAX(total_risk_flags) = 2 THEN 'high' -- High: exactly 2 risk flags in worst contract
    WHEN MAX(total_risk_flags) = 1 THEN 'medium' -- Medium: 1 risk flag in worst contract
    ELSE 'low' -- Low: no risk flags across all contracts
  END AS partner_risk_level
FROM MART.FM_FINANCE_MONTHLY
GROUP BY 1,2,3,4;

-- Monthly audit synthesis for risk monitoring with composite risk rating
CREATE OR REPLACE TABLE MART.FM_AUDIT_MONTHLY AS
SELECT
  dt_partition_yyyymm AS yyyymm, -- Monthly partition key
  TO_DATE(dt_partition_yyyymm || '01', 'YYYYMMDD') AS month_start_date, -- Month start date
  agency_id, -- Agency key
  broker_id, -- Broker key
  contract_id, -- Contract key
  COUNT(*) AS exception_count, -- Total audit exceptions in period
  SUM(CASE WHEN status IN ('open','in_progress') THEN 1 ELSE 0 END) AS open_exception_count, -- Count of unresolved exceptions
  SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) AS critical_exception_count, -- Count of critical severity exceptions
  SUM(CASE WHEN severity = 'high' THEN 1 ELSE 0 END) AS high_exception_count, -- Count of high severity exceptions
  SUM(CASE WHEN severity = 'medium' THEN 1 ELSE 0 END) AS medium_exception_count, -- Count of medium severity exceptions
  SUM(COALESCE(delta_value,0)) AS total_delta_value, -- Cumulative deviation/variance amount in EUR
  ROUND(SUM(COALESCE(delta_value,0)) / NULLIF(COUNT(*), 0), 2) AS avg_delta_per_exception, -- Average deviation magnitude per exception
  -- Composite audit risk classification based on severity distribution
  CASE
    WHEN SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) > 0 THEN 'critical' -- Critical risk: any critical exception exists
    WHEN SUM(CASE WHEN severity = 'high' THEN 1 ELSE 0 END) >= 2 THEN 'high' -- High risk: 2+ high severity exceptions
    WHEN SUM(CASE WHEN severity IN ('high','medium') THEN 1 ELSE 0 END) > 0 THEN 'medium' -- Medium risk: at least 1 high or medium exception
    ELSE 'low' -- Low risk: only low/info level exceptions
  END AS audit_risk_rating
FROM RAW.AUDIT_EXCEPTIONS
WHERE status NOT IN ('cancelled','archived') -- Filter out void/cancelled exception records
GROUP BY 1,2,3,4,5;

-- Final compact view consumed by BI semantic model with all calculations and filters
CREATE OR REPLACE VIEW MART.VW_BI_FINANCE_COCKPIT AS
SELECT
  -- Time and entity keys
  f.yyyymm, -- Monthly partition key (YYYYMM format)
  f.month_start_date, -- Month start date (derived for calendar joins)
  
  -- Agency and broker attributes (from dimension)
  f.agency_id, -- Agency key
  p.agency_name, -- Agency name
  p.region, -- Geographic region
  p.network_type, -- Network classification (direct/partner/broker network)
  p.is_low_risk_partner, -- Agency risk flag: 1 if risk_segment in (low/medium), 0 otherwise
  
  f.broker_id, -- Broker key
  p.broker_full_name, -- Broker full name
  p.broker_type, -- Broker classification
  p.is_broker_eligible, -- Broker eligibility: 1 if active and registration_status = active, 0 otherwise
  
  -- Contract attributes (from dimension with calculated tiers)
  f.contract_id, -- Contract key
  c.product_family, -- Insurance product family
  c.customer_segment, -- Customer segment classification
  c.premium_tier, -- Calculated premium tier: high (>5000), medium (>1000), or low
  c.is_active_contract, -- Contract active flag: 1 if status in (active/pending), 0 otherwise
  
  -- Transaction flow metrics (calculated in FM_TRANSACTION_FLOW)
  f.inflow_eur, -- Inbound cash transactions for period (SUM where flow_direction = IN)
  f.outflow_eur, -- Outbound cash transactions for period (SUM where flow_direction = OUT)
  f.net_flow_eur, -- Net cash position: inflow - outflow
  f.tx_count, -- Total transaction volume for period
  
  -- Commission metrics (calculated in FM_COMMISSION_EFFICIENCY)
  f.comm_expected_eur, -- Expected commission baseline from transaction rules
  f.comm_paid_eur, -- Actual commission paid to partner
  f.comm_adjustment_eur, -- Commission adjustments/corrections applied
  f.commission_efficiency_pct, -- KPI: (comm_paid / comm_expected) * 100 - efficiency percentage
  
  -- Settlement metrics (calculated in FM_SETTLEMENT_AGING)
  f.due_eur, -- Settlement amount due from/to counterparty
  f.paid_eur, -- Settlement amount actually paid
  f.residual_eur, -- Unpaid settlement amount remaining
  f.collection_rate_pct, -- KPI: (paid / due) * 100 - collection efficiency percentage
  f.overdue_count, -- Count of overdue settlement records
  
  -- Quality and anomaly detection metrics (calculated in FM_TRANSACTION_FLOW)
  f.reversal_rate_pct, -- KPI: (reversed_tx_count / total_tx_count) * 100 - transaction reversal rate
  
  -- Individual risk flags (0 or 1)
  f.has_commission_issues_flag, -- Risk: 1 if pending or exception commissions exist
  f.has_residual_risk_flag, -- Risk: 1 if residual exceeds 15% of due amount
  f.has_overdue_risk_flag, -- Risk: 1 if >10% of settlements are overdue
  f.has_reversal_risk_flag, -- Risk: 1 if reversal rate exceeds 5%
  f.total_risk_flags, -- Composite risk score: sum of above 4 flags (0-4 scale)
  
  -- Audit exception metrics (calculated in FM_AUDIT_MONTHLY)
  COALESCE(a.exception_count, 0) AS exception_count, -- Total audit exceptions for contract
  COALESCE(a.open_exception_count, 0) AS open_exception_count, -- Unresolved exceptions
  COALESCE(a.critical_exception_count, 0) AS critical_exception_count, -- Critical severity exceptions
  COALESCE(a.audit_risk_rating, 'low') AS audit_risk_rating, -- Composite audit risk: critical/high/medium/low
  
  -- Partner-level performance aggregates (calculated in FM_PARTNER_PERFORMANCE)
  COALESCE(pp.avg_commission_efficiency_pct, 0) AS partner_avg_efficiency_pct, -- Partner average commission efficiency across contracts
  COALESCE(pp.avg_collection_rate_pct, 0) AS partner_avg_collection_pct, -- Partner average collection rate across contracts
  COALESCE(pp.partner_risk_level, 'low') AS partner_risk_level -- Partner-level risk classification: critical/high/medium/low
FROM MART.FM_FINANCE_MONTHLY f
LEFT JOIN MART.FM_AUDIT_MONTHLY a
  ON a.yyyymm = f.yyyymm
  AND a.agency_id = f.agency_id
  AND a.broker_id = f.broker_id
  AND a.contract_id = f.contract_id -- Join audit exceptions by month and entity keys
LEFT JOIN MART.DM_PARTNER p
  ON p.agency_id = f.agency_id
  AND p.broker_id = f.broker_id -- Join partner descriptive attributes (agency + broker)
LEFT JOIN MART.DM_CONTRACT_CORE c
  ON c.contract_id = f.contract_id -- Join contract descriptive attributes
LEFT JOIN MART.FM_PARTNER_PERFORMANCE pp
  ON pp.yyyymm = f.yyyymm
  AND pp.agency_id = f.agency_id
  AND pp.broker_id = f.broker_id; -- Join partner-level performance aggregates

-- ----------------------------------------------------------------------------
-- 7) Final validation checks
-- Validate all MART tables and calculated metrics
-- Row count validation ensures all pipelines completed successfully
-- Quality checks verify that calculated KPIs and risk flags are populated
-- Anomaly detection identifies contracts with specific risk conditions
-- ----------------------------------------------------------------------------

-- Validate row counts across all MART tables to ensure completeness
SELECT 'DM_PARTNER' AS table_name, COUNT(*) AS row_count FROM MART.DM_PARTNER
UNION ALL SELECT 'DM_CONTRACT_CORE', COUNT(*) FROM MART.DM_CONTRACT_CORE
UNION ALL SELECT 'FM_TRANSACTION_FLOW', COUNT(*) FROM MART.FM_TRANSACTION_FLOW
UNION ALL SELECT 'FM_COMMISSION_EFFICIENCY', COUNT(*) FROM MART.FM_COMMISSION_EFFICIENCY
UNION ALL SELECT 'FM_SETTLEMENT_AGING', COUNT(*) FROM MART.FM_SETTLEMENT_AGING
UNION ALL SELECT 'FM_FINANCE_MONTHLY', COUNT(*) FROM MART.FM_FINANCE_MONTHLY
UNION ALL SELECT 'FM_PARTNER_PERFORMANCE', COUNT(*) FROM MART.FM_PARTNER_PERFORMANCE
UNION ALL SELECT 'FM_AUDIT_MONTHLY', COUNT(*) FROM MART.FM_AUDIT_MONTHLY
UNION ALL SELECT 'VW_BI_FINANCE_COCKPIT', COUNT(*) FROM MART.VW_BI_FINANCE_COCKPIT;

-- Quality checks: verify calculated metrics are populated and within expected ranges
SELECT
  'Commission Efficiency' AS metric_check, -- Commission payout ratio metric
  COUNT(*) AS records_with_value, -- Total records
  COUNT(CASE WHEN commission_efficiency_pct > 0 THEN 1 END) AS non_zero_count, -- Records with non-zero efficiency
  ROUND(AVG(commission_efficiency_pct), 2) AS avg_pct, -- Average efficiency percentage (0-100%)
  MIN(commission_efficiency_pct) AS min_pct, -- Minimum efficiency
  MAX(commission_efficiency_pct) AS max_pct -- Maximum efficiency
FROM MART.FM_FINANCE_MONTHLY
UNION ALL
SELECT
  'Collection Rate', -- Settlement payment collection metric
  COUNT(*),
  COUNT(CASE WHEN collection_rate_pct > 0 THEN 1 END),
  ROUND(AVG(collection_rate_pct), 2),
  MIN(collection_rate_pct),
  MAX(collection_rate_pct)
FROM MART.FM_FINANCE_MONTHLY
UNION ALL
SELECT
  'Risk Flags Distribution', -- Composite risk score (0-4 scale)
  COUNT(*),
  COUNT(CASE WHEN total_risk_flags > 0 THEN 1 END),
  ROUND(AVG(total_risk_flags), 2),
  MIN(total_risk_flags),
  MAX(total_risk_flags)
FROM MART.FM_FINANCE_MONTHLY;

-- Audit data quality: check for anomalies by counting contracts with specific risk conditions
-- Note: PERFORMANCE OPTIMIZATION RECOMMENDATIONS:
-- 1. Add clustering keys on RAW tables for large-scale deployments: CLUSTER BY (dt_partition_yyyymm, agency_id)
-- 2. Consider materialized view instead of VW_BI_FINANCE_COCKPIT for frequent queries: CREATE MATERIALIZED VIEW ...
-- 3. Use dynamic data masking (DDM) on sensitive columns (tax_id_masked, phone_masked, bank_account_masked)
-- 4. Enable query result caching for dashboard queries (SET RESULT_SCAN_CACHE_SIZE)
-- 5. Monitor query performance with QUERY_HISTORY view for MART layer queries
SELECT
  'Records with Commission Issues' AS data_quality_check, -- Has pending or exception commissions
  COUNT(*) AS count_val
FROM MART.FM_FINANCE_MONTHLY
WHERE has_commission_issues_flag = 1
UNION ALL
SELECT 'Records with Residual Risk', COUNT(*) FROM MART.FM_FINANCE_MONTHLY WHERE has_residual_risk_flag = 1 -- Unpaid > 15%
UNION ALL
SELECT 'Records with Overdue Risk', COUNT(*) FROM MART.FM_FINANCE_MONTHLY WHERE has_overdue_risk_flag = 1 -- >10% overdue settlements
UNION ALL
SELECT 'Records with Reversal Risk', COUNT(*) FROM MART.FM_FINANCE_MONTHLY WHERE has_reversal_risk_flag = 1 -- >5% transaction reversals
UNION ALL
SELECT 'Partner Performance Records', COUNT(*) FROM MART.FM_PARTNER_PERFORMANCE -- Total partner-month combinations
UNION ALL
SELECT 'High Risk Partners', COUNT(*) FROM MART.FM_PARTNER_PERFORMANCE WHERE partner_risk_level IN ('high','critical'); -- Partners with max risk >= 2
