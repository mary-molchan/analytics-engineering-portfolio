# Raw Notes Template

## Purpose

This document is used to capture raw input from the initial discovery meeting for a Power BI dashboard project.

It is not a polished specification. Its role is to preserve the original meeting material before it is transformed into a structured clean meeting summary.

---

## Meeting Information

| Field | Value |
|---|---|
| Project name | |
| Meeting date | |
| Meeting type | Video call / In-person / Workshop |
| Client / Business owner | |
| Participants | |
| Analyst | |
| Business domain | |
| Dashboard name, if known | |
| Recording available | Yes / No |
| Transcript available | Yes / No |
| Existing report or dashboard available | Yes / No |

---

## Initial Request

```text
[Paste the initial client request here]
```

---

## Discovery Questions to Cover During the Meeting

### 1. Business Context

- What business domain does the dashboard cover?
- Which business process, activity, team, product, or service should it support?
- Why is this dashboard needed now?
- What problem, pain point, or decision-making gap should it solve?
- Is this a new dashboard or a replacement/improvement of an existing report?

### 2. Dashboard Objective

- What is the main purpose of the dashboard?
- What should users understand immediately after opening it?
- What decisions should the dashboard support?
- What actions should users take based on the dashboard insights?
- What would make this dashboard successful?

### 3. Target Users

- Who are the main users of the dashboard?
- Are they executives, managers, operational users, analysts, or external stakeholders?
- How often will they use it?
- What level of detail do they need?
- Do different user groups need different views or access levels?

### 4. Business Questions

- What key questions should the dashboard answer?
- Which questions are the highest priority?
- Which questions should be answered on the first page?
- Which questions require detailed analysis?
- What is explicitly out of scope?

### 5. KPIs and Metrics

- Which KPIs are mandatory?
- Which metrics are optional?
- Are KPI definitions already agreed?
- Who owns or validates each KPI?
- What is the expected calculation logic?
- What time logic should be used?
- Are targets, thresholds, benchmarks, or comparisons required?

### 6. Data Sources

- Which systems, databases, files, or tools contain the required data?
- Who owns each data source?
- How often is the data updated?
- Is historical data available?
- Are there known data quality issues?
- Are there access, confidentiality, or GDPR constraints?

### 7. Filters and Dimensions

- Which filters should users have?
- Which dimensions are required: date, country, region, product, client, team, status, category?
- What should be the default view?
- Are hierarchies, drill-downs, or drill-throughs required?
- Should filters apply globally or only to specific pages?

### 8. Visual and UX Expectations

- Does the client have examples of dashboards they like?
- Should the dashboard be executive, operational, exploratory, or detailed?
- Are there corporate branding or design rules?
- Are there preferred or forbidden visual types?
- Are tables, exports, tooltips, comments, or explanations required?

### 9. Interactions and Navigation

- How many pages are expected?
- Is an executive summary page needed?
- Should users navigate from overview to detail?
- Are bookmarks, drill-through pages, buttons, or custom tooltips required?
- Should the dashboard be optimized for desktop, web, or mobile?

### 10. Security and Access

- Who should have access to the dashboard?
- Are different access levels required?
- Is row-level security needed?
- Are there sensitive or confidential fields?
- Should some metrics or pages be restricted?

### 11. Delivery and Validation

- Who will validate the dashboard?
- Who gives final approval?
- What is the expected deadline?
- Are there fixed demo or delivery dates?
- What are the acceptance criteria?
- How many review iterations are expected?

---

## Raw Meeting Notes

```text
[Paste raw notes here]
```

---

## Transcript Excerpts

```text
[Paste transcript excerpts here]
```

---

## Quick Captures

### Mentioned KPIs

- 
- 
- 

### Mentioned Data Sources

- 
- 
- 

### Mentioned Filters or Dimensions

- 
- 
- 

### Visual Expectations

- 
- 
- 

### Decisions Made

| Decision | Confirmed by | Notes |
|---|---|---|
| | | |

### Open Questions

| Question | Owner | Priority |
|---|---|---|
| | | High / Medium / Low |

### Follow-Up Actions

| Action | Owner | Due date | Status |
|---|---|---|---|
| | | | Not started / In progress / Done |

---

## Generative AI Prompt — Convert Raw Notes into a Clean Meeting Summary

```text
You are a senior business analyst and Power BI consultant.

I will provide raw notes or a transcript from a discovery meeting for a Power BI dashboard project.

Your task is to transform the raw material into a structured clean meeting summary.

Rules:
- Do not invent information.
- If something is unclear, mark it as "To be confirmed".
- Preserve the stakeholder’s business intent.
- Separate confirmed information from assumptions.
- Separate KPIs from filters, dimensions, and data sources.
- Keep all open questions visible and actionable.
- Highlight risks, constraints, and missing information.
- Use clear and professional wording.
- Prepare the output so it can be reused in the next workflow phase.

Output structure:

# Clean Meeting Summary

## 1. Meeting Context
## 2. Business Problem
## 3. Dashboard Objective
## 4. Target Users
## 5. Expected Decisions
## 6. Requested Dashboard Pages or Views
## 7. Requested KPIs and Metrics
## 8. Mentioned Data Sources
## 9. Filters and Dimensions
## 10. Visual Preferences
## 11. Interactions and Navigation
## 12. Security and Access Constraints
## 13. Constraints and Risks
## 14. Confirmed Decisions
## 15. Assumptions
## 16. Open Questions
## 17. Recommended Next Steps

Raw material:
[paste raw notes or transcript here]
```

---

## Next Step

Use this raw material and the Generative AI prompt to create:

- `clean_meeting_summary_template.md`
