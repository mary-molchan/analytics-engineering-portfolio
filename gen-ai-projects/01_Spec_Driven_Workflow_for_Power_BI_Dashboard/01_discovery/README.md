# Phase 1. Discovery.

![Phase](https://img.shields.io/badge/Phase_1-Discovery-2E8B57?style=for-the-badge)
![Focus](https://img.shields.io/badge/Focus-Business_Discovery-blue?style=for-the-badge)
![GenAI](https://img.shields.io/badge/GenAI-Assisted-purple?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Workflow_Phase-green?style=for-the-badge)

## Purpose

The **Discovery** phase is the starting point of the Power BI dashboard creation workflow.

Its purpose is to prepare and conduct the initial client discovery meeting, capture raw business input, and transform unstructured meeting material into a clean and structured summary that can be reused in the next phases of the project.

This phase ensures that the dashboard project does not start from vague or incomplete requirements. Instead, the client conversation is guided, documented, supported by Generative AI prompts, and manually reviewed before moving to business framing, requirements definition, KPI clarification, dashboard design, and build readiness.

---

## Process Overview

```text
Discovery meeting checklist
→ Optional GenAI customization of the checklist
→ Client meeting
→ Raw notes and transcript capture
→ GenAI conversion prompt
→ Clean meeting summary
→ Human review
→ Input for the Business Framing phase
```

---

## What This Phase Covers

This folder contains two types of files:

1. **Artifact templates** — documents used to prepare, capture, and structure the discovery meeting output.
2. **Generative AI prompt files** — reusable prompts used to customize the checklist and transform raw meeting material into a clean summary.

The goal is to identify and document:

- the business context of the dashboard;
- the main objective of the report;
- the business problem or decision-making gap;
- the target users and their needs;
- the key business questions the dashboard should answer;
- the first list of requested KPIs and metrics;
- mentioned data sources;
- expected filters, dimensions, pages, and views;
- visual and UX expectations;
- security, access, refresh, and maintenance constraints;
- confirmed decisions, assumptions, risks, and open questions.

---

## Inputs

The Discovery phase can start from one or several of the following inputs:

- a live meeting with the client or business owner;
- a video conference recording;
- a meeting transcript;
- handwritten or digital working notes;
- answers collected during a discovery workshop;
- an initial business request;
- a Jira ticket, email, or informal dashboard request;
- screenshots, examples, Excel reports, or existing dashboards.

---

## Outputs

At the end of this phase, the expected output is a structured and reviewed meeting summary that separates confirmed information, assumptions, risks, constraints, and open questions.

The main output is:

- [`05_clean_meeting_summary_template.md`](./05_clean_meeting_summary_template.md)

This document becomes the official input for the next phase: **Business Framing**.

---

## Files Included

| File | Type | Purpose |
|---|---|---|
| [`01_discovery_meeting_checklist.md`](./01_discovery_meeting_checklist.md) | Artifact template | Provides a complete set of structured discovery questions grouped by topic. It is used before and during the client meeting to guide the conversation and ensure that all important business, functional, data, visual, security, and validation topics are covered. |
| [`02_gen_ai_prompt_customize_checklist.md`](./02_gen_ai_prompt_customize_checklist.md) | GenAI prompt | Contains a reusable Generative AI prompt for adapting the discovery checklist to a specific business domain, stakeholder context, dashboard objective, or project situation. This keeps the checklist flexible while preserving a structured discovery approach. |
| [`03_raw_notes_template.md`](./03_raw_notes_template.md) | Artifact template | Provides a working space to capture the raw output of the discovery meeting: meeting notes, transcript excerpts, answers to checklist questions, quick captures, decisions, open questions, risks, constraints, and follow-up actions. This file stores the original meeting material before it is cleaned and structured. |
| [`04_gen_ai_prompt_convert_raw_into_clean.md`](./04_gen_ai_prompt_convert_raw_into_clean.md) | GenAI prompt | Contains a detailed Generative AI prompt that transforms raw notes, transcript excerpts, and checklist answers into a structured clean meeting summary. It instructs the model to separate confirmed facts, assumptions, risks, KPIs, data sources, filters, dimensions, open questions, and readiness for the next phase. |
| [`05_clean_meeting_summary_template.md`](./05_clean_meeting_summary_template.md) | Artifact template | Provides the structured target format for the cleaned meeting summary. It contains the fields expected from the Generative AI output generated from the raw notes: meeting context, initial request, business problem, dashboard objective, target users, decisions, KPIs, data sources, filters, visual expectations, assumptions, risks, open questions, and readiness for Phase 2. |

---

## How to Use This Folder

1. Start with [`01_discovery_meeting_checklist.md`](./01_discovery_meeting_checklist.md) before the meeting.
2. If the project context is specific, use [`02_gen_ai_prompt_customize_checklist.md`](./02_gen_ai_prompt_customize_checklist.md) to adapt the checklist to the business domain, audience, and known dashboard objective.
3. Use the checklist to prepare the discussion and make sure all critical discovery topics are covered.
4. During or immediately after the meeting, capture the raw material in [`03_raw_notes_template.md`](./03_raw_notes_template.md).
5. Paste meeting notes, transcript excerpts, stakeholder answers, decisions, risks, constraints, and open questions into the raw notes document.
6. Use [`04_gen_ai_prompt_convert_raw_into_clean.md`](./04_gen_ai_prompt_convert_raw_into_clean.md) to transform the raw material into a structured clean meeting summary.
7. Copy the generated output into [`05_clean_meeting_summary_template.md`](./05_clean_meeting_summary_template.md).
8. Review the clean summary manually to remove ambiguity, correct possible AI mistakes, and make sure no unsupported assumptions are presented as facts.
9. Use the validated clean meeting summary as input for the next phase: [`02_business_framing`](../02_business_framing/).

---

## Role of Generative AI in This Phase

Generative AI is used to support the analyst in customizing, structuring, and cleaning discovery material.

In this phase, Generative AI helps to:

- adapt the discovery checklist to a specific business context;
- transform raw notes and transcript excerpts into a structured summary;
- separate confirmed information from assumptions;
- identify missing information and open questions;
- organize KPIs, data sources, filters, dimensions, risks, and constraints;
- prepare a clean output that can be reused in the next workflow phase.

The Generative AI prompts are stored in separate files to make them easier to reuse, version, adapt, and improve independently from the project artifact templates.

Generative AI does not replace the analyst’s judgment. The analyst remains responsible for reviewing, validating, correcting, and approving the final clean meeting summary.

---

## Human-in-the-Loop Validation

Before moving to Phase 2, the analyst must verify that:

- the clean summary reflects the actual client conversation;
- no AI-generated assumptions are presented as confirmed facts;
- the dashboard objective is clear;
- the business problem is explicitly documented;
- target users are identified;
- KPIs are not confused with filters, dimensions, or data sources;
- missing KPI definitions are marked as `To be confirmed`;
- data sources are listed only if they were mentioned;
- sensitive or confidential information is removed or flagged;
- open questions are visible and actionable;
- blocking issues are clearly identified.

---

## Key Principle

The Discovery phase is not about designing the dashboard immediately.

It is about understanding the business need, capturing the original stakeholder input, and creating a reliable foundation for the next phases of the Power BI dashboard workflow.

A strong Discovery phase reduces misunderstandings, prevents unnecessary rework, improves stakeholder alignment, and ensures that the final dashboard supports real business decisions.
