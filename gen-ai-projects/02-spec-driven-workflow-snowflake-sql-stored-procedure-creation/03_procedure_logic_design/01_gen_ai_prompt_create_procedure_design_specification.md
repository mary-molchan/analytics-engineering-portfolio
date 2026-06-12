# GenAI Prompt — Create Procedure Design Specification

## Purpose

This prompt is used to transform a validated **SQL Request Brief** and **Data Contract and Mapping** document into a structured **Procedure Design Specification** for a Snowflake SQL stored procedure.

The goal is to define the stored procedure behavior before generating SQL code: procedure signature, parameters, execution flow, target object handling, load strategy, checks, transformations, DML behavior, error handling, logging, idempotency, security, and readiness for SQL implementation.

This prompt must not generate the final SQL script. It prepares the technical design required before Snowflake SQL code generation.

---

## Input

Use this prompt with the validated outputs from previous phases:

- [`../01_requirement_discovery/02_sql_request_brief_template.md`](../01_requirement_discovery/02_sql_request_brief_template.md)
- [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md)

Optional supporting inputs:

- existing SQL logic;
- current stored procedure pattern;
- Snowflake naming standards;
- audit table structure;
- error logging requirements;
- security / role requirements;
- scheduling or orchestration context;
- expected deployment environment.

---

## Output

Copy the generated output into:

- [`02_procedure_design_specification_template.md`](./02_procedure_design_specification_template.md)

---

## Prompt

