# GenAI Prompt — Create Validation and Release Package

## Purpose

This prompt is used to create a structured **Validation and Release Readiness Package** for a Snowflake SQL stored procedure.

The goal is to prepare the procedure for safe validation, testing, execution, deployment, or handover after SQL implementation and code review.

This prompt must not execute SQL. It creates a validation plan, release checklist, deployment readiness assessment, rollback considerations, and final Go / Conditional Go / No-Go recommendation.

---

## Input

Use this prompt with the reviewed SQL implementation outputs:

- [`../04_sql_implementation/02_snowflake_stored_procedure_script.sql`](../04_sql_implementation/02_snowflake_stored_procedure_script.sql)
- [`../04_sql_implementation/04_sql_code_review_report_template.md`](../04_sql_implementation/04_sql_code_review_report_template.md)

Recommended supporting inputs:

- [`../03_procedure_logic_design/02_procedure_design_specification_template.md`](../03_procedure_logic_design/02_procedure_design_specification_template.md)
- [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md)

Optional supporting inputs:

- deployment standards;
- Snowflake environment details;
- expected test data;
- source and target sample counts;
- audit table structure;
- CI/CD process;
- rollback or recovery standards;
- release approval process.

---

## Output

Copy the generated output into:

- [`02_validation_release_package_template.md`](./02_validation_release_package_template.md)

---

## Prompt

