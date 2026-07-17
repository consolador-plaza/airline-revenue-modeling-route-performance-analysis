# 04_Dataset_Integration_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 04

**Document Type:** Report

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial dataset integration report |
| 2.0 | July 2026 | Updated to reflect the final analytical dataset, Power BI semantic model, and implementation alignment |

---

# 1. Purpose

This report documents the integration of the BTS T100 Segment and DB1B Market datasets into a unified analytical dataset supporting the Airline Route Performance & Estimated Passenger Revenue Analysis project.

It describes the integration methodology, validation activities, analytical coverage, and resulting data model used throughout the SQL analysis, Power BI dashboard, and supporting documentation.

This report serves as the authoritative reference for the construction of the project's analytical dataset.

---

# 2. Scope

This report covers:

- Source datasets
- Integration methodology
- Join validation
- Passenger coverage analysis
- Revenue estimation methodology
- Derived analytical fields
- Final analytical dataset
- Data lineage
- Risks and limitations

Dashboard implementation and analytical findings are documented separately in:

- 05_Analytical_Evidence_Specification
- 06_Dashboard_Design_Specification

---

# 3. Source Datasets

| Dataset | Description |
|----------|-------------|
| BTS T100 Segment | Quarterly operational flight activity including passengers and available seats |
| BTS DB1B Market | Quarterly passenger fare survey used to estimate weighted average fares |

These publicly available BTS datasets provide complementary operational and commercial information required for estimating passenger revenue.

---

# 4. Integration Strategy

The integration process was designed to combine operational and fare data at the **route-quarter** level.

Initial validation evaluated both carrier-level and route-level integration strategies.

Validation demonstrated that route-quarter integration produced substantially greater analytical coverage while preserving approximately **99.6%** of passenger volume.

As a result, the implemented analytical model excludes carrier identifiers from the analytical grain.

---

# 5. Integration Workflow

```
BTS T100 Segment
        │
        ▼
Quarterly Route Aggregation
        │
        │
DB1B Market
        │
        ▼
Passenger-Weighted Fare Aggregation
        │
        ▼
Coverage Validation
        │
        ▼
route_performance_analytics
        │
        ▼
Power BI Semantic Model
        │
        ▼
Interactive Dashboard
```

---

# 6. Revenue Estimation Methodology

Passenger revenue is estimated using passenger-weighted average fares derived from DB1B.

The implemented methodology is:

```
Estimated Passenger Revenue

=

Passengers

×

Weighted Average Fare
```

Weighted Average Fare is calculated as:

```
SUM(Fare × Passengers)

÷

SUM(Passengers)
```

This methodology avoids double averaging and preserves statistical accuracy across aggregated routes.

---

# 7. Integration Validation

Validation was performed throughout the integration process.

## Route Matching

Route-quarter combinations were validated between both datasets before analytical integration.

---

## Passenger Coverage

The implemented integration strategy captures approximately:

- **57%** of distinct route-quarter combinations
- **99.6%** of transported passengers

Although route coverage appears moderate, passenger coverage confirms that nearly all commercial traffic is represented.

---

## Revenue Validation

Estimated passenger revenue was reconciled against weighted fare calculations and passenger totals.

Validation confirmed internal consistency across all integrated metrics.

---

# 8. Final Analytical Dataset

The implemented analytical dataset is:

```
route_performance_analytics
```

This dataset serves as the analytical source of truth for:

- SQL validation
- Power BI semantic model
- Dashboard measures
- Analytical evidence
- Technical documentation

---

## Primary Fields

Operational

- Year
- Quarter
- Origin
- Destination
- Passengers
- Seats

Commercial

- Weighted Average Fare
- Estimated Passenger Revenue

Derived

- Airport Pair
- Load Factor
- Quarter Start Date

Additional reporting fields may be created within Power BI where appropriate, while preserving the SQL dataset as the authoritative analytical source.

---

# 9. Data Lineage

The complete analytical lineage is shown below.

```
Raw BTS Data

(T100 Segment)

+

(DB1B Market)

↓

SQL Transformation

↓

route_performance_analytics

↓

SQL Validation

↓

Power BI Semantic Model

↓

Interactive Dashboard

↓

Analytical Documentation
```

---

# 10. Risks and Limitations

The analytical dataset should be interpreted alongside the following considerations.

- Estimated passenger revenue represents an analytical estimate rather than reported airline financial revenue.
- Carrier-level analysis was intentionally excluded to maximize analytical coverage.
- Quarterly aggregation does not capture within-quarter seasonality.
- Route coverage is lower than passenger coverage because many low-volume routes are excluded during integration.

---

# 11. Relationship to Project Documentation

This report supports the following documents.

| Document | Relationship |
|----------|--------------|
| 05 Analytical Evidence Specification | Source dataset for validated findings |
| 06 Dashboard Design Specification | Source dataset for dashboard implementation |
| 07 Master Traceability Matrix | Analytical source of truth |
| 08 QA Audit Report | Dataset validation reference |

---

# 12. Conclusion

The dataset integration process successfully combined operational flight activity with passenger fare information into a validated analytical dataset suitable for commercial analysis.

The resulting `route_performance_analytics` dataset serves as the project's analytical source of truth and underpins all SQL validation, Power BI measures, dashboard visualizations, and analytical findings presented throughout the Airline Route Performance & Estimated Passenger Revenue Analysis project.

The integration methodology prioritizes analytical accuracy, statistical validity, and business applicability while maintaining complete traceability across the project's technical and governance documentation.