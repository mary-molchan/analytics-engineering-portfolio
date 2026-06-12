# GenAI Prompt : Create Client Confirmation Message

## Purpose

This prompt is used to create a concise client-facing confirmation message before starting the Power BI build phase.

The goal is to confirm the validated scope, design, assumptions, remaining open points, accepted risks, and build readiness decision with the business owner or stakeholder.

---

## Input

Use this prompt with the completed document:

- [`02_build_readiness_package_template.md`](./02_build_readiness_package_template.md)

Optional supporting inputs:

- [`../04_dashboard_design/02_dashboard_design_specification_template.md`](../04_dashboard_design/02_dashboard_design_specification_template.md)
- [`../04_dashboard_design/04_visual_design_specification_template.md`](../04_dashboard_design/04_visual_design_specification_template.md)

---

## Output

Copy the generated output into:

- [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md)

---

## Prompt

```text
You are a senior BI consultant preparing a concise client-facing confirmation message before the Power BI build phase.

I will provide a completed Build Readiness Package.

Your task is to create a professional confirmation message for the business owner or stakeholder.

The message should confirm:
- what is ready to be built;
- which dashboard pages or areas are included;
- which KPIs or metric groups are included;
- which key visual and interaction principles are included;
- which assumptions or accepted risks remain;
- which open points still require confirmation, if any;
- whether the project is ready to move to the Power BI build phase.

Important rules:
1. Do not include internal technical details unless the client needs to confirm them.
2. Do not mention unnecessary development jargon.
3. Do not invent scope, KPIs, deadlines, or approvals.
4. Be clear, concise, and professional.
5. Clearly separate confirmed scope from open points.
6. If the readiness decision is "Go", ask for formal confirmation to start the build.
7. If the readiness decision is "Conditional Go", ask for confirmation of the accepted open points or risks.
8. If the readiness decision is "No-Go", do not ask for build approval; summarize what must be clarified or reworked.
9. Keep the message stakeholder-friendly.
10. The output should be ready to paste into an email, Teams message, or project ticket.

Use the following output structure:

# Client Confirmation Message

## Subject

Provide a short subject line.

## Message

Write the confirmation message.

Include:
- short context;
- confirmed build scope;
- key included pages or dashboard areas;
- key KPI or metric groups;
- main design or interaction principles;
- remaining open points or accepted risks;
- requested confirmation;
- next step after confirmation.

## Confirmation Requested

Create a short checklist:

| Item | Confirmation |
|---|---|
| Dashboard scope confirmed | Yes / No |
| KPI groups confirmed | Yes / No |
| Design direction confirmed | Yes / No |
| Accepted risks confirmed | Yes / No / Not applicable |
| Approval to start build | Yes / No |

Now create the client confirmation message from the following Build Readiness Package:

[paste the completed Build Readiness Package here]
```

---

## Human Review Checklist

Before sending the message, verify that:

- the message is understandable for a business stakeholder;
- confirmed scope is accurate;
- open points and accepted risks are visible;
- no internal-only technical detail is exposed unnecessarily;
- the message asks for the correct decision: approval, conditional approval, or clarification;
- the output is ready to be copied into [`04_client_confirmation_message_template.md`](./04_client_confirmation_message_template.md).
