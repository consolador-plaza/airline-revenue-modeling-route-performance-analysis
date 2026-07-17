# 09_Change_Log

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 09

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial project documentation |
| 2.0 | July 2026 | Final implementation following validation, dashboard refinement, and documentation alignment |

---

# 1. Purpose

This document records significant project changes made throughout the Airline Route Performance & Estimated Passenger Revenue Analysis project.

The purpose of the Change Log is to provide transparency regarding design decisions, implementation refinements, analytical improvements, and documentation updates that occurred during project execution.

Each change reflects a deliberate decision supported by validation, business requirements, or implementation feedback.

---

# 2. Change Management Principles

Project changes were governed by the following principles:

- Preserve analytical accuracy.
- Improve business usability.
- Maintain SQL as the analytical source of truth.
- Validate all modifications before implementation.
- Ensure documentation remains aligned with the implemented solution.

---

# 3. Major Project Changes

## CL-001

### Analytical Dataset Renaming

**Original**

```
route_performance_fact
```

**Final**

```
route_performance_analytics
```

**Reason**

The final analytical table contains validated metrics, derived fields, and business-ready attributes rather than raw fact data.

**Impact**

Documentation, SQL scripts, Power BI model, and dashboard updated.

---

## CL-002

### Carrier-Level Integration Removed

**Original Design**

Carrier included within the analytical grain.

**Validation Outcome**

Carrier-level joins reduced analytical coverage to approximately 46%.

Route-quarter integration preserved approximately 99.6% of passenger volume.

**Decision**

Carrier removed from the analytical model.

**Impact**

Higher analytical coverage and simplified semantic model.

---

## CL-003

### Weighted Fare Methodology Revised

**Original**

Average of weighted averages.

**Final**

Passenger-weighted aggregation.

```
SUM(Fare × Passengers)
÷
SUM(Passengers)
```

**Reason**

Eliminated double averaging.

**Impact**

Improved statistical accuracy.

---

## CL-004

### Dashboard Architecture Revised

**Original Design**

Six dashboard pages.

**Implemented Design**

Five dashboard pages.

**Reason**

Reduced redundancy and improved navigation.

**Impact**

Merged Route Performance and Trends into a single analytical page.

---

## CL-005

### Dashboard Visual Redesign

Several exploratory statistical visuals were replaced with business-oriented visualizations.

Examples include:

| Removed | Replaced With |
|----------|---------------|
| Pareto Chart | Top Airport Pairs |
| Revenue Histogram | Revenue Analysis |
| Revenue Deciles | Median Revenue KPI |
| Lowest Yield Ranking | Load Factor vs Average Fare |

**Reason**

Improve business storytelling and executive usability.

---

## CL-006

### KPI Framework Simplified

Original dashboard concepts contained numerous KPIs.

Final implementation adopted:

- Five KPIs on Executive Overview.
- Three to four KPIs on analytical pages.

**Reason**

Improve readability and reduce cognitive load.

---

## CL-007

### Dashboard Layout Standardized

A common page structure was adopted.

```
Global Filters

↓

KPIs

↓

Primary Visuals

↓

Detail Table

↓

Narrative Insights
```

**Impact**

Improved consistency across the dashboard.

---

## CL-008

### Documentation Governance Introduced

Additional governance documents were created.

New documents:

- Master Traceability Matrix
- QA Audit Report
- Change Log
- Project Closure Report

**Reason**

Improve traceability and project governance.

---

# 4. Lessons Learned

Throughout implementation several important lessons were identified.

## Data Engineering

- Passenger coverage is a more meaningful validation metric than route coverage alone.
- Analytical grain should be determined through empirical validation rather than assumption.

---

## SQL Development

- Weighted averages require careful aggregation.
- Validation queries should accompany all derived metrics.

---

## Power BI

- Business-oriented visuals communicate insights more effectively than exploratory statistical graphics.
- Consistent layout improves usability.

---

## Project Management

- Documentation should evolve alongside implementation.
- Traceability simplifies validation and future maintenance.

---

# 5. Version Summary

| Version | Summary |
|----------|---------|
| Version 1.0 | Initial planning and analytical design |
| Version 2.0 | Final validated implementation and documentation alignment |

---

# 6. Overall Impact

The project evolved through evidence-based refinement rather than changes in business objectives.

Major improvements included:

- Improved analytical accuracy.
- Simplified dashboard navigation.
- Stronger business storytelling.
- Increased documentation quality.
- Complete analytical traceability.
- Formal governance documentation.

These refinements collectively strengthened the project's technical quality and presentation without altering its original analytical objectives.

---

# 7. Conclusion

The recorded changes represent the natural progression of an iterative analytics project.

Each modification was validated through SQL, reconciled within the Power BI semantic model, and reflected consistently throughout the project documentation.

Version 2.0 therefore represents the authoritative implementation of the Airline Route Performance & Estimated Passenger Revenue Analysis project.
