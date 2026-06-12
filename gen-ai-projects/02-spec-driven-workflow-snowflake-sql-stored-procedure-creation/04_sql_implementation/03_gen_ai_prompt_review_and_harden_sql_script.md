# GenAI Prompt — Review and Harden Snowflake SQL Script

## Purpose

This prompt is used to review and harden a generated Snowflake SQL stored procedure script before validation, testing, or execution.

The goal is to assess whether the script correctly implements the validated Procedure Design Specification and follows Snowflake-specific SQL, Snowflake Scripting, safety, maintainability, and data engineering standards.

This prompt must not execute SQL. It produces a structured code review report and, when useful, targeted hardening recommendations.

---

## Input

Use this prompt with the generated SQL script:

- [`02_snowflake_stored_procedure_script.sql`](./02_snowflake_stored_procedure_script.sql)

Recommended supporting inputs:

- [`../03_procedure_logic_design/02_procedure_design_specification_template.md`](../03_procedure_logic_design/02_procedure_design_specification_template.md)
- [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md)

Optional supporting inputs:

- existing Snowflake procedure standards;
- deployment standards;
- audit table structure;
- security / role requirements;
- Snowflake environment constraints;
- expected test scenarios.

---

## Output

Copy the generated review output into:

- [`04_sql_code_review_report_template.md`](./04_sql_code_review_report_template.md)

---

## Prompt

