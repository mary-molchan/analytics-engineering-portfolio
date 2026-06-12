# Phase 2 — Business Framing

## Purpose

The **Business Framing** phase transforms the structured output from Phase 1 — Discovery into a clear business-oriented brief for the future Power BI dashboard.

Its purpose is to clarify why the dashboard is needed, who will use it, what decisions it should support, and which business questions it must answer.

This phase ensures that the dashboard is designed as a decision-making tool, not just as a collection of visuals or technical reports.

Generative AI is used in this phase to transform the clean meeting summary into a structured business brief and to review the quality of the business framing before moving to Requirements & KPI.

---

## Process Overview

```text
Clean meeting summary from Discovery
→ GenAI prompt to create business brief
→ Dashboard business brief
→ GenAI review prompt
→ Analyst corrections and validation
→ Input for the Requirements & KPI phase
```

---

## What This Phase Covers

This folder contains the prompt files and artifact template used to define the business framing of the dashboard before moving into detailed requirements and KPI definition.

The goal is to define:

- the business domain covered by the dashboard;
- the business problem or opportunity behind the request;
- the main dashboard purpose;
- the target audience and user groups;
- the decisions the dashboard should support;
- the key business questions the dashboard must answer;
- the expected business value;
- the project scope and out of scope;
- assumptions, constraints, risks, and open questions;
- readiness for the next phase.

---

## Inputs

The Business Framing phase starts from the validated output of Phase 1 — Discovery.

Main input:

- [`../01_discovery/05_clean_meeting_summary_template.md`](../01_discovery/05_clean_meeting_summary_template.md)

Typical input content includes:

- initial client request;
- structured business context;
- business problem or reporting gap;
- dashboard objective;
- target users;
- expected decisions;
- first list of requested KPIs or analytical views;
- mentioned data sources;
- stakeholder comments;
- assumptions, risks, constraints, and open questions.

---

## Outputs

At the end of this phase, the expected output is a validated business brief that explains the purpose, scope, expected value, and decision-making role of the Power BI dashboard.

The main output is:

- [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md)

This document becomes the foundation for the next phase:

- [`../03_requirements_and_kpi/`](../03_requirements_and_kpi/)

---

## Files Included

| File | Type | Purpose |
|---|---|---|
| [`01_gen_ai_prompt_create_business_brief.md`](./01_gen_ai_prompt_create_business_brief.md) | GenAI prompt | Contains the prompt used to transform the clean meeting summary from Discovery into a structured Dashboard Business Brief. It guides Generative AI to focus on business purpose, users, supported decisions, business questions, scope, expected value, risks, assumptions, and readiness for Phase 3. |
| [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md) | Artifact template | Provides the target structure for the Dashboard Business Brief. It contains the sections produced by the creation prompt: source information, business domain, business problem, dashboard purpose, target audience, supported decisions, business questions, expected value, scope, success criteria, assumptions, risks, open questions, and readiness for Phase 3. |
| [`03_gen_ai_prompt_review_business_brief.md`](./03_gen_ai_prompt_review_business_brief.md) | GenAI review prompt | Contains the prompt used to review the completed Dashboard Business Brief before moving to Requirements & KPI. It produces review feedback, identifies blocking and non-blocking issues, checks business clarity, and helps the analyst improve the brief. It does not create a separate final artifact. |

---

## How to Use This Folder

1. Start from the validated clean meeting summary created during Phase 1: [`../01_discovery/05_clean_meeting_summary_template.md`](../01_discovery/05_clean_meeting_summary_template.md).
2. Use [`01_gen_ai_prompt_create_business_brief.md`](./01_gen_ai_prompt_create_business_brief.md) to generate a structured Dashboard Business Brief.
3. Copy the generated output into [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md).
4. Review the generated business brief manually to ensure that no unsupported assumptions are presented as facts.
5. Use [`03_gen_ai_prompt_review_business_brief.md`](./03_gen_ai_prompt_review_business_brief.md) to assess the quality and completeness of the business framing.
6. Apply the review feedback directly to [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md).
7. Update the review status and readiness assessment inside [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md).
8. Use the validated business brief as input for the next phase: [`../03_requirements_and_kpi/`](../03_requirements_and_kpi/).

---

## Role of Generative AI in This Phase

Generative AI is used to support the analyst in transforming and reviewing business information.

In this phase, Generative AI helps to:

- convert the clean meeting summary into a business-oriented brief;
- clarify the business problem and dashboard purpose;
- structure target users and supported decisions;
- organize key business questions;
- separate scope from out of scope;
- identify assumptions, risks, constraints, and open questions;
- assess whether the project is ready to move to Requirements & KPI;
- produce review feedback before the business brief is finalized.

Generative AI does not replace the analyst’s judgment. The analyst remains responsible for validating the content, correcting mistakes, confirming assumptions, and approving the final business brief.

---

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- What business problem is the dashboard designed to solve?
- Why is the dashboard needed?
- Who will use the dashboard?
- What decisions should users be able to make with it?
- Which business questions should the dashboard answer?
- What is included in the dashboard scope?
- What is explicitly out of scope?
- What value should the dashboard bring to the business?
- What risks, constraints, or assumptions must be clarified before defining KPIs and requirements?
- Is the project ready to move to Phase 3 — Requirements & KPI?

---

## Human-in-the-Loop Validation

Before moving to Phase 3, the analyst must verify that:

- the business problem is clear;
- the dashboard purpose is explicit;
- target users are identified;
- supported decisions are documented;
- key business questions are actionable;
- scope and out of scope are separated;
- expected business value is clear;
- assumptions are not presented as confirmed facts;
- risks and constraints are visible;
- blocking open questions are clearly identified;
- the document does not include premature technical implementation details;
- the validated brief is ready for [`../03_requirements_and_kpi/`](../03_requirements_and_kpi/).

---

## Key Principle

The Business Framing phase prevents the dashboard from becoming a purely visual or technical deliverable.

Before defining KPIs, visuals, pages, data models, or Power BI implementation details, the project must have a clear business purpose.

A strong Business Framing phase ensures that the final dashboard is aligned with real user needs, business priorities, and decision-making processes.
