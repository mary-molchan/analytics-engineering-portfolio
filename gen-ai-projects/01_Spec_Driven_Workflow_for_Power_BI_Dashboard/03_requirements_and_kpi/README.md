# Phase 3. Requirements & KPI.

## Purpose

The **Requirements & KPI** phase transforms the business brief into a structured set of dashboard requirements and measurable indicators.

Its purpose is to formalize what the Power BI dashboard must contain, which KPIs it should display, how those KPIs are defined, and which filters, dimensions, and business rules are required to make the report useful and reliable.

This phase acts as the bridge between business understanding and dashboard design. It ensures that the project does not move into visual design or Power BI implementation before the client requirements and KPI logic are clearly documented.

## Process Overview

```text
Validated Business Brief
→ GenAI prompt for requirements
→ Client Requirements Specification
→ GenAI prompt for KPI dictionary
→ KPI Dictionary
→ Input for Dashboard Design phase
```

## What This Phase Covers

This folder contains templates used to document the client’s functional expectations and define the analytical content of the future dashboard.

The goal is to clarify:

- the confirmed dashboard scope;
- the target users and their reporting needs;
- the required dashboard pages;
- the mandatory and optional KPIs;
- the business definition of each KPI;
- KPI calculation logic, if already known;
- the required filters and dimensions;
- the expected level of detail;
- business rules and exclusions;
- KPI ownership and validation rules;
- open questions, risks, and assumptions.

## Inputs

The Requirements & KPI phase starts from the output of Phase 2 — Business Framing.

Typical inputs include:

- `dashboard_business_brief_template.md`;
- confirmed dashboard objective;
- target user groups;
- key business questions;
- expected business decisions supported by the dashboard;
- initial list of metrics or KPIs mentioned by the client;
- known data sources or business domains;
- assumptions and open questions from the previous phases.

## Outputs

At the end of this phase, the expected output is a clear and validated requirements package that can be used to design the dashboard structure, user journey, visuals, and Power BI report logic.

The main outputs are:

- `client_requirements_specification_template.md`
- `kpi_dictionary_template.md`

These documents become the foundation for the next phase: **Dashboard Design**.

## Templates Included

| File | Purpose |
|---|---|
| `client_requirements_specification_template.md` | Documents the client’s dashboard requirements, including scope, target users, expected pages, filters, dimensions, constraints, and acceptance criteria. |
| `kpi_dictionary_template.md` | Defines each KPI used in the dashboard, including business definition, formula status, granularity, time logic, filters, exclusions, owner, validation rules, and open questions. |

## How to Use This Folder

1. Start from the completed business brief created during the Business Framing phase.
2. Use `client_requirements_specification_template.md` to formalize the client’s expectations.
3. Define the required dashboard pages, filters, dimensions, user needs, and acceptance criteria.
4. Use `kpi_dictionary_template.md` to document all KPIs requested for the dashboard.
5. For each KPI, clarify the business definition, calculation logic, owner, granularity, format, and validation rule.
6. Mark any missing or uncertain information as `To be confirmed`.
7. Review the requirements and KPI dictionary with the client or KPI owner before moving to dashboard design.
8. Use the completed documents as input for the next phase: `04_dashboard_design`.

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- What exactly should the dashboard contain?
- Which pages are required?
- Which KPIs are mandatory and which are optional?
- How is each KPI defined from a business perspective?
- Who owns or validates each KPI?
- What filters and dimensions are required?
- What level of detail should users be able to access?
- What assumptions or open questions remain?
- What criteria will be used to validate the dashboard?

## KPI Definition Principles

Each KPI should be documented with enough detail to avoid ambiguity during dashboard design and implementation.

A good KPI definition should include:

- business meaning;
- calculation formula or formula status;
- granularity;
- time logic;
- filters applied;
- exclusions;
- expected Power BI format;
- visual usage;
- validation rule;
- business owner;
- open questions.

If a KPI formula is not clearly confirmed, it should not be invented. It should be marked as `To be confirmed`.

## Key Principle

The Requirements & KPI phase protects the dashboard from ambiguity.

A dashboard can only be reliable if its requirements and KPIs are clearly defined before the visual design begins. This phase ensures that the future Power BI report is based on validated business logic, consistent metric definitions, and a clear understanding of what users need to see and why.
