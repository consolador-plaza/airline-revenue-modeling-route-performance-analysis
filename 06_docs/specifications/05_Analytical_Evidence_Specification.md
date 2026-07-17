# 05_Analytical_Evidence_Specification

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 05

**Document Type:** Specification

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial analytical evidence register |
| 2.0 | July 2026 | Converted into governing analytical specification with complete dashboard traceability and implementation alignment |

---

# 1. Purpose

The **Analytical Evidence Specification** serves as the authoritative register of validated analytical findings for the Airline Route Performance & Estimated Passenger Revenue Analysis project.

Each analytical finding documented within this specification has been:

- Validated through SQL against the `route_performance_analytics` analytical dataset.
- Reviewed during the Quality Assurance audit.
- Mapped to the implemented Power BI dashboard.
- Referenced by the project's technical documentation.

This specification establishes the analytical source of truth for the project and ensures consistency between data, implementation, and business communication.

---

# 2. Scope

This specification governs all validated analytical findings presented throughout the project.

Specifically, it defines:

- Business questions answered by the analysis.
- Supporting SQL validation.
- Analytical findings.
- Business interpretation.
- Business implications.
- Confidence assessment.
- Dashboard implementation.
- Documentation traceability.

This document does **not** describe SQL implementation details or dashboard design decisions except where necessary to establish analytical traceability.

---

# 3. Dependencies

This specification depends upon the successful completion of the following project stages.

| Document | Purpose |
|----------|---------|
| 01 Data Understanding Report | Dataset profiling and feasibility assessment |
| 02 Planning Report | Business objectives and analytical questions |
| 03 Transformation Strategy Report | SQL transformation methodology |
| 04 Dataset Integration Report | Construction and validation of the analytical dataset |

---

# 4. Analytical Methodology

Analytical findings were produced using SQL queries executed against the validated analytical dataset:

```

route_performance_analytics

```

The analytical workflow followed the process below.

```

Raw BTS Data

↓

SQL Transformation

↓

Analytical Dataset

↓

SQL Validation

↓

Analytical Findings

↓

Power BI Dashboard

↓

Business Insights

```

Only findings that successfully passed SQL validation were incorporated into the dashboard and supporting documentation.

---

# 5. Evidence Classification

Each analytical finding is classified according to the following framework.

| Attribute | Description |
|------------|-------------|
| Business Question | Analytical objective being addressed |
| SQL Validation | Supporting SQL analysis |
| Finding | Validated analytical result |
| Business Interpretation | Practical meaning of the result |
| Business Implication | Potential business relevance |
| Confidence | Analytical confidence level |
| Dashboard Mapping | Implemented Power BI page and visual |
| Documentation Reference | Supporting documentation |

Confidence ratings are defined as:

| Rating | Definition |
|---------|------------|
| High | Directly validated with complete supporting evidence |
| Medium | Supported by analytical evidence with stated assumptions |
| Low | Exploratory finding requiring further validation |

---

# 6. Analytical Evidence Register

## AE-01 — Revenue Estimation Coverage

**Business Question**

How representative is the estimated passenger revenue model?

**SQL Validation**

Revenue estimation coverage analysis.

**Finding**

Route-quarter integration captures approximately **99.6% of passenger volume**, despite matching a smaller proportion of distinct routes.

**Business Interpretation**

Passenger-weighted coverage demonstrates that the analytical dataset is highly representative of commercial activity.

**Business Implication**

The estimated revenue model is suitable for network-level commercial analysis.

**Confidence**

High

**Dashboard Mapping**

Methodological finding (not directly visualized).

**Documentation**

Dataset Integration Report

---

## AE-02 — Revenue Concentration

**Business Question**

Is estimated passenger revenue concentrated among a small number of airport pairs?

**Finding**

Estimated passenger revenue is concentrated among relatively few airport pairs.

**Business Interpretation**

Commercial performance is driven by a limited number of strategically important markets.

**Business Implication**

High-revenue airport pairs warrant focused commercial and operational attention.

**Confidence**

High

**Dashboard Mapping**

Executive Overview

Revenue Analysis → Top Airport Pairs

---

## AE-03 — Revenue Distribution

**Business Question**

How is estimated passenger revenue distributed across the network?

**Finding**

Revenue distribution is positively skewed, with a small number of exceptionally high-performing markets.

**Business Interpretation**

Median revenue provides a more representative measure of a typical airport pair than the arithmetic mean.

**Business Implication**

Median-based KPIs improve executive interpretation.

**Confidence**

High

**Dashboard Mapping**

Revenue Analysis

Median Revenue KPI

---

## AE-04 — Passenger Demand Concentration

**Business Question**

Where is passenger demand concentrated?

**Finding**

Passenger demand is concentrated among major airport pairs.

**Business Interpretation**

Network demand is unevenly distributed.

**Business Implication**

High-demand markets should remain priority routes for capacity planning.

**Confidence**

High

**Dashboard Mapping**

Demand Analysis

Top Airport Pairs

Passengers by Origin

---

## AE-05 — Passenger Demand and Revenue Relationship

**Business Question**

Does passenger demand drive estimated passenger revenue?

