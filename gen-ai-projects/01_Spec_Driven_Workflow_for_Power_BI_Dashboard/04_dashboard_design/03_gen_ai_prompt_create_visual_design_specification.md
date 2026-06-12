# GenAI Prompt — Create Visual Design Specification

## Purpose

This prompt transforms the Dashboard Design Specification into a structured **Visual Design Specification**.

The goal is to define how the dashboard should look and communicate information visually: layout, chart types, tables, matrices, visual hierarchy, UX rules, accessibility, and consistency principles.

A Power BI dashboard is not only a set of KPI cards. It may include trend charts, comparison charts, detailed tables, matrices, maps, decomposition trees, scatter plots, waterfall charts, slicers, tooltips, and other visuals depending on the analytical need.

---

## Input

Use this prompt with the completed document:

- [`02_dashboard_design_specification_template.md`](./02_dashboard_design_specification_template.md)

Supporting input if needed:

- [`../03_requirements_and_kpi/04_kpi_dictionary_template.md`](../03_requirements_and_kpi/04_kpi_dictionary_template.md)

---

## Output

Copy the generated output into:

- [`04_visual_design_specification_template.md`](./04_visual_design_specification_template.md)

---

## Prompt

```text
You are a senior Power BI dashboard designer and BI consultant.

I will provide a Dashboard Design Specification for a Power BI dashboard project.

Your task is to create a structured Visual Design Specification.

The goal is to define how the dashboard should be visually organized so that users can understand information quickly, navigate easily, and make decisions based on clear visual hierarchy.

A dashboard is not limited to KPI cards. It may include:
- KPI cards;
- KPI cards with trend indicators;
- line charts;
- area charts;
- bar charts;
- column charts;
- stacked bar or stacked column charts;
- combo charts;
- tables;
- matrices;
- maps;
- scatter plots;
- waterfall charts;
- decomposition trees;
- gauges, only when justified by a target;
- slicers;
- tooltips;
- text blocks;
- alert or status indicators.

Important rules:
1. Do not invent requirements.
2. Do not invent KPIs.
3. Do not change KPI definitions.
4. Do not write SQL, DAX, Power Query, or data model logic.
5. Do not create final pixel-perfect mockups.
6. Do not invent corporate branding rules. If branding is unknown, write "To be confirmed".
7. Recommend visual types only when they are supported by the analytical purpose.
8. Keep visuals aligned with business questions and user needs.
9. Prefer clarity, readability, and decision support over decorative design.
10. Do not overuse KPI cards.
11. Use tables when users need detailed records, operational follow-up, audit, validation, or export.
12. Use matrices when users need cross-tab analysis by two dimensions.
13. Use line charts for trends over time.
14. Use bar or column charts for ranking, category comparison, or breakdown.
15. Use stacked charts only when part-to-whole comparison is necessary and readable.
16. Use maps only when geographic analysis is a real business need.
17. Use scatter plots only for relationships between two numeric variables.
18. Use waterfall charts for contribution, variance, or bridge analysis.
19. Use decomposition trees only when root cause exploration is useful.
20. Avoid pie charts unless there are very few categories and the part-to-whole relationship is essential.
21. Avoid gauges unless a target or threshold is clearly defined.
22. If the best visual type is unclear, mark it as "To be confirmed".
23. Flag any visual design risk that may reduce readability, trust, or usability.

Use the following output structure:

# Visual Design Specification

## 1. Source Information

| Field | Value |
|---|---|
| Source document | |
| Generated with Generative AI | Yes |
| Manually reviewed by analyst | To be completed |
| Ready for Build Readiness | Yes / Conditional / No |

## 2. Visual Design Objective

Summarize the visual design objective in 2–4 sentences.

Explain how the visual design should support:
- fast understanding;
- decision-making;
- KPI monitoring;
- trend analysis;
- comparison;
- detailed analysis;
- navigation;
- readability.

## 3. Visual Design Principles

List the main design principles.

Include:
- clarity;
- consistency;
- visual hierarchy;
- accessibility;
- minimal cognitive load;
- business-first design;
- readable data density;
- desktop or mobile constraints if mentioned.

## 4. Page Layout Recommendations

Create a table:

| Page ID | Page / View | Recommended layout | Visual hierarchy | Notes |
|---|---|---|---|---|

Do not create pixel-perfect layouts. Describe the structure at a practical level.

## 5. Visual Components Inventory

Create a detailed visual inventory table:

| Visual ID | Page ID | KPI / Information | Recommended visual type | Analytical purpose | Why this visual type | Notes |
|---|---|---|---|---|---|---|

Recommended visual types may include:
- KPI card;
- KPI card with trend indicator;
- line chart;
- area chart;
- bar chart;
- column chart;
- stacked bar / stacked column chart;
- combo chart;
- table;
- matrix;
- map;
- scatter plot;
- waterfall chart;
- decomposition tree;
- gauge;
- slicer;
- tooltip;
- text block / commentary;
- alert or status indicator.

Each visual must have a clear analytical purpose.

## 6. Visual Type Guidelines

Create a table:

| Visual type | Best used for | Usage note |
|---|---|---|

Include guidance for:
- KPI card;
- line chart;
- bar chart;
- column chart;
- stacked chart;
- combo chart;
- table;
- matrix;
- map;
- scatter plot;
- waterfall chart;
- decomposition tree;
- gauge;
- tooltip;
- slicer;
- text block.

## 7. KPI Visual Treatment

Create a table:

| KPI ID | KPI / Metric | Recommended visual treatment | Comparison / context | Status |
|---|---|---|---|---|

Include:
- KPI cards;
- trend indicators;
- target comparison;
- conditional formatting;
- previous period comparison;
- benchmark if mentioned.

## 8. Tables and Matrices Design

Create a table:

| Page ID | Table / Matrix | Purpose | Recommended structure | Export need | Notes |
|---|---|---|---|---|---|

Include this section when detailed data, operational tracking, audit, validation, or cross-tab analysis is required.

## 9. Charts and Analytical Visuals Design

Create a table:

| Page ID | Chart / Visual | Analytical purpose | Recommended chart type | Required dimension | Required measure |
|---|---|---|---|---|---|

Use this section for trend charts, comparison charts, ranking charts, variance charts, distribution charts, geographic visuals, and root cause visuals.

## 10. Filters and Slicers Layout

Create a table:

| Filter / Slicer | Recommended placement | Applies to | Notes |
|---|---|---|---|

Consider:
- top filter bar;
- side panel;
- page-level filters;
- hidden filter pane;
- reset filters button.

## 11. Navigation and UX Rules

Create a table:

| UX element | Purpose | Recommendation |
|---|---|---|

Include:
- page navigation;
- home button;
- back button;
- reset filters;
- tooltips;
- drill-through labels;
- glossary or help section;
- export guidance.

## 12. Color, Branding, and Style

Create a table:

| Topic | Recommendation | Status |
|---|---|---|

Include:
- corporate colors;
- accent colors;
- KPI status colors;
- background;
- typography;
- spacing;
- icon usage.

If branding is unknown, mark it as "To be confirmed".

## 13. Accessibility and Readability

List recommendations related to:
- contrast;
- font size;
- label clarity;
- color-blind friendly design;
- avoiding overloaded pages;
- clear legends;
- meaningful titles;
- readable tables;
- matrix readability;
- tooltip explanations.

## 14. Visual Risks and Constraints

Create a table:

| Risk / Constraint | Description | Impact | Required action |
|---|---|---|---|

Include risks such as overloaded pages, too many KPIs, too many visuals, unclear chart choice, unreadable tables, missing branding, accessibility issues, or unclear target device.

## 15. Open Visual Design Questions

Create a table:

| Question | Related page / visual | Owner | Priority | Blocking? |
|---|---|---|---|---|

## 16. Readiness Assessment

Create a table:

| Item | Assessment |
|---|---|
| Ready for Build Readiness | Yes / Conditional / No |
| Main visual blockers | |
| Required clarifications | |

Now create the Visual Design Specification from the following Dashboard Design Specification:

[paste the completed Dashboard Design Specification here]
```

---

## Human Review Checklist

After generating the specification, manually verify that:

- visual choices support business questions;
- the dashboard is not reduced to KPI cards only;
- tables and matrices are included when detailed analysis is needed;
- charts are selected based on analytical purpose;
- visuals are not decorative or unsupported;
- KPI treatment is consistent with KPI definitions;
- branding is not invented;
- accessibility and readability are addressed;
- open visual questions are visible;
- the document is ready to be copied into [`04_visual_design_specification_template.md`](./04_visual_design_specification_template.md).
