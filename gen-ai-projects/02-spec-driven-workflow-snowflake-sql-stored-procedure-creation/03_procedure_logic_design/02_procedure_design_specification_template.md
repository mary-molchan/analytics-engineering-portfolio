# Procedure Design Specification Template

## Purpose

This document defines the technical design of a Snowflake SQL stored procedure before SQL implementation.

It describes the procedure signature, parameters, target object handling, load strategy, execution flow, DDL/DML behavior, idempotency, error handling, logging, transaction considerations, security context, performance risks, and readiness for SQL code generation.

This document must be completed and reviewed before generating or executing Snowflake SQL code.

---

## 1. Source Information

| Field | Value |
|---|---|
| SQL request brief | [`../01_requirement_discovery/02_sql_request_brief_template.md`](../01_requirement_discovery/02_sql_request_brief_template.md) |
| Data contract and mapping | [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md) |
| Created with prompt | [`01_gen_ai_prompt_create_procedure_design_specification.md`](./01_gen_ai_prompt_create_procedure_design_specification.md) |
| Generated with Generative AI | Yes / No |
| Manually reviewed by Data Engineer | Yes / No |
| Ready for SQL Implementation | Yes / Conditional / No |

---

## 2. Procedure Design Summary

```text
[Summarize the stored procedure design in 3–5 sentences.

Include:
- procedure purpose;
- target object behavior;
- high-level load strategy;
- main transformation flow;
- key safety or validation controls.]
```

---

## 3. Procedure Identity and Signature

| Item | Design decision |
|---|---|
| Procedure name | |
| Fully qualified procedure name | `DATABASE.SCHEMA.PROCEDURE` / To be confirmed |
| Procedure language | SQL / Snowflake Scripting / To be confirmed |
| Return type | STRING / VARIANT / OBJECT / TABLE / To be confirmed |
| Execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed |
| Expected caller | Analyst / Data Engineer / Task / Pipeline / Application / To be confirmed |
| Execution frequency | One-time / Scheduled / On demand / Event-based / To be confirmed |
| Target environment | Dev / Test / Prod / To be confirmed |

---

## 4. Procedure Parameters

| Parameter name | Snowflake data type | Required? | Default value | Purpose | Validation rule |
|---|---|---|---|---|---|
| | | Yes / No / To be confirmed | | | |

### Candidate Parameters to Confirm

| Candidate parameter | Reason | Required? | Status |
|---|---|---|---|
| `P_LOAD_DATE` | Controls date-based load scope. | Yes / No / To be confirmed | To be confirmed |
| `P_BATCH_ID` | Tracks execution batch. | Yes / No / To be confirmed | To be confirmed |
| `P_LOAD_MODE` | Controls append, merge, reload, or validation behavior. | Yes / No / To be confirmed | To be confirmed |
| `P_SOURCE_SYSTEM` | Limits or identifies source system scope. | Yes / No / To be confirmed | To be confirmed |
| `P_FORCE_RELOAD` | Allows controlled reload behavior if explicitly approved. | Yes / No / To be confirmed | To be confirmed |

---

## 5. Target Object Handling

| Step | Design decision | Status |
|---|---|---|
| Check target object existence | Yes / No / To be confirmed | |
| Create target object if missing | Yes / No / To be confirmed | |
| Fail if target object is missing | Yes / No / To be confirmed | |
| Validate target structure before load | Yes / No / To be confirmed | |
| Check existing target data | Yes / No / To be confirmed | |
| Existing data behavior | Append / Skip / Merge / Delete and reload / Fail / To be confirmed | |
| Duplicate prevention required | Yes / No / To be confirmed | |
| Historical data preservation required | Yes / No / To be confirmed | |
| Target ownership / privileges confirmed | Yes / No / To be confirmed | |

---

## 6. Load Strategy

| Topic | Design decision | Notes |
|---|---|---|
| Load mode | Full reload / Incremental / Append-only / Merge / Validate only / To be confirmed | |
| Incremental key / watermark | | |
| Merge key / business key | | |
| Deduplication strategy | | |
| Late-arriving data handling | | |
| Reprocessing behavior | | |
| Empty source behavior | Continue / Stop / Log warning / Fail / To be confirmed | |
| Empty target behavior | Insert / Skip / Validate only / To be confirmed | |
| Existing target data behavior | Append / Skip / Merge / Delete and reload / Fail / To be confirmed | |

