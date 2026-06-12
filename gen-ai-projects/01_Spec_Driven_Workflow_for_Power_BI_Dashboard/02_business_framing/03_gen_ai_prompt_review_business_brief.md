# GenAI Prompt — Review Dashboard Business Brief

## Purpose

This prompt is used to review the completed Dashboard Business Brief before moving to Phase 3 — Requirements & KPI.

The goal is to check whether the business framing is clear, complete, consistent, and ready to support detailed requirements and KPI definition.

This prompt does not create a new project artifact. It produces review feedback that should be used to improve [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md).

---

## Input

Use this prompt with the completed document: [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md)

The input should contain:

- business domain;
- business problem or opportunity;
- dashboard purpose;
- target audience;
- key business questions;
- supported decisions;
- expected business value;
- scope and out of scope;
- success criteria;
- assumptions;
- risks and constraints;
- open questions;
- readiness for Phase 3.

---

## Expected Output

The output is a **Business Brief Review Report**.

Use the review feedback to update and validate:

[`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md)

---

## Prompt

```text
You are a senior BI project reviewer and business analyst.

I will provide a completed Dashboard Business Brief for a Power BI dashboard project.

Your task is to review the document and assess whether it is ready to be used as input for Phase 3 — Requirements & KPI.

The goal is not to rewrite the entire document unless necessary.

The goal is to:
- identify missing or unclear business information;
- check whether the business problem is clearly defined;
- check whether the dashboard purpose is explicit;
- verify that target users are identified;
- verify that supported decisions are clear;
- check whether key business questions are actionable;
- assess whether scope and out of scope are clear;
- identify assumptions presented as facts;
- identify risks, constraints, and blocking open questions;
- decide whether the project is ready to move to Requirements & KPI.

Important rules:
1. Do not invent missing information.
2. Do not add new business requirements that are not supported by the brief.
3. Do not write SQL, DAX, data model logic, or detailed dashboard design.
4. Do not define KPI formulas.
5. Focus only on business framing quality and readiness for the next phase.
6. Clearly separate blocking issues from non-blocking improvements.
7. Provide practical corrections that the analyst can apply to the Business Brief.

Use the following output structure:

# Business Brief Review Report

## 1. Readiness Assessment

| Item | Assessment |
|---|---|
| Ready for Phase 3 — Requirements & KPI | Yes / Conditional / No |
| Readiness score | 0–100% |
| Main reason | |

## 2. Strengths

List what is already clear and usable in the Business Brief.

## 3. Blocking Issues

List issues that prevent moving to Phase 3.

Examples:
- unclear business problem;
- unclear dashboard objective;
- missing target users;
- unclear supported decisions;
- unclear scope;
- blocking open questions;
- assumptions presented as confirmed facts.

## 4. Non-Blocking Improvements

List useful improvements that do not block the next phase.

## 5. Missing Information

Create a table:

| Missing information | Why it matters | Blocking? |
|---|---|---|

## 6. Business Problem Check

Assess whether the business problem or opportunity is clear.

Return:
- Clear / Partially clear / Not clear
- Explanation
- Suggested correction if needed

## 7. Dashboard Purpose Check

Assess whether the dashboard purpose is clear and business-oriented.

Return:
- Clear / Partially clear / Not clear
- Explanation
- Suggested correction if needed

## 8. Target Audience and Decision Check

Assess whether users and supported decisions are clearly documented.

Return:
- Target users clarity: Clear / Partially clear / Not clear
- Supported decisions clarity: Clear / Partially clear / Not clear
- Suggested correction if needed

## 9. Business Questions Check

Assess whether the key business questions are specific, actionable, and useful for the next phase.

Return:
- Clear / Partially clear / Not clear
- Questions to improve
- Missing questions to confirm with stakeholders

## 10. Scope Check

Assess whether in-scope and out-of-scope items are clearly separated.

Return:
- Scope clarity: Clear / Partially clear / Not clear
- Scope risks
- Suggested correction if needed

## 11. Assumptions and Risks Check

Identify assumptions that need confirmation and risks that should be tracked before Phase 3.

Create a table:

| Item | Type | Issue | Recommended action |
|---|---|---|---|

Type can be:
- Assumption
- Risk
- Constraint
- Dependency

## 12. Recommended Corrections

Provide a concise list of corrections to apply to `02_dashboard_business_brief_template.md`

## 13. Final Recommendation

Choose one:

- Ready for Phase 3
- Conditionally ready for Phase 3 after minor clarification
- Not ready for Phase 3

Explain the recommendation in 2–4 sentences.

Now review the following Dashboard Business Brief:

[paste the completed Dashboard Business Brief here]
```

---

## How to Use the Review Output

After running this prompt:

1. Apply the recommended corrections to [`02_dashboard_business_brief_template.md`](./02_dashboard_business_brief_template.md).
2. Update the `Review Status` section in the Business Brief.
3. Mark the document as:
   - `Approved`;
   - `Needs revision`;
   - or `Conditional approval`.
4. Use the validated Business Brief as input for Phase 3 — Requirements & KPI.
