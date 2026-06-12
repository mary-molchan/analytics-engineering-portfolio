# Phase 4. Dashboard Design.

![Phase](https://img.shields.io/badge/Phase_4-Dashboard_Design-1E90FF?style=for-the-badge)
![Focus](https://img.shields.io/badge/Focus-UX_%26_Visual_Design-blue?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-Assisted-purple?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Workflow_Phase-green?style=for-the-badge)

## Purpose

The **Dashboard Design** phase transforms validated requirements and KPI documentation into a structured Power BI dashboard design package.

Its purpose is to define how the report should be organized, how users should navigate through it, which pages and analytical views are needed, and which visual components should support each business question.

This phase covers not only KPI cards, but also the full dashboard experience: charts, tables, matrices, slicers, tooltips, navigation, interactions, visual hierarchy, readability, and accessibility.

Generative AI is used in this phase to help the analyst convert requirements into a structured dashboard design and then transform that design into a clear visual specification before build preparation.

## Process Overview

```text
Validated Client Requirements Specification
+ Validated KPI Dictionary
→ GenAI prompt to create Dashboard Design Specification
→ Dashboard Design Specification
→ GenAI prompt to create Visual Design Specification
→ Visual Design Specification
→ Input for Build Readiness phase
```

## What This Phase Covers

This folder contains prompt files and artifact templates used to design the future Power BI report before implementation.

The goal is to define:

- dashboard pages and their business purpose;
- user journey from overview to detailed analysis;
- analytical flow and decision-making path;
- KPI and metric placement logic;
- expected visual components by page;
- charts for trends, comparisons, rankings, variance, distribution, and root cause analysis;
- tables and matrices for detailed records, operational follow-up, exports, and cross-tab analysis;
- filters, slicers, dimensions, and default behavior;
- drill-down, drill-through, tooltips, cross-filtering, and navigation;
- visual hierarchy and page layout principles;
- UX rules, readability, and accessibility expectations;
- design assumptions, risks, constraints, and open questions;
- readiness for Build Readiness.

## Inputs

The Dashboard Design phase starts from the validated outputs of Phase 3 — Requirements & KPI.

Main inputs:

- [`../03_requirements_and_kpi/02_client_requirements_specification_template.md`](../03_requirements_and_kpi/02_client_requirements_specification_template.md)
- [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md)

Typical input content includes:

- confirmed dashboard scope;
- target user groups;
- business questions;
- functional requirements;
- required filters and dimensions;
- validated or candidate KPIs;
- KPI business meanings and validation status;
- expected user actions;
- known access or security constraints;
- known visual, UX, or branding expectations.

---

## Outputs

At the end of this phase, the expected output is a validated dashboard design package that describes how the Power BI report should be structured, navigated, and visually presented.

Main outputs:

- [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md)
- [`04_visual_design_specification_template.md`](./04_visual_design_specification_template.md)

These documents become the foundation for the next phase:

- [`../05_build_readiness/`](../05_build_readiness/)

---

## Files Included

| File | Type | Purpose |
|---|---|---|
| [`01_gen_ai_prompt_create_dashboard_design_specification.md`](./01_gen_ai_prompt_create_dashboard_design_specification.md) | GenAI prompt | Transforms the validated requirements and KPI dictionary into a functional dashboard design. It focuses on pages, user journey, analytical flow, KPI placement, expected visual components, tables, matrices, filters, slicers, navigation, interactions, and open design questions. |
| [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md) | Artifact template | Provides the target structure for the Dashboard Design Specification. It documents the functional and structural design of the dashboard before visual styling and build preparation. |
| [`03_gen_ai_prompt_create_visual_design_specification.md`](./03_gen_ai_prompt_create_visual_design_specification.md) | GenAI prompt | Transforms the dashboard design specification into a visual design specification. It focuses on layout, chart choices, tables, matrices, visual hierarchy, UX rules, accessibility, branding constraints, and readability. |
| [`04_visual_design_specification_template.md`](./04_visual_design_specification_template.md) | Artifact template | Provides the target structure for the Visual Design Specification. It documents visual components, chart types, page layouts, KPI treatment, tables, matrices, slicer placement, navigation rules, accessibility, and visual risks. |

---

## How to Use This Folder

1. Start from the validated Phase 3 outputs: [`../03_requirements_and_kpi/02_client_requirements_specification_template.md`](../03_requirements_and_kpi/02_client_requirements_specification_template.md) and [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md).
2. Use [`01_gen_ai_prompt_create_dashboard_design_specification.md`](./01_gen_ai_prompt_create_dashboard_design_specification.md) to generate the Dashboard Design Specification.
3. Copy the generated output into [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md).
4. Review the dashboard design manually to ensure that each page, KPI, visual component, table, matrix, filter, and interaction supports a real business question.
5. Use [`03_gen_ai_prompt_create_visual_design_specification.md`](./03_gen_ai_prompt_create_visual_design_specification.md) to generate the Visual Design Specification.
6. Copy the generated output into [`04_visual_design_specification_template.md`](./04_visual_design_specification_template.md).
7. Review visual choices manually to ensure that the dashboard is readable, consistent, accessible, and not overloaded.
8. Use the validated design package as input for [`../05_build_readiness/`](../05_build_readiness/).

---

## Role of Generative AI in This Phase

Generative AI is used to support the analyst in translating requirements into design documentation.

In this phase, Generative AI helps to:

- propose a dashboard structure based on user needs and business questions;
- organize pages and analytical views;
- map KPIs and metrics to pages and visual roles;
- identify where tables, matrices, charts, slicers, and tooltips are needed;
- suggest visual families for trends, comparisons, rankings, variance, geography, distribution, and root cause analysis;
- structure navigation and interaction requirements;
- document visual design principles and UX rules;
- identify design assumptions, risks, and open questions;
- assess readiness for Build Readiness.

Generative AI does not replace the analyst’s design judgment. The analyst remains responsible for validating every page, visual, interaction, and design choice against the actual business need.

---

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- How should the dashboard be structured?
- Which pages or analytical views are required?
- What is the purpose of each page?
- How should users move from overview to detail?
- Which business questions should each page answer?
- Which KPIs should appear on which page?
- Which visual components are needed beyond KPI cards?
- Where are tables, matrices, charts, maps, slicers, and tooltips required?
- Which visuals best support trends, comparisons, rankings, variance, or detailed analysis?
- Which filters, slicers, and interactions are needed?
- How should the dashboard remain readable, consistent, and easy to use?
- Is the design ready for Build Readiness?

---

## Dashboard Design Principles

A strong dashboard design should follow several key principles:

- each page should have a clear business purpose;
- each visual should answer a specific business question;
- KPI cards should be used for headline indicators, not as the entire dashboard;
- charts should support trends, comparisons, rankings, variance, distribution, or root cause analysis;
- tables and matrices should support detail, validation, operational follow-up, or export needs;
- users should be guided from overview to detailed analysis;
- filters and interactions should support analysis without creating confusion;
- visual hierarchy should make the dashboard easy to scan;
- design choices should improve readability and decision-making;
- colors should have consistent meaning;
- the dashboard should avoid unnecessary visual complexity.

---

## Human-in-the-Loop Validation

Before moving to Phase 5, the analyst must verify that:

- every page is supported by requirements;
- every visual supports a business question or user need;
- the dashboard is not reduced to KPI cards only;
- charts are selected according to analytical purpose;
- tables and matrices are included where detailed analysis is required;
- KPI placement is consistent with the KPI dictionary;
- filters, slicers, and interactions are clear;
- visual choices are not decorative or unsupported;
- accessibility and readability are addressed;
- open design questions are visible;
- blocking issues are clearly marked;
- the design package is ready for [`../05_build_readiness/`](../05_build_readiness/).

---

## Key Principle

The Dashboard Design phase ensures that the Power BI report is planned before it is built.

This phase helps avoid common dashboard issues such as unclear page structure, overloaded visuals, weak analytical flow, inconsistent formatting, missing detail views, and poor user experience.

A well-designed dashboard should not only display data, but guide users toward meaningful insights, confident interpretation, and business decisions.


- UX rules, readability, and accessibility expectations;
- design assumptions, risks, constraints, and open questions;
- readiness for Build Readiness.

---
