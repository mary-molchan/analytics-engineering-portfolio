# Phase 1 — Discovery

## Purpose

The **Discovery** phase is the starting point of the Power BI dashboard creation workflow. Its purpose is to capture the initial client request, collect business context, and transform raw meeting input into a structured and usable summary.

This phase helps ensure that the dashboard project does not start from vague or incomplete requirements. Instead, the client conversation is converted into clear working material that can be used in the next phases: business framing, requirements definition, KPI clarification, dashboard design, and build readiness.

## Process Overview

```text
Client meeting
→ Meeting recording or working notes
→ Raw notes template
→ Clean meeting summary
→ Input for the Business Framing phase
```

## What This Phase Covers

This folder contains templates and guidance for preparing, conducting, and structuring the initial discovery meeting with the dashboard requester or business stakeholders.

The goal is to identify:

- the business context of the dashboard;
- the main objective of the report;
- the target users and their decision-making needs;
- the expected dashboard pages or analytical views;
- the first list of requested KPIs and metrics;
- mentioned data sources;
- expected filters, dimensions, and interactions;
- open questions, assumptions, risks, and constraints.

## Inputs

The Discovery phase can start from one or several of the following inputs:

- a live meeting with the client or business owner;
- a video conference recording;
- a meeting transcript;
- handwritten or digital working notes;
- an initial business request;
- a Jira ticket, email, or informal dashboard request.

## Outputs

At the end of this phase, the expected output is a structured summary of the discovery meeting, separating confirmed information from assumptions and open questions.

The main output is:

- `clean_meeting_summary_template.md`

This document becomes the foundation for the next phase: **Business Framing**.

## Templates Included

| File | Purpose |
|---|---|
| `discovery_meeting_checklist.md` | Provides a structured list of questions to guide the client discovery meeting. |
| `raw_notes_template.md` | Captures unstructured meeting notes, transcript excerpts, decisions, and open points. |
| `clean_meeting_summary_template.md` | Converts raw meeting material into a clean, structured summary ready for analysis. |

## How to Use This Folder

1. Use `discovery_meeting_checklist.md` before and during the meeting to guide the conversation.
2. Capture the discussion in `raw_notes_template.md` or paste the meeting transcript into it.
3. Transform the raw material into `clean_meeting_summary_template.md`.
4. Review the summary manually to remove ambiguity and avoid unsupported assumptions.
5. Use the clean summary as input for the next phase: `02_business_framing`.

## Key Principle

The Discovery phase is not about designing the dashboard immediately. It is about understanding the business need before moving to specifications, KPIs, visuals, and Power BI implementation.

A good discovery phase reduces misunderstandings, prevents unnecessary rework, and ensures that the final dashboard supports real business decisions.
