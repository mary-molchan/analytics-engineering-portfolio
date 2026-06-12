# SQL Request Brief Template

## Purpose

This document captures the initial business or technical request for a Snowflake SQL stored procedure or complex SQL automation.

It clarifies the expected outcome, execution context, target object behavior, high-level data needs, risks, assumptions, and open questions before moving to data contract and source-to-target mapping.

This document should be completed before any Snowflake SQL code is generated.

---

## 1. Source Information

| Field | Value |
|---|---|
| Source input | Business request / Technical request / Jira ticket / Meeting notes / Existing SQL / Other |
| Created with prompt | [`01_gen_ai_prompt_create_sql_request_brief.md`](./01_gen_ai_prompt_create_sql_request_brief.md) |
| Generated with Generative AI | Yes / No |
| Manually reviewed by Data Engineer | Yes / No |
| Ready for Data Contract & Mapping | Yes / Conditional / No |

---

## 2. Request Summary

```text
[Summarize the request in 3–5 sentences.

Include:
- what needs to be built;
- why it is needed;
- which process it supports;
- what the expected result should be.]
```

---

## 3. Request Type

| Category | Assessment | Notes |
|---|---|---|
| Business need | Yes / No / To be confirmed | |
| Technical automation | Yes / No / To be confirmed | |
| Data load / integration | Yes / No / To be confirmed | |
| Data quality / validation | Yes / No / To be confirmed | |
| Reporting / analytics support | Yes / No / To be confirmed | |
| Operational process | Yes / No / To be confirmed | |

---

## 4. Expected Outcome

| Item | Description |
|---|---|
| Expected final output | |
| Target object | Database / Schema / Table / View / To be confirmed |
| Expected data action | Create / Insert / Merge / Update / Delete / Truncate and reload / Validate / To be confirmed |
| Expected return value | Success message / Row count / Status object / Error message / To be confirmed |
| Success definition | |

---

## 5. Execution Context

| Topic | Details |
|---|---|
| Expected caller | Analyst / Data Engineer / Task / Pipeline / Application / To be confirmed |
| Execution frequency | One-time / Scheduled / On demand / Event-based / To be confirmed |
| Snowflake environment | Dev / Test / Prod / To be confirmed |
| Required warehouse | To be confirmed |
| Required role | To be confirmed |
| Execution rights | EXECUTE AS CALLER / EXECUTE AS OWNER / To be confirmed |

---

## 6. Target Object Behavior

| Question | Answer |
|---|---|
| Should the procedure check whether the target table exists? | Yes / No / To be confirmed |
| Should the procedure create the target table if it does not exist? | Yes / No / To be confirmed |
| Should the procedure fail if the target table does not exist? | Yes / No / To be confirmed |
| Should the procedure check whether the target table already contains data? | Yes / No / To be confirmed |
| What should happen if the target table already contains data? | Append / Skip / Merge / Delete and reload / Fail / To be confirmed |
| Is duplicate prevention required? | Yes / No / To be confirmed |
| Is historical data preservation required? | Yes / No / To be confirmed |

---

## 7. High-Level Data Needs

| Data need | Known source | Required? | Status |
|---|---|---|---|
| | | Yes / No / To be confirmed | Confirmed / To be confirmed |

---

## 8. Known Business Rules

| Rule ID | Business rule | Status |
|---|---|---|
| RULE-001 | | Confirmed / To be confirmed |

---

## 9. Known Technical Constraints

| Constraint | Description | Impact |
|---|---|---|
| Snowflake environment | | High / Medium / Low |
| Access restrictions | | High / Medium / Low |
| Source availability | | High / Medium / Low |
| Target table ownership | | High / Medium / Low |
| Refresh / scheduling expectation | | High / Medium / Low |
| Data volume | | High / Medium / Low |
| Performance expectation | | High / Medium / Low |
| Security constraint | | High / Medium / Low |
| Naming standard | | High / Medium / Low |
| Deployment constraint | | High / Medium / Low |

---

## 10. Assumptions

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

---

## 11. Risks

| Risk | Area | Impact | Mitigation / Required clarification |
|---|---|---|---|
| | Duplicate risk / Data loss / Missing source / Unclear logic / Security / Performance / Other | High / Medium / Low | |

---

## 12. Open Questions

| Question | Owner | Priority | Blocking for next phase? |
|---|---|---|---|
| | Business owner / Data owner / Data Engineer / To be confirmed | High / Medium / Low | Yes / No |

---

## 13. Readiness Assessment

| Item | Assessment |
|---|---|
| Request clear enough for data contract and mapping? | Yes / Conditional / No |
| Main blockers | |
| Required confirmations | |
| Recommended next step | Move to data contract and mapping / Clarify request / Rework scope |

---

## Output of This Document

This SQL Request Brief is used as input for:

- [`../02_data_contract_and_mapping/01_gen_ai_prompt_create_data_contract_and_mapping.md`](../02_data_contract_and_mapping/01_gen_ai_prompt_create_data_contract_and_mapping.md)
- [`../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md`](../02_data_contract_and_mapping/02_data_contract_and_mapping_template.md)

Before moving to the next phase, all blocking questions must be clarified or explicitly accepted as pending.
