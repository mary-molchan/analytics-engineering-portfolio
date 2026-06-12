# Raw Notes Template

## Purpose

This document is used to capture raw input from the initial discovery meeting for a Power BI dashboard project.

It is a working document, not a final specification. Its purpose is to store the original meeting material: notes, transcript excerpts, stakeholder answers, decisions, open questions, and follow-up actions.

The raw material captured here will be transformed into a structured clean meeting summary in the next document: `03_clean_meeting_summary_template.md`.

---

## Meeting Information

| Field | Value |
|---|---|
| Project name | |
| Meeting date | |
| Meeting type | Video call / In-person / Workshop |
| Client / Business owner | |
| Main requester | |
| Participants | |
| Analyst | |
| Business domain | |
| Dashboard name, if known | |
| Recording available | Yes / No |
| Transcript available | Yes / No |
| Existing report or dashboard available | Yes / No |
| Related files or examples shared | Yes / No |
| Confidential or sensitive information discussed | Yes / No / To be confirmed |

---

## Initial Client Request

Paste or summarize the initial request as it was expressed by the client or stakeholder.

```text
[Paste the initial client request here]
```

---

## Raw Meeting Notes

Paste your raw notes from the meeting here.

These notes can be incomplete, informal, repetitive, or unstructured. The goal is to preserve the original content before cleaning and organizing it.

```text
[Paste raw meeting notes here]
```

---

## Answers Collected from the Discovery Checklist

Use this section to paste or write the answers collected during the meeting based on `01_discovery_meeting_checklist.md`.

Do not try to make this section perfect. Keep the original wording as much as possible.

```text
[Paste answers to checklist questions here]
```

---

## Transcript Excerpts

If a meeting transcript is available, paste the relevant parts here.

```text
[Paste transcript excerpts here]
```

---

## Quick Capture Section

Use this section immediately after the meeting to quickly capture the most important information before it is structured.

### Business Context

```text
[What business area, process, team, product, service, or activity does the dashboard concern?]
```

### Business Problem

```text
[What problem, pain point, reporting gap, or decision-making issue was mentioned?]
```

### Dashboard Objective

```text
[What is the expected purpose of the dashboard?]
```

### Target Users

```text
[Who will use the dashboard? Mention user groups, roles, or teams.]
```

### Key Business Questions

```text
[Which questions should the dashboard help answer?]
```

### KPIs and Metrics Mentioned

```text
[List all KPIs or metrics mentioned during the meeting, even if definitions are unclear.]
```

### Data Sources Mentioned

```text
[List systems, databases, files, applications, manual extracts, or other data sources mentioned.]
```

### Filters and Dimensions Mentioned

```text
[List filters or dimensions mentioned: date, country, region, product, client, team, status, category, etc.]
```

### Dashboard Pages or Views Mentioned

```text
[List any expected pages, sections, views, or analytical areas mentioned.]
```

### Visual or UX Expectations

```text
[List any expectations about dashboard style, examples, visuals, tables, navigation, tooltips, exports, or layout.]
```

### Security and Access Notes

```text
[List any access restrictions, confidentiality constraints, GDPR concerns, row-level security needs, or sensitive data topics.]
```

### Refresh, Usage, and Maintenance Notes

```text
[List any expectations about refresh frequency, usage frequency, maintenance, ownership, or future updates.]
```

---

## Decisions Made During the Meeting

| Decision | Confirmed by | Notes |
|---|---|---|
| | | |
| | | |

---

## Open Questions

| Question | Owner | Priority | Blocking? |
|---|---|---|---|
| | | High / Medium / Low | Yes / No |
| | | High / Medium / Low | Yes / No |

---

## Follow-Up Actions

| Action | Owner | Due date | Status |
|---|---|---|---|
| | | | Not started / In progress / Done |
| | | | Not started / In progress / Done |

---

## Risks, Constraints, or Uncertainties Mentioned

| Risk / Constraint / Uncertainty | Notes | Impact |
|---|---|---|
| | | High / Medium / Low |
| | | High / Medium / Low |

---

## Generative AI Prompt — Convert Raw Notes into a Clean Meeting Summary

Use this prompt after the meeting to transform the raw content of this document into a structured summary for `03_clean_meeting_summary_template.md`.

