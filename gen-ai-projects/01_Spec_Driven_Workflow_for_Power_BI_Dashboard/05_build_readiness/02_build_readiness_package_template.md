# Build Readiness Package Template

## Purpose

This document consolidates the technical preparation, build backlog, validation checks, blockers, and readiness decision before starting the Power BI build phase.

It is the final internal readiness artifact of the workflow.

---

## 1. Source Information

| Field | Value |
|---|---|
| Dashboard design source | [`../04_dashboard_design/02_dashboard_design_specification_template.md`](../04_dashboard_design/02_dashboard_design_specification_template.md) |
| Visual design source | [`../04_dashboard_design/04_visual_design_specification_template.md`](../04_dashboard_design/04_visual_design_specification_template.md) |
| Created with prompt | [`01_gen_ai_prompt_create_build_readiness_package.md`](./01_gen_ai_prompt_create_build_readiness_package.md) |
| Generated with Generative AI | Yes / No |
| Manually reviewed by analyst / developer | Yes / No |
| Build readiness status | Go / Conditional Go / No-Go |

---

## 2. Build Scope Summary

```text
[Summarize what will be built in Power BI: pages, KPI groups, visual families, filters, interactions, security constraints, and expected delivery scope.]
```

---

## 3. Technical Power BI Preparation

| Area | Requirement / Task | Status | Notes |
|---|---|---|---|
| Workspace | | To be confirmed | |
| Dataset / semantic model | | To be confirmed | |
| Data connections | | To be confirmed | |
| Power Query | | To be confirmed | |
| Relationships | | To be confirmed | |
| DAX measures | | To be confirmed | |
| Date table | | To be confirmed | |
| Refresh configuration | | To be confirmed | |
| Gateway | | To be confirmed | |
| Row-level security | | To be confirmed | |
| Report theme | | To be confirmed | |
| Deployment target | | To be confirmed | |
| Performance considerations | | To be confirmed | |

---

## 4. Data and Model Readiness

| Item | Requirement | Ready? | Blocking? | Notes |
|---|---|---|---|---|
| Required tables | | Yes / No / To be confirmed | Yes / No | |
| Required fields | | Yes / No / To be confirmed | Yes / No | |
| Relationships | | Yes / No / To be confirmed | Yes / No | |
| Date logic | | Yes / No / To be confirmed | Yes / No | |
| Source access | | Yes / No / To be confirmed | Yes / No | |
| Data quality | | Yes / No / To be confirmed | Yes / No | |
| Refresh frequency | | Yes / No / To be confirmed | Yes / No | |

---

## 5. KPI and Measure Implementation Readiness

| KPI ID | KPI / Measure | Definition status | Implementation need | Blocking? |
|---|---|---|---|---|
| KPI-001 | | Confirmed / To be confirmed | DAX measure / Existing field / Calculation / Other | Yes / No |

---

## 6. Report Page Build Backlog

| Task ID | Page / Area | Build task | Type | Priority | Status |
|---|---|---|---|---|---|
| BUILD-001 | | | Data preparation / Model / DAX / Page layout / Visual / Table / Matrix / Slicer / Interaction / Navigation / Tooltip / Security / Refresh / Testing | High / Medium / Low | Not started / Ready / Blocked |

---

## 7. Pre-Build Validation Checklist

| Validation item | Status | Blocking? | Notes |
|---|---|---|---|
| Requirements validated | Yes / No / To be confirmed | Yes / No | |
| KPI definitions validated | Yes / No / To be confirmed | Yes / No | |
| Data sources confirmed | Yes / No / To be confirmed | Yes / No | |
| Required fields available | Yes / No / To be confirmed | Yes / No | |
| Page structure validated | Yes / No / To be confirmed | Yes / No | |
| Visual design validated | Yes / No / To be confirmed | Yes / No | |
| Security rules confirmed | Yes / No / To be confirmed | Yes / No | |
| Refresh expectations confirmed | Yes / No / To be confirmed | Yes / No | |
| Build backlog ready | Yes / No / To be confirmed | Yes / No | |
| Open blockers resolved or accepted | Yes / No / To be confirmed | Yes / No | |

---

## 8. Blockers and Required Clarifications

| Blocker / Clarification | Area | Owner | Impact | Required action |
|---|---|---|---|---|
| | | | High / Medium / Low | |

---

## 9. Build Readiness Decision

| Item | Assessment |
|---|---|
| Ready to build? | Go / Conditional Go / No-Go |
| Main reason | |
| Blocking items | |
| Accepted risks | |
| Required confirmations before build | |
| Next action | Start build / Clarify requirements / Rework design |

---

## 10. Recommended Next Steps

1. 
2. 
3. 

---

## Output of This Document

If the decision is `Go` or `Conditional Go`, this document is used as input for:

- [`03_gen_ai_prompt_create_client_confirmation_message.md`](./03_gen_ai_prompt_create_client_confirmation_message.md)
- [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md)

If the decision is `No-Go`, the project should return to the relevant previous phase for clarification or rework.
