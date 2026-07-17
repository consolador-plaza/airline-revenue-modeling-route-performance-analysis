# 10_Project_Closure_Report

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document ID:** 10

**Version:** 2.0

**Status:** Final

**Owner:** <Consolador M Plaza>

**Last Updated:** July 2026

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | July 2026 | Initial project closure |
| 2.0 | July 2026 | Final implementation following QA audit and documentation alignment |

---

# 1. Executive Summary

The Airline Route Performance & Estimated Passenger Revenue Analysis project was initiated to integrate operational flight data from the BTS T100 Segment dataset with passenger fare information from the DB1B Market dataset.

The objective was to construct a validated analytical model capable of estimating passenger revenue at the route-quarter level and to communicate business insights through an interactive Power BI dashboard.

The project successfully achieved its objectives through a structured analytical workflow encompassing data understanding, planning, SQL transformation, dataset integration, validation, dashboard development, documentation, and quality assurance.

---

# 2. Project Objectives

The project was designed to achieve the following objectives:

- Integrate operational and fare datasets.
- Estimate passenger revenue at the route-quarter level.
- Validate analytical assumptions using SQL.
- Build a reusable analytical dataset.
- Develop an interactive executive dashboard.
- Document analytical findings with complete traceability.
- Produce a portfolio-ready business intelligence solution.

---

# 3. Final Deliverables

## Data Engineering

- SQL transformation scripts
- Analytical dataset (`route_performance_analytics`)
- Validation queries
- Derived analytical metrics

---

## Business Intelligence

- Interactive Power BI dashboard
- Five analytical pages
- DAX measures
- Executive KPIs
- Interactive filtering

---

## Documentation

- Data Understanding Report
- Planning Report
- Transformation Strategy Report
- Dataset Integration Report
- Analytical Evidence Register
- Dashboard Design Specification
- Master Traceability Matrix
- QA Audit Report
- Change Log
- Project Closure Report

---

# 4. Final Solution Architecture

```
BTS T100 Segment

          +

DB1B Market

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

Technical Documentation

          ↓

Business Insights
```

---

# 5. Major Project Achievements

## Data Integration

Successfully integrated operational flight activity with passenger fare data while preserving approximately 99.6% of passenger volume.

---

## Revenue Estimation

Developed a passenger-weighted methodology for estimating passenger revenue at the route-quarter level.

---

## Dashboard Development

Designed and implemented a five-page Power BI dashboard supporting executive reporting and exploratory business analysis.

---

## Validation

Every major analytical finding was validated using SQL before implementation.

---

## Documentation

Established complete traceability between:

- Business Questions
- SQL
- Analytical Evidence
- Dashboard
- Documentation

---

# 6. Key Analytical Findings

The project identified several significant business insights.

- Estimated passenger revenue is highly concentrated among a relatively small number of airport pairs.
- Passenger demand is the strongest observed driver of estimated passenger revenue.
- Average fare differentiates commercially successful markets with similar passenger demand.
- Network load factor indicates generally healthy capacity utilization.
- Route-level integration provides substantially greater analytical coverage than carrier-level integration.

These findings are documented within the Analytical Evidence Register.

---

# 7. Challenges and Resolutions

| Challenge | Resolution |
|------------|------------|
| Carrier-level integration reduced coverage | Revised analytical grain to route-quarter level |
| Double-average fare calculation | Implemented passenger-weighted aggregation |
| Dashboard redundancy | Reduced dashboard from six pages to five |
| Exploratory visuals lacked business value | Replaced with business-oriented visualizations |
| Documentation drift | Completed Version 2 alignment and governance review |

---

# 8. Lessons Learned

## Technical

- Analytical grain should be validated empirically.
- Weighted averages require careful aggregation.
- SQL validation improves dashboard reliability.

---

## Business

- Executive dashboards should prioritize business questions over exploratory analysis.
- Visual simplicity often improves communication.

---

## Project Management

- Documentation should evolve alongside implementation.
- Governance documents improve long-term maintainability.
- Traceability simplifies validation and future enhancements.

---

# 9. Future Enhancements

Potential future improvements include:

- Monthly analytical granularity.
- Carrier-level analysis using enhanced datasets.
- Integration of actual airline financial revenue.
- Forecasting models.
- Interactive route drill-through pages.
- Geographic route visualization.
- Automated data refresh.

---

# 10. Project Success Assessment

| Objective | Status |
|------------|:------:|
| Data Integration | ✅ |
| SQL Validation | ✅ |
| Analytical Dataset | ✅ |
| Dashboard Development | ✅ |
| Documentation | ✅ |
| Governance | ✅ |

Overall Project Status:

**Successfully Completed**

---

# 11. Final Project Metrics

| Category | Result |
|-----------|--------|
| Source Datasets | 2 |
| SQL Views | 1 |
| Dashboard Pages | 5 |
| Analytical Evidence Items | 10 |
| Governance Documents | 4 |
| Documentation Reports | 10 |
| QA Reviews | Complete |

---

# 12. Conclusion

The Airline Route Performance & Estimated Passenger Revenue Analysis project successfully transformed publicly available aviation datasets into a validated analytical model supporting business intelligence and executive decision-making.

The project demonstrates competencies in:

- SQL Development
- Data Engineering
- Data Validation
- Business Intelligence
- Power BI
- DAX
- Dashboard Design
- Analytical Documentation
- Project Governance

The completed solution provides a fully traceable analytical workflow from raw data through business insight and is suitable for portfolio publication as Version 2.0.

---

# Formal Project Closure

Project Status:

**Closed**

Release Status:

**Approved for Portfolio Publication**

Version:

**2.0**

Date:

July 2026
