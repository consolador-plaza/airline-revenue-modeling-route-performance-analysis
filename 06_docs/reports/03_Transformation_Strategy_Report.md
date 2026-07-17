# 03_Transformation_Strategy_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 03

**Document Type:** Report

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial transformation strategy |
| 2.0 | July 2026 | Updated to reflect validated implementation, analytical grain refinement, and final SQL transformation methodology |

---

# 1. Purpose

This report documents the transformation strategy used to prepare the BTS T100 Segment and DB1B Market datasets for analytical integration.

The report describes the transformation decisions, validation outcomes, analytical grain, aggregation methodology, and implementation refinements that resulted in the final analytical dataset (`route_performance_analytics`).

Unlike the initial planning document, this report reflects the **validated transformation strategy** implemented following SQL development and integration testing.

---

# 2. Scope

This report covers:

- Source dataset preparation
- Analytical grain selection
- Route definition
- Data transformations
- Aggregation methodology
- Fare weighting methodology
- Validation-driven design decisions
- Risks and assumptions

Dataset integration and validation are documented separately in the Dataset Integration Report.

---

# 3. Source Datasets

| Dataset | Purpose |
|----------|---------|
| BTS T100 Segment | Operational flight activity (passengers and seats) |
| BTS DB1B Market | Passenger fare survey used for weighted fare estimation |

Both datasets were transformed independently before integration.

---

# 4. Transformation Objectives

The transformation process was designed to:

- Standardize both datasets.
- Create a common analytical grain.
- Preserve passenger-weighted commercial metrics.
- Maximize analytical coverage.
- Produce a reusable analytical dataset suitable for SQL analysis and Power BI reporting.

---

# 5. Analytical Grain

## Initial Design

The original analytical grain proposed during planning was:

```
Year
Quarter
Carrier
Origin
Destination
```

Carrier identifiers were initially retained to support potential carrier-level analysis.

---

## Validation Outcome

SQL validation demonstrated that carrier-level integration substantially reduced analytical coverage.

Key findings included:

- Approximately **46%** carrier-level route matching.
- Approximately **99.6%** passenger representation using route-quarter integration.

---

## Final Analytical Grain

The implemented analytical dataset uses:

```
Year
Quarter
Origin
Destination
```

This analytical grain maximizes commercial coverage while supporting the project's business objectives.

---

# 6. Route Definition

Airport routes are treated as **directional**.

Example:

```
LAX → JFK

≠

JFK → LAX
```

Directionality was preserved throughout the transformation process to maintain operational accuracy.

---

# 7. Airport Pair

For reporting purposes, a derived Airport Pair field is created within the semantic model.

Example:

```
Origin

-

Destination

↓

LAX - JFK
```

This field improves dashboard readability while preserving the underlying analytical grain.

---

# 8. T100 Transformation

The T100 dataset was aggregated to the implemented analytical grain.

Aggregated measures include:

- Passengers
- Seats

Grouping columns:

- Year
- Quarter
- Origin
- Destination

Carrier identifiers were excluded from the final analytical model following validation.

---

# 9. DB1B Transformation

DB1B records were aggregated independently using passenger-weighted fare calculations.

Grouping columns:

- Year
- Quarter
- Origin
- Destination

Primary output:

- Weighted Average Fare

---

# 10. Weighted Fare Methodology

Average fare is calculated using passenger-weighted aggregation.

```
SUM(Fare × Passengers)

÷

SUM(Passengers)
```

This methodology preserves the contribution of high-volume markets and avoids statistical distortion caused by simple averaging.

The weighted fare calculation forms the basis of the project's estimated passenger revenue model.

---

# 11. Validation-Driven Refinements

Several transformation decisions evolved during implementation.

| Original Approach | Validation Outcome | Final Decision |
|-------------------|-------------------|----------------|
| Carrier-level analytical grain | Reduced coverage | Removed carrier |
| Average fare aggregation | Double averaging identified | Passenger-weighted aggregation |
| Dashboard-derived Airport Pair | Reporting convenience | Created in semantic model |

These refinements were introduced following SQL validation rather than initial design assumptions.

---

# 12. Assumptions

The implemented transformation strategy assumes:

- Route-quarter aggregation is appropriate for commercial analysis.
- Passenger-weighted fares provide representative pricing.
- Route direction is operationally significant.
- Quarterly aggregation adequately supports the project's business objectives.

---

# 13. Risks

| Risk | Mitigation |
|------|------------|
| Carrier-level inconsistency | Removed carrier from analytical grain |
| Statistical bias from averaging | Passenger-weighted methodology |
| Route matching limitations | Passenger coverage validation |
| Quarterly aggregation | Documented as analytical limitation |

---

# 14. Relationship to Project Documentation

This report supports:

| Document | Relationship |
|----------|--------------|
| 04 Dataset Integration Report | Transformation inputs |
| 05 Analytical Evidence Specification | Analytical methodology |
| 06 Dashboard Design Specification | Source transformations |
| 07 Master Traceability Matrix | Transformation traceability |

---

# 15. Conclusion

The transformation strategy successfully standardized two independent BTS datasets into a consistent analytical structure suitable for integration and business intelligence.

Implementation refinements driven by SQL validation strengthened the analytical model by improving statistical accuracy, increasing passenger coverage, and simplifying the analytical grain.

The resulting transformation methodology provides the foundation for the `route_performance_analytics` dataset and supports all subsequent SQL validation, Power BI reporting, and analytical findings documented throughout this project.