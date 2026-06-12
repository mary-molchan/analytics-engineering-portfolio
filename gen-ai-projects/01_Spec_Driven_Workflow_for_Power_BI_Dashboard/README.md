##  Spec-Driven Workflow for Power BI Dashboard Creation (EN version)

![Project](https://img.shields.io/badge/Project-Spec_Driven_Workflow-7B61FF?style=for-the-badge)
![Scope](https://img.shields.io/badge/Scope-End_to_End_Workflow-blue?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-Assisted-purple?style=for-the-badge)
![Output](https://img.shields.io/badge/Output-Build_Ready_Specification-green?style=for-the-badge)

## Project Overview

This project presents a **Generative AI-assisted, spec-driven workflow for creating a Power BI dashboard from scratch**.

The workflow starts from an initial client discovery meeting and transforms unstructured business input — such as meeting notes, transcripts, stakeholder comments, or dashboard requests — into a complete, structured, and build-ready Power BI specification package.

The main purpose of this project is to demonstrate how **Generative AI can support and accelerate the early stages of BI dashboard delivery** by helping the analyst structure client requirements, clarify business objectives, define KPIs, design the dashboard logic, prepare documentation, and validate readiness before implementation.

This workflow does not replace the BI analyst or Power BI developer. Instead, it positions Generative AI as an assistant for:

- structuring raw meeting notes and transcripts;
- extracting business context and decision-making needs;
- drafting client requirements specifications;
- identifying open questions and assumptions;
- supporting KPI definition and validation;
- drafting functional and visual design specifications;
- preparing technical Power BI documentation;
- generating a build backlog;
- supporting pre-build validation and client confirmation.

The analyst remains responsible for reviewing, validating, correcting, and approving all AI-generated outputs. This makes the workflow suitable for a professional BI context where traceability, human oversight, business alignment, and quality control are essential.

The goal of this project is to reduce ambiguity, prevent unnecessary rework, improve stakeholder communication, and demonstrate how Generative AI can be integrated into a structured analytics engineering workflow.


## Workflow Phases

| Phase | Folder | Description |
|---|---|---|
| **Phase 1 - Discovery** | [`01_discovery`](./01_discovery/) | Captures the initial client request through a meeting, transcript, or working notes and converts raw input into a structured meeting summary. |
| **Phase 2 - Business Framing** | [`02_business_framing`](./02_business_framing/) | Clarifies the business context, dashboard objective, target users, decision-making needs, and key business questions. |
| **Phase 3 - Requirements & KPI** | [`03_requirements_and_kpi`](./03_requirements_and_kpi/) | Formalizes client requirements, required dashboard pages, KPIs, filters, dimensions, business rules, and validation expectations. |
| **Phase 4 - Dashboard Design** | [`04_dashboard_design`](./04_dashboard_design/) | Defines the dashboard structure, user journey, functional behavior, page logic, visuals, interactions, and visual design principles. |
| **Phase 5 - Build Readiness** | [`05_build_readiness`](./05_build_readiness/) | Prepares the project for Power BI implementation through a technical specification, build backlog, pre-build validation, and client confirmation. |

## Repository Structure

```text
01_Spec_Driven_Workflow_for_Power_BI_Dashboard/
│
├── 01_discovery/
│   ├── README.md
│   ├── discovery_meeting_checklist.md
│   ├── raw_notes_template.md
│   └── clean_meeting_summary_template.md
│
├── 02_business_framing/
│   ├── README.md
│   └── dashboard_business_brief_template.md
│
├── 03_requirements_and_kpi/
│   ├── README.md
│   ├── client_requirements_specification_template.md
│   └── kpi_dictionary_template.md
│
├── 04_dashboard_design/
│   ├── README.md
│   ├── functional_specification_template.md
│   ├── dashboard_structure_template.md
│   └── visual_design_specification_template.md
│
├── 05_build_readiness/
│   ├── README.md
│   ├── technical_powerbi_specification_template.md
│   ├── build_backlog_template.md
│   ├── pre_build_validation_checklist.md
│   └── client_confirmation_message_template.md
│
└── README.md
```

## How to Use This Workflow

1. Start with the **Discovery** phase to collect and structure the initial client request.
2. Use Generative AI to transform raw notes or transcripts into a clean meeting summary.
3. Move to **Business Framing** to clarify the business objective, target users, and decision-making context.
4. Use the **Requirements & KPI** phase to document what the dashboard must contain and how KPIs should be defined.
5. Continue with **Dashboard Design** to define the report structure, user journey, visuals, and design rules.
6. Complete the **Build Readiness** phase to validate whether the project is ready for Power BI implementation.
7. Review and validate every AI-generated artifact manually before using it as a project deliverable.

Each phase contains reusable Markdown templates that can be adapted to real BI projects, client workshops, internal reporting initiatives, or portfolio case studies.

## Human-in-the-Loop Principle

This project follows a **human-in-the-loop approach**.

Generative AI is used to accelerate drafting, structuring, summarizing, and documentation tasks. However, all outputs must be reviewed by a human analyst before being shared with stakeholders or used for implementation.

The BI analyst remains responsible for:

- validating business meaning;
- checking KPI definitions;
- identifying missing or ambiguous requirements;
- confirming assumptions with stakeholders;
- ensuring that the dashboard supports real business decisions;
- approving the final specification package before the build phase.

## Workflow Diagram

```mermaid
flowchart TD

    subgraph P1[Phase 1 — Discovery]
        A[Client meeting] --> B[Raw notes / transcript]
        B --> C[Clean meeting summary]
    end

    subgraph P2[Phase 2 — Business framing]
        C --> D[Dashboard business brief]
        D --> E[Business objective]
        D --> F[Target users]
        D --> G[Key business questions]
    end

    subgraph P3[Phase 3 — Requirements and KPI]
        E --> H[Client requirements specification]
        F --> H
        G --> H
        H --> I[KPI dictionary]
        H --> J[Filters and dimensions]
    end

    subgraph P4[Phase 4 — Dashboard design]
        H --> K[Functional specification]
        I --> K
        K --> L[Dashboard structure and user journey]
        L --> M[Visual design specification]
    end

    subgraph P5[Phase 5 — Build readiness]
        L --> N[Technical Power BI specification]
        M --> O[Build backlog]
        N --> O
        O --> P[Pre-build validation review]
        P --> Q{Ready to build?}
        Q -->|Yes| R[Client confirmation]
        Q -->|No| S[Clarify or rework requirements]
        S --> H
        R --> T[Power BI build phase]
    end
```
