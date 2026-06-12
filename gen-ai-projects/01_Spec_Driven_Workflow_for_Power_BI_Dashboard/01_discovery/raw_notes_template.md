# Raw Notes Template

## Purpose

This template is used to capture raw input from the initial client discovery meeting for a Power BI dashboard project.

The goal is not to produce a polished specification at this stage, but to preserve the original business input, stakeholder comments, decisions, assumptions, and open questions.

This document serves as the source material for the clean meeting summary generated in the next step.

## Meeting Information

| Field | Value |
|---|---|
| Project name | |
| Meeting date | |
| Meeting type | Video call / In-person / Workshop |
| Client / business owner | |
| Participants | |
| Analyst | |
| Business domain | |
| Dashboard name, if known | |
| Recording available | Yes / No |
| Transcript available | Yes / No |
| Existing dashboard available | Yes / No |
| Initial request source | Email / Jira ticket / Verbal request / Workshop / Other |

## Initial Business Request

Briefly describe the initial dashboard request in the client’s own words.

```text
[Paste or write the initial request here]
```

## Raw Meeting Notes

Use this section to capture unstructured notes during or immediately after the meeting.

```text
[Paste raw notes here]
```

## Transcript Excerpts

Use this section if a meeting transcript is available.

```text
[Paste transcript excerpts here]
```

## Mentioned Business Problems

- 
- 
- 

## Mentioned Dashboard Objectives

- 
- 
- 

## Mentioned Target Users

| User group | Notes |
|---|---|
| | |

## Mentioned Business Questions

| Business question | Context | Priority |
|---|---|---|
| | | High / Medium / Low |

## Mentioned KPIs and Metrics

| KPI / Metric | Context | Confirmed? |
|---|---|---|
| | | Yes / No / To be confirmed |

## Mentioned Data Sources

| Source | Type | Owner | Notes |
|---|---|---|---|
| | Database / File / System / Manual input | | |

## Mentioned Filters and Dimensions

| Filter / Dimension | Notes |
|---|---|
| Date | |
| Country | |
| Region | |
| Product | |
| Client | |
| Team | |
| Status | |
| Category | |
| Other | |

## Visual Expectations Mentioned

- 
- 
- 

## Interaction and Navigation Expectations

- 
- 
- 

## Security or Access Constraints

- 
- 
- 

## Decisions Made During the Meeting

| Decision | Confirmed by | Notes |
|---|---|---|
| | | |

## Open Questions

| Question | Owner | Priority |
|---|---|---|
| | | High / Medium / Low |

## Risks and Constraints Mentioned

| Risk / Constraint | Description | Impact |
|---|---|---|
| | | High / Medium / Low |

## Follow-Up Actions

| Action | Owner | Due date | Status |
|---|---|---|---|
| | | | Not started / In progress / Done |

## Generative AI Prompt — Transform Raw Notes into Clean Summary

Use this prompt to transform raw notes or transcripts into a structured clean meeting summary.

```text
You are a senior business analyst and Power BI consultant.

I will provide raw meeting notes or a transcript from a client discovery meeting for a Power BI dashboard project.

Your task is to:
1. Clean and structure the raw material.
2. Preserve all important business information.
3. Separate confirmed information from assumptions.
4. Identify open questions and missing information.
5. Avoid inventing details that were not mentioned.
6. Prepare a structured clean meeting summary.

Important rules:
- Do not add information that is not present in the notes.
- If something is unclear, mark it as "To be confirmed".
- Keep business wording clear and professional.
- Separate KPIs from filters, dimensions, and data sources.
- Preserve all open questions.
- Highlight risks and constraints.
- Identify the next actions needed before business framing.

Use the following output structure:

# Clean Meeting Summary

## 1. Meeting context
## 2. Business problem
## 3. Dashboard objective
## 4. Target users
## 5. Expected decisions
## 6. Requested dashboard pages or views
## 7. Requested KPIs and metrics
## 8. Mentioned data sources
## 9. Filters and dimensions
## 10. Visual preferences
## 11. Interactions and navigation
## 12. Security and access constraints
## 13. Constraints and risks
## 14. Confirmed decisions
## 15. Assumptions
## 16. Open questions
## 17. Recommended next steps

Raw material:
[paste raw notes or transcript here]
```

## Human Review Checklist

After using Generative AI, the analyst must verify that:

- no unsupported information was invented;
- client wording was not distorted;
- confirmed decisions are clearly separated from assumptions;
- all open questions are preserved;
- KPI names and business terms are accurate;
- KPIs are not confused with dimensions or filters;
- sensitive information is removed or anonymized if needed;
- risks and constraints are clearly documented;
- the output is ready to be copied into `clean_meeting_summary_template.md`.

## Expected Output

This document should provide enough source material to create:

- `clean_meeting_summary_template.md`;
- the Business Framing phase;
- the first list of dashboard requirements and open questions.
