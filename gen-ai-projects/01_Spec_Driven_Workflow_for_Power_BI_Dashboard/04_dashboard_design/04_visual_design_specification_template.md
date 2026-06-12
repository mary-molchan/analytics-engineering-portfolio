# Visual Design Specification Template

## Purpose

This document defines the visual design principles, page layout recommendations, visual components, chart choices, tables, matrices, UX rules, and readability guidelines for the Power BI dashboard.

It should be completed after the Dashboard Design Specification.

---

## 1. Source Information

| Field | Value |
|---|---|
| Source document | [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md) |
| Supporting KPI document | [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md) |
| Created with prompt | [`03_gen_ai_prompt_create_visual_design_specification.md`](./03_gen_ai_prompt_create_visual_design_specification.md) |
| Generated with Generative AI | Yes / No |
| Manually reviewed by analyst | Yes / No |
| Ready for Build Readiness | Yes / Conditional / No |

---

## 2. Visual Design Objective

```text
[Summarize how the visual design supports understanding, navigation, KPI monitoring, trend analysis, comparison, detailed analysis, and decision-making.]
```

---

## 3. Visual Design Principles

- Clarity:
- Consistency:
- Visual hierarchy:
- Accessibility:
- Minimal cognitive load:
- Business-first design:
- Readable data density:

---

## 4. Page Layout Recommendations

| Page ID | Page / View | Recommended layout | Visual hierarchy | Notes |
|---|---|---|---|---|
| PAGE-01 | | | | |

---

## 5. Visual Components Inventory

| Visual ID | Page ID | KPI / Information | Recommended visual type | Analytical purpose | Why this visual type | Notes |
|---|---|---|---|---|---|---|
| VIS-001 | PAGE-01 | | KPI card / Line chart / Bar chart / Column chart / Matrix / Table / Map / Scatter plot / Waterfall chart / Decomposition tree / Slicer / Tooltip / Other | | | |

---

## 6. Visual Type Guidelines

| Visual type | Best used for | Usage note |
|---|---|---|
| KPI card | Headline indicators and key metrics | Use for the most important KPIs only. |
| KPI card with trend | KPI value with period comparison | Useful when users need immediate performance context. |
| Line chart | Trends over time | Best for monthly, weekly, daily, or yearly evolution. |
| Area chart | Trend with volume emphasis | Use only if the filled area improves understanding. |
| Bar chart | Ranking or category comparison | Useful for comparing products, teams, regions, or segments. |
| Column chart | Time-based or category comparison | Use when vertical comparison is easy to read. |
| Stacked bar / column chart | Part-to-whole comparison | Use only if the chart remains readable. |
| Combo chart | Comparing two related measures | Use carefully to avoid visual overload. |
| Table | Detailed records, exports, or operational follow-up | Useful for users who need row-level or entity-level detail. |
| Matrix | Cross-tab analysis by two dimensions | Useful for structured breakdowns such as region by product or month by category. |
| Map | Geographic analysis | Use only if location is relevant to the business question. |
| Scatter plot | Relationship between two numeric variables | Use for correlation, distribution, or outlier analysis. |
| Waterfall chart | Variance, contribution, or bridge analysis | Useful for explaining changes between values. |
| Decomposition tree | Root cause exploration | Useful for interactive diagnostic analysis. |
| Gauge | Target progress | Use only if a clear target or threshold exists. |
| Tooltip | Additional context | Use to avoid overcrowding the main page. |
| Slicer | User filtering | Should support the expected user journey. |
| Text block | Explanation or business commentary | Use for definitions, warnings, or interpretation notes. |

---

## 7. KPI Visual Treatment

| KPI ID | KPI / Metric | Recommended visual treatment | Comparison / context | Status |
|---|---|---|---|---|
| KPI-001 | | KPI card / Trend indicator / Conditional formatting / Target comparison | | Confirmed / To be confirmed |

---

## 8. Tables and Matrices Design

| Page ID | Table / Matrix | Purpose | Recommended structure | Export need | Notes |
|---|---|---|---|---|---|
| PAGE-01 | | Detail view / Operational tracking / Cross-tab analysis / Audit / Validation | | Yes / No / To be confirmed | |

---

## 9. Charts and Analytical Visuals Design

| Page ID | Chart / Visual | Analytical purpose | Recommended chart type | Required dimension | Required measure |
|---|---|---|---|---|---|
| PAGE-01 | | Trend / Comparison / Ranking / Variance / Distribution / Geographic / Root cause | Line / Bar / Column / Scatter / Waterfall / Map / Decomposition tree / Other | | |

---

## 10. Filters and Slicers Layout

| Filter / Slicer | Recommended placement | Applies to | Notes |
|---|---|---|---|
| | Top bar / Side panel / Page-level / Hidden pane / To be confirmed | | |

---

## 11. Navigation and UX Rules

| UX element | Purpose | Recommendation |
|---|---|---|
| Page navigation | | |
| Home / Back button | | |
| Reset filters | | |
| Tooltips | | |
| Drill-through labels | | |
| Glossary / Help section | | |
| Export guidance | | |

---

## 12. Color, Branding, and Style

| Topic | Recommendation | Status |
|---|---|---|
| Corporate colors | | To be confirmed |
| Accent colors | | To be confirmed |
| KPI status colors | | To be confirmed |
| Background | | To be confirmed |
| Typography | | To be confirmed |
| Spacing | | To be confirmed |
| Icon usage | | To be confirmed |

---

## 13. Accessibility and Readability

- Contrast:
- Font size:
- Label clarity:
- Color-blind friendly design:
- Page density:
- Legends:
- Titles:
- Table readability:
- Matrix readability:
- Tooltip explanations:

---

## 14. Visual Risks and Constraints

| Risk / Constraint | Description | Impact | Required action |
|---|---|---|---|
| | | High / Medium / Low | |

---

## 15. Open Visual Design Questions

| Question | Related page / visual | Owner | Priority | Blocking? |
|---|---|---|---|---|
| | | | High / Medium / Low | Yes / No |

---

## 16. Readiness Assessment

| Item | Assessment |
|---|---|
| Ready for Build Readiness | Yes / Conditional / No |
| Main visual blockers | |
| Required clarifications | |

---

## Output of This Document

This visual design specification is used as input for:

- [`../05_build_readiness/`](../05_build_readiness/)
