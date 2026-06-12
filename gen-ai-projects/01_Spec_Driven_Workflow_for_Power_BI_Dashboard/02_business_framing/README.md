# Phase 2. Business Framing

## Purpose

The **Business Framing** phase transforms the structured discovery output into a clear business-oriented brief for the future Power BI dashboard.

Its purpose is to clarify why the dashboard is needed, who will use it, what decisions it should support, and which business questions it must answer. This phase ensures that the dashboard is designed as a decision-making tool, not just as a collection of visuals.

The main objective is to convert the clean meeting summary from the Discovery phase into a well-defined dashboard business brief that can guide requirements, KPI definition, dashboard structure, and visual design.

## Process Overview

```text
Clean meeting summary
→ Dashboard business brief
→ Business objective
→ Target users
→ Key business questions
→ Input for the Requirements & KPI phase
```

## What This Phase Covers

This folder contains the template used to structure the business context of the dashboard before moving into detailed requirements and KPI definition.

The goal is to define:

- the business domain covered by the dashboard;
- the business problem or opportunity behind the request;
- the main dashboard objective;
- the target audience and user groups;
- the decisions the dashboard should support;
- the key business questions the dashboard must answer;
- the expected business value;
- the project scope;
- assumptions, constraints, risks, and open questions.

## Inputs

The Business Framing phase starts from the output of Phase 1 — Discovery.

Typical inputs include:

- `clean_meeting_summary_template.md`;
- structured meeting notes;
- confirmed business context;
- initial dashboard expectations;
- first list of requested KPIs or analytical views;
- stakeholder comments and open questions.

## Outputs

At the end of this phase, the expected output is a structured business brief that explains the purpose and expected value of the Power BI dashboard.

The main output is:

- `dashboard_business_brief_template.md`

This document becomes the foundation for the next phase: **Requirements & KPI**.

## Template Included

| File | Purpose |
|---|---|
| `dashboard_business_brief_template.md` | Defines the business context, dashboard objective, target users, supported decisions, key business questions, scope, expected value, risks, and assumptions. |

## How to Use This Folder

1. Start from the clean meeting summary created during the Discovery phase.
2. Use `dashboard_business_brief_template.md` to formalize the business context of the dashboard.
3. Identify the main business objective and the problem the dashboard is expected to solve.
4. Define the target users and describe how each user group will interact with the dashboard.
5. Translate the client request into clear business questions.
6. Clarify which decisions the dashboard should support.
7. Document assumptions, risks, constraints, and open questions.
8. Use the completed business brief as input for the next phase: `03_requirements_and_kpi`.

## Key Questions Answered in This Phase

This phase should help answer the following questions:

- What business problem is the dashboard designed to solve?
- Who will use the dashboard?
- What decisions should users be able to make with it?
- Which business questions should the dashboard answer?
- What is included in the dashboard scope?
- What is explicitly out of scope?
- What value should the dashboard bring to the business?
- What risks or assumptions must be clarified before defining KPIs and requirements?

## Key Principle

The Business Framing phase prevents the dashboard from becoming a purely visual or technical deliverable.

Before defining KPIs, visuals, pages, or Power BI implementation details, the project must have a clear business purpose. A strong business framing phase ensures that the final dashboard is aligned with real user needs, business priorities, and decision-making processes.
