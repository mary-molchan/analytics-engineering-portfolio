# GenAI Prompt — Generate Snowflake SQL Script

## Purpose

This prompt is used to generate a Snowflake SQL stored procedure script from a validated **Procedure Design Specification**.

The goal is to create a clean, reviewable, Snowflake-compatible SQL script that implements the approved procedure design without inventing unconfirmed objects, columns, business rules, load behavior, or security assumptions.

This prompt generates the first implementation version of the SQL script. The output must still be reviewed and hardened before execution.

---

## Input

Use this prompt with the validated output from Phase 3:

- [`../03_procedure_logic_design/02_procedure_design_specification_template.md`](../03_procedure_logic_design/02_procedure_design_specification_template.md)

Optional supporting inputs:

- [`../01_requirement_discovery/02_sql_request_brief_template.md`](../01_requirement_discovery/02_sql_request_brief_template.md)
- [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md)
- existing SQL logic;
- existing table DDL;
- existing audit table structure;
- naming standards;
- deployment environment details;
- Snowflake role / warehouse / database / schema context.

---

## Output

Copy the generated SQL script into:

- [`02_snowflake_stored_procedure_script.sql`](./02_snowflake_stored_procedure_script.sql)

---

## Prompt

```text
You are a Senior / Lead Data Engineer specialized in Snowflake SQL, Snowflake Scripting, production-grade stored procedures, and safe data pipeline implementation.

I will provide a validated Procedure Design Specification for a Snowflake SQL stored procedure.

Your task is to generate a Snowflake-compatible SQL script implementing the approved design.

The output must be a complete, readable, reviewable SQL script, ready to be copied into `02_snowflake_stored_procedure_script.sql`.

The script must not be executed automatically.

Important rules:
1. Generate Snowflake SQL only.
2. Use Snowflake SQL / Snowflake Scripting syntax, not generic SQL.
3. Prefer `LANGUAGE SQL` stored procedures unless the design explicitly requires another supported language.
4. Do not invent databases, schemas, tables, columns, parameters, roles, warehouses, grants, or business rules.
5. Do not invent source-to-target mapping.
6. Do not invent load behavior.
7. Do not invent destructive logic.
8. If a required detail is missing, insert a clear TODO comment instead of guessing.
9. Use fully qualified object names when provided.
10. Do not use unqualified object names unless the design explicitly allows session context.
11. Respect the confirmed `EXECUTE AS CALLER` or `EXECUTE AS OWNER` setting.
12. If execution rights are not confirmed, mark them as TODO and do not assume.
13. Do not use `DELETE`, `TRUNCATE`, full reload, or destructive overwrite unless explicitly confirmed.
14. Do not create objects inside the procedure unless DDL behavior is explicitly confirmed.
15. If target table creation is confirmed, use a safe and explicit `CREATE TABLE IF NOT EXISTS` pattern.
16. If target table must exist, validate or document the expected failure behavior.
17. Implement existing target data behavior exactly as specified: append, skip, merge, delete and reload, fail, or validate only.
18. Implement duplicate prevention only if the required business key, merge key, or deduplication rule is confirmed.
19. If idempotency cannot be guaranteed from the specification, add a TODO comment and flag the risk in the script header.
20. Add clear comments for major logic sections.
21. Keep the script readable and maintainable.
22. Do not over-engineer the script.
23. Do not add unnecessary dynamic SQL.
24. If dynamic SQL is required, clearly isolate it and comment why it is needed.
25. Include error handling if required by the design.
26. Include audit logging only if the audit target and expected log fields are confirmed.
27. Capture row counts only where Snowflake-compatible and meaningful.
28. Avoid unnecessary full scans where filters or incremental boundaries are defined.
29. Use explicit column lists in `INSERT` and `MERGE` statements.
30. Never use `SELECT *` for production insert or merge logic.
31. Use deterministic deduplication logic when deduplication is required.
32. Add TODO comments for unresolved Snowflake-specific decisions.
33. The script must be suitable for code review before execution.

Generate the script using the following structure:

1. File header comment
   - procedure name;
   - purpose;
   - generated from specification;
   - execution environment placeholder;
   - safety notes;
   - known TODOs if any.

2. Optional context section
   - optional `USE DATABASE`;
   - optional `USE SCHEMA`;
   - optional `USE WAREHOUSE`;
   - include only if confirmed;
   - otherwise leave commented placeholders.

3. Optional prerequisite section
   - target table creation only if confirmed;
   - audit table creation only if confirmed;
   - comments for required grants or roles if needed.

4. Stored procedure definition
   - `CREATE OR REPLACE PROCEDURE`;
   - confirmed parameters;
   - confirmed return type;
   - `LANGUAGE SQL`;
   - confirmed `EXECUTE AS CALLER` or `EXECUTE AS OWNER`;
   - Snowflake Scripting body.

5. Procedure body
   - declare variables for execution metadata, counters, statuses, and messages where needed;
   - validate parameters if required;
   - validate source object assumptions if specified;
   - handle target object existence or target data state as specified;
   - prepare source dataset using CTEs or intermediate logic;
   - apply joins, filters, transformations, and data quality checks;
   - apply deduplication if required;
   - execute confirmed DML operation;
   - write audit log if confirmed;
   - return success status.

6. Exception handling
   - include exception handling if required by the design;
   - return a clear failure message or structured status;
   - write failure log only if audit logging is confirmed;
   - do not hide errors silently.

7. Optional example call
   - include a commented `CALL` example only if parameters are confirmed;
   - otherwise provide a placeholder.

8. Post-generation notes
   - list TODOs;
   - list assumptions;
   - list items requiring manual review before execution.

Use the following output format:

```sql
-- SQL script here
```

Now generate the Snowflake SQL stored procedure script from the following Procedure Design Specification:

[paste the completed Procedure Design Specification here]

Optional supporting documentation:
[paste existing SQL, table DDL, mapping details, audit table structure, deployment standards, or platform constraints here]
```

---

## Required SQL Quality Standards

| Area | Standard |
|---|---|
| Snowflake compatibility | Use Snowflake SQL and Snowflake Scripting syntax only. |
| Object naming | Use fully qualified names when provided. |
| Column handling | Use explicit target column lists. |
| Load safety | Do not assume destructive operations. |
| Idempotency | Implement only confirmed duplicate prevention or merge logic. |
| Maintainability | Use clear sections and comments. |
| Reviewability | Make assumptions and TODOs visible. |
| Security | Do not assume roles, grants, warehouses, or execution rights. |
| Error handling | Do not swallow errors silently. |
| Performance | Avoid unnecessary scans and unsupported logic. |

---

## Human Review Checklist

After generating the SQL script, the Data Engineer must verify that:

- the script follows Snowflake SQL / Snowflake Scripting syntax;
- the procedure signature matches the design specification;
- the return type is appropriate;
- the execution rights are confirmed;
- no object, column, role, warehouse, parameter, or business rule was invented;
- target table existence behavior is implemented correctly;
- existing target data behavior is implemented exactly as specified;
- no destructive DML was added without confirmation;
- all `INSERT`, `MERGE`, `UPDATE`, or `DELETE` statements use explicit logic;
- no production DML relies on `SELECT *`;
- source-to-target mapping is respected;
- joins and filters match the data contract;
- deduplication logic is deterministic if used;
- the procedure is safe to rerun or clearly marked as not idempotent;
- error handling is appropriate;
- logging is implemented only if confirmed;
- unresolved decisions are marked with TODO comments;
- the script is ready for [`03_gen_ai_prompt_review_and_harden_sql_script.md`](./03_gen_ai_prompt_review_and_harden_sql_script.md).