```text
You are a senior business analyst and Power BI consultant.

I will provide raw notes, checklist answers, and possibly transcript excerpts from a discovery meeting for a Power BI dashboard project.

Your task is to transform this raw material into a structured clean meeting summary that can be reused in the next workflow phase.

The goal is not to create a final specification yet. The goal is to clean, organize, and structure the meeting content while preserving the original business meaning.

Important rules:
1. Do not invent information.
2. Do not assume missing details.
3. If information is unclear or missing, mark it as "To be confirmed".
4. Preserve the stakeholder’s intent and business wording as much as possible.
5. Separate confirmed information from assumptions.
6. Separate KPIs, metrics, filters, dimensions, data sources, and dashboard pages.
7. Keep all open questions visible and actionable.
8. Identify blockers and non-blocking uncertainties.
9. Highlight risks, constraints, dependencies, and missing information.
10. Do not write SQL, DAX, data model logic, or technical implementation details at this stage.
11. Keep the output professional, concise, and suitable for a BI project documentation workflow.
12. If the raw material contains sensitive or personal information, flag it as "Sensitive information — review before sharing".

Use the following output structure:

# Clean Meeting Summary

## 1. Meeting Context

Summarize the meeting context.

Include:
- project name;
- meeting date, if available;
- business domain;
- requester or business owner;
- participants, if available;
- purpose of the meeting;
- source material used: notes, transcript, checklist answers, recording.

## 2. Initial Request

Summarize the initial dashboard request in clear business language.

If the request is vague, keep the original meaning and mark unclear elements as "To be confirmed".

## 3. Business Context

Summarize:
- business domain;
- process, activity, team, product, service, or department concerned;
- why the dashboard is needed now;
- current reporting situation;
- existing reports or tools mentioned.

## 4. Business Problem

Describe the business problem, pain point, reporting gap, or decision-making issue discussed during the meeting.

Separate:
- confirmed problem;
- possible interpretation;
- information to be confirmed.

## 5. Dashboard Objective

Describe the main purpose of the future Power BI dashboard.

Clarify whether the dashboard is expected to support:
- monitoring;
- reporting;
- decision-making;
- performance tracking;
- operational follow-up;
- executive overview;
- anomaly detection;
- investigation;
- replacement of manual reporting.

## 6. Target Users

Create a table with the following columns:

| User group | Role / Profile | Expected usage | Level of detail needed | Status |
|---|---|---|---|---|

Use "To be confirmed" where information is missing.

## 7. Expected Decisions Supported by the Dashboard

Create a table with the following columns:

| Decision / Action | User group | Frequency | Required information | Status |
|---|---|---|---|---|

If no explicit decisions were mentioned, list possible decision areas as "To be confirmed" and do not present them as facts.

## 8. Key Business Questions

List the business questions the dashboard should answer.

Group them if possible:
- overview questions;
- performance questions;
- trend questions;
- comparison questions;
- root cause questions;
- operational follow-up questions.

Mark unclear questions as "To be confirmed".

## 9. Requested Dashboard Pages or Views

Create a table with the following columns:

| Page / View | Purpose | Target user | Priority | Status |
|---|---|---|---|---|

Use only pages or views mentioned in the raw material. If page structure was not discussed, write "To be defined in the Dashboard Design phase".

## 10. Requested KPIs and Metrics

Create a table with the following columns:

| KPI / Metric | Business meaning | Formula mentioned? | Priority | Owner / Validator | Status |
|---|---|---|---|---|---|

Rules:
- Do not invent formulas.
- If a formula is missing, write "To be confirmed".
- If the KPI owner is missing, write "To be confirmed".
- Do not confuse KPIs with filters, dimensions, or data sources.

## 11. Mentioned Data Sources

Create a table with the following columns:

| Data source | Type | Owner | Refresh frequency | Notes | Status |
|---|---|---|---|---|---|

Examples of source types:
- database;
- Excel file;
- SharePoint file;
- CRM;
- ERP;
- data warehouse;
- API;
- manual extract;
- existing Power BI dataset;
- unknown.

Use "To be confirmed" where information is missing.

## 12. Filters and Dimensions

Create a table with the following columns:

| Filter / Dimension | Purpose | Applies to | Status |
|---|---|---|---|

Examples:
- date;
- period;
- country;
- region;
- product;
- client;
- team;
- status;
- category;
- business unit;
- project.

## 13. Visual and UX Preferences

Summarize any expectations about:
- dashboard style;
- existing examples;
- layout;
- charts;
- tables;
- executive summary;
- detailed views;
- navigation;
- tooltips;
- exports;
- branding;
- accessibility.

If nothing was mentioned, write "Not discussed".

## 14. Interactions and Navigation

Summarize any expectations about:
- slicers;
- drill-down;
- drill-through;
- bookmarks;
- navigation buttons;
- tooltips;
- cross-filtering;
- export;
- reset filters;
- page navigation.

If nothing was mentioned, write "Not discussed".

## 15. Security and Access Constraints

Summarize any information about:
- access groups;
- row-level security;
- restricted pages;
- restricted KPIs;
- sensitive data;
- personal data;
- GDPR or confidentiality constraints.

If nothing was mentioned, write "To be confirmed".

## 16. Refresh, Usage, and Maintenance

Summarize:
- expected refresh frequency;
- usage frequency;
- dashboard owner;
- maintenance owner;
- future updates;
- version 2 expectations;
- last refresh date requirement.

Use "To be confirmed" where information is missing.

## 17. Confirmed Decisions

Create a table with the following columns:

| Decision | Confirmed by | Notes |
|---|---|---|

Only include decisions clearly confirmed during the meeting.

## 18. Assumptions

Create a table with the following columns:

| Assumption | Reason | Needs confirmation? |
|---|---|---|

Do not present assumptions as confirmed facts.

## 19. Constraints, Risks, and Dependencies

Create a table with the following columns:

| Type | Description | Impact | Required action |
|---|---|---|---|

Types may include:
- data availability;
- data quality;
- unclear KPI definition;
- stakeholder availability;
- access rights;
- deadline;
- security;
- technical dependency;
- business alignment.

## 20. Open Questions

Create a table with the following columns:

| Question | Owner | Priority | Blocking? |
|---|---|---|---|

Mark questions as blocking when they prevent the project from moving to the next phase.

## 21. Recommended Next Steps

Provide a short list of recommended next steps.

Include:
- what must be clarified;
- what can move to Phase 2;
- what should be confirmed with the client;
- what information is required before defining requirements and KPIs.

## 22. Readiness for Phase 2

Provide a readiness assessment:

- Ready for Phase 2: Yes / Conditional / No
- Reason:
- Blocking missing information:
- Non-blocking missing information:

Now transform the following raw meeting material into the clean meeting summary.

Raw material:
[paste the full content of this raw notes document here]
```

---

## Human Review After AI Output

After generating the clean meeting summary, manually check that:

- no information was invented;
- assumptions are not presented as facts;
- KPIs are not confused with filters or dimensions;
- data sources are not invented;
- open questions are visible;
- sensitive information is flagged;
- business meaning is preserved;
- the output is ready to be copied into `03_clean_meeting_summary_template.md`.

---

## Next Step

Use the AI-generated and manually reviewed output to complete:

- `03_clean_meeting_summary_template.md`
