# Phase 4 — Dashboard Design

## Purpose

The **Dashboard Design** phase transforms validated requirements and KPI definitions into a structured Power BI dashboard concept.

Its purpose is to define how the report will be organized, how users will navigate through it, which pages and visuals will be included, and how the dashboard should look and feel before the Power BI build phase begins.

This phase ensures that the dashboard is designed around user needs, business questions, and decision-making flows rather than around disconnected charts.

## Process Overview

```text
Client requirements specification
→ KPI dictionary
→ Functional specification
→ Dashboard structure and user journey
→ Visual design specification
→ Input for the Build Readiness phase
```

## What This Phase Covers

This folder contains templates used to design the future Power BI report before implementation.

The goal is to define:

- the functional behavior of the dashboard;
- the dashboard pages and their purpose;
- the user journey through the report;
- the business questions answered by each page;
- recommended visuals for each analytical need;
- filters, slicers, interactions, drill-downs, and tooltips;
- navigation logic between pages;
- visual hierarchy and layout principles;
- design style, colors, typography, and formatting rules;
- readability and accessibility expectations.

## Inputs

The Dashboard Design phase starts from the output of Phase 3 — Requirements & KPI.

Typical inputs include:

- `client_requirements_specification_template.md`;
- `kpi_dictionary_template.md`;
- confirmed dashboard scope;
- validated KPI definitions;
- required filters and dimensions;
- target user groups;
- business questions;
- user needs and expected actions;
- known visual or branding expectations.

## Outputs

At the end of this phase, the expected output is a complete dashboard design package that describes how the Power BI report should be structured, navigated, and visually presented.

The main outputs are:

- `functional_specification_template.md`
- `dashboard_structure_template.md`
- `visual_design_specification_template.md`

These documents become the foundation for the next phase: **Build Readiness**.

## Templates Included

| File | Purpose |
|---|---|
| `functional_specification_template.md` | Describes how the dashboard should work from the user perspective, including pages, visuals, filters, interactions, tooltips, navigation, and functional acceptance criteria. |
| `dashboard_structure_template.md` | Defines the dashboard architecture, page order, analytical storytelling logic, user journey, and page-level layout recommendations. |
| `visual_design_specification_template.md` | Documents the visual style of the dashboard, including layout principles, color roles, typography, KPI cards, chart formatting, tables, slicers, accessibility, and design acceptance criteria. |

## How to Use This Folder

1. Start from the completed client requirements specification and KPI dictionary.
2. Use `functional_specification_template.md` to describe the expected dashboard behavior and user interactions.
3. Define each dashboard page with its purpose, target user, business questions, visuals, filters, and expected insights.
4. Use `dashboard_structure_template.md` to organize the report into a logical analytical flow.
5. Define the user journey from overview to detailed analysis.
6. Use `visual_design_specification_template.md` to document the visual style and layout principles.
7. Review the design package to ensure that each visual supports a clear business question.
8. Use the completed documents as input for the next phase: `05_build_readiness`.

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- How should the dashboard be structured?
- Which pages should the report contain?
- What is the purpose of each page?
- How should users navigate through the report?
- Which business questions should each page answer?
- Which visuals are most appropriate for each KPI or analytical need?
- Which filters, slicers, tooltips, and interactions are required?
- What should the dashboard look like?
- What design principles should guide the Power BI implementation?
- How can the report remain readable, consistent, and easy to use?

## Dashboard Design Principles

A strong dashboard design should follow several key principles:

- each page should have a clear purpose;
- each visual should answer a specific business question;
- the most important KPIs should be visible first;
- the report should guide the user from overview to detail;
- filters and interactions should support analysis, not create confusion;
- the visual hierarchy should make the dashboard easy to scan;
- design choices should improve readability and decision-making;
- colors should have consistent meaning;
- the dashboard should avoid unnecessary visual complexity.

## Key Principle

The Dashboard Design phase ensures that the Power BI report is planned before it is built.

This phase helps avoid common dashboard issues such as unclear page structure, overloaded visuals, inconsistent formatting, weak storytelling, and poor user experience. A well-designed dashboard should not only display data, but also guide users toward meaningful insights and business decisions.
