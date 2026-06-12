# Phase 5. Build Readiness.

![Phase](https://img.shields.io/badge/Phase_5-Build_Readiness-DC143C?style=for-the-badge)
![Focus](https://img.shields.io/badge/Focus-Implementation_Readiness-blue?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-Assisted-purple?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Workflow_Phase-green?style=for-the-badge)

## Purpose

The **Build Readiness** phase prepares the Power BI dashboard project for implementation.

Its purpose is to convert the validated dashboard design package into a concise, technical, and actionable build-ready package that can be used by a Power BI developer to start the implementation phase with a clear scope, backlog, validation criteria, blockers, and client confirmation.

This phase ensures that the project does not move into Power BI Desktop too early. Before development starts, the dashboard structure, visual design, KPI implementation needs, data and model readiness, refresh expectations, security requirements, dependencies, and remaining open points must be clearly documented.

Generative AI is used in this phase to help transform validated design documentation into a developer-oriented readiness package and then prepare a stakeholder-facing confirmation message before the build starts.

---

## Process Overview

```text
Validated Dashboard Design Specification
+ Validated Visual Design Specification
→ GenAI prompt to create Build Readiness Package
→ Build Readiness Package
→ GenAI prompt to create Client Confirmation Message
→ Client Confirmation Message
→ Power BI build phase
```

## What This Phase Covers

This folder contains prompt files and artifact templates used to prepare the dashboard project for implementation.

The goal is to define and validate:

- technical Power BI preparation needs;
- dataset and semantic model readiness;
- required tables, fields, relationships, and date logic;
- KPI and measure implementation readiness;
- report page build tasks;
- visual, table, matrix, slicer, tooltip, and interaction build tasks;
- security, access, and row-level security requirements;
- refresh, gateway, workspace, and deployment expectations;
- implementation backlog;
- pre-build validation checks;
- blockers, dependencies, and required clarifications;
- final Go / Conditional Go / No-Go readiness decision;
- client confirmation before the Power BI build phase starts.

---

## Inputs

The Build Readiness phase starts from the validated outputs of Phase 4 — Dashboard Design.

Main inputs:

- [`../04_dashboard_design/02_dashboard_design_specification_template.md`](../04_dashboard_design/02_dashboard_design_specification_template.md)
- [`../04_dashboard_design/04_visual_design_specification_template.md`](../04_dashboard_design/04_visual_design_specification_template.md)

Optional supporting inputs:

- [`../03_requirements_and_kpi/02_client_requirements_specification_template.md`](../03_requirements_and_kpi/02_client_requirements_specification_template.md)
- [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md)

Typical input content includes:

- confirmed dashboard pages;
- validated visual components;
- required KPI groups and metrics;
- filters, slicers, interactions, and navigation rules;
- tables, matrices, charts, and detailed views;
- data and model dependencies;
- access and security constraints;
- refresh expectations;
- open design or KPI questions;
- known implementation risks.

---

## Outputs

At the end of this phase, the expected output is a validated build-ready package and a client-facing confirmation message.

Main outputs:

- [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md)
- [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md)

The final result of this phase is:

- a consolidated internal implementation readiness package;
- a stakeholder-facing confirmation message;
- a clear decision on whether the project is ready to move into the Power BI build phase.

---

## Files Included

| File | Type | Purpose |
|---|---|---|
| [`01_gen_ai_prompt_create_build_readiness_package.md`](./01_gen_ai_prompt_create_build_readiness_package.md) | GenAI prompt | Transforms the validated dashboard design package into a concise Build Readiness Package. It focuses on technical Power BI preparation, data and model readiness, KPI and measure implementation, report build tasks, backlog, validation checks, blockers, dependencies, and readiness decision. |
| [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md) | Artifact template | Provides the target structure for the internal Build Readiness Package. It consolidates technical preparation, implementation backlog, pre-build validation, blockers, required clarifications, accepted risks, and the Go / Conditional Go / No-Go decision. |
| [`03_gen_ai_prompt_create_client_confirmation_message.md`](./03_gen_ai_prompt_create_client_confirmation_message.md) | GenAI prompt | Creates a concise stakeholder-facing confirmation message from the Build Readiness Package. It confirms scope, dashboard areas, KPI groups, design direction, open points, accepted risks, and approval to start the Power BI build phase. |
| [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md) | Artifact template | Provides the target format for the final client confirmation message. It can be reused in an email, Teams message, project ticket, or client validation note before implementation starts. |

---

## How to Use This Folder

1. Start from the validated Phase 4 outputs: [`../04_dashboard_design/02_dashboard_design_specification_template.md`](../04_dashboard_design/02_dashboard_design_specification_template.md) and [`../04_dashboard_design/04_visual_design_specification_template.md`](../04_dashboard_design/04_visual_design_specification_template.md).
2. Use [`01_gen_ai_prompt_create_build_readiness_package.md`](./01_gen_ai_prompt_create_build_readiness_package.md) to generate the Build Readiness Package.
3. Copy the generated output into [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md).
4. Review the package manually from a developer perspective: data readiness, model readiness, KPI implementation, DAX needs, report pages, visuals, interactions, security, refresh, deployment, and blockers.
5. Confirm the readiness decision: `Go`, `Conditional Go`, or `No-Go`.
6. If the decision is `Go` or `Conditional Go`, use [`03_gen_ai_prompt_create_client_confirmation_message.md`](./03_gen_ai_prompt_create_client_confirmation_message.md) to generate the client confirmation message.
7. Copy the generated message into [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md).
8. Review the message manually to ensure that it is stakeholder-friendly and does not expose unnecessary internal technical details.
9. Send or reuse the confirmation message to obtain final approval before starting the Power BI build phase.
10. If the decision is `No-Go`, return to the relevant previous phase for clarification or rework.

---

## Role of Generative AI in This Phase

Generative AI is used to support the analyst and developer in preparing the project for implementation.

In this phase, Generative AI helps to:

- translate dashboard design documentation into technical build preparation;
- identify Power BI development tasks;
- structure the implementation backlog;
- detect missing technical information before build start;
- highlight blockers and dependencies;
- organize pre-build validation checks;
- separate blocking issues from non-blocking clarifications;
- formulate the Go / Conditional Go / No-Go readiness decision;
- draft a concise client confirmation message.

Generative AI does not replace developer judgment. The analyst or Power BI developer remains responsible for validating technical feasibility, confirming data access, checking KPI implementation logic, assessing security requirements, and approving the final build start.

---

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- Is the dashboard project ready to be built in Power BI?
- Are the report pages, visuals, tables, matrices, filters, and interactions clearly defined?
- Are the required data sources, fields, relationships, and date logic available or confirmed?
- Are KPI and measure implementation needs clear?
- Are DAX, Power Query, semantic model, refresh, security, and deployment topics identified where relevant?
- Are there any unresolved blockers?
- Are implementation tasks actionable for a Power BI developer?
- Are validation checks defined before build start?
- Has the client or business owner confirmed the scope and design direction?
- Should the project move forward, move forward conditionally, or return to clarification or rework?

---

## Readiness Decision

The Build Readiness Package should result in one of three possible decisions:

| Decision | Meaning |
|---|---|
| `Go` | The project is ready to move into the Power BI build phase. |
| `Conditional Go` | The build can start, but some non-blocking questions, risks, or confirmations must still be tracked. |
| `No-Go` | The project is not ready for implementation and must return to clarification or rework. |

---

## Build Readiness Principles

A Power BI project should move into implementation only when:

- the dashboard scope is clear;
- the dashboard pages are validated;
- the main visuals, tables, matrices, filters, and interactions are defined;
- KPI and measure implementation needs are understood;
- required data sources and fields are confirmed or clearly marked as `To be confirmed`;
- semantic model, relationships, date logic, and refresh expectations are understood;
- access, security, and row-level security needs are identified where relevant;
- implementation tasks are structured in a build backlog;
- blockers and dependencies are visible;
- the client has confirmed the validated scope or accepted remaining non-blocking risks.

---

## Human-in-the-Loop Validation

Before starting the Power BI build phase, the analyst or developer must verify that:

- no technical requirement was invented by Generative AI;
- all build tasks are supported by validated design documentation;
- KPI implementation needs are linked to validated KPI definitions;
- data and model readiness are realistically assessed;
- security and refresh expectations are not assumed;
- blockers are clearly separated from non-blocking clarifications;
- the readiness decision is justified;
- the client confirmation message reflects the validated scope accurately;
- the project is ready to move into actual Power BI development.

---

## Key Principle

The Build Readiness phase protects the project from premature implementation.

Starting the Power BI build before scope, KPIs, visuals, technical expectations, data readiness, and validation criteria are clear often leads to rework, inconsistent dashboards, unclear ownership, and stakeholder dissatisfaction.

This phase ensures that the dashboard enters development with a structured, validated, and traceable build-ready package.
