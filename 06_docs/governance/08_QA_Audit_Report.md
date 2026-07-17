# 08_QA_Audit_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 08

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial QA review |
| 2.0 | July 2026 | Final QA audit following implementation, dashboard validation, and documentation alignment |

---

# 1. Purpose

This report documents the Quality Assurance (QA) audit performed for the Airline Route Performance & Estimated Passenger Revenue Analysis project.

The audit evaluates consistency, completeness, traceability, and technical correctness across the project's analytical pipeline, including SQL development, dataset integration, Power BI implementation, dashboard design, and supporting documentation.

The objective is to determine whether the project is suitable for final publication as Version 2.0.

---

# 2. Audit Scope

The QA audit covered the following project components.

## Data Engineering

- BTS T100 Segment dataset
- DB1B Market dataset
- SQL transformation scripts
- Integration methodology
- Analytical dataset (`route_performance_analytics`)

## Data Validation

- Join validation
- Passenger coverage validation
- Revenue estimation validation
- Load factor validation
- Weighted fare validation

## Power BI

- Data model
- DAX measures
- Visual consistency
- KPI reconciliation
- Dashboard navigation
- Page interactions

## Documentation

- Data Understanding Report
- Planning Report
- Transformation Strategy Report
- Dataset Integration Report
- Analytical Evidence Register
- Dashboard Design Specification
- Master Traceability Matrix

---

# 3. Audit Methodology

The audit followed a structured validation approach.

```
Raw Data
      ↓
SQL Transformation
      ↓
Analytical Dataset
      ↓
SQL Validation
      ↓
Power BI Semantic Model
      ↓
Dashboard
      ↓
Documentation
```

Each downstream artifact was reconciled against its upstream dependency to ensure consistency.

---

# 4. Audit Results

## 4.1 Data Engineering

| Area | Result |
|------|:------:|
| Dataset Integrity | ✅ |
| Route Integration | ✅ |
| Passenger Coverage | ✅ |
| Revenue Estimation | ✅ |
| Load Factor Calculation | ✅ |

### Summary

The analytical dataset successfully integrated BTS T100 Segment and DB1B Market data at the route-quarter level.

Carrier-level integration was evaluated but excluded after validation demonstrated significantly reduced analytical coverage.

---

## 4.2 SQL Validation

| Validation | Status |
|------------|:------:|
| Passenger Matching | ✅ |
| Revenue Estimation | ✅ |
| Weighted Fare | ✅ |
| Load Factor | ✅ |
| Route Validation | ✅ |

### Summary

All analytical measures implemented in Power BI reconcile with validated SQL outputs.

No material discrepancies were identified.

---

## 4.3 Power BI Dashboard

### Executive Overview

Status: ✅

### Revenue Analysis

Status: ✅

### Demand Analysis

Status: ✅

### Capacity & Utilization

Status: ✅

### Route Performance

Status: ✅

### Summary

The implemented dashboard reflects the validated analytical model and presents business-focused visualizations aligned with the Analytical Evidence Register.

---

## 4.4 Documentation

| Document | Status |
|----------|:------:|
| Data Understanding | Minor Revision |
| Planning | Moderate Revision |
| Transformation Strategy | Moderate Revision |
| Dataset Integration | Minor Revision |
| Analytical Evidence Register | Moderate Revision |
| Dashboard Design Specification | Major Revision |
| Master Traceability Matrix | Complete |

---

# 5. Major Findings

## Finding 1

### Dashboard Evolution

The dashboard evolved from an initial six-page design into a five-page implementation.

Reason:

Improved usability and elimination of redundant analytical visuals.

Status:

Resolved

---

## Finding 2

### Carrier-Level Integration

Carrier-level joins reduced analytical coverage to approximately 46%.

Route-quarter integration preserved approximately 99.6% of passenger volume.

Final Decision:

Carrier excluded from the analytical model.

Status:

Resolved

---

## Finding 3

### Weighted Fare Calculation

A double-average methodology was identified during SQL validation.

The calculation was revised to a passenger-weighted aggregation.

Status:

Resolved

---

## Finding 4

### Dashboard Visuals

Several exploratory statistical visuals were replaced with business-oriented visualizations.

Examples:

- Pareto Chart → Top Airport Pairs
- Revenue Histogram → Revenue Analysis
- Revenue Deciles → Median Revenue KPI

Status:

Resolved

---

## Finding 5

### Documentation Alignment

Implementation refined several planning assumptions.

Version 2 documentation updates are required to align all reports with the implemented analytical model.

Status:

In Progress

---

# 6. Issue Register

| ID | Issue | Severity | Status |
|----|-------|:--------:|:------:|
| IR-001 | Dashboard redesigned from six pages to five | High | Closed |
| IR-002 | Carrier strategy revised after validation | Medium | Closed |
| IR-003 | Dashboard mappings updated | Medium | Closed |
| IR-004 | Final analytical table renamed to `route_performance_analytics` | Low | Closed |
| IR-005 | KPI framework refined during implementation | Medium | Closed |

---

# 7. Traceability Assessment

The audit confirmed complete traceability between:

- Business Questions
- SQL Validation
- Analytical Evidence
- Power BI Dashboard
- Project Documentation

The Master Traceability Matrix serves as the governing document for maintaining this alignment.

Status:

✅ Verified

---

# 8. Quality Assessment

| Area | Rating |
|------|:------:|
| Data Engineering | Excellent |
| SQL Development | Excellent |
| Data Validation | Excellent |
| Dashboard Design | Excellent |
| Business Analytics | Excellent |
| Documentation | Very Good |
| Governance | Excellent |

Overall Project Rating:

**9.9 / 10**

---

# 9. Release Readiness

| Deliverable | Status |
|-------------|:------:|
| SQL Development | ✅ |
| Analytical Dataset | ✅ |
| SQL Validation | ✅ |
| Power BI Dashboard | ✅ |
| Analytical Evidence | ✅ |
| Traceability Matrix | ✅ |
| Documentation Alignment | In Progress |
| README | Pending |
| Technical Report | Pending |
| Presentation | Pending |

---

# 10. Recommendations

Before public release, complete the following activities.

1. Finalize Version 2 documentation.
2. Prepare repository README.
3. Complete Technical Report.
4. Prepare project presentation.
5. Perform final repository review.
6. Publish Version 2.0.

---

# 11. Conclusion

The QA audit concludes that the Airline Route Performance & Estimated Passenger Revenue Analysis project successfully meets its stated business objectives.

The analytical model has been validated through SQL, reconciled within Power BI, and aligned with supporting documentation.

Following completion of the remaining documentation updates, the project is considered suitable for portfolio publication as Version 2.0.

---

# Approval

| Role | Status |
|------|:------:|
| SQL Validation | ✅ Approved |
| Data Integration | ✅ Approved |
| Power BI Dashboard | ✅ Approved |
| Documentation QA | Pending Version 2 Alignment |
| Release Readiness | Pending |
