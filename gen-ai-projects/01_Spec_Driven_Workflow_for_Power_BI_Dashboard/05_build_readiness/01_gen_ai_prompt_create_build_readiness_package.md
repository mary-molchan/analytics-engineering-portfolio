# GenAI Prompt — Create Build Readiness Package

## Purpose

This prompt is used to transform the validated dashboard design documentation into a consolidated **Build Readiness Package**.

The goal is to prepare the Power BI development phase by identifying technical implementation needs, build tasks, dependencies, blockers, validation checks, and the final Go / Conditional Go / No-Go decision.

---

## Input

Use this prompt with the validated outputs from Phase 4:

- [`../04_dashboard_design/02_dashboard_design_specification_template.md`](../04_dashboard_design/02_dashboard_design_specification_template.md)
- [`../04_dashboard_design/04_visual_design_specification_template.md`](../04_dashboard_design/04_visual_design_specification_template.md)

Optional supporting inputs:

- [`../03_requirements_and_kpi/02_client_requirements_specification_template.md`](../03_requirements_and_kpi/02_client_requirements_specification_template.md)
- [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md)

---

## Output

Copy the generated output into:

- [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md)

---

## Prompt

```text
You are a senior Power BI developer, BI consultant, and analytics engineer.

I will provide validated dashboard design documentation for a Power BI dashboard project.

Your task is to create a concise Build Readiness Package.

The goal is to prepare the actual Power BI build phase by defining:
- technical Power BI preparation;
- dataset and semantic model readiness;
- measures and KPI implementation needs;
- report page build tasks;
- visual and interaction build tasks;
- security and access requirements;
- refresh and deployment requirements;
- build backlog;
- pre-build validation checklist;
- blockers and dependencies;
- final Go / Conditional Go / No-Go decision.

Important rules:
1. Do not invent requirements, KPIs, data sources, or security rules.
2. Do not rewrite previous business documentation.
3. Focus only on what is needed to start and organize Power BI development.
4. If something is missing, write "To be confirmed".
5. Separate confirmed build items from assumptions.
6. Do not write full SQL, DAX, or Power Query code unless explicitly requested.
7. Mention DAX, Power Query, data model, relationships, RLS, refresh, workspace, gateway, and deployment only as build preparation topics.
8. Identify blockers that prevent starting the build.
9. Identify non-blocking clarifications that can be resolved during development.
10. Keep the output concise, practical, and developer-oriented.

Use the following output structure:

# Build Readiness Package

## 1. Source Information

| Field | Value |
|---|---|
| Dashboard design source | |
| Visual design source | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst / developer | To be completed |
| Build readiness status | Go / Conditional Go / No-Go |

## 2. Build Scope Summary

Summarize what will be built in Power BI.

Include:
- number or list of report pages;
- main KPI groups;
- main visual families;
- filters and interactions;
- security or access constraints if mentioned.

## 3. Technical Power BI Preparation

Create a table:

| Area | Requirement / Task | Status | Notes |
|---|---|---|---|

Cover only relevant items:
- Power BI workspace;
- dataset / semantic model;
- data connections;
- Power Query transformations;
- relationships;
- measures / DAX;
- calculation groups if relevant;
- date table;
- refresh configuration;
- gateway need;
- row-level security;
- report theme;
- deployment target;
- naming conventions;
- performance considerations.

## 4. Data and Model Readiness

Create a table:

| Item | Requirement | Ready? | Blocking? | Notes |
|---|---|---|---|---|

Include:
- required tables;
- required fields;
- relationships;
- date logic;
- missing fields;
- data quality concerns;
- source access;
- refresh frequency.

Do not invent data elements.

## 5. KPI and Measure Implementation Readiness

Create a table:

| KPI ID | KPI / Measure | Definition status | Implementation need | Blocking? |
|---|---|---|---|---|

Use KPI IDs from the KPI Dictionary if available.

## 6. Report Page Build Backlog

Create a backlog table:

| Task ID | Page / Area | Build task | Type | Priority | Status |
|---|---|---|---|---|---|

Task types may include:
- data preparation;
- model;
- DAX measure;
- page layout;
- visual;
- table / matrix;
- slicer;
- interaction;
- navigation;
- tooltip;
- security;
- refresh;
- testing;
- documentation.

## 7. Pre-Build Validation Checklist

Create a table:

| Validation item | Status | Blocking? | Notes |
|---|---|---|---|

Check:
- requirements validated;
- KPI definitions validated;
- data sources confirmed;
- required fields available;
- page structure validated;
- visual design validated;
- security rules confirmed;
- refresh expectations confirmed;
- build backlog ready;
- open blockers resolved or accepted.

## 8. Blockers and Required Clarifications

Create a table:

| Blocker / Clarification | Area | Owner | Impact | Required action |
|---|---|---|---|---|

Only mark an item as blocking if it prevents a reliable build start.

## 9. Build Readiness Decision

Create a table:

| Item | Assessment |
|---|---|
| Ready to build? | Go / Conditional Go / No-Go |
| Main reason | |
| Blocking items | |
| Accepted risks | |
| Required confirmations before build | |
| Next action | Start build / Clarify requirements / Rework design |

## 10. Recommended Next Steps

Provide 3–7 practical next steps for the analyst or Power BI developer.

Now create the Build Readiness Package from the following inputs:

Dashboard Design Specification:
[paste the completed Dashboard Design Specification here]

Visual Design Specification:
[paste the completed Visual Design Specification here]

Optional supporting requirements or KPI documentation:
[paste supporting documents if needed]
```

---

## Human Review Checklist

After generating the Build Readiness Package, verify that:

- no technical requirement was invented;
- build tasks are actionable for a Power BI developer;
- KPI implementation needs are linked to validated KPI definitions;
- blockers are clearly separated from non-blocking clarifications;
- security, refresh, deployment, and performance topics are addressed where relevant;
- the Go / Conditional Go / No-Go decision is justified;
- the output is ready to be copied into [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md).
