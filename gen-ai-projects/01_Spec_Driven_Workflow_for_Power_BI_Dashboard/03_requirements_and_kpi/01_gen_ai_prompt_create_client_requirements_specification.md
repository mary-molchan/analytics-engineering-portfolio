# GenAI Prompt — Create Client Requirements Specification

## Purpose

This prompt is used to transform the validated Dashboard Business Brief from Phase 2 into a structured **Client Requirements Specification**.

The goal is to define what the Power BI dashboard must support from a business and functional perspective before creating the KPI dictionary, dashboard structure, and visual design.

---

## Input

Use this prompt with the completed and validated document:

- [`../02_business_framing/02_dashboard_business_brief_template.md`](../02_business_framing/02_dashboard_business_brief_template.md)

Optional supporting input:

- [`../01_discovery/05_clean_meeting_summary_template.md`](../01_discovery/05_clean_meeting_summary_template.md)

---

## Output

Copy the generated output into:

- [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md)

---

## Prompt

```text
You are a senior BI consultant and business analyst.

I will provide a validated Dashboard Business Brief from Phase 2 of a Power BI dashboard project.

Your task is to transform it into a structured Client Requirements Specification.

The goal is to define the business and functional requirements of the future Power BI dashboard before moving to KPI definition, dashboard design, data modeling, DAX, SQL, or technical implementation.

Important rules:
1. Do not invent information.
2. Do not assume missing details.
3. If information is unclear or missing, write "To be confirmed".
4. Separate confirmed requirements from assumptions.
5. Keep the language clear, business-oriented, and suitable for stakeholders.
6. Do not write SQL, DAX, data model logic, or technical implementation details.
7. Do not define detailed KPI formulas. KPI formulas belong to the KPI Dictionary.
8. Do not design final visuals. Only capture functional expectations and analytical needs.
9. Separate business requirements, user requirements, functional requirements, filters, dimensions, access constraints, risks, and open questions.
10. Identify blocking missing information before moving to the KPI Dictionary and Dashboard Design phases.

Use the following output structure:

# Client Requirements Specification

## 1. Source Information

| Field | Value |
|---|---|
| Source document | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst | To be completed |
| Ready for KPI Dictionary | Yes / Conditional / No |
| Ready for Dashboard Design | Yes / Conditional / No |

## 2. Business Objective Summary

Summarize the business objective of the dashboard in 2–4 sentences.

## 3. Target Users and Usage Needs

Create a table:

| User group | Usage need | Level of detail | Frequency of use | Status |
|---|---|---|---|---|

Use "To be confirmed" where information is missing.

## 4. Business Questions to Answer

List the business questions the dashboard must answer.

Group them if useful:
- overview questions;
- performance questions;
- trend questions;
- comparison questions;
- operational follow-up questions;
- exception or risk questions.

## 5. Functional Requirements

Create a table:

| Requirement ID | Requirement | User group | Priority | Status |
|---|---|---|---|---|

Rules:
- Use short requirement IDs such as REQ-001, REQ-002.
- Focus on what the dashboard must allow users to understand, monitor, compare, filter, or analyze.
- Do not include technical implementation details.

## 6. Dashboard Pages or Analytical Views

Create a table:

| Page / View | Purpose | Main users | Key questions covered | Priority | Status |
|---|---|---|---|---|---|

If page structure is not confirmed, mark it as "To be confirmed".

## 7. Filters and Dimensions

Create a table:

| Filter / Dimension | Business purpose | Applies to | Priority | Status |
|---|---|---|---|---|

Examples:
- date;
- period;
- country;
- region;
- product;
- client;
- team;
- status;
- category;
- business unit;
- project.

Do not confuse filters or dimensions with KPIs.

## 8. Metrics and KPIs Mentioned

Create a table:

| KPI / Metric | Business purpose | Priority | Definition status | Owner / Validator |
|---|---|---|---|---|

Rules:
- Include only KPIs or metrics mentioned or clearly required by the business questions.
- Do not invent formulas.
- If a metric is implied but not confirmed, mark it as "Candidate / To be confirmed".
- Detailed definitions will be completed in the KPI Dictionary.

## 9. Data and Source Dependencies

Create a table:

| Data / Source Need | Related requirement | Known source | Owner | Status |
|---|---|---|---|---|

Do not invent data sources. If the source is unknown, write "To be confirmed".

## 10. Access, Security, and Confidentiality Requirements

Create a table:

| Requirement | Description | User group affected | Status |
|---|---|---|---|

Include access levels, restricted data, sensitive data, personal data, GDPR constraints, and row-level security needs if mentioned.

## 11. Refresh, Usage, and Maintenance Requirements

Create a table:

| Topic | Requirement / Expectation | Status |
|---|---|---|

Cover refresh frequency, usage frequency, dashboard ownership, maintenance ownership, and future update expectations.

## 12. Scope

### In Scope

List confirmed requirements included in this phase or first dashboard version.

### Out of Scope

List excluded, postponed, unclear, or future-version items.

## 13. Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|

Do not present assumptions as confirmed facts.

## 14. Risks, Constraints, and Dependencies

Create a table:

| Type | Description | Impact | Required action |
|---|---|---|---|

Types may include:
- unclear requirement;
- unclear KPI definition;
- missing data source;
- data quality risk;
- stakeholder availability;
- access or security constraint;
- scope ambiguity;
- deadline risk.

## 15. Open Questions

Create a table:

| Question | Owner | Priority | Blocking? |
|---|---|---|---|

Mark as blocking only if the missing answer prevents moving to KPI Dictionary or Dashboard Design.

## 16. Readiness Assessment

Create a table:

| Item | Assessment |
|---|---|
| Ready for KPI Dictionary | Yes / Conditional / No |
| Ready for Dashboard Design | Yes / Conditional / No |
| Main blockers | |
| Required clarifications | |

Now create the Client Requirements Specification from the following Dashboard Business Brief:

[paste the completed Dashboard Business Brief here]
```

---

## Human Review Checklist

After generating the specification, manually verify that:

- no unsupported requirement was invented;
- business questions are clear;
- user groups are documented;
- filters and dimensions are separated from KPIs;
- KPI formulas are not prematurely defined;
- data sources are not invented;
- scope and out of scope are clear;
- open questions are visible;
- blocking issues are marked;
- the document is ready to be copied into [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md).