```text
You are a Senior / Lead Data Engineer specialized in Snowflake SQL, Snowflake Scripting, data pipeline design, and production-grade stored procedures.

I will provide:
1. A validated SQL Request Brief.
2. A validated Data Contract and Source-to-Target Mapping document.

Your task is to create a Procedure Design Specification for a Snowflake SQL stored procedure.

The goal is to define the stored procedure behavior clearly before generating Snowflake SQL code.

Important rules:
1. Do not generate the final SQL script.
2. Do not invent databases, schemas, tables, columns, roles, warehouses, parameters, or business rules.
3. Do not invent source-to-target mapping or KPI logic.
4. Use Snowflake-specific terminology and design considerations.
5. If information is missing, write "To be confirmed".
6. Clearly separate confirmed design decisions from assumptions.
7. Define whether the procedure should use Snowflake SQL / Snowflake Scripting.
8. Define whether the procedure should use EXECUTE AS CALLER or EXECUTE AS OWNER if confirmed.
9. Define target object behavior: create if missing, fail if missing, validate only, or to be confirmed.
10. Define existing target data behavior: append, skip, merge, delete and reload, fail, or to be confirmed.
11. Define idempotency expectations and duplicate prevention logic.
12. Define DDL and DML behavior separately.
13. Do not assume that DDL can be safely rolled back; explicitly flag DDL transaction behavior as a design consideration.
14. Define error handling and return behavior at design level.
15. Define logging and audit requirements if needed.
16. Identify risks related to unsafe reloads, repeated execution, duplicates, partial loads, dynamic SQL, permissions, or performance.
17. Keep the output concise, technical, and ready for Data Engineer review.

Use the following output structure:

# Procedure Design Specification

## 1. Source Information

| Field | Value |
|---|---|
| SQL request brief | |
| Data contract and mapping | |
| Generated with Generative AI | Yes |
| Manually reviewed by Data Engineer | To be completed |
| Ready for SQL Implementation | Yes / Conditional / No |

## 2. Procedure Design Summary

Summarize the stored procedure design in 3–5 sentences.

Include:
- procedure purpose;
- target object behavior;
- high-level load strategy;
- main transformation flow;
- key safety or validation controls.

## 3. Procedure Identity and Signature

Create a table:

| Item | Design decision |
|---|---|
| Procedure name | |
| Fully qualified procedure name | DATABASE.SCHEMA.PROCEDURE / To be confirmed |
| Procedure language | SQL / Snowflake Scripting / To be confirmed |
| Return type | STRING / VARIANT / OBJECT / TABLE / To be confirmed |
| Execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed |
| Expected caller | Analyst / Data Engineer / Task / Pipeline / Application / To be confirmed |
| Execution frequency | One-time / Scheduled / On demand / Event-based / To be confirmed |

## 4. Procedure Parameters

Create a table:

| Parameter name | Snowflake data type | Required? | Default value | Purpose | Validation rule |
|---|---|---|---|---|---|

Rules:
- Do not invent parameters.
- If a parameter is likely needed but not confirmed, mark it as "Candidate / To be confirmed".
- Include common parameter candidates only when justified by the request, such as load date, batch ID, load mode, source system, or force reload flag.

## 5. Target Object Handling

Create a table:

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

## 6. Load Strategy

Create a table:

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

## 7. Execution Flow

Create a numbered execution flow.

The flow should include only steps supported by the request and data contract.

Suggested structure:
1. Initialize execution metadata.
2. Validate input parameters.
3. Validate source object availability.
4. Validate target object existence or creation behavior.
5. Validate target data state if required.
6. Prepare source dataset.
7. Apply joins, filters, transformations, and data quality rules.
8. Apply deduplication or aggregation if required.
9. Execute DML operation: insert, merge, update, delete and reload, or validate only.
10. Capture row counts and execution status.
11. Write audit or log entry if required.
12. Return success or failure status.

## 8. Source Data Preparation Logic

Create a table:

| Step ID | Source / Intermediate dataset | Purpose | Key logic | Status |
|---|---|---|---|---|

Include:
- source filtering;
- join preparation;
- transformation staging;
- deduplication;
- aggregation;
- validation dataset;
- intermediate result.

Do not write SQL code.

## 9. DDL Design

Create a table:

| DDL action | Applies to | Required? | Design rule | Risk / Notes |
|---|---|---|---|---|

DDL actions may include:
- create target table if not exists;
- create temporary table;
- create transient table;
- create audit table;
- alter object;
- none.

Rules:
- Do not assume DDL is allowed inside the procedure.
- If DDL is required, identify ownership, privileges, and transaction implications.
- If dynamic object names are needed, flag dynamic SQL and identifier handling as a risk to validate.

## 10. DML Design

Create a table:

| DML action | Target object | Condition | Expected behavior | Safety rule |
|---|---|---|---|---|

DML actions may include:
- insert;
- merge;
- update;
- delete;
- truncate and insert;
- validate only;
- to be confirmed.

Rules:
- Flag any destructive action as high risk unless explicitly confirmed.
- Do not allow truncate, delete, or reload behavior unless confirmed.
- Define how repeated execution should behave.

## 11. Idempotency and Duplicate Prevention

Create a table:

| Topic | Design decision | Status |
|---|---|---|
| Procedure safe to rerun? | Yes / No / To be confirmed | |
| Duplicate prevention logic | | |
| Business key / merge key | | |
| Existing target data check | | |
| Reprocessing strategy | | |
| Failure recovery behavior | | |

Explain what should happen if the procedure is executed twice with the same input.

## 12. Error Handling and Return Behavior

Create a table:

| Scenario | Expected behavior | Return / Log detail | Blocking? |
|---|---|---|---|

Include:
- missing source object;
- missing target object;
- invalid parameter;
- empty source dataset;
- duplicate key violation risk;
- failed data quality check;
- failed DML operation;
- permission issue;
- unexpected error.

Define whether the procedure should return:
- success message;
- row counts;
- structured status object;
- error message;
- audit reference ID.

## 13. Audit and Logging Design

Create a table:

| Logging item | Required? | Expected value | Target log object |
|---|---|---|---|
| Procedure name | Yes / No / To be confirmed | | |
| Run ID / Batch ID | Yes / No / To be confirmed | | |
| Start timestamp | Yes / No / To be confirmed | | |
| End timestamp | Yes / No / To be confirmed | | |
| Execution status | Yes / No / To be confirmed | Success / Failure / Warning | |
| Rows inserted | Yes / No / To be confirmed | | |
| Rows updated | Yes / No / To be confirmed | | |
| Rows skipped | Yes / No / To be confirmed | | |
| Error message | Yes / No / To be confirmed | | |

## 14. Transaction and Failure Behavior

Create a table:

| Topic | Design decision | Notes |
|---|---|---|
| Transaction required? | Yes / No / To be confirmed | |
| Transaction scope | Full procedure / DML only / To be confirmed | |
| DDL transaction consideration | To be confirmed | Do not assume DDL rollback behavior without validation. |
| Partial load prevention | | |
| Failure recovery | | |
| Rollback / re-run strategy | | |

## 15. Security and Execution Context

Create a table:

| Topic | Requirement / Design decision | Status |
|---|---|---|
| Required role | | To be confirmed |
| Required warehouse | | To be confirmed |
| Required privileges on source objects | SELECT / To be confirmed | |
| Required privileges on target object | INSERT / UPDATE / DELETE / MERGE / OWNERSHIP / To be confirmed | |
| Procedure execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed | |
| Dynamic SQL risk | Yes / No / To be confirmed | |
| Sensitive data handling | | To be confirmed |

## 16. Performance Considerations

Create a table:

| Area | Consideration | Risk level | Recommended action |
|---|---|---|---|
| Source scan volume | | High / Medium / Low | |
| Join complexity | | High / Medium / Low | |
| Filter pushdown / early filtering | | High / Medium / Low | |
| Deduplication cost | | High / Medium / Low | |
| Merge complexity | | High / Medium / Low | |
| Large target table behavior | | High / Medium / Low | |
| Warehouse sizing | | High / Medium / Low | |
| Query profile review needed | Yes / No / To be confirmed | | |

## 17. Design Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

Do not present assumptions as confirmed facts.

## 18. Procedure Design Risks

Create a table:

| Risk | Area | Impact | Required action |
|---|---|---|---|
| | Target handling / Load strategy / Idempotency / DML safety / Error handling / Security / Performance / Other | High / Medium / Low | |

## 19. Open Questions

Create a table:

| Question | Owner | Priority | Blocking for SQL Implementation? |
|---|---|---|---|
| | Business owner / Data owner / Data Engineer / Platform owner / To be confirmed | High / Medium / Low | Yes / No |

## 20. Readiness Assessment

Create a table:

| Item | Assessment |
|---|---|
| Procedure design ready for SQL implementation? | Yes / Conditional / No |
| Target object behavior clear? | Yes / Partial / No |
| Load strategy clear? | Yes / Partial / No |
| DML behavior safe and confirmed? | Yes / Partial / No |
| Idempotency behavior clear? | Yes / Partial / No |
| Error handling defined? | Yes / Partial / No |
| Security context clear? | Yes / Partial / No |
| Main blockers | |
| Required confirmations | |
| Recommended next step | Move to SQL implementation / Clarify procedure design / Rework data contract |

Now create the Procedure Design Specification from the following inputs:

SQL Request Brief:
[paste the completed SQL Request Brief here]

Data Contract and Mapping:
[paste the completed Data Contract and Mapping document here]

Optional supporting documentation:
[paste existing SQL, naming standards, audit requirements, deployment constraints, or platform standards here]
```

---

## Human Review Checklist

After generating the Procedure Design Specification, the Data Engineer must verify that:

- no procedure name, parameter, object, role, warehouse, or SQL behavior was invented;
- target object behavior is clear;
- existing target data behavior is explicitly defined;
- load strategy is safe and unambiguous;
- destructive DML actions are not assumed;
- idempotency and duplicate prevention are addressed;
- DDL and DML responsibilities are separated;
- error handling and return behavior are defined;
- audit and logging expectations are clear or marked as `To be confirmed`;
- security and execution context are documented;
- Snowflake-specific procedure considerations are visible;
- blocking questions are separated from non-blocking clarifications;
- the document is ready for [`../04_sql_implementation/`](../04_sql_implementation/).
