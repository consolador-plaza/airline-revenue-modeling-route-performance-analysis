# 06_Dashboard_Design_Specification

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 06

**Document Type:** Specification

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial dashboard blueprint |
| 2.0 | July 2026 | Updated to reflect the implemented dashboard following SQL validation, analytical refinement, and QA review |

---

# 1. Purpose

This document defines the implemented Power BI dashboard for the **Airline Route Performance & Estimated Passenger Revenue Analysis** project.

The dashboard communicates validated analytical findings derived from the `route_performance_analytics` analytical dataset and provides interactive business intelligence for commercial, operational, and strategic analysis.

Unlike the original dashboard blueprint, this specification documents the solution that was ultimately implemented following analytical validation and iterative design refinement.

---

# 2. Scope

This specification documents:

- Dashboard architecture
- Navigation
- Global filters
- KPI definitions
- Page layouts
- Visual inventory
- User interactions
- Design standards
- Analytical traceability

Dashboard implementation details are governed by the Analytical Evidence Specification (Document 05).

---

# 3. Dependencies

The implemented dashboard depends upon:

| Document | Purpose |
|----------|---------|
| 04 Dataset Integration Report | Analytical dataset construction |
| 05 Analytical Evidence Specification | Validated business findings |
| 07 Master Traceability Matrix | End-to-end governance |

---

# 4. Dashboard Architecture

The dashboard consists of five analytical pages.

| Page | Business Question |
|------|-------------------|
| Executive Overview | How is the airline network performing overall? |
| Revenue Analysis | Where is estimated passenger revenue generated? |
| Demand Analysis | Where is passenger demand concentrated? |
| Capacity & Utilization | How efficiently is seat capacity utilized? |
| Route Performance | What differentiates successful airport pairs? |

The dashboard intentionally separates executive monitoring from detailed analytical exploration.

---

# 5. Global Filters

The following slicers are available across all pages.

| Filter | Purpose |
|---------|---------|
| Year | Compare annual performance |
| Quarter | Analyze quarterly performance |
| Origin Airport | Filter by departure airport |
| Destination Airport | Filter by arrival airport |

All dashboard pages inherit these filters to ensure a consistent analytical experience.

---

# 6. Dashboard Design Standards

The following principles governed dashboard development.

## Layout

Each analytical page follows a common structure.

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

---

## Visual Design

- White report background
- Dark blue section headers
- Consistent typography
- Standardized spacing
- Uniform KPI sizing
- Minimal visual clutter

---

## Interaction Principles

- Cross-filtering enabled where analytically meaningful
- Drill-through avoided to maintain simplicity
- Tables provide detailed route-level exploration
- Visual titles describe business questions rather than chart types

---

# 7. Page Specifications

## Page 1 — Executive Overview

### Business Question

How is the airline network performing overall?

### KPIs

- Estimated Passenger Revenue
- Total Passengers
- Total Seats
- Average Weighted Fare
- Average Load Factor

### Visuals

- Quarterly Revenue Trend
- Top Airport Pairs by Revenue
- Executive Insights Narrative

### Supporting Evidence

AE-01

AE-02

AE-03

AE-06

---

## Page 2 — Revenue Analysis

### Business Question

Where is estimated passenger revenue generated?

### KPIs

- Estimated Passenger Revenue
- Median Revenue
- Average Weighted Fare
- Highest Revenue Airport Pair

### Visuals

- Top Airport Pairs by Revenue
- Revenue by Origin Airport
- Revenue Detail Table

### Supporting Evidence

AE-02

AE-03

AE-09

---

## Page 3 — Demand Analysis

### Business Question

Where is passenger demand concentrated?

### KPIs

- Total Passengers
- Median Passengers
- Highest Passenger Airport Pair

### Visuals

- Top Airport Pairs by Passengers
- Passengers by Origin Airport
- Revenue vs Passengers Scatter Plot
- Passenger Detail Table

### Supporting Evidence

AE-04

AE-05

---

## Page 4 — Capacity & Utilization

### Business Question

How efficiently is available seat capacity utilized?

### KPIs

- Total Seats
- Average Load Factor
- Median Load Factor *(or Average if that's your final implementation)*

### Visuals

- Top Airport Pairs by Load Factor
- Seats by Origin Airport
- Load Factor vs Passengers Scatter Plot
- Capacity Detail Table

### Supporting Evidence

AE-07

AE-08

---

## Page 5 — Route Performance

### Business Question

What differentiates high-performing airport pairs?

### KPIs

- Average Weighted Fare
- Average Load Factor
- Highest Yield Airport Pair

### Visuals

- Highest Yield Markets
- Load Factor vs Average Fare
- Route Performance Detail Table

### Supporting Evidence

AE-09

AE-10

---

# 8. KPI Definitions

| KPI | Definition |
|------|------------|
| Estimated Passenger Revenue | Passenger-weighted revenue estimate derived from DB1B fares and T100 passenger volumes |
| Total Passengers | Sum of transported passengers |
| Total Seats | Sum of available seats |
| Average Weighted Fare | Estimated Passenger Revenue ÷ Total Passengers |
| Average Load Factor | Total Passengers ÷ Total Seats |
| Median Revenue | Median estimated passenger revenue across airport pairs |

All KPIs reconcile with validated SQL outputs.

---

# 9. Dashboard Traceability

| Dashboard Page | Evidence | Business Objective |
|---------------|----------|--------------------|
| Executive Overview | AE-01, AE-02, AE-03, AE-06 | Network monitoring |
| Revenue Analysis | AE-02, AE-03, AE-09 | Revenue performance |
| Demand Analysis | AE-04, AE-05 | Passenger demand |
| Capacity & Utilization | AE-07, AE-08 | Operational efficiency |
| Route Performance | AE-09, AE-10 | Commercial performance |

---

# 10. Design Evolution

The implemented dashboard differs from the original design in several important ways.

| Original Design | Final Implementation |
|-----------------|----------------------|
| Six dashboard pages | Five dashboard pages |
| Pareto charts | Top Airport Pair rankings |
| Revenue histograms | Business KPI summaries |
| Revenue deciles | Median Revenue KPI |
| Exploratory visuals | Business-focused analytics |

These changes were introduced following SQL validation, dashboard usability testing, and analytical review.

---

# 11. Limitations

The dashboard should be interpreted alongside the following considerations.

- Estimated passenger revenue is an analytical estimate rather than reported airline financial revenue.
- Carrier-level analysis is intentionally excluded.
- Quarterly aggregation does not capture within-quarter seasonality.
- Dashboard findings should be interpreted together with the Analytical Evidence Specification.

---

# 12. Governance Statement

This Dashboard Design Specification defines the implemented business intelligence solution for Version 2.0 of the project.

Any future modifications to dashboard visuals, KPIs, or analytical logic should maintain alignment with:

- `route_performance_analytics`
- Analytical Evidence Specification
- Master Traceability Matrix

---

# 13. Conclusion

The implemented Power BI dashboard provides a business-oriented analytical environment for exploring estimated passenger revenue, passenger demand, capacity utilization, and commercial route performance.

Every dashboard page has been designed to communicate validated analytical findings while maintaining complete traceability to SQL validation and supporting project documentation.

This specification serves as the authoritative reference for the implemented dashboard and supersedes the original Dashboard Blueprint.