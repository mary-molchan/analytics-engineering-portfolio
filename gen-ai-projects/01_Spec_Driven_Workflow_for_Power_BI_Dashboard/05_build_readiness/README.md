# Phase 5 — Build Readiness

## Purpose

The **Build Readiness** phase prepares the Power BI dashboard project for implementation.

Its purpose is to convert the validated dashboard design into a build-ready package that can be used to start the Power BI development phase with a clear scope, technical expectations, task backlog, validation criteria, and client confirmation.

This phase ensures that the project does not move into Power BI Desktop too early. Before the build begins, the report structure, expected data model, required measures, visuals, filters, interactions, risks, open questions, and acceptance criteria should be clearly documented.

## Process Overview

```text
Dashboard structure and visual design
→ Technical Power BI specification
→ Build backlog
→ Pre-build validation review
→ Ready to build?
    → Yes: Client confirmation
    → No: Clarify or rework requirements
→ Power BI build phase
```

## What This Phase Covers

This folder contains templates used to prepare the dashboard project for implementation.

The goal is to define:

- the technical Power BI requirements;
- the expected report pages and visuals;
- the required fields, tables, relationships, and DAX measures;
- the report filters, slicers, and interactions;
- the expected refresh logic and security requirements;
- the implementation backlog;
- task priorities, dependencies, and done criteria;
- pre-build validation checks;
- remaining blockers or open questions;
- the final client confirmation before development starts.

## Inputs

The Build Readiness phase starts from the output of Phase 4 — Dashboard Design.

Typical inputs include:

- `functional_specification_template.md`;
- `dashboard_structure_template.md`;
- `visual_design_specification_template.md`;
- validated KPI dictionary;
- confirmed dashboard pages;
- expected visuals and interactions;
- required filters and dimensions;
- design principles and layout expectations;
- known technical constraints;
- open questions from previous phases.

## Outputs

At the end of this phase, the expected output is a complete build-ready package for the Power BI implementation phase.

The main outputs are:

- `technical_powerbi_specification_template.md`
- `build_backlog_template.md`
- `pre_build_validation_checklist.md`
- `client_confirmation_message_template.md`

These documents prepare the project for the next step: **Power BI Build Phase**.

## Templates Included

| File | Purpose |
|---|---|
| `technical_powerbi_specification_template.md` | Documents the Power BI technical requirements, including expected tables, fields, relationships, DAX measures, filters, refresh requirements, security, performance expectations, and deployment needs. |
| `build_backlog_template.md` | Converts the specifications into an actionable implementation backlog with tasks, priorities, dependencies, estimated effort, owners, and done criteria. |
| `pre_build_validation_checklist.md` | Reviews whether the project is ready to move into the Power BI build phase and identifies blockers, missing information, risks, and required actions. |
| `client_confirmation_message_template.md` | Provides a structured message to confirm the final requirements, scope, KPIs, pages, and next steps with the client before implementation begins. |

## How to Use This Folder

1. Start from the completed dashboard design package created during the Dashboard Design phase.
2. Use `technical_powerbi_specification_template.md` to document the Power BI-specific implementation requirements.
3. Define the expected report pages, required fields, measures, slicers, interactions, refresh needs, and security rules.
4. Use `build_backlog_template.md` to translate the specifications into concrete implementation tasks.
5. Identify dependencies, priorities, owners, effort estimates, and done criteria for each task.
6. Use `pre_build_validation_checklist.md` to assess whether the project is ready for the build phase.
7. If the validation result is `Go`, prepare the final confirmation message for the client.
8. If the validation result is `Conditional Go` or `No-Go`, clarify or rework the missing requirements before starting implementation.
9. Use `client_confirmation_message_template.md` to confirm the final scope and next steps with the client.
10. Start the Power BI build phase only after the key requirements and blockers have been addressed.

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- Is the dashboard project ready to be built in Power BI?
- Are the functional and visual requirements clear enough?
- Are the expected report pages and visuals defined?
- Are the required fields, measures, filters, and interactions documented?
- Are there any unresolved KPI or data questions?
- Are there any technical blockers?
- Are the implementation tasks clearly defined?
- Are priorities and dependencies understood?
- Has the client confirmed the scope before the build starts?
- Should the project move forward, move forward conditionally, or return to requirement clarification?

## Readiness Decision

The pre-build validation should result in one of three possible decisions:

| Decision | Meaning |
|---|---|
| `Go` | The project is ready to move into the Power BI build phase. |
| `Conditional Go` | The build can start, but some non-blocking questions or risks must still be clarified. |
| `No-Go` | The project is not ready for implementation and must return to requirements clarification or rework. |

## Build Readiness Principles

A Power BI project should move into implementation only when:

- the business objective is clear;
- the target users are defined;
- the dashboard pages are documented;
- the main KPIs are defined or clearly marked as `To be confirmed`;
- required filters and dimensions are listed;
- major open questions are visible;
- functional requirements are documented;
- technical expectations are understood;
- implementation tasks are organized;
- acceptance criteria are defined;
- the client has confirmed the scope or pending clarifications.

## Key Principle

The Build Readiness phase protects the project from premature implementation.

Starting the Power BI build before requirements, KPIs, visuals, technical expectations, and validation criteria are clear often leads to rework, inconsistent dashboards, unclear ownership, and client dissatisfaction.

This phase ensures that the dashboard enters development with a structured, validated, and traceable specification package.
