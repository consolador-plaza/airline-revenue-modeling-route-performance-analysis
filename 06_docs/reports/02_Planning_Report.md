# 02_Planning_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 02

**Document Type:** Report

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial project planning |
| 2.0 | July 2026 | Updated to document implementation outcomes and align with the completed analytical solution |

---

# 1. Purpose

This report documents the planning phase of the Airline Route Performance & Estimated Passenger Revenue Analysis project.

It defines the business problem, analytical objectives, project scope, success criteria, and intended deliverables that guided subsequent implementation.

This document should be interpreted alongside the Transformation Strategy Report and Dataset Integration Report, which describe how the original plan evolved through SQL validation and analytical refinement.

---

# 2. Business Context

Airline network planning requires an understanding of the relationship between passenger demand, pricing, capacity utilization, and commercial performance.

Although publicly available BTS datasets do not provide airline financial revenue, they contain sufficient operational and fare information to construct an estimated passenger revenue model capable of supporting strategic route analysis.

The project therefore focuses on developing a validated analytical model for estimating passenger revenue at the route-quarter level and presenting business insights through an interactive Power BI dashboard.

---

# 3. Business Objectives

The project established the following objectives.

## Primary Objectives

- Integrate operational and fare datasets.
- Estimate passenger revenue using passenger-weighted fares.
- Validate analytical assumptions using SQL.
- Develop a reusable analytical dataset.
- Build an executive Power BI dashboard.
- Produce a portfolio-quality analytical project with supporting documentation.

## Secondary Objectives

- Identify commercially significant airport pairs.
- Evaluate passenger demand concentration.
- Assess capacity utilization.
- Explore pricing and route performance relationships.

---

# 4. Business Questions

The planning phase identified the following analytical questions.

## Revenue

- Where is estimated passenger revenue generated?
- Which airport pairs contribute the greatest commercial value?
- How is estimated passenger revenue distributed across the network?

## Demand

- Which airport pairs carry the highest passenger volumes?
- Does passenger demand explain estimated passenger revenue?
- How is demand distributed geographically?

## Capacity

- How efficiently are available seats utilized?
- Which airport pairs exhibit unusually high or low load factors?

## Commercial Performance

- Which airport pairs combine pricing, demand, and utilization most effectively?
- How do average fare and load factor differentiate successful markets?

## Deferred Questions

The planning phase proposed carrier-level analysis.

During implementation, SQL validation demonstrated that carrier-level integration substantially reduced analytical coverage.

Accordingly, carrier analysis was deferred from Version 2.0 and documented as a future enhancement.

---

# 5. Project Scope

## Included

- BTS T100 Segment dataset
- BTS DB1B Market dataset
- SQL transformation and validation
- Analytical dataset construction
- Power BI dashboard
- DAX measures
- Analytical Evidence Specification
- Governance documentation

## Excluded

- Airline financial statements
- Monthly forecasting
- Carrier profitability analysis
- Route scheduling optimization

---

# 6. Planned Deliverables

The planning phase defined the following deliverables.

| Deliverable | Final Status |
|-------------|:------------:|
| SQL Development | ✅ Completed |
| Analytical Dataset | ✅ Completed |
| SQL Validation | ✅ Completed |
| Power BI Dashboard | ✅ Completed |
| Documentation | ✅ Completed |
| Governance Framework | ✅ Completed |
| Portfolio Presentation | Planned |
| Repository README | Planned |

---

# 7. KPI Framework

The planning phase proposed a broad KPI framework.

Implementation refined the final KPI set to improve usability.

## Executive Overview

- Estimated Passenger Revenue
- Total Passengers
- Total Seats
- Average Weighted Fare
- Average Load Factor

## Revenue Analysis

- Estimated Passenger Revenue
- Median Revenue
- Average Weighted Fare
- Highest Revenue Airport Pair

## Demand Analysis

- Total Passengers
- Median Passengers
- Highest Passenger Airport Pair

## Capacity & Utilization

- Total Seats
- Average Load Factor
- Median Load Factor *(or Average if retained in the final dashboard)*

## Route Performance

- Average Weighted Fare
- Average Load Factor
- Highest Yield Airport Pair

All KPI definitions are governed by the Dashboard Design Specification.

---

# 8. Success Criteria

The project will be considered successful if it:

- Produces a validated analytical dataset.
- Reconciles SQL outputs with Power BI measures.
- Presents business-oriented analytical insights.
- Maintains complete traceability across SQL, dashboard, and documentation.
- Supports executive decision-making through an interactive dashboard.

---

# 9. Implementation Outcomes

During implementation, several planning assumptions were refined through empirical validation.

## Carrier-Level Analysis

Initially included.

Final Outcome:

Deferred due to reduced analytical coverage.

---

## Dashboard Architecture

Initially planned as six pages.

Final Outcome:

Implemented as five pages following usability review.

---

## Visual Design

Originally emphasized exploratory statistical charts.

Final Outcome:

Focused on business-oriented visuals aligned with validated analytical findings.

---

## Documentation

Originally limited to technical reports.

Final Outcome:

Expanded to include:

- Analytical Evidence Specification
- Dashboard Design Specification
- Master Traceability Matrix
- QA Audit Report
- Change Log
- Project Closure Report

---

# 10. Relationship to Project Documentation

This planning report establishes the business foundation for:

| Document | Relationship |
|----------|--------------|
| 03 Transformation Strategy Report | Technical implementation |
| 04 Dataset Integration Report | Analytical dataset |
| 05 Analytical Evidence Specification | Validated findings |
| 06 Dashboard Design Specification | Implemented dashboard |

---

# 11. Conclusion

The planning phase successfully established the analytical direction for the Airline Route Performance & Estimated Passenger Revenue Analysis project.

Subsequent SQL validation, dashboard development, and quality assurance refined several implementation decisions while preserving the original business objectives.

Version 2.0 demonstrates that the project remained faithful to its intended purpose while evolving through evidence-based analytical design and iterative business intelligence development.