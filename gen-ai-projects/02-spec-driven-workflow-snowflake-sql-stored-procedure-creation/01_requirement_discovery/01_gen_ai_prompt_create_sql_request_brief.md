# GenAI Prompt — Create SQL Request Brief

## Purpose

This prompt is used to transform an initial business or technical request into a structured **SQL Request Brief** for a Snowflake SQL stored procedure project.

The goal is to clarify the need, expected outcome, execution context, target object behavior, high-level load strategy, assumptions, risks, and open questions before defining the data contract and source-to-target mapping.

This prompt must not generate SQL code. It prepares the request for technical analysis.

---

## Input

Use this prompt with one or several of the following inputs:

- business request;
- technical request;
- Jira ticket;
- email or stakeholder message;
- meeting notes;
- existing manual SQL logic;
- description of a recurring data process;
- description of a target table or reporting need;
- known source and target objects;
- known Snowflake environment constraints.

---

## Output

Copy the generated output into:

- [`02_sql_request_brief_template.md`](./02_sql_request_brief_template.md)

---

## Prompt

```text
You are a Senior / Lead Data Engineer specialized in Snowflake SQL and Snowflake Scripting.

I will provide an initial request for a Snowflake SQL stored procedure or a complex SQL automation.

Your task is to transform the request into a structured SQL Request Brief.

The goal is to clarify what must be built before moving to data contract, source-to-target mapping, procedure logic design, and SQL implementation.

Important rules:
1. Do not write SQL code.
2. Do not design the full stored procedure logic yet.
3. Do not invent database names, schema names, table names, column names, roles, warehouses, or data sources.
4. If information is missing, write "To be confirmed".
5. Clearly separate confirmed facts from assumptions.
6. Identify whether the request is business-driven, technical, operational, or data quality related.
7. Identify the expected output of the procedure.
8. Identify whether the procedure should create, insert into, merge into, update, reload, or validate a target object.
9. Identify whether the target table may already exist and whether it may already contain data.
10. Identify potential risks related to duplicate records, unintended data loss, unsafe reloads, missing source data, unclear filters, or ambiguous business rules.
11. Identify blockers that prevent moving to data contract and mapping.
12. Keep the output concise, technical, and ready for Data Engineer review.

Use the following output structure:

# SQL Request Brief

## 1. Source Information

| Field | Value |
|---|---|
| Source input | Business request / Technical request / Jira ticket / Meeting notes / Existing SQL / Other |
| Generated with Generative AI | Yes |
| Manually reviewed by Data Engineer | To be completed |
| Ready for Data Contract & Mapping | Yes / Conditional / No |

## 2. Request Summary

Summarize the request in 3–5 sentences.

Include:
- what needs to be built;
- why it is needed;
- which process it supports;
- what the expected result should be.

## 3. Request Type

Create a table:

| Category | Assessment | Notes |
|---|---|---|
| Business need | Yes / No / To be confirmed | |
| Technical automation | Yes / No / To be confirmed | |
| Data load / integration | Yes / No / To be confirmed | |
| Data quality / validation | Yes / No / To be confirmed | |
| Reporting / analytics support | Yes / No / To be confirmed | |
| Operational process | Yes / No / To be confirmed | |

## 4. Expected Outcome

Create a table:

| Item | Description |
|---|---|
| Expected final output | |
| Target object | Database / Schema / Table / View / To be confirmed |
| Expected data action | Create / Insert / Merge / Update / Delete / Truncate and reload / Validate / To be confirmed |
| Expected return value | Success message / Row count / Status object / Error message / To be confirmed |
| Success definition | |

## 5. Execution Context

Create a table:

| Topic | Details |
|---|---|
| Expected caller | Analyst / Data Engineer / Task / Pipeline / Application / To be confirmed |
| Execution frequency | One-time / Scheduled / On demand / Event-based / To be confirmed |
| Snowflake environment | Dev / Test / Prod / To be confirmed |
| Required warehouse | To be confirmed |
| Required role | To be confirmed |
| Execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed |

## 6. Target Object Behavior

Create a table:

| Question | Answer |
|---|---|
| Should the procedure check whether the target table exists? | Yes / No / To be confirmed |
| Should the procedure create the target table if it does not exist? | Yes / No / To be confirmed |
| Should the procedure fail if the target table does not exist? | Yes / No / To be confirmed |
| Should the procedure check whether the target table already contains data? | Yes / No / To be confirmed |
| What should happen if the target table already contains data? | Append / Skip / Merge / Delete and reload / Fail / To be confirmed |
| Is duplicate prevention required? | Yes / No / To be confirmed |
| Is historical data preservation required? | Yes / No / To be confirmed |

## 7. High-Level Data Needs

Create a table:

| Data need | Known source | Required? | Status |
|---|---|---|---|
| | | Yes / No / To be confirmed | Confirmed / To be confirmed |

Do not invent source objects or columns.

## 8. Known Business Rules

List only rules explicitly mentioned in the request.

| Rule ID | Business rule | Status |
|---|---|---|
| RULE-001 | | Confirmed / To be confirmed |

## 9. Known Technical Constraints

Create a table:

| Constraint | Description | Impact |
|---|---|---|
| | | High / Medium / Low |

Consider:
- Snowflake environment;
- access restrictions;
- source availability;
- target table ownership;
- refresh or scheduling expectations;
- data volume;
- performance expectations;
- security constraints;
- naming standards;
- deployment constraints.

## 10. Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

Do not present assumptions as confirmed facts.

## 11. Risks

Create a table:

| Risk | Area | Impact | Mitigation / Required clarification |
|---|---|---|---|
| | Duplicate risk / Data loss / Missing source / Unclear logic / Security / Performance / Other | High / Medium / Low | |

## 12. Open Questions

Create a table:

| Question | Owner | Priority | Blocking for next phase? |
|---|---|---|---|
| | Business owner / Data owner / Data Engineer / To be confirmed | High / Medium / Low | Yes / No |

## 13. Readiness Assessment

Create a table:

| Item | Assessment |
|---|---|
| Request clear enough for data contract and mapping? | Yes / Conditional / No |
| Main blockers | |
| Required confirmations | |
| Recommended next step | Move to data contract and mapping / Clarify request / Rework scope |

Now create the SQL Request Brief from the following input:

[paste the initial request here]
```

---

## Human Review Checklist

After generating the SQL Request Brief, the Data Engineer must verify that:

- the expected outcome is clear;
- no database, schema, table, column, role, or warehouse was invented;
- target object behavior is explicitly documented;
- existing target data behavior is clarified or marked as `To be confirmed`;
- load behavior is not assumed;
- duplicate and data loss risks are visible;
- execution context is clear or marked as `To be confirmed`;
- blockers are separated from non-blocking open questions;
- the request is ready for [`../02_data_contract_and_mapping/`](../02_data_contract_and_mapping/).