---

## 7. Execution Flow

| Step # | Step name | Description | Blocking dependency |
|---|---|---|---|
| 1 | Initialize execution metadata | | |
| 2 | Validate input parameters | | |
| 3 | Validate source object availability | | |
| 4 | Validate or create target object | | |
| 5 | Check existing target data if required | | |
| 6 | Prepare source dataset | | |
| 7 | Apply joins, filters, and transformations | | |
| 8 | Apply data quality checks | | |
| 9 | Apply deduplication or aggregation if required | | |
| 10 | Execute DML operation | Insert / Merge / Update / Delete and reload / Validate only / To be confirmed | |
| 11 | Capture row counts and execution status | | |
| 12 | Write audit or log entry if required | | |
| 13 | Return success or failure status | | |

---

## 8. Source Data Preparation Logic

| Step ID | Source / Intermediate dataset | Purpose | Key logic | Status |
|---|---|---|---|---|
| PREP-001 | | | Filtering / Join preparation / Transformation / Deduplication / Aggregation / Validation / Other | Confirmed / To be confirmed |

---

## 9. DDL Design

| DDL action | Applies to | Required? | Design rule | Risk / Notes |
|---|---|---|---|---|
| Create target table if not exists | | Yes / No / To be confirmed | | |
| Create temporary object | | Yes / No / To be confirmed | | |
| Create transient object | | Yes / No / To be confirmed | | |
| Create audit / log table | | Yes / No / To be confirmed | | |
| Alter object | | Yes / No / To be confirmed | | |
| No DDL required | | Yes / No / To be confirmed | | |

> [!CAUTION]
> Do not assume that DDL is safe inside the procedure unless ownership, privileges, deployment rules, and transaction implications are confirmed.

---

## 10. DML Design

| DML action | Target object | Condition | Expected behavior | Safety rule |
|---|---|---|---|---|
| Insert | | | | |
| Merge | | | | |
| Update | | | | |
| Delete | | | | |
| Truncate and insert | | | | |
| Validate only | | | | |

> [!CAUTION]
> Destructive actions such as `DELETE`, `TRUNCATE`, or full reload must be explicitly confirmed before implementation.

---

## 11. Idempotency and Duplicate Prevention

| Topic | Design decision | Status |
|---|---|---|
| Procedure safe to rerun? | Yes / No / To be confirmed | |
| Duplicate prevention logic | | |
| Business key / merge key | | |
| Existing target data check | | |
| Reprocessing strategy | | |
| Failure recovery behavior | | |
| Expected behavior if executed twice with same input | | |

---

## 12. Error Handling and Return Behavior

| Scenario | Expected behavior | Return / Log detail | Blocking? |
|---|---|---|---|
| Missing source object | Fail / Log warning / Skip / To be confirmed | | Yes / No |
| Missing target object | Create / Fail / To be confirmed | | Yes / No |
| Invalid parameter | Fail / Use default / To be confirmed | | Yes / No |
| Empty source dataset | Continue / Stop / Log warning / Fail / To be confirmed | | Yes / No |
| Duplicate key risk | Fail / Deduplicate / Log warning / To be confirmed | | Yes / No |
| Failed data quality check | Fail / Skip / Quarantine / Log warning / To be confirmed | | Yes / No |
| Failed DML operation | Roll back / Log failure / Return error / To be confirmed | | Yes / No |
| Permission issue | Fail and return error / To be confirmed | | Yes / No |
| Unexpected error | Fail and return structured error / To be confirmed | | Yes / No |

### Expected Return Payload

| Item | Included? | Notes |
|---|---|---|
| Execution status | Yes / No / To be confirmed | Success / Failure / Warning |
| Procedure name | Yes / No / To be confirmed | |
| Run ID / Batch ID | Yes / No / To be confirmed | |
| Rows inserted | Yes / No / To be confirmed | |
| Rows updated | Yes / No / To be confirmed | |
| Rows skipped | Yes / No / To be confirmed | |
| Error message | Yes / No / To be confirmed | |
| Audit reference | Yes / No / To be confirmed | |

---

