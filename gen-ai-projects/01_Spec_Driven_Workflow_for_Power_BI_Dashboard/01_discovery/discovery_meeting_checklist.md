# Discovery Meeting Checklist

## Purpose

This checklist is used to prepare and conduct the initial discovery meeting for a Power BI dashboard project.

Its goal is to collect structured business input before creating dashboard requirements, KPI definitions, functional specifications, and design documentation.

## When to Use

Use this checklist before or during a meeting with:

- business stakeholders;
- dashboard requesters;
- product owners;
- managers;
- operational teams;
- reporting users.

## Meeting Preparation

Before the meeting, clarify:

- who requested the dashboard;
- who will use it;
- what business process it supports;
- whether any existing reports already exist;
- whether examples or screenshots are available;
- whether the meeting can be recorded or only notes will be taken.

## Discovery Questions

### 1. Business Context

- What business domain does the dashboard cover?
- What process, team, or activity should the dashboard support?
- Why is this dashboard needed now?
- What current pain point should it solve?

### 2. Dashboard Objective

- What is the main purpose of the dashboard?
- What decisions should users make based on it?
- What should users understand within the first few minutes?
- What would make this dashboard successful?

### 3. Target Users

- Who are the main users?
- Are they executives, managers, operational users, or analysts?
- How often will they use the dashboard?
- What level of detail do they need?

### 4. KPIs and Metrics

- Which KPIs are mandatory?
- Which metrics are optional?
- Are the KPI definitions already agreed?
- Who owns or validates each KPI?
- Are there any conflicting definitions?

### 5. Data Sources

- Which systems or files contain the required data?
- Who owns these sources?
- How often is the data updated?
- Are there known data quality issues?

### 6. Filters and Dimensions

- Which filters should users have?
- Which dimensions are required: date, country, product, client, team, status?
- What default view should users see?
- Is drill-down or drill-through needed?

### 7. Visual Expectations

- Does the client have examples of dashboards they like?
- Should the dashboard be executive, operational, exploratory, or detailed?
- Are there corporate branding rules?
- Are there preferred or forbidden visual types?

### 8. Delivery and Validation

- Who will validate the dashboard?
- What is the expected deadline?
- What are the acceptance criteria?
- What should be confirmed before the build phase starts?

## Generative AI Prompt

Use this prompt to adapt the checklist to a specific business context.

```text
You are a senior BI consultant preparing a discovery meeting for a Power BI dashboard project.

Context:
- Business domain: [insert domain]
- Target users: [insert users]
- Dashboard objective: [insert known objective]
- Current business problem: [insert known problem]

Create a customized discovery meeting checklist with questions grouped by:
1. Business context
2. Dashboard objective
3. Target users
4. KPIs and metrics
5. Data sources
6. Filters and dimensions
7. Visual expectations
8. Validation and delivery

The questions should be specific, professional, and suitable for a business stakeholder meeting.