```text
You are a Senior / Lead Data Engineer specialized in Snowflake SQL, Snowflake Scripting, stored procedure validation, release readiness, and production data pipeline governance.

I will provide:
1. A Snowflake SQL stored procedure script.
2. A SQL Code Review Report.
3. Optional supporting procedure design and data contract documents.

Your task is to create a Validation and Release Readiness Package.

The goal is to define how the stored procedure should be validated before execution, deployment, or handover.

Important rules:
1. Do not execute SQL.
2. Do not invent objects, columns, roles, warehouses, test results, row counts, grants, or deployment approvals.
3. Do not assume that the procedure is production-ready unless the review report supports it.
4. Do not ignore critical or high-severity code review findings.
5. If information is missing, write "To be confirmed".
6. Clearly separate validation tasks, release blockers, accepted risks, and optional improvements.
7. Include Snowflake-specific validation topics: compilation, procedure call, execution rights, warehouse, role, object privileges, query history, query profile, row counts, audit logs, and transaction / failure behavior.
8. Include test cases for target table existence, empty target, existing target data, duplicate prevention, failed data quality checks, empty source, and repeated execution when relevant.
9. Include validation for destructive operations only if they were explicitly confirmed.
10. Include rollback or recovery considerations.
11. Include a final Go / Conditional Go / No-Go recommendation.
12. Keep the output concise, technical, and ready for Data Engineer review.

Use the following output structure:

# Validation and Release Readiness Package

## 1. Source Information

| Field | Value |
|---|---|
| Reviewed SQL script | |
| SQL code review report | |
| Procedure design source | |
| Data contract source | |
| Generated with Generative AI | Yes |
| Manually reviewed by Data Engineer | To be completed |
| Release readiness status | Go / Conditional Go / No-Go |

## 2. Validation Summary

Summarize the validation scope in 3–5 sentences.

Include:
- procedure purpose;
- target environment for validation;
- main validation focus;
- known blockers from code review;
- expected release decision.

## 3. Pre-Validation Prerequisites

Create a table:

| Prerequisite | Required? | Status | Blocking? | Notes |
|---|---|---|---|---|

Cover:
- target Snowflake environment;
- required role;
- required warehouse;
- source object access;
- target object access;
- audit object access;
- test data availability;
- reviewed SQL script available;
- unresolved critical findings fixed;
- deployment context confirmed.

## 4. Snowflake Compilation and Syntax Validation

Create a table:

| Validation item | Expected result | Status | Notes |
|---|---|---|---|
| Procedure script compiles | Procedure created or replaced successfully in target environment. | To be confirmed | |
| Procedure signature is correct | Parameters and return type match design. | To be confirmed | |
| Snowflake Scripting syntax is valid | No syntax errors in declarations, control flow, DML, exception handling, or return logic. | To be confirmed | |
| Object references resolve | Fully qualified source, target, and audit objects are valid. | To be confirmed | |
| Procedure can be called | `CALL` statement executes with approved test parameters. | To be confirmed | |

## 5. Functional Test Scenarios

Create a table:

| Test ID | Scenario | Input / Setup | Expected result | Status | Blocking? |
|---|---|---|---|---|---|

Include only relevant scenarios:
- valid execution;
- validate-only mode;
- empty source dataset;
- empty target table;
- target table already contains data;
- repeated execution with same input;
- duplicate source records;
- missing required parameter;
- invalid load mode;
- missing source object;
- missing target object;
- failed data quality check;
- merge / append / reload behavior if applicable.

## 6. Data Validation Checks

Create a table:

| Check ID | Validation check | Source / Target | Expected result | Status | Notes |
|---|---|---|---|---|---|

Cover:
- source row count;
- inserted / updated / skipped row count;
- target row count after load;
- duplicate key check;
- null key check;
- required field completeness;
- transformation rule validation;
- join output validation;
- filter rule validation;
- technical metadata validation;
- audit log validation.

## 7. Idempotency and Re-Run Validation

Create a table:

| Check | Expected behavior | Status | Notes |
|---|---|---|---|
| Procedure can be re-run safely | Yes / No / To be confirmed | To be confirmed | |
| Duplicate prevention works | Yes / No / To be confirmed | To be confirmed | |
| Merge key / business key behaves correctly | Yes / No / To be confirmed | To be confirmed | |
| Same input does not create uncontrolled duplicates | Yes / No / To be confirmed | To be confirmed | |
| Failure and re-run behavior is understood | Yes / No / To be confirmed | To be confirmed | |

## 8. Error Handling and Failure Validation

Create a table:

| Failure scenario | Expected behavior | Return / Log expectation | Status |
|---|---|---|---|
| Invalid parameter | | | To be confirmed |
| Missing source object | | | To be confirmed |
| Missing target object | | | To be confirmed |
| Empty source dataset | | | To be confirmed |
| Data quality check failure | | | To be confirmed |
| DML failure | | | To be confirmed |
| Permission failure | | | To be confirmed |
| Unexpected error | | | To be confirmed |

Verify that failures are visible and not silently swallowed.

## 9. Security and Access Validation

Create a table:

| Security item | Expected requirement | Status | Blocking? |
|---|---|---|---|
| Execution role confirmed | | To be confirmed | Yes / No |
| Warehouse access confirmed | | To be confirmed | Yes / No |
| Source object privileges confirmed | SELECT / To be confirmed | To be confirmed | Yes / No |
| Target object privileges confirmed | INSERT / UPDATE / DELETE / MERGE / OWNERSHIP / To be confirmed | To be confirmed | Yes / No |
| Audit object privileges confirmed | INSERT / To be confirmed | To be confirmed | Yes / No |
| Procedure execution rights confirmed | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed | To be confirmed | Yes / No |
| Sensitive data handling validated | | To be confirmed | Yes / No |

## 10. Performance Validation

Create a table:

| Performance check | Expected result | Status | Notes |
|---|---|---|---|
| Query completes within acceptable time | | To be confirmed | |
| Warehouse size is appropriate | | To be confirmed | |
| Large source scans are acceptable | | To be confirmed | |
| Join and merge performance is acceptable | | To be confirmed | |
| Query profile reviewed | Yes / No / To be confirmed | To be confirmed | |
| No unnecessary full scans identified | Yes / No / To be confirmed | To be confirmed | |
| Incremental filter or pruning behavior works if applicable | Yes / No / To be confirmed | To be confirmed | |

## 11. Audit and Observability Validation

Create a table:

| Observability item | Expected result | Status | Notes |
|---|---|---|---|
| Procedure returns clear status | | To be confirmed | |
| Row counts are returned or logged | | To be confirmed | |
| Error messages are visible | | To be confirmed | |
| Audit table receives success records | | To be confirmed | |
| Audit table receives failure records | | To be confirmed | |
| Query history can be used for investigation | | To be confirmed | |
| Run ID / Batch ID is traceable | | To be confirmed | |

## 12. Release Checklist

Create a table:

| Release item | Status | Blocking? | Notes |
|---|---|---|---|
| Critical code review findings fixed | Yes / No / Not applicable | Yes / No | |
| High-severity findings fixed or accepted | Yes / No / Not applicable | Yes / No | |
| SQL script validated in non-production environment | Yes / No / To be confirmed | Yes / No | |
| Functional tests completed | Yes / No / To be confirmed | Yes / No | |
| Data validation checks completed | Yes / No / To be confirmed | Yes / No | |
| Security and access confirmed | Yes / No / To be confirmed | Yes / No | |
| Performance acceptable | Yes / No / To be confirmed | Yes / No | |
| Rollback or recovery approach defined | Yes / No / To be confirmed | Yes / No | |
| Release owner confirmed | Yes / No / To be confirmed | Yes / No | |
| Deployment window confirmed | Yes / No / To be confirmed | Yes / No | |

## 13. Rollback and Recovery Considerations

Create a table:

| Scenario | Recovery approach | Owner | Status |
|---|---|---|---|
| Procedure creation fails | | | To be confirmed |
| Procedure execution fails before DML | | | To be confirmed |
| Procedure execution fails after partial DML | | | To be confirmed |
| Incorrect rows inserted or merged | | | To be confirmed |
| Audit logging fails | | | To be confirmed |
| Performance issue during execution | | | To be confirmed |

Do not invent a rollback strategy if it is not confirmed. Mark missing information as "To be confirmed".

## 14. Open Release Questions

Create a table:

| Question | Owner | Priority | Blocking for release? |
|---|---|---|---|
| | Data Engineer / Platform owner / Data owner / Business owner / To be confirmed | High / Medium / Low | Yes / No |

## 15. Release Risks

Create a table:

| Risk | Area | Impact | Mitigation / Required action |
|---|---|---|---|
| | Data correctness / Access / Performance / DML safety / Observability / Deployment / Other | High / Medium / Low | |

## 16. Final Release Readiness Decision

Create a table:

| Item | Assessment |
|---|---|
| Ready for validation testing? | Yes / Conditional / No |
| Ready for release / deployment? | Go / Conditional Go / No-Go |
| Main reason | |
| Blocking items | |
| Accepted risks | |
| Required actions before release | |
| Recommended next step | Validate in DEV / Deploy to TEST / Deploy to PROD / Rework SQL / Clarify requirements |

## 17. Recommended Next Steps

Provide 3–7 concrete next steps.

Now create the Validation and Release Readiness Package from the following inputs:

Snowflake SQL Stored Procedure Script:
[paste the SQL script here]

SQL Code Review Report:
[paste the completed SQL Code Review Report here]

Optional Procedure Design Specification:
[paste the completed Procedure Design Specification here]

Optional Data Contract and Mapping:
[paste the completed Data Contract and Mapping document here]

Optional deployment or platform standards:
[paste standards here]
```

---

## Human Review Checklist

After generating the Validation and Release Readiness Package, the Data Engineer must verify that:

- no validation result was invented;
- no release approval was assumed;
- all critical and high-severity review findings are addressed or explicitly tracked;
- test scenarios are relevant to the procedure design;
- Snowflake environment, role, warehouse, and privileges are confirmed or marked as `To be confirmed`;
- data validation checks are sufficient to verify correctness;
- idempotency and re-run behavior are explicitly tested where relevant;
- destructive DML and reload behavior are validated only if explicitly approved;
- rollback and recovery considerations are documented;
- final release decision is justified;
- the document is ready to be copied into [`02_validation_release_package_template.md`](./02_validation_release_package_template.md).
```
