# Data Contract and Mapping Template

## Purpose

This document defines the data contract and source-to-target mapping for a Snowflake SQL stored procedure or complex SQL automation.

It captures source objects, target object expectations, target grain, field-level mapping, join logic, filters, transformation rules, data quality checks, Snowflake-specific considerations, risks, and open questions before stored procedure logic is designed.

This document must be completed and reviewed before generating Snowflake SQL code.

---

## 1. Source Information

| Field | Value |
|---|---|
| Source request brief | [`../01_requirement_discovery/02_sql_request_brief_template.md`](../01_requirement_discovery/02_sql_request_brief_template.md) |
| Created with prompt | [`01_gen_ai_prompt_create_data_contract_and_mapping.md`](./01_gen_ai_prompt_create_data_contract_and_mapping.md) |
| Generated with Generative AI | Yes / No |
| Manually reviewed by Data Engineer | Yes / No |
| Ready for Procedure Logic Design | Yes / Conditional / No |

---

## 2. Data Contract Summary

```text
[Summarize the expected data contract in 3–5 sentences.

Include:
- target object;
- source object categories;
- expected target grain;
- high-level transformation need;
- unresolved data dependencies.]
```

---

## 3. Target Object Specification

| Item | Description |
|---|---|
| Target database | |
| Target schema | |
| Target table / object | |
| Fully qualified target name | `DATABASE.SCHEMA.OBJECT` / To be confirmed |
| Target object type | Table / Transient table / Temporary table / View / To be confirmed |
| Target grain | |
| Expected load behavior | Insert / Append / Merge / Reload / Validate only / To be confirmed |
| Existing data behavior | Append / Skip / Merge / Delete and reload / Fail / To be confirmed |
| Historical data preservation | Yes / No / To be confirmed |
| Duplicate prevention required | Yes / No / To be confirmed |
| Target owner | To be confirmed |
| Target usage / downstream consumers | To be confirmed |

---

## 4. Target Column Specification

| Target column | Expected Snowflake data type | Nullable? | Business meaning | Source / Derivation | Status |
|---|---|---|---|---|---|
| | | Yes / No / To be confirmed | | Direct / Derived / Default / Generated metadata / To be confirmed | Confirmed / To be confirmed |

### Technical Metadata Columns

| Column | Purpose | Expected value / Logic | Required? | Status |
|---|---|---|---|---|
| `LOAD_TIMESTAMP` | Load execution timestamp | Current execution timestamp / To be confirmed | Yes / No / To be confirmed | |
| `BATCH_ID` | Load batch identifier | Generated / Provided as parameter / To be confirmed | Yes / No / To be confirmed | |
| `SOURCE_SYSTEM` | Source system identifier | Static / Derived / To be confirmed | Yes / No / To be confirmed | |
| `PROCEDURE_RUN_ID` | Procedure execution identifier | Generated / To be confirmed | Yes / No / To be confirmed | |

---

## 5. Source Object Inventory

| Source ID | Source object | Object type | Grain | Required fields | Freshness / availability | Status |
|---|---|---|---|---|---|---|
| SRC-001 | `DATABASE.SCHEMA.OBJECT` / To be confirmed | Table / View / External table / Stream / Stage / File / Semi-structured source / To be confirmed | | | | Confirmed / To be confirmed |

---

## 6. Source-to-Target Mapping

| Target column | Source object | Source column / expression | Mapping type | Transformation rule | Required? | Status |
|---|---|---|---|---|---|---|
| | | | Direct / Derived / Default value / Generated metadata / Lookup / Aggregation / Conditional logic / To be confirmed | | Yes / No / To be confirmed | Confirmed / To be confirmed |

---

## 7. Join and Relationship Logic

| Join ID | Left source | Right source | Join keys | Join type | Expected cardinality | Risk / Notes |
|---|---|---|---|---|---|---|
| JOIN-001 | | | | Inner / Left / Right / Full outer / Cross / To be confirmed | One-to-one / One-to-many / Many-to-one / Many-to-many / To be confirmed | |

---

## 8. Filter and Exclusion Rules

| Rule ID | Filter / Exclusion rule | Applies to | Business reason | Status |
|---|---|---|---|---|
| FILT-001 | | Source / Target / Intermediate dataset / To be confirmed | | Confirmed / To be confirmed |

