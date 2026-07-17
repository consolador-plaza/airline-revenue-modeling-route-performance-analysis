# 01_Data_Understanding_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 01

**Document Type:** Report

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial data understanding and feasibility assessment |
| 2.0 | July 2026 | Updated with implementation outcomes and documentation alignment |

---

# 1. Purpose

This report documents the initial data understanding phase of the Airline Route Performance & Estimated Passenger Revenue Analysis project.

The objective of this phase was to evaluate the suitability of the BTS T100 Segment and DB1B Market datasets for integration, identify potential analytical risks, and determine whether the available data could support the project's business objectives.

This document represents the starting point of the project's analytical lifecycle.

---

# 2. Scope

This report covers:

- Source dataset profiling
- Data quality assessment
- Initial feasibility analysis
- Route compatibility assessment
- Carrier assessment
- Risks and assumptions
- Implementation outcomes

Subsequent transformation, integration, validation, and analytical implementation are documented in later project reports.

---

# 3. Source Datasets

The project utilizes two publicly available datasets published by the U.S. Bureau of Transportation Statistics (BTS).

| Dataset | Description |
|----------|-------------|
| BTS T100 Segment | Quarterly operational flight activity including passengers and available seats |
| BTS DB1B Market | Quarterly passenger fare survey used to estimate weighted average fares |

These datasets provide complementary operational and commercial information suitable for analytical integration.

---

# 4. Initial Data Quality Assessment

The initial assessment focused on:

- Dataset completeness
- Required analytical fields
- Temporal coverage
- Route consistency
- Missing values
- Identifier compatibility

The review concluded that both datasets contained sufficient information to support the project's analytical objectives.

No material data quality issues were identified that would prevent integration.

---

# 5. Initial Feasibility Assessment

The project investigated whether operational flight activity and passenger fare information could be integrated using common route characteristics.

The initial assessment concluded that:

- Route-level integration appeared feasible.
- Temporal alignment was achievable using Year and Quarter.
- Passenger-weighted fare estimation could support commercial analysis.

These findings justified proceeding to the transformation phase.

---

# 6. Route Compatibility Assessment

Initial route profiling demonstrated that both datasets shared common geographic attributes:

- Origin Airport
- Destination Airport
- Year
- Quarter

These shared dimensions provided a suitable foundation for analytical integration.

Subsequent implementation confirmed that route-quarter integration produced the most effective analytical model.

---

# 7. Carrier Assessment

During the planning phase, carrier identifiers were considered as potential components of the analytical grain.

### Initial Observation

Carrier information appeared suitable for analytical integration.

### Implementation Outcome

SQL validation later demonstrated that carrier-level integration significantly reduced analytical coverage.

The final analytical model therefore adopted a route-quarter grain without carrier identifiers.

This refinement is documented in the Transformation Strategy Report and Dataset Integration Report.

---

# 8. Initial Risks

The following risks were identified during the data understanding phase.

| Risk | Initial Assessment | Final Outcome |
|------|--------------------|---------------|
| Carrier consistency | Monitor | Mitigated through revised analytical grain |
| Route matching | Validate | Successfully validated |
| Fare aggregation | Validate | Implemented using passenger-weighted methodology |
| Revenue estimation | Analytical estimate | Successfully implemented |

All identified risks were either validated or mitigated during subsequent project phases.

---

# 9. Implementation Outcomes

The initial feasibility assessment proved to be accurate.

Key implementation outcomes include:

### Data Integration

Successfully integrated operational and fare datasets into the `route_performance_analytics` analytical dataset.

---

### SQL Validation

Confirmed that passenger-weighted analytical coverage represented approximately **99.6%** of transported passengers.

---

### Revenue Estimation

Implemented a statistically valid passenger-weighted revenue estimation methodology.

---

### Dashboard Development

Successfully developed a five-page Power BI dashboard aligned with validated analytical findings.

---

### Governance

Established complete analytical traceability through:

- Analytical Evidence Specification
- Dashboard Design Specification
- Master Traceability Matrix
- QA Audit Report

---

# 10. Relationship to Project Documentation

This report establishes the foundation for the remaining project documentation.

| Document | Relationship |
|----------|--------------|
| 02 Planning Report | Business objectives |
| 03 Transformation Strategy Report | Technical implementation |
| 04 Dataset Integration Report | Analytical dataset construction |
| 05 Analytical Evidence Specification | Validated findings |
| 06 Dashboard Design Specification | Business intelligence implementation |

---

# 11. Lessons from the Data Understanding Phase

Several important lessons emerged during the project.

- Early feasibility assessments should be validated through implementation rather than treated as final conclusions.
- Passenger coverage is a more meaningful measure of analytical representativeness than route coverage alone.
- Analytical grain should be determined using empirical evidence.
- Public datasets can support sophisticated business intelligence when combined through appropriate statistical methodology.

These lessons informed several implementation decisions throughout the project.

---

# 12. Conclusion

The Data Understanding phase successfully established the feasibility of integrating BTS operational and fare datasets for commercial route analysis.

The subsequent implementation validated the majority of the initial assumptions while refining several technical decisions through SQL validation and analytical testing.

The findings documented in this report provided the foundation for the transformation strategy, dataset integration, analytical validation, and business intelligence solution delivered in Version 2.0 of the Airline Route Performance & Estimated Passenger Revenue Analysis project.