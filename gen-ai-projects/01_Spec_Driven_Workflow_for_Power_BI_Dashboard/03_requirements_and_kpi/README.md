# Phase 3. Requirements & KPI.
![Phase](https://img.shields.io/badge/Phase_3-Requirements_%26_KPI-7B61FF?style=for-the-badge)
![Focus](https://img.shields.io/badge/Focus-Business_Requirements-blue?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-Assisted_Workflow-purple?style=for-the-badge)
![Output](https://img.shields.io/badge/Output-KPI_Dictionary-green?style=for-the-badge)

## Purpose

The **Requirements & KPI** phase transforms the validated business brief into a structured requirements package for the future Power BI dashboard.

Its purpose is to clarify what the dashboard must contain, which business questions it must answer, which KPIs and metrics are required, and what filters, dimensions, data dependencies, risks, and open questions must be documented before moving to dashboard design.

This phase acts as the bridge between business framing and dashboard design. It ensures that the project does not move into visuals, data modeling, DAX, SQL, or Power BI implementation before the requirements and KPI logic are clearly structured.

Generative AI is used in this phase to convert the validated business brief into two structured artifacts: a **Client Requirements Specification** and a **KPI Dictionary**.

---

## Process Overview

```text
Validated Dashboard Business Brief
→ GenAI prompt to create client requirements specification
→ Client Requirements Specification
→ GenAI prompt to create KPI dictionary
→ KPI Dictionary
→ Input for Dashboard Design phase
```

---

## What This Phase Covers

This folder contains prompt files and artifact templates used to define the functional and analytical content of the Power BI dashboard.

The goal is to document:

- target users and usage needs;
- key business questions;
- functional dashboard requirements;
- expected dashboard pages or analytical views;
- required filters and dimensions;
- mentioned KPIs and metrics;
- data and source dependencies;
- access, security, and confidentiality requirements;
- refresh, usage, and maintenance expectations;
- KPI business meaning and definition status;
- KPI ownership and validation needs;
- assumptions, risks, constraints, and open questions;
- readiness for the Dashboard Design phase.

---

## Inputs

The Requirements & KPI phase starts from the validated output of Phase 2 — Business Framing.

Main input:

- [`../02_business_framing/02_dashboard_business_brief_template.md`](../02_business_framing/02_dashboard_business_brief_template.md)

Optional supporting input:

- [`../01_discovery/05_clean_meeting_summary_template.md`](../01_discovery/05_clean_meeting_summary_template.md)

Typical input content includes:

- confirmed dashboard objective;
- business problem or opportunity;
- target user groups;
- key business questions;
- expected business decisions;
- initial list of metrics or KPIs;
- known data or source dependencies;
- scope and out of scope;
- assumptions, risks, constraints, and open questions.

---

## Outputs

At the end of this phase, the expected output is a validated requirements package that can be used to design the dashboard structure, user journey, visual layout, and Power BI report logic.

Main outputs:

- [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md)
- [`04_kpi_dictionary_template.md`](./04_kpi_dictionary_template.md)

These documents become the foundation for the next phase:

- [`../04_dashboard_design/`](../04_dashboard_design/)

---

## Files Included

| File | Type | Purpose |
|---|---|---|
| [`01_gen_ai_prompt_create_client_requirements_specification.md`](./01_gen_ai_prompt_create_client_requirements_specification.md) | GenAI prompt | Transforms the validated Dashboard Business Brief into a structured Client Requirements Specification. It focuses on business questions, user needs, functional requirements, pages or analytical views, filters, dimensions, access constraints, risks, assumptions, and readiness for the next steps. |
| [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md) | Artifact template | Provides the target structure for documenting client requirements. It captures what the dashboard must support from a business and functional perspective, without going into DAX, SQL, data modeling, or visual design. |
| [`03_gen_ai_prompt_create_kpi_dictionary.md`](./03_gen_ai_prompt_create_kpi_dictionary.md) | GenAI prompt | Extracts and structures KPIs and metrics from the Client Requirements Specification. It helps separate KPIs from filters and dimensions, identify missing definitions, mark candidate KPIs, and prepare KPI information for analyst review. |
| [`04_kpi_dictionary_template.md`](./04_kpi_dictionary_template.md) | Artifact template | Provides the target structure for documenting KPIs and metrics. It includes business meaning, definition status, granularity, time logic, ownership, source dependency, filters, comparisons, validation issues, and open questions. |

---

## How to Use This Folder

1. Start from the validated business brief: [`../02_business_framing/02_dashboard_business_brief_template.md`](../02_business_framing/02_dashboard_business_brief_template.md).
2. Use [`01_gen_ai_prompt_create_client_requirements_specification.md`](./01_gen_ai_prompt_create_client_requirements_specification.md) to generate the Client Requirements Specification.
3. Copy the generated output into [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md).
4. Review the requirements manually to ensure that no unsupported requirement was invented.
5. Use [`03_gen_ai_prompt_create_kpi_dictionary.md`](./03_gen_ai_prompt_create_kpi_dictionary.md) to generate the KPI Dictionary from the completed requirements specification.
6. Copy the generated output into [`04_kpi_dictionary_template.md`](./04_kpi_dictionary_template.md).
7. Review the KPI Dictionary manually to confirm that KPIs are not confused with filters, dimensions, pages, or data sources.
8. Mark missing or uncertain information as `To be confirmed`.
9. Use the validated requirements and KPI dictionary as input for the next phase: [`../04_dashboard_design/`](../04_dashboard_design/).

---

## Role of Generative AI in This Phase

Generative AI is used to support the analyst in structuring requirements and KPI information.

In this phase, Generative AI helps to:

- transform the business brief into structured client requirements;
- organize user needs and business questions;
- identify functional dashboard requirements;
- structure expected pages, filters, and dimensions;
- extract KPIs and metrics from requirements;
- separate KPIs from filters, dimensions, pages, and data sources;
- identify missing KPI definitions, owners, sources, or calculation logic;
- mark candidate KPIs and unclear metrics;
- highlight risks, assumptions, dependencies, and open questions;
- assess readiness for the Dashboard Design phase.

Generative AI does not replace analyst validation. The analyst remains responsible for checking accuracy, confirming definitions with business owners, and ensuring that no unsupported requirements or KPI formulas are invented.

---

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- What exactly should the dashboard support?
- Which users and usage needs must be covered?
- Which business questions must the dashboard answer?
- Which pages or analytical views are expected?
- Which filters and dimensions are required?
- Which KPIs and metrics are mandatory, optional, or still candidates?
- What is the business meaning of each KPI?
- Which KPI definitions are confirmed and which are still missing?
- Who owns or validates each KPI?
- Which data or source dependencies are already known?
- What assumptions, risks, constraints, or open questions remain?
- Is the project ready to move to Dashboard Design?

---

## KPI Definition Principles

Each KPI should be documented with enough detail to avoid ambiguity during dashboard design and implementation.

A good KPI definition should clarify:

- business meaning;
- formula or definition status;
- unit;
- granularity;
- time logic;
- owner or validator;
- required data;
- known source;
- relevant dimensions and filters;
- target, threshold, benchmark, or comparison need;
- validation issues;
- open questions.

If a KPI formula is not clearly confirmed, it must not be invented. It should be marked as `To be confirmed`.

---

## Human-in-the-Loop Validation

Before moving to Phase 4, the analyst must verify that:

- requirements are supported by the validated business brief;
- no unsupported requirements were invented;
- business questions are clear and actionable;
- filters and dimensions are separated from KPIs;
- KPI formulas are not invented;
- candidate KPIs are clearly marked;
- missing KPI definitions are marked as `To be confirmed`;
- data sources are not invented;
- KPI owners or validators are documented where available;
- access and security constraints are visible;
- blocking issues are clearly identified;
- both main outputs are ready for [`../04_dashboard_design/`](../04_dashboard_design/).

---

## Key Principle

The Requirements & KPI phase protects the dashboard from ambiguity.

A dashboard can only be reliable if its requirements and KPIs are clearly defined before the visual design begins.

This phase ensures that the future Power BI report is based on validated business needs, consistent metric definitions, and a clear understanding of what users need to see and why.