```text
You are a Senior / Lead Data Engineer specialized in Snowflake SQL, Snowflake Scripting, stored procedure implementation, SQL code review, data safety, and production hardening.

I will provide:
1. A generated Snowflake SQL stored procedure script.
2. The validated Procedure Design Specification.
3. Optional supporting data contract, mapping, or platform standards.

Your task is to review and harden the SQL script.

The goal is to verify whether the script is correct, safe, maintainable, Snowflake-compatible, and ready for validation testing.

Important rules:
1. Do not execute the SQL.
2. Do not invent requirements, objects, columns, roles, warehouses, grants, or business rules.
3. Do not rewrite the full script unless explicitly requested.
4. Focus on review, risk identification, and targeted hardening recommendations.
5. Verify the script against the Procedure Design Specification.
6. Verify that source-to-target mapping is respected.
7. Verify that the script uses Snowflake SQL / Snowflake Scripting syntax, not generic SQL.
8. Verify `CREATE OR REPLACE PROCEDURE` syntax, parameters, return type, `LANGUAGE SQL`, and execution rights.
9. Verify whether `EXECUTE AS CALLER` or `EXECUTE AS OWNER` matches the design.
10. Check that unresolved decisions are marked with TODO comments instead of hidden assumptions.
11. Flag any unconfirmed destructive operation such as `DELETE`, `TRUNCATE`, full reload, or overwrite.
12. Check that DDL behavior is explicitly confirmed before object creation inside the procedure.
13. Flag DDL transaction risks and do not assume DDL rollback behavior.
14. Check that DML operations use explicit column lists.
15. Flag any production `INSERT`, `MERGE`, `UPDATE`, or `DELETE` logic relying on `SELECT *`.
16. Check idempotency and repeated execution behavior.
17. Check duplicate prevention and deterministic deduplication logic.
18. Check target object existence handling.
19. Check existing target data behavior.
20. Check parameter validation.
21. Check error handling and exception behavior.
22. Check whether failures are returned or logged clearly.
23. Check audit logging only if audit objects and fields are confirmed.
24. Check row count capture logic and whether counters are meaningful.
25. Check source filtering, join logic, transformation logic, and data quality checks.
26. Check performance risks such as unnecessary full scans, late filtering, heavy joins, large MERGE operations, or missing incremental boundaries.
27. Check security assumptions, required privileges, dynamic SQL risks, and execution context.
28. Classify findings by severity: Critical, High, Medium, Low.
29. Separate blocking issues from non-blocking improvements.
30. Provide specific recommended corrections.

Use the following output structure:

# SQL Code Review Report

## 1. Source Information

| Field | Value |
|---|---|
| Reviewed SQL script | |
| Procedure design source | |
| Data contract source | |
| Generated with Generative AI | Yes |
| Manually reviewed by Data Engineer | To be completed |
| Review status | Pass / Conditional pass / Fail |

## 2. Executive Review Summary

Summarize the review result in 3–5 sentences.

Include:
- whether the script appears aligned with the design;
- whether it is safe enough for validation testing;
- main blocking issues;
- main hardening actions required.

## 3. Readiness Decision

Create a table:

| Item | Assessment |
|---|---|
| Ready for validation testing? | Yes / Conditional / No |
| Ready for deployment? | Yes / Conditional / No |
| Main reason | |
| Blocking issues | |
| Required fixes before execution | |

## 4. Design Alignment Review

Create a table:

| Area | Assessment | Issue / Notes |
|---|---|---|
| Procedure purpose matches design | Pass / Warning / Fail | |
| Procedure signature matches design | Pass / Warning / Fail | |
| Parameters match design | Pass / Warning / Fail | |
| Return type matches design | Pass / Warning / Fail | |
| Execution rights match design | Pass / Warning / Fail | |
| Target object behavior matches design | Pass / Warning / Fail | |
| Existing target data behavior matches design | Pass / Warning / Fail | |
| Load strategy matches design | Pass / Warning / Fail | |
| Error handling matches design | Pass / Warning / Fail | |
| Logging matches design | Pass / Warning / Fail | |

## 5. Snowflake Compatibility Review

Create a table:

| Check | Assessment | Issue / Recommendation |
|---|---|---|
| Snowflake procedure syntax | Pass / Warning / Fail | |
| Snowflake Scripting block structure | Pass / Warning / Fail | |
| Variable declarations | Pass / Warning / Fail | |
| Bind variable usage | Pass / Warning / Fail | |
| Exception handling syntax | Pass / Warning / Fail | |
| Return statement compatibility | Pass / Warning / Fail | |
| DDL / DML syntax | Pass / Warning / Fail | |
| Transaction statements | Pass / Warning / Fail | |
| Use of Snowflake-supported functions | Pass / Warning / Fail | |

## 6. Data Safety Review

Create a table:

| Risk area | Assessment | Severity | Recommendation |
|---|---|---|---|
| Unconfirmed destructive DML | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Duplicate creation risk | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Non-idempotent behavior | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Unsafe reload behavior | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Missing target data checks | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Missing source validation | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Partial load risk | Pass / Warning / Fail | Critical / High / Medium / Low | |

## 7. Source-to-Target Mapping Review

Create a table:

| Mapping area | Assessment | Issue / Recommendation |
|---|---|---|
| Explicit target column list | Pass / Warning / Fail | |
| Source columns match mapping | Pass / Warning / Fail | |
| Transformations match mapping | Pass / Warning / Fail | |
| Join logic matches mapping | Pass / Warning / Fail | |
| Filters match mapping | Pass / Warning / Fail | |
| Data quality rules implemented | Pass / Warning / Fail | |
| Technical metadata handled correctly | Pass / Warning / Fail | |

## 8. Idempotency and Duplicate Prevention Review

Create a table:

| Check | Assessment | Notes |
|---|---|---|
| Safe to rerun with same input | Yes / No / To be confirmed | |
| Business key / merge key used correctly | Yes / No / To be confirmed | |
| Deduplication deterministic | Yes / No / To be confirmed | |
| Existing target data behavior controlled | Yes / No / To be confirmed | |
| Duplicate risk remains | Yes / No / To be confirmed | |
| Required fix | |

## 9. DDL and DML Review

Create a table:

| Area | Assessment | Severity | Recommendation |
|---|---|---|---|
| DDL inside procedure | Pass / Warning / Fail | Critical / High / Medium / Low | |
| DDL privilege assumptions | Pass / Warning / Fail | Critical / High / Medium / Low | |
| DDL transaction implications | Pass / Warning / Fail | Critical / High / Medium / Low | |
| INSERT logic | Pass / Warning / Fail | Critical / High / Medium / Low | |
| MERGE logic | Pass / Warning / Fail | Critical / High / Medium / Low | |
| UPDATE logic | Pass / Warning / Fail | Critical / High / Medium / Low | |
| DELETE / TRUNCATE logic | Pass / Warning / Fail | Critical / High / Medium / Low | |
| Explicit column usage | Pass / Warning / Fail | Critical / High / Medium / Low | |

## 10. Error Handling and Logging Review

Create a table:

| Check | Assessment | Issue / Recommendation |
|---|---|---|
| Parameter validation present | Pass / Warning / Fail | |
| Expected failure scenarios handled | Pass / Warning / Fail | |
| Unexpected errors handled | Pass / Warning / Fail | |
| Errors are not silently swallowed | Pass / Warning / Fail | |
| Return payload is useful | Pass / Warning / Fail | |
| Failure logging is appropriate | Pass / Warning / Fail | |
| Audit logging is confirmed and safe | Pass / Warning / Fail | |

## 11. Security and Execution Context Review

Create a table:

| Check | Assessment | Issue / Recommendation |
|---|---|---|
| Execution rights confirmed | Pass / Warning / Fail | |
| Required privileges identified | Pass / Warning / Fail | |
| Role assumptions avoided | Pass / Warning / Fail | |
| Warehouse assumptions avoided | Pass / Warning / Fail | |
| Dynamic SQL risk controlled | Pass / Warning / Fail | |
| Sensitive data handling considered | Pass / Warning / Fail | |
| Cross-database / cross-schema access considered | Pass / Warning / Fail | |

## 12. Performance and Maintainability Review

Create a table:

| Area | Assessment | Issue / Recommendation |
|---|---|---|
| Early filtering | Pass / Warning / Fail | |
| Join complexity | Pass / Warning / Fail | |
| Large table scan risk | Pass / Warning / Fail | |
| MERGE performance risk | Pass / Warning / Fail | |
| Deduplication cost | Pass / Warning / Fail | |
| Query profile review needed | Yes / No / To be confirmed | |
| Script readability | Pass / Warning / Fail | |
| Comments and sections | Pass / Warning / Fail | |
| Naming consistency | Pass / Warning / Fail | |

## 13. Findings

Create a table:

| Finding ID | Severity | Area | Finding | Required action |
|---|---|---|---|---|
| FND-001 | Critical / High / Medium / Low | | | |

Severity rules:
- Critical: can cause data loss, duplicate production data, unsafe destructive action, or execution failure.
- High: can cause incorrect results, failed deployment, security risk, or non-idempotent behavior.
- Medium: affects maintainability, performance, validation, or operational reliability.
- Low: minor improvement or documentation issue.

## 14. Required Fixes Before Execution

List only fixes required before running the script in any environment.

- 
- 
- 

## 15. Recommended Hardening Improvements

List useful improvements that are not strictly blocking.

- 
- 
- 

## 16. Optional Targeted Patch Suggestions

If useful, provide small corrected SQL snippets for specific issues.

Rules:
- Do not rewrite the entire script unless explicitly requested.
- Only provide snippets for clearly identified findings.
- Keep placeholders where details are not confirmed.
- Do not invent missing object names or columns.

Use this format:

```sql
-- Finding FND-XXX
-- Suggested correction:
<SQL snippet>
