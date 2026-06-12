# GenAI Prompt — Create Dashboard Design Specification

## Purpose

This prompt transforms validated requirements and KPI documentation into a structured **Dashboard Design Specification**.

The goal is to define the functional and structural design of the Power BI dashboard before creating the visual design specification or moving to build preparation.

This document should describe not only KPI cards, but also the full dashboard structure: pages, user journey, analytical flow, expected visual components, filters, interactions, navigation, and functional behavior.

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
- KPI and metric placement;
- expected visual components;
- filters and slicers;
- tables and matrices;
- charts and graphical analysis;
- navigation logic;
- interactions;
- drill-down or drill-through needs;
- functional behavior;
- open design questions.

This is not the final visual styling phase yet. Do not create a full visual style guide, color system, branding rules, or pixel-perfect layout. Those belong to the Visual Design Specification.

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
10. Each KPI, table, matrix, chart, or visual component must support a business question or user need.
11. Do not design a dashboard made only of KPI cards.
12. Include tables or matrices when users need detailed records, operational follow-up, export, or cross-tab analysis.
13. Include charts when users need trends, comparisons, ranking, segmentation, distribution, variance, or root cause analysis.
14. Do not add pages or visuals only for aesthetic reasons.
15. Mark unresolved design issues as open questions.
16. Identify blockers before moving to Visual Design or Build Readiness.

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
- KPI monitoring;
- detailed analysis;
- operational follow-up.

## 3. Target Users and Design Needs

Create a table:

| User group | Main need | Expected usage | Required level of detail | Design implication |
|---|---|---|---|---|

Use "To be confirmed" where information is missing.

## 4. User Journey

Describe the expected analytical journey.

The journey should explain how users move from:
- overview;
- headline KPIs;
- trends or comparisons;
- detailed tables or matrices;
- filtering or segmentation;
- root cause exploration;
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

| Page ID | Main KPIs / Metrics | Main dimensions | Filters / slicers | Expected visual components | Main interactions | Notes |
|---|---|---|---|---|---|---|

Expected visual components may include:
- KPI cards;
- trend charts;
- bar or column charts;
- tables;
- matrices;
- maps;
- decomposition tree;
- waterfall chart;
- scatter plot;
- slicers;
- tooltips;
- status indicators.

Do not invent KPIs, dimensions, filters, or visuals unsupported by requirements.

## 7. Analytical Visual Requirements

Create a table:

| Page ID | Analytical need | Recommended visual family | Business reason | Status |
|---|---|---|---|---|

Recommended visual families may include:
- KPI monitoring;
- trend analysis;
- category comparison;
- ranking;
- part-to-whole analysis;
- detailed records;
- cross-tab analysis;
- geographic analysis;
- variance analysis;
- root cause exploration;
- distribution or correlation analysis.

## 8. KPI and Metric Placement Logic

Create a table:

| KPI ID | KPI / Metric | Recommended page | Expected visual role | Business question supported | Placement rationale |
|---|---|---|---|---|---|

Expected visual role may include:
- headline KPI card;
- trend chart;
- comparison chart;
- table column;
- matrix value;
- tooltip detail;
- status indicator.

Use KPI IDs from the KPI Dictionary if available.

## 9. Tables and Matrices Requirements

Create a table:

| Page ID | Table / Matrix purpose | Required fields or dimensions | Level of detail | Export needed? | Status |
|---|---|---|---|---|---|

Use this section when users need:
- operational follow-up;
- detailed lists;
- transaction-level or entity-level detail;
- cross-tab analysis;
- export to Excel;
- validation or audit views.

## 10. Filters, Slicers, and Dimensions

Create a table:

| Filter / Dimension | Scope | Applies to | Default behavior | Status |
|---|---|---|---|---|

Scope can be:
- global;
- page-level;
- visual-level;
- to be confirmed.

## 11. Navigation and Interactions

Create a table:

| Interaction | Purpose | Applies to | Required? | Status |
|---|---|---|---|---|

Include:
- page navigation;
- drill-down;
- drill-through;
- cross-filtering;
- bookmarks;
- reset filters;
- tooltips;
- export;
- glossary or help page.

## 12. Functional Behavior

Document how the dashboard should behave from a user perspective.

Include:
- default landing page;
- default filters;
- comparison logic;
- period selection;
- detail access;
- restricted views if mentioned;
- expected user actions.

## 13. Design Assumptions

Create a table:

| Assumption | Reason | Needs confirmation? |
|---|---|---|

Do not present assumptions as confirmed facts.

## 14. Design Risks and Constraints

Create a table:

| Risk / Constraint | Description | Impact | Required action |
|---|---|---|---|

Include risks related to unclear page structure, too many visuals, missing KPI definitions, unclear filters, access constraints, export needs, or conflicting user needs.

## 15. Open Design Questions

Create a table:

| Question | Related page / feature | Owner | Priority | Blocking? |
|---|---|---|---|---|

## 16. Readiness Assessment

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
- the dashboard is not reduced to KPI cards only;
- charts, tables, matrices, and other visual components support real analytical needs;
- KPI placement is aligned with business questions;
- filters and dimensions are not confused with KPIs;
- no unsupported feature was invented;
- open design questions are visible;
- assumptions are clearly marked;
- the document is ready to be copied into [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md).
