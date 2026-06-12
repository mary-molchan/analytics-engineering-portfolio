# GenAI Prompt — Create Dashboard Business Brief

## Purpose

This prompt is used to transform the validated clean meeting summary from Phase 1 into a structured **Dashboard Business Brief**.

The goal is to clarify the business purpose of the future Power BI dashboard before moving to detailed requirements, KPI definition, dashboard design, or technical implementation.

---

## Input

Use this prompt with the completed output from:

```text
../02_discovery/05_clean_meeting_summary_template.md
```

The input should contain:

- initial client request;
- business context;
- business problem;
- dashboard objective;
- target users;
- expected decisions;
- key business questions;
- requested KPIs or metrics;
- data sources mentioned;
- constraints, assumptions, risks, and open questions.

---

## Expected Output

The output should be copied into:

```text
01_dashboard_business_brief_template.md
```

---

## Prompt

```text
You are a senior BI consultant and business analyst.

I will provide a clean meeting summary from the Discovery phase of a Power BI dashboard project.

Your task is to transform this summary into a structured Dashboard Business Brief.

The goal of this phase is not to define detailed KPI formulas, visuals, data models, SQL queries, DAX measures, or Power BI implementation details.

The goal is to clarify the business framing of the dashboard:
- why the dashboard is needed;
- which business problem it should solve;
- who will use it;
- which decisions it should support;
- which business questions it must answer;
- what value it should bring to the business;
- what is in scope and out of scope;
- what assumptions, risks, and open questions must be clarified before moving to Requirements & KPI.

Important rules:
1. Do not invent information.
2. Do not assume missing details.
3. If information is unclear or missing, write "To be confirmed".
4. Separate confirmed facts from assumptions.
5. Keep the language business-oriented and clear for stakeholders.
6. Do not write SQL, DAX, data model logic, or detailed visual design.
7. Do not define KPI formulas unless they were explicitly confirmed in the input.
8. Focus on business purpose, decision-making, users, scope, and expected value.
9. Preserve the stakeholder’s intent from the Discovery phase.
10. Highlight blocking open questions before moving to the next phase.

Use the following output structure:

# Dashboard Business Brief

## 1. Source Information

| Field | Value |
|---|---|
| Source document | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst | To be completed |
| Ready for Phase 3 | Yes / Conditional / No |

## 2. Business Domain

Describe the business area, process, team, product, service, or activity covered by the dashboard.

## 3. Business Problem or Opportunity

Describe the business problem, pain point, reporting gap, decision-making issue, or opportunity behind the dashboard request.

Separate:
- confirmed problem;
- possible opportunity;
- information to be confirmed.

## 4. Dashboard Purpose

Describe the main purpose of the Power BI dashboard.

Clarify whether the dashboard is intended for:
- monitoring;
- reporting;
- performance tracking;
- decision-making;
- operational follow-up;
- executive overview;
- anomaly detection;
- replacing manual reporting.

## 5. Target Audience

Create a table:

| User group | Role / Profile | Expected usage | Decision-making need | Status |
|---|---|---|---|---|

Use "To be confirmed" where information is missing.

## 6. Key Business Questions

List the main business questions the dashboard should answer.

Group them if relevant:
- overview questions;
- performance questions;
- trend questions;
- comparison questions;
- root cause questions;
- operational follow-up questions.

## 7. Decisions Supported by the Dashboard

Create a table:

| Decision / Action | User group | Frequency | Required information | Status |
|---|---|---|---|---|

Do not invent decisions. If decisions are implied but not confirmed, mark them as "To be confirmed".

## 8. Expected Business Value

Describe the expected value of the dashboard.

Consider:
- time saved;
- better visibility;
- faster decision-making;
- reduced manual reporting;
- improved KPI consistency;
- better monitoring;
- improved stakeholder alignment;
- reduced reporting ambiguity.

## 9. Scope

### In Scope

List what is clearly included in the dashboard project.

### Out of Scope

List what is excluded, postponed, unclear, or not part of the first version.

Use "To be confirmed" where scope is not clear.

## 10. Success Criteria

List the criteria that would make the dashboard successful from a business perspective.

Examples:
- users can answer the key business questions;
- KPIs are clearly understood;
- decision-making is faster;
- manual reporting effort is reduced;
- users trust the dashboard;
- the dashboard is validated by the business owner.

## 11. Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|

Do not present assumptions as confirmed facts.

## 12. Risks and Constraints

Create a table:

| Risk / Constraint | Description | Impact | Required action |
|---|---|---|---|

Include risks related to:
- unclear business objective;
- unclear KPI ownership;
- stakeholder availability;
- scope ambiguity;
- data availability;
- data quality;
- deadline;
- access or security;
- conflicting expectations.

## 13. Open Questions

Create a table:

| Question | Owner | Priority | Blocking for Phase 3? |
|---|---|---|---|

Mark as blocking only if the missing answer prevents moving to Requirements & KPI.

## 14. Recommended Next Steps

Provide a short list of next steps before moving to Phase 3.

Include:
- what must be confirmed with the business owner;
- what should be clarified with KPI owners;
- what can already be used as input for requirements definition;
- whether the project is ready to move to Requirements & KPI.

## 15. Readiness for Phase 3

Provide a readiness assessment:

| Item | Assessment |
|---|---|
| Ready for Phase 3 — Requirements & KPI | Yes / Conditional / No |
| Reason | |
| Blocking missing information | |
| Non-blocking missing information | |
| Required clarifications | |

Now create the Dashboard Business Brief from the following clean meeting summary:

[paste the full clean meeting summary here]
```

---

## Human Review Checklist

After generating the Dashboard Business Brief, manually verify that:

- the business problem is clear;
- the dashboard purpose is explicit;
- target users are identified;
- key business questions are business-oriented;
- supported decisions are not invented;
- scope and out of scope are documented;
- assumptions are separated from confirmed facts;
- open questions are visible and actionable;
- the document does not include premature technical implementation details;
- the output is ready to be copied into `01_dashboard_business_brief_template.md`.
