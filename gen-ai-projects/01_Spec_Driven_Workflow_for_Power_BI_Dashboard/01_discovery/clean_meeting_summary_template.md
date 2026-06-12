# Clean Meeting Summary Template

## Purpose

This document summarizes the initial client discovery meeting for a Power BI dashboard project.

It transforms raw meeting notes, transcripts, or informal stakeholder input into a structured summary that can be used in the next phases of the workflow: business framing, requirements definition, KPI clarification, dashboard design, and build readiness.

The goal is to create a reliable and traceable summary without inventing missing information.

## Source Material

| Source | Available? | Notes |
|---|---|---|
| Meeting recording | Yes / No | |
| Transcript | Yes / No | |
| Raw notes | Yes / No | |
| Initial request | Yes / No | |
| Existing dashboard examples | Yes / No | |
| Jira ticket / Email request | Yes / No | |

## 1. Meeting Context

| Field | Value |
|---|---|
| Project name | |
| Meeting date | |
| Business domain | |
| Dashboard requester | |
| Business owner | |
| Participants | |
| Analyst | |
| Meeting objective | |

## 2. Business Problem

Describe the business issue, reporting need, or decision-making gap discussed during the meeting.

```text
[Describe the business problem here]
```

## 3. Dashboard Objective

Describe the main purpose of the future Power BI dashboard.

```text
[Describe the dashboard objective here]
```

## 4. Target Users

| User group | Role | Expected usage | Notes |
|---|---|---|---|
| | | | |

## 5. Expected Decisions Supported by the Dashboard

| Decision | User group | Frequency | Required information |
|---|---|---|---|
| | | | |

## 6. Requested Dashboard Pages or Views

| Page / View | Purpose | Priority | Status |
|---|---|---|---|
| | | High / Medium / Low | Confirmed / To be confirmed |

## 7. Requested KPIs and Metrics

| KPI / Metric | Business meaning | Priority | Status |
|---|---|---|---|
| | | High / Medium / Low | Confirmed / To be confirmed |

## 8. Mentioned Data Sources

| Source | Type | Owner | Refresh frequency | Notes |
|---|---|---|---|---|
| | Database / File / System | | | |

## 9. Filters and Dimensions Mentioned

| Filter / Dimension | Purpose | Status |
|---|---|---|
| | | Confirmed / To be confirmed |

## 10. Visual Preferences

Document any visual expectations mentioned by the client.

Examples:

- preferred dashboard style;
- examples of existing reports;
- expected charts;
- need for executive overview;
- need for detailed operational view;
- corporate branding;
- export needs.

```text
[Describe visual preferences here]
```

## 11. Interactions and Navigation

Document any expectations related to dashboard interactions.

Examples:

- slicers;
- drill-down;
- drill-through;
- bookmarks;
- tooltips;
- navigation buttons;
- export to Excel;
- page-level filters;
- cross-filtering.

```text
[Describe interaction and navigation expectations here]
```

## 12. Security and Access Constraints

| Constraint | Description | Status |
|---|---|---|
| Access groups | | To be confirmed |
| Row-level security | | To be confirmed |
| Sensitive data | | To be confirmed |
| GDPR / data privacy | | To be confirmed |

## 13. Constraints and Risks

| Constraint / Risk | Description | Impact | Action needed |
|---|---|---|---|
| | | High / Medium / Low | |

## 14. Confirmed Decisions

| Decision | Confirmed by | Notes |
|---|---|---|
| | | |

## 15. Assumptions

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

## 16. Open Questions

| Question | Owner | Priority | Required before next phase? |
|---|---|---|---|
| | | High / Medium / Low | Yes / No |

## 17. Recommended Next Steps

1. Confirm the clean meeting summary with the requester if needed.
2. Clarify blocking open questions.
3. Move to Phase 2 — Business Framing.
4. Create the dashboard business brief.
5. Prepare the first version of the client requirements specification.

## Generative AI Prompt — Create Clean Meeting Summary

```text
You are a senior business analyst and Power BI consultant.

I will provide raw notes or a transcript from a discovery meeting for a Power BI dashboard project.

Your task is to create a structured clean meeting summary.

Rules:
- Do not invent information.
- If something is unclear, mark it as "To be confirmed".
- Separate confirmed information, assumptions, risks, and open questions.
- Preserve business meaning and stakeholder intent.
- Use clear and professional wording.
- Prepare the output so it can be reused in the next workflow phase.
- Separate KPIs from filters, dimensions, and data sources.
- Keep all open questions visible and actionable.

Output structure:
1. Meeting context
2. Business problem
3. Dashboard objective
4. Target users
5. Expected decisions
6. Requested pages or views
7. Requested KPIs and metrics
8. Mentioned data sources
9. Filters and dimensions
10. Visual preferences
11. Interactions and navigation
12. Security and access constraints
13. Constraints and risks
14. Confirmed decisions
15. Assumptions
16. Open questions
17. Recommended next steps

Input:
[paste raw notes or transcript here]
```

## Generative AI Prompt — Review the Summary

```text
You are a senior BI project reviewer.

Review the following clean meeting summary for a Power BI dashboard project.

Check whether:
1. The business problem is clear.
2. The dashboard objective is explicit.
3. Target users are identified.
4. Expected business decisions are described.
5. KPIs are separated from dimensions and filters.
6. Confirmed facts are separated from assumptions.
7. Open questions are visible.
8. Risks and constraints are documented.
9. Security and access constraints are mentioned if relevant.
10. The summary is ready to be used in the Business Framing phase.

Return:
- readiness score from 0 to 100%;
- blocking issues;
- non-blocking issues;
- missing information;
- recommended next steps.

Clean meeting summary:
[paste summary here]
```

## Human Validation Checklist

Before moving to Phase 2, verify that:

- the summary reflects the actual client conversation;
- no AI-generated assumptions are presented as facts;
- business objective and problem are clearly separated;
- KPI names are accurate;
- missing KPI definitions are marked as `To be confirmed`;
- data sources are listed only if mentioned;
- open questions are actionable;
- risks and constraints are visible;
- sensitive or confidential information is removed if needed;
- the document is ready to support Business Framing.

## Output of This Phase

The completed clean meeting summary becomes the official input for:

- `02_business_framing/dashboard_business_brief_template.md`;
- future client requirements;
- KPI dictionary preparation;
- dashboard structure and design.
