# GenAI Prompt — Create KPI Dictionary

## Purpose

This prompt is used to transform the Client Requirements Specification into a structured **KPI Dictionary**.

The goal is to document the KPIs and metrics required for the Power BI dashboard before dashboard design and implementation.

---

## Input

Use this prompt with the completed document:

- [`02_client_requirements_specification_template.md`](./02_client_requirements_specification_template.md)

Supporting input if needed:

- [`../02_business_framing/02_dashboard_business_brief_template.md`](../02_business_framing/02_dashboard_business_brief_template.md)

---

## Output

Copy the generated output into:

- [`04_kpi_dictionary_template.md`](./04_kpi_dictionary_template.md)

---

## Prompt

```text
You are a senior BI consultant and KPI definition specialist.

I will provide a Client Requirements Specification for a Power BI dashboard project.

Your task is to extract, organize, and structure all KPIs and metrics into a KPI Dictionary.

The goal is not to write DAX, SQL, data model logic, or technical implementation details.

The goal is to clarify the business meaning, ownership, calculation readiness, granularity, source dependency, validation status, and open questions for each KPI or metric.

Important rules:
1. Do not invent KPIs.
2. Do not invent formulas.
3. Do not invent data sources.
4. If a KPI or metric is mentioned but not fully defined, include it and mark missing elements as "To be confirmed".
5. If a metric is implied by a business question but not explicitly confirmed, include it only as "Candidate / To be confirmed".
6. Separate KPIs from filters, dimensions, pages, and data sources.
7. Do not confuse a dimension such as country, product, status, or team with a KPI.
8. Do not write SQL, DAX, Power Query, or data model implementation.
9. Use business formulas only if they are explicitly provided or clearly confirmed.
10. Identify conflicting, duplicate, vague, or incomplete KPI definitions.
11. Identify KPI owners or validators where mentioned.
12. Identify which KPIs are blocking for Dashboard Design if their definition is unclear.
13. Keep the output concise, structured, and ready for analyst review.

Use the following output structure:

# KPI Dictionary

## 1. Source Information

| Field | Value |
|---|---|
| Source document | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst | To be completed |
| Ready for Dashboard Design | Yes / Conditional / No |

## 2. KPI Overview

Create a table:

| KPI ID | KPI / Metric | Type | Business meaning | Priority | Status |
|---|---|---|---|---|---|

Type can be:
- KPI;
- Metric;
- Candidate KPI;
- Supporting metric.

Status can be:
- Confirmed;
- To be confirmed;
- Candidate;
- Conflicting definition;
- Missing definition.

## 3. KPI Definitions

Create a table:

| KPI ID | Business formula / Definition | Unit | Granularity | Time logic | Owner / Validator |
|---|---|---|---|---|---|

Rules:
- If formula is missing, write "To be confirmed".
- If unit is missing, write "To be confirmed".
- If granularity is missing, write "To be confirmed".
- If date logic is missing, write "To be confirmed".

## 4. KPI Data Requirements

Create a table:

| KPI ID | Required data | Known source | Data owner | Data availability | Notes |
|---|---|---|---|---|---|

Do not invent sources. Use "To be confirmed" where needed.

## 5. Dimensions and Filters Linked to KPIs

Create a table:

| KPI ID | Relevant dimensions | Relevant filters | Notes |
|---|---|---|---|

Include only dimensions and filters mentioned in the requirements.

## 6. Targets, Benchmarks, and Comparisons

Create a table:

| KPI ID | Target / Threshold | Comparison needed | Status |
|---|---|---|---|

Examples of comparisons:
- previous period;
- previous year;
- target;
- budget;
- forecast;
- benchmark;
- segment comparison.

## 7. KPI Validation Issues

Create a table:

| KPI ID | Issue | Impact | Required clarification | Blocking? |
|---|---|---|---|---|

Include:
- missing formula;
- unclear owner;
- unclear date logic;
- unclear source;
- conflicting definition;
- missing target;
- unclear granularity.

## 8. Open Questions for KPI Owners

Create a table:

| Question | Related KPI | Owner | Priority | Blocking? |
|---|---|---|---|---|

## 9. Readiness for Dashboard Design

Create a table:

| Item | Assessment |
|---|---|
| KPI dictionary ready for Dashboard Design | Yes / Conditional / No |
| Blocking KPI issues | |
| Non-blocking KPI issues | |
| Required clarifications | |

Now create the KPI Dictionary from the following Client Requirements Specification:

[paste the completed Client Requirements Specification here]
```

---

## Human Review Checklist

After generating the KPI Dictionary, manually verify that:

- no KPI was invented;
- candidate KPIs are clearly marked;
- formulas are not invented;
- missing definitions are marked as `To be confirmed`;
- KPIs are not confused with filters or dimensions;
- sources are not invented;
- KPI owners or validators are documented where available;
- blocking KPI questions are visible;
- the output is ready to be copied into [`04_kpi_dictionary_template.md`](./04_kpi_dictionary_template.md).