## 13. Audit and Logging Design

| Logging item | Required? | Expected value | Target log object |
|---|---|---|---|
| Procedure name | Yes / No / To be confirmed | | |
| Run ID / Batch ID | Yes / No / To be confirmed | | |
| Start timestamp | Yes / No / To be confirmed | | |
| End timestamp | Yes / No / To be confirmed | | |
| Execution status | Yes / No / To be confirmed | Success / Failure / Warning | |
| Rows selected from source | Yes / No / To be confirmed | | |
| Rows inserted | Yes / No / To be confirmed | | |
| Rows updated | Yes / No / To be confirmed | | |
| Rows deleted | Yes / No / To be confirmed | | |
| Rows skipped | Yes / No / To be confirmed | | |
| Error message | Yes / No / To be confirmed | | |

---

## 14. Transaction and Failure Behavior

| Topic | Design decision | Notes |
|---|---|---|
| Transaction required? | Yes / No / To be confirmed | |
| Transaction scope | Full procedure / DML only / To be confirmed | |
| DDL transaction consideration | To be confirmed | Do not assume DDL rollback behavior without validation. |
| Partial load prevention | | |
| Failure recovery | | |
| Rollback / re-run strategy | | |
| Behavior after failed execution | | |

---

## 15. Security and Execution Context

| Topic | Requirement / Design decision | Status |
|---|---|---|
| Required role | | To be confirmed |
| Required warehouse | | To be confirmed |
| Required privileges on source objects | SELECT / To be confirmed | |
| Required privileges on target object | INSERT / UPDATE / DELETE / MERGE / OWNERSHIP / To be confirmed | |
| Required privileges on audit object | INSERT / To be confirmed | |
| Procedure execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed | |
| Dynamic SQL risk | Yes / No / To be confirmed | |
| Sensitive data handling | | To be confirmed |
| Cross-database / cross-schema access | | To be confirmed |

---

## 16. Performance Considerations

| Area | Consideration | Risk level | Recommended action |
|---|---|---|---|
| Source scan volume | | High / Medium / Low | |
| Join complexity | | High / Medium / Low | |
| Filter pushdown / early filtering | | High / Medium / Low | |
| Deduplication cost | | High / Medium / Low | |
| Merge complexity | | High / Medium / Low | |
| Large target table behavior | | High / Medium / Low | |
| Warehouse sizing | | High / Medium / Low | |
| Query profile review needed | Yes / No / To be confirmed | High / Medium / Low | |

---

## 17. Design Assumptions

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

---

## 18. Procedure Design Risks

| Risk | Area | Impact | Required action |
|---|---|---|---|
| | Target handling / Load strategy / Idempotency / DML safety / Error handling / Security / Performance / Other | High / Medium / Low | |

---

## 19. Open Questions

| Question | Owner | Priority | Blocking for SQL Implementation? |
|---|---|---|---|
| | Business owner / Data owner / Data Engineer / Platform owner / To be confirmed | High / Medium / Low | Yes / No |

---

## 20. Readiness Assessment

| Item | Assessment |
|---|---|
| Procedure design ready for SQL implementation? | Yes / Conditional / No |
| Target object behavior clear? | Yes / Partial / No |
| Load strategy clear? | Yes / Partial / No |
| DML behavior safe and confirmed? | Yes / Partial / No |
| Idempotency behavior clear? | Yes / Partial / No |
| Error handling defined? | Yes / Partial / No |
| Audit / logging design clear? | Yes / Partial / No |
| Security context clear? | Yes / Partial / No |
| Performance risks identified? | Yes / Partial / No |
| Main blockers | |
| Required confirmations | |
| Recommended next step | Move to SQL implementation / Clarify procedure design / Rework data contract |

---

## Output of This Document

This Procedure Design Specification is used as input for:

- [`../04_sql_implementation/01_gen_ai_prompt_generate_snowflake_sql_script.md`](../04_sql_implementation/01_gen_ai_prompt_generate_snowflake_sql_script.md)
- [`../04_sql_implementation/02_snowflake_stored_procedure_script.sql`](../04_sql_implementation/02_snowflake_stored_procedure_script.sql)

Before moving to SQL implementation, all blocking design decisions must be clarified or explicitly accepted as pending.
