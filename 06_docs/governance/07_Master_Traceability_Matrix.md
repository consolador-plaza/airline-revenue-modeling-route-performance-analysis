# 07_Master_Traceability_Matrix

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 07

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

## Purpose

The Master Traceability Matrix provides end-to-end traceability across the Airline Route Performance & Estimated Passenger Revenue Analysis project.

It establishes a single governance framework linking business objectives, SQL validation, analytical evidence, Power BI implementation, and project documentation. This document serves as the authoritative reference for ensuring consistency throughout the project lifecycle.

---

## Traceability Framework

The project follows the validation path below:

Business Question

↓

SQL Validation

↓

Analytical Evidence

↓

Power BI Dashboard

↓

Technical Documentation

↓

Business Insight

Every reported finding can be traced through each stage of this framework.

---

# Traceability Matrix

| Business Question | SQL Validation | Analytical Evidence | Dashboard Page | Primary Visual | Documentation |
|-------------------|---------------|---------------------|----------------|----------------|---------------|
| How much estimated passenger revenue is represented after integration? | Revenue estimation validation | AE-01 | Executive Overview | KPI Cards | 04 Dataset Integration Report |
| Is revenue concentrated among a small number of airport pairs? | Revenue concentration analysis | AE-02 | Revenue Analysis | Top Airport Pairs | 05 Analytical Evidence Register |
| How is revenue distributed across the network? | Revenue distribution analysis | AE-03 | Revenue Analysis | Median Revenue KPI | 05 Analytical Evidence Register |
| Where is passenger demand concentrated? | Passenger concentration analysis | AE-04 | Demand Analysis | Top Airport Pairs | 05 Analytical Evidence Register |
| Does passenger demand drive estimated passenger revenue? | Correlation analysis | AE-05 | Demand Analysis | Revenue vs Passengers Scatter Plot | 05 Analytical Evidence Register |
| How has network revenue changed over time? | Quarterly trend analysis | AE-06 | Executive Overview | Quarterly Revenue Trend | Technical Report |
| How efficiently is available seat capacity utilized? | Load factor analysis | AE-07 | Capacity & Utilization | Load Factor Visuals | Technical Report |
| Are there notable operational anomalies? | Load factor anomaly validation | AE-08 | Capacity & Utilization | Capacity Insights | Technical Report |
| Which airport pairs generate the strongest commercial performance? | Revenue ranking analysis | AE-09 | Revenue Analysis / Route Performance | Highest Yield Markets | Technical Report |
| How do pricing and utilization differentiate markets? | Yield analysis | AE-10 | Route Performance | Load Factor vs Average Fare | Technical Report |

---

# Data Lineage

The implemented analytical workflow is illustrated below.

Raw BTS Data

(DB1B Market)

+

(T100 Segment)

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

Project Documentation

↓

Business Recommendations

---

# Source of Truth Hierarchy

The project adopts the following hierarchy for governance.

| Priority | Artifact | Purpose |
|----------|-----------|---------|
| 1 | SQL Views (`route_performance_analytics`) | Authoritative analytical dataset |
| 2 | SQL Validation Queries | Validation of analytical results |
| 3 | Analytical Evidence Register | Validated business findings |
| 4 | Power BI Measures | Dashboard calculations |
| 5 | Dashboard Visuals | Business presentation layer |
| 6 | Technical Documentation | Project communication |

Any discrepancies should be resolved by reconciling downstream artifacts with upstream sources unless a validated error is identified.

---

# Dashboard Traceability

| Dashboard Page | Business Objective | Supporting Evidence |
|---------------|--------------------|---------------------|
| Executive Overview | Overall network performance | AE-01, AE-02, AE-03, AE-06 |
| Revenue Analysis | Revenue generation | AE-02, AE-03, AE-09 |
| Demand Analysis | Passenger demand | AE-04, AE-05 |
| Capacity & Utilization | Operational efficiency | AE-07, AE-08 |
| Route Performance | Commercial performance | AE-09, AE-10 |

---

# Documentation Dependencies

| Document | Dependency |
|----------|------------|
| 01 Data Understanding Report | None |
| 02 Planning Report | 01 |
| 03 Transformation Strategy Report | 01–02 |
| 04 Dataset Integration Report | 01–03 |
| 05 Analytical Evidence Register | 01–04 |
| 06 Dashboard Design Specification | 01–05 |
| 07 Master Traceability Matrix | Entire project |

---

# QA Validation Summary

| Validation Area | Status |
|-----------------|:------:|
| SQL Validation | ✅ |
| Dataset Integration | ✅ |
| Analytical Findings | ✅ |
| Power BI Measures | ✅ |
| Dashboard Implementation | ✅ |
| Documentation Alignment | Pending Version 2 Updates |

---

# Governance Statement

The Master Traceability Matrix serves as the governing document for the Airline Route Performance & Estimated Passenger Revenue Analysis project.

All analytical findings, dashboard visualizations, technical documentation, and business recommendations are expected to remain consistent with the SQL analytical model (`route_performance_analytics`) and the validated analytical evidence documented throughout this project.