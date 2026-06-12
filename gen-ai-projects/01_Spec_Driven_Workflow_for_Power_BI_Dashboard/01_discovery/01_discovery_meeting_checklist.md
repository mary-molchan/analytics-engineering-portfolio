# Discovery Meeting Checklist

## Purpose

This checklist is used to prepare and conduct the initial discovery meeting for a Power BI dashboard project.

Its goal is to help the analyst collect complete, structured, and actionable business input before creating the next project artifacts:

- raw meeting notes;
- clean meeting summary;
- dashboard business brief;
- client requirements specification;
- KPI dictionary;
- functional specification;
- dashboard design documentation;
- build readiness package.

This checklist is not a final specification. It is a facilitation guide used to make sure that the meeting covers all critical topics required to start a Power BI dashboard project properly.

---

## When to Use

Use this checklist before and during a discovery meeting with:

- business stakeholders;
- dashboard requesters;
- product owners;
- managers;
- operational teams;
- reporting users;
- BI sponsors;
- data owners;
- KPI owners.

---

## Meeting Preparation

Before the meeting, clarify or prepare the following:

- who requested the dashboard;
- who is the business owner;
- who will use the dashboard;
- what business process the dashboard should support;
- whether the request is for a new dashboard or an improvement of an existing report;
- whether any existing reports, dashboards, Excel files, screenshots, or mockups are available;
- whether the meeting can be recorded;
- whether a transcript will be available;
- whether only manual notes will be taken;
- whether sensitive or confidential information may be discussed;
- whether there are known deadlines, business constraints, or urgent decisions linked to the dashboard.

---

## Meeting Output Expected

By the end of the meeting, the analyst should be able to capture enough raw information to complete:

- `raw_notes_template.md`;
- `clean_meeting_summary_template.md`;
- Phase 2: `02_business_framing`.

The meeting should provide at least a first understanding of:

- business context;
- dashboard objective;
- target users;
- key business questions;
- requested KPIs;
- known data sources;
- expected filters and dimensions;
- visual expectations;
- access and security constraints;
- delivery expectations;
- open questions and next steps.

---

# Discovery Questions

## 1. Business Context

- What business domain does the dashboard cover?
- Which business process, activity, product, service, department, or team should the dashboard support?
- Why is this dashboard needed now?
- What current business pain point should it solve?
- What decision-making gap exists today?
- Is this request linked to a specific project, transformation, audit, reporting need, or management priority?
- Is this a new dashboard or a replacement/improvement of an existing report?
- What is currently used instead of this dashboard?
- What is not working in the current reporting process?
- What happens today when users do not have this dashboard?
- What are the main consequences of not solving this reporting need?

---

## 2. Dashboard Objective

- What is the main purpose of the dashboard?
- What should users understand immediately after opening it?
- What business decisions should the dashboard support?
- What actions should users take after reviewing the dashboard?
- Should the dashboard be used for monitoring, analysis, decision-making, performance tracking, reporting, alerting, or investigation?
- Is the dashboard mainly strategic, tactical, or operational?
- What would make this dashboard successful?
- What would make this dashboard ineffective?
- What should the dashboard help users do faster, better, or more reliably?
- Is the goal to replace manual reporting, improve visibility, standardize KPIs, detect anomalies, monitor performance, or support management decisions?

---

## 3. Target Users

- Who are the main users of the dashboard?
- Who is the primary audience?
- Who is the secondary audience?
- Are users executives, managers, operational teams, analysts, finance users, sales teams, HR teams, project managers, or external stakeholders?
- How often will each user group use the dashboard?
- What level of detail does each user group need?
- Do different user groups need different views?
- Do users need high-level summaries, detailed operational data, or both?
- What is the expected data literacy level of the users?
- Are users familiar with Power BI?
- Will users mainly consume the report or actively interact with slicers, filters, drill-downs, and exports?
- Who will provide feedback during the design and validation process?
- Who has final approval authority?

---

## 4. Business Questions

- What are the key business questions the dashboard should answer?
- Which questions are the highest priority?
- Which questions should be answered on the first page?
- Which questions require detailed analysis?
- Which questions are currently difficult or time-consuming to answer?
- Which recurring questions do users ask today?
- Which questions should the dashboard not answer?
- What is explicitly out of scope?
- Are users trying to understand trends, comparisons, breakdowns, exceptions, root causes, forecasts, targets, or performance gaps?
- What should users be able to conclude after using the dashboard?

---

## 5. KPIs and Metrics

- Which KPIs are mandatory?
- Which metrics are optional?
- Which KPIs are business-critical?
- Which KPIs should appear on the first page?
- Are KPI definitions already agreed?
- Who owns or validates each KPI?
- Are there official KPI definitions?
- Are there conflicting definitions across teams?
- What is the expected calculation logic for each KPI?
- What is the required level of granularity: customer, transaction, product, project, team, country, month, day?
- What date logic should be used: creation date, closing date, invoice date, payment date, delivery date, reporting date?
- Are targets, thresholds, benchmarks, budgets, or forecasts required?
- Should KPIs be compared with previous period, previous year, target, budget, forecast, or peer group?
- Are there business rules, exclusions, or special cases?
- Are there KPIs that require validation before being displayed?
- Are there KPIs that are sensitive or restricted?

---

## 6. Data Sources

- Which systems, databases, files, tools, or applications contain the required data?
- Who owns each data source?
- Who can provide access to the data?
- Is the data already available for Power BI?
- Is the data stored in a database, Excel file, SharePoint, CRM, ERP, data warehouse, API, manual extract, or another system?
- How often is the data updated?
- What refresh frequency is expected for the dashboard?
- Is historical data available?
- How far back should historical data go?
- Are there known data quality issues?
- Are some fields missing, unreliable, duplicated, or manually maintained?
- Are there known delays in data availability?
- Are there confidentiality, security, GDPR, or access restrictions?
- Are there reference tables, mapping files, or business rules maintained outside the main system?
- Are there data owners or subject matter experts who should be involved?

---

## 7. Filters and Dimensions

- Which filters should users have?
- Which dimensions are required?
- Should users filter by date, period, country, region, product, category, client, supplier, team, status, project, channel, segment, or business unit?
- What should be the default filter state?
- Should some filters apply to all pages?
- Should some filters apply only to specific pages?
- Are hierarchies required?
- Is drill-down required?
- Is drill-through required?
- Should users compare several entities side by side?
- Should users be able to switch between different time granularities?
- Should users see global data first and then drill into details?
- Are there dimensions that should be hidden from some users?

---

## 8. Dashboard Pages and Analytical Views

- How many pages are expected?
- Is an executive summary page needed?
- Is a detailed analysis page needed?
- Is an operational monitoring page needed?
- Is a data quality or notes page needed?
- Should there be separate pages by user group?
- Should there be separate pages by business topic?
- What should be visible on the first page?
- What should users see first: KPIs, trends, breakdowns, alerts, tables, or commentary?
- Should the dashboard follow an overview-to-detail structure?
- Should there be a dedicated page for exceptions, anomalies, or risks?
- Should there be a dedicated page for entity-level details?
- Are there views that are mandatory for the first version?
- Are there views that can be postponed to a later version?

---

## 9. Visual and UX Expectations

- Does the client have examples of dashboards they like?
- Are there existing reports, screenshots, mockups, or Excel files to use as reference?
- Should the dashboard be executive, operational, exploratory, financial, analytical, or presentation-oriented?
- Should the dashboard be simple and high-level or dense and detailed?
- Are there corporate branding or design rules?
- Are there preferred colors, fonts, or layout principles?
- Are there preferred visual types?
- Are there visual types to avoid?
- Are tables or matrices required?
- Is export to Excel required?
- Are explanatory comments, notes, definitions, or tooltips required?
- Should the dashboard include alerts, thresholds, icons, conditional formatting, or status indicators?
- Should the report be optimized for desktop, web, mobile, or presentation mode?
- Are there accessibility requirements?

---

## 10. Interactions and Navigation

- Should users navigate from overview to detail?
- Are navigation buttons required?
- Are bookmarks required?
- Are drill-through pages required?
- Are custom tooltips required?
- Should visuals cross-filter each other?
- Should some interactions be disabled?
- Should users be able to export detailed data?
- Should users be able to reset filters easily?
- Should the dashboard include a home page or navigation menu?
- Should there be help text, metric definitions, or a glossary page?
- Should users be guided through a specific analytical journey?

---

## 11. Security and Access

- Who should have access to the dashboard?
- Are different access levels required?
- Is row-level security required?
- Should access depend on country, region, team, business unit, manager, client portfolio, or role?
- Are some pages restricted to specific users?
- Are some KPIs restricted?
- Are there sensitive or confidential fields?
- Are there GDPR or data privacy constraints?
- Can personal data be displayed?
- Should data be anonymized, aggregated, or masked?
- Who approves access rights?
- Who maintains user groups?

---

## 12. Refresh, Usage, and Maintenance

- How often should the dashboard refresh?
- Is real-time or near-real-time data required?
- Is daily, weekly, monthly, or manual refresh sufficient?
- Who will monitor refresh failures?
- Who will maintain the dashboard after delivery?
- Who will update KPI definitions if business rules change?
- Who will manage user access?
- Who will collect feedback after release?
- Is there a planned version 2?
- Should the dashboard include a last refresh date?
- Should users be informed about data latency?

---

## 13. Delivery and Validation

- What is the expected deadline?
- Are there fixed demo, review, or delivery dates?
- Who will validate the dashboard?
- Who gives final approval?
- What are the acceptance criteria?
- What must be confirmed before the build phase starts?
- How many review iterations are expected?
- What format should the validation take: meeting, written approval, UAT session, email confirmation?
- Who should participate in the validation?
- What are the critical blockers that could delay the project?
- What is the minimum viable version?
- What can be delivered later?

---

## 14. Risks, Constraints, and Open Questions

- What information is still unclear?
- Which decisions are not yet confirmed?
- Which KPIs need validation?
- Which data sources are uncertain?
- Which data quality issues may affect the dashboard?
- Which dependencies may block the project?
- Are there risks related to deadlines, access, data availability, business alignment, or stakeholder availability?
- Are there assumptions that must be confirmed?
- What should be clarified before moving to the next phase?
- What should be clarified before starting the Power BI build?

---

# Minimum Information to Capture in Raw Notes

During or immediately after the meeting, make sure the raw notes contain at least:

- project name;
- meeting date;
- participants;
- business domain;
- initial request;
- business problem;
- dashboard objective;
- target users;
- key business questions;
- requested KPIs;
- mentioned data sources;
- required filters and dimensions;
- expected pages or views;
- visual preferences;
- security or access constraints;
- delivery expectations;
- confirmed decisions;
- open questions;
- follow-up actions.

---

# Human Review Checklist

Before using this checklist in a real meeting, verify that:

- the questions are adapted to the business domain;
- the questions are understandable for the stakeholder audience;
- irrelevant or overly technical questions are removed;
- sensitive or confidential topics are handled carefully;
- the meeting objective is clear;
- the expected meeting output is clear;
- the checklist supports the creation of high-quality raw meeting notes;
- the checklist covers business, functional, visual, data, security, and validation aspects.

---

# Next Step

After the meeting, use the collected answers, notes, and transcript excerpts to complete:

- `raw_notes_template.md`