**Finding**

Passenger volume exhibits a strong positive relationship with estimated passenger revenue.

**Business Interpretation**

Demand is the primary commercial driver of revenue generation.

**Business Implication**

Passenger demand should remain a primary planning metric.

**Confidence**

High

**Dashboard Mapping**

Demand Analysis

Revenue vs Passengers Scatter Plot

---

## AE-06 — Quarterly Revenue Trend

**Business Question**

How has estimated passenger revenue changed over time?

**Finding**

Quarterly estimated passenger revenue exhibits an overall positive trend during the study period.

**Business Interpretation**

Network revenue remained resilient across observed quarters.

**Business Implication**

Quarterly monitoring supports executive performance reviews.

**Confidence**

High

**Dashboard Mapping**

Executive Overview

Quarterly Revenue Trend

---

## AE-07 — Capacity Utilization

**Business Question**

How efficiently is available seat capacity utilized?

**Finding**

Most airport pairs operate within healthy load factor ranges.

**Business Interpretation**

The network generally demonstrates effective seat utilization.

**BusinessImplication**

Capacity planning appears broadly aligned with observed passenger demand.

**Confidence**

High

**Dashboard Mapping**

Capacity & Utilization

Load Factor KPI

Top Airport Pairs by Load Factor

Load Factor vs Passengers

---

## AE-08 — Capacity Anomalies

**Business Question**

Are there notable operational anomalies?

**Finding**

A small number of airport pairs exhibit unusually high load factors requiring operational review.

**Business Interpretation**

Extreme load factors may indicate data quality issues or operational exceptions.

**Business Implication**

These markets should be investigated before operational conclusions are drawn.

**Confidence**

Medium

**Dashboard Mapping**

Capacity Insights Narrative

---

## AE-09 — Commercial Performance

**Business Question**

Which airport pairs generate the strongest commercial performance?

**Finding**

Commercial performance is concentrated among a relatively small number of airport pairs.

**Business Interpretation**

High-performing routes combine demand, pricing, and capacity efficiency.

**Business Implication**

These markets should inform future network planning.

**Confidence**

High

**Dashboard Mapping**

Revenue Analysis

Top Airport Pairs

Route Performance

Highest Yield Markets

---

## AE-10 — Pricing and Utilization

**Business Question**

How do pricing and utilization differentiate airport pairs?

**Finding**

Average fare and load factor jointly distinguish premium markets from high-volume markets.

**Business Interpretation**

Strong commercial performance is achieved through different combinations of pricing and utilization.

**Business Implication**

Pricing and capacity strategies should be evaluated together rather than independently.

**Confidence**

High

**Dashboard Mapping**

Route Performance

Load Factor vs Average Fare

---

# 7. Dashboard Traceability

| Dashboard Page | Supporting Evidence |
|----------------|---------------------|
| Executive Overview | AE-01, AE-02, AE-03, AE-06 |
| Revenue Analysis | AE-02, AE-03, AE-09 |
| Demand Analysis | AE-04, AE-05 |
| Capacity & Utilization | AE-07, AE-08 |
| Route Performance | AE-09, AE-10 |

---

# 8. Evidence Coverage Matrix

| Evidence | SQL | Dashboard | Documentation |
|----------|:---:|:---------:|:-------------:|
| AE-01 | ✅ | N/A | ✅ |
| AE-02 | ✅ | ✅ | ✅ |
| AE-03 | ✅ | ✅ | ✅ |
| AE-04 | ✅ | ✅ | ✅ |
| AE-05 | ✅ | ✅ | ✅ |
| AE-06 | ✅ | ✅ | ✅ |
| AE-07 | ✅ | ✅ | ✅ |
| AE-08 | ✅ | Narrative | ✅ |
| AE-09 | ✅ | ✅ | ✅ |
| AE-10 | ✅ | ✅ | ✅ |

---

# 9. Limitations

The analytical findings should be interpreted alongside the following considerations.

- Estimated passenger revenue is derived from passenger volumes and DB1B weighted fares and should not be interpreted as reported airline financial revenue.
- Carrier-level analysis was intentionally excluded following integration validation to maximize analytical coverage.
- Findings are based on quarterly aggregated data and do not capture monthly or seasonal variation within quarters.
- Operational anomalies identified through load factor analysis should be investigated using additional operational datasets before drawing definitive conclusions.

---

# 10. Governance Statement

This specification constitutes the authoritative register of validated analytical findings for the Airline Route Performance & Estimated Passenger Revenue Analysis project.

All SQL validation, Power BI measures, dashboard visualizations, technical documentation, and business conclusions shall remain consistent with the evidence documented herein.

Any future enhancement to the analytical model should update this specification before implementation.

---

# 11. Conclusion

The Analytical Evidence Specification establishes a complete and traceable record of the validated analytical findings supporting the Airline Route Performance & Estimated Passenger Revenue Analysis project.

Each finding has been empirically validated, reconciled with the Power BI implementation, and linked to the project's supporting documentation.

This specification serves as the analytical foundation for Version 2.0 of the project and provides the governing reference for all business insights presented throughout the accompanying dashboard and technical documentation.