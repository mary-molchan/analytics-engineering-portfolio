# GenAI Prompt — Create Dashboard Design Specification

## Purpose

This prompt transforms validated requirements and KPI documentation into a structured **Dashboard Design Specification**.

The goal is to define the dashboard structure, page logic, user journey, navigation, filters, interactions, and functional behavior before creating the visual design specification or moving to Power BI build preparation.

---

## Input

Use this prompt with the validated outputs from Phase 3:

- [`../03_requirements_and_kpi/02_client_requirements_specification_template.md`](../03_requirements_and_kpi/02_client_requirements_specification_template.md)
- [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md)

---

## Output

Copy the generated output into:

- [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md)

---

## Prompt

```text
You are a senior Power BI consultant, BI analyst, and dashboard design specialist.

I will provide:
1. A validated Client Requirements Specification.
2. A validated KPI Dictionary.

Your task is to create a structured Dashboard Design Specification for a Power BI dashboard.

The goal is to define the functional and structural design of the dashboard:
- dashboard pages;
- page purpose;
- user journey;
- analytical flow;
- KPI placement;
- filters and slicers;
- navigation logic;
- interactions;
- drill-down or drill-through needs;
- functional behavior;
- open design questions.

This is not the visual design phase yet. Do not create a full visual style guide, color system, branding rules, or detailed mockup layout. Those belong to the Visual Design Specification.

Important rules:
1. Do not invent requirements.
2. Do not invent KPI definitions.
3. Do not invent data sources.
4. Do not write SQL, DAX, Power Query, or data model logic.
5. Do not change KPI formulas or business meanings.
6. If information is missing, write "To be confirmed".
7. Separate confirmed design decisions from assumptions.
8. Keep the design aligned with business questions and target users.
9. Each proposed page must have a clear business purpose.
10. Each KPI placement must be justified by a business question or user need.
11. Do not add pages only for aesthetic reasons.
12. Mark unresolved design issues as open questions.
13. Identify blockers before moving to Visual Design or Build Readiness.

Use the following output structure:

# Dashboard Design Specification

## 1. Source Information

| Field | Value |
|---|---|
| Requirements source | |
| KPI source | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst | To be completed |
| Ready for Visual Design | Yes / Conditional / No |
| Ready for Build Readiness | Yes / Conditional / No |

## 2. Dashboard Design Objective

Summarize the dashboard design objective in 2–4 sentences.

Explain how the dashboard structure supports:
- target users;
- business questions;
- decision-making needs;
- KPI monitoring.

## 3. Target Users and Design Needs

Create a table:

| User group | Main need | Expected usage | Required level of detail | Design implication |
|---|---|---|---|---|

Use "To be confirmed" where information is missing.

## 4. User Journey

Describe the expected analytical journey.

The journey should explain how users move from:
- overview;
- key insights;
- detailed analysis;
- filtering or segmentation;
- decision or action.

## 5. Dashboard Pages

Create a table:

| Page ID | Page / View | Purpose | Main users | Key questions answered | Priority | Status |
|---|---|---|---|---|---|---|

Rules:
- Use short page IDs such as PAGE-01, PAGE-02.
- Include only pages supported by requirements.
- If a page is useful but not confirmed, mark it as "Candidate / To be confirmed".

## 6. Page-Level Design Specification

Create a table:

| Page ID | Main KPIs / Metrics | Main dimensions | Filters / slicers | Main interactions | Notes |
|---|---|---|---|---|---|

Do not invent KPIs, dimensions, or filters.

## 7. KPI Placement Logic

Create a table:

| KPI ID | KPI / Metric | Recommended page | Business question supported | Placement rationale |
|---|---|---|---|---|

Use KPI IDs from the KPI Dictionary if available.

## 8. Filters, Slicers, and Dimensions

Create a table:

| Filter / Dimension | Scope | Applies to | Default behavior | Status |
|---|---|---|---|---|

Scope can be:
- global;
- page-level;
- visual-level;
- to be confirmed.

## 9. Navigation and Interactions

Document expected navigation and interactions.

Include:
- page navigation;
- drill-down;
- drill-through;
- cross-filtering;
- bookmarks;
- reset filters;
- tooltips;
- export needs;
- glossary or help page.

Create a table:

| Interaction | Purpose | Applies to | Required? | Status |
|---|---|---|---|---|

## 10. Functional Behavior

Document how the dashboard should behave from a user perspective.

Include:
- default landing page;
- default filters;
- comparison logic;
- period selection;
- detail access;
- restricted views if mentioned;
- expected user actions.

## 11. Design Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|

Do not present assumptions as confirmed facts.

## 12. Design Risks and Constraints

Create a table:

| Risk / Constraint | Description | Impact | Required action |
|---|---|---|---|

Include risks related to unclear page structure, missing KPI definitions, unclear filters, access constraints, or conflicting user needs.

## 13. Open Design Questions

Create a table:

| Question | Related page / feature | Owner | Priority | Blocking? |
|---|---|---|---|---|

## 14. Readiness Assessment

Create a table:

| Item | Assessment |
|---|---|
| Ready for Visual Design | Yes / Conditional / No |
| Ready for Build Readiness | Yes / Conditional / No |
| Main blockers | |
| Required clarifications | |

Now create the Dashboard Design Specification from the following inputs:

Client Requirements Specification:
[paste the completed Client Requirements Specification here]

KPI Dictionary:
[paste the completed KPI Dictionary here]
```

---

## Human Review Checklist

After generating the specification, manually verify that:

- all pages are supported by requirements;
- KPI placement is aligned with business questions;
- filters and dimensions are not confused with KPIs;
- no unsupported feature was invented;
- open design questions are visible;
- assumptions are clearly marked;
- the document is ready to be copied into [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md).