---

## 9. Transformation Rules

| Rule ID | Transformation rule | Input fields | Output field | Status |
|---|---|---|---|---|
| TRF-001 | | | | Confirmed / To be confirmed |

---

## 10. Data Quality Rules

| Check ID | Data quality check | Applies to | Expected behavior if failed | Blocking? |
|---|---|---|---|---|
| DQ-001 | Required field not null / Uniqueness / Duplicate detection / Valid date range / Valid values / Referential consistency / Record count check / Casting risk / Other | | Fail procedure / Skip record / Log warning / Quarantine / To be confirmed | Yes / No / To be confirmed |

---

## 11. Incremental or Reload Logic Requirements

| Topic | Requirement | Status |
|---|---|---|
| Load mode | Full reload / Incremental / Append-only / Merge / Validate only / To be confirmed | |
| Incremental key / watermark | | To be confirmed |
| Late-arriving data handling | | To be confirmed |
| Reprocessing behavior | | To be confirmed |
| Duplicate prevention logic | | To be confirmed |
| Existing target data handling | | To be confirmed |
| Expected row count logic | | To be confirmed |

---

## 12. Snowflake-Specific Considerations

| Topic | Requirement / Consideration | Status |
|---|---|---|
| Fully qualified object names | Use `DATABASE.SCHEMA.OBJECT` where confirmed. | To be confirmed |
| Identifier case sensitivity | Confirm whether quoted identifiers are required. | To be confirmed |
| Data type compatibility | Confirm Snowflake data types for target columns. | To be confirmed |
| Semi-structured data handling | Confirm use of `VARIANT`, `OBJECT`, `ARRAY`, or path extraction if relevant. | To be confirmed |
| Time zone / timestamp handling | Confirm expected use of `TIMESTAMP_NTZ`, `TIMESTAMP_LTZ`, or `TIMESTAMP_TZ`. | To be confirmed |
| Large table / scan risk | Identify large source objects or expensive scans. | To be confirmed |
| Clustering / pruning consideration | Confirm if clustering or partition-pruning logic is relevant. | To be confirmed |
| Warehouse / performance expectation | Confirm expected warehouse and performance constraints. | To be confirmed |
| Object ownership / grants | Confirm required privileges and ownership model. | To be confirmed |
| Execution context dependency | Confirm whether the future procedure should use caller or owner rights. | To be confirmed |

---

## 13. Assumptions

| Assumption | Reason | Needs confirmation? |
|---|---|---|
| | | Yes / No |

---

## 14. Data Risks and Dependencies

| Risk / Dependency | Area | Impact | Required action |
|---|---|---|---|
| | Source availability / Mapping / Join logic / Grain mismatch / Data quality / Security / Performance / Other | High / Medium / Low | |

---

## 15. Open Questions

| Question | Owner | Priority | Blocking for Procedure Logic Design? |
|---|---|---|---|
| | Business owner / Data owner / Data Engineer / To be confirmed | High / Medium / Low | Yes / No |

---

## 16. Readiness Assessment

| Item | Assessment |
|---|---|
| Data contract ready for procedure logic design? | Yes / Conditional / No |
| Source objects confirmed? | Yes / Partial / No |
| Target structure confirmed? | Yes / Partial / No |
| Source-to-target mapping complete? | Yes / Partial / No |
| Join logic clear? | Yes / Partial / No |
| Filter and transformation logic clear? | Yes / Partial / No |
| Data quality expectations clear? | Yes / Partial / No |
| Main blockers | |
| Required confirmations | |
| Recommended next step | Move to procedure logic design / Clarify mapping / Rework data contract |

---

## Output of This Document

This Data Contract and Mapping document is used as input for:

- [`../03_procedure_logic_design/01_gen_ai_prompt_create_procedure_design_specification.md`](../03_procedure_logic_design/01_gen_ai_prompt_create_procedure_design_specification.md)
- [`../03_procedure_logic_design/02_procedure_design_specification_template.md`](../03_procedure_logic_design/02_procedure_design_specification_template.md)

Before moving to the next phase, all blocking data, mapping, grain, join, and target object questions must be clarified or explicitly accepted as pending.
