# Planning Report

## Project

Airline Revenue Modeling & Route Performance Analysis

## Phase

Planning

## Objective

The purpose of the Planning Phase was to establish the project's business direction, define analytical objectives, determine KPI requirements, design the analytical framework, and specify dashboard requirements before any data modeling or SQL development begins.

---

# Business Context

## Business Perspective

Revenue Growth

## Primary Stakeholder

Commercial / Revenue Management Team

## Analytical Focus

Route-Level Decision Making

The project is designed to support revenue-related decisions at the route level by identifying high-performing routes, revenue concentration patterns, demand trends, and potential revenue growth opportunities.

---

# Business Objective

Analyze passenger demand and airfare data to identify the routes that contribute the most to estimated revenue, understand revenue concentration across the network, and uncover route-level opportunities that support revenue growth decisions.

---

# Business Questions

## Revenue Performance

### Q1

Which routes generate the highest estimated revenue?

### Q2

What percentage of total revenue comes from the top-performing routes?

### Q3

How concentrated is revenue across the route network?

---

## Demand Performance

### Q4

Which routes carry the highest passenger volume?

### Q5

Do high-demand routes also generate high revenue?

### Q6

How has passenger demand changed from 2022–2024?

---

## Revenue Opportunity

### Q7

Which routes have strong demand but relatively low average fares?

### Q8

Which routes generate strong revenue despite lower passenger volume?

### Q9

Which routes appear under-monetized?

---

## Carrier Context

### Q10

Which carriers participate in the highest revenue routes?

### Q11

How is estimated revenue distributed across carriers?

Note: Carrier analysis is considered supporting context rather than the primary focus of the project.

---

# Project Scope

## Included

### Revenue Analysis

* Estimated revenue
* Revenue trends
* Revenue concentration

### Demand Analysis

* Passenger volume
* Passenger growth
* Route demand rankings

### Route Performance Analysis

* Top-performing routes
* Route comparisons
* Route growth trends

### Revenue Opportunity Analysis

* High-demand / low-fare routes
* Revenue optimization opportunities

### Capacity Utilization Analysis

* Seats
* Passengers
* Load factor

---

## Excluded

### Profitability Analysis

Reason:
No operating cost data is available.

### Forecasting

Reason:
Outside current project objectives.

### Machine Learning

Reason:
Not required to answer business questions.

### Customer Segmentation

Reason:
No customer-level data is available.

---

# KPI Framework

## Primary KPIs

| KPI                    | Purpose                            |
| ---------------------- | ---------------------------------- |
| Estimated Revenue      | Measure route revenue contribution |
| Revenue Contribution % | Measure revenue concentration      |
| Passenger Volume       | Measure demand                     |
| Revenue Rank           | Identify top-performing routes     |
| Passenger Rank         | Identify highest-demand routes     |

---

## Supporting KPIs

| KPI                  | Purpose                |
| -------------------- | ---------------------- |
| Average Market Fare  | Pricing context        |
| Revenue Growth %     | Revenue trend analysis |
| Passenger Growth %   | Demand trend analysis  |
| Seats                | Capacity context       |
| Departures Performed | Operational context    |

---

## Diagnostic KPIs

| KPI                   | Purpose                     |
| --------------------- | --------------------------- |
| Revenue per Passenger | Revenue efficiency          |
| Load Factor           | Capacity utilization        |
| Revenue per Departure | Route productivity          |
| Fare Index            | Relative pricing comparison |

---

# Analytical Framework

## Layer 1 – Revenue Analysis

Objective:
Identify where revenue is generated.

Key Outputs:

* Revenue rankings
* Revenue contribution
* Revenue concentration

---

## Layer 2 – Demand Analysis

Objective:
Identify where passenger demand exists.

Key Outputs:

* Passenger rankings
* Passenger trends
* Demand growth

---

## Layer 3 – Revenue vs Demand Analysis

Objective:
Determine whether demand and revenue are aligned.

Key Outputs:

* Revenue rank vs passenger rank
* Revenue per passenger
* Demand-revenue relationship

---

## Layer 4 – Route Opportunity Analysis

Objective:
Identify routes with revenue growth potential.

Key Outputs:

* High-demand / low-fare routes
* Emerging routes
* Under-monetized routes

---

## Layer 5 – Capacity Utilization Analysis

Objective:
Evaluate how efficiently route capacity is utilized.

Key Outputs:

* Load factor analysis
* Capacity comparison
* Utilization rankings

---

# Analytical Narrative

The project follows the following analytical sequence:

1. Where is revenue generated?
2. What drives that revenue?
3. Is demand aligned with revenue?
4. Where are revenue growth opportunities?
5. How effectively is capacity utilized?

This narrative is designed to mirror the workflow of a Commercial / Revenue Management Team.

---

# Dashboard Requirements

## Dashboard Structure

### Page 1 – Executive Overview

Purpose:
High-level network performance summary.

Key Metrics:

* Estimated Revenue
* Passenger Volume
* Average Fare
* Revenue Growth %
* Passenger Growth %

---

### Page 2 – Revenue Performance

Purpose:
Identify revenue-generating routes.

Key Metrics:

* Estimated Revenue
* Revenue Contribution %
* Revenue Rank

---

### Page 3 – Demand Performance

Purpose:
Analyze passenger demand.

Key Metrics:

* Passenger Volume
* Passenger Growth %
* Passenger Rank

---

### Page 4 – Revenue vs Demand Analysis

Purpose:
Compare demand and revenue performance.

Key Metrics:

* Revenue Rank
* Passenger Rank
* Revenue per Passenger

---

### Page 5 – Route Opportunity Analysis

Purpose:
Identify revenue growth opportunities.

Key Metrics:

* Average Fare
* Revenue per Passenger
* Passenger Growth %
* Load Factor

---

### Page 6 – Capacity & Utilization Analysis

Purpose:
Assess route utilization.

Key Metrics:

* Seats
* Passengers
* Load Factor
* Departures

---

### Page 7 – Methodology & Data Notes

Purpose:
Document assumptions and analytical limitations.

Contents:

* Revenue estimation methodology
* Dataset descriptions
* Assumptions
* Limitations
* KPI definitions

---

# Dashboard Design Decisions

## Dashboard Size

7 Pages Total

* 6 Analytical Pages
* 1 Methodology Page

---

## Route Naming Convention

Airport Pair Naming

Examples:

* JFK → LAX
* ATL → ORD
* DFW → DEN

Reason:
Maintains consistency with source data and supports route-level analysis.

---

## Global Filters

Recommended Filters:

* Year
* Quarter
* Carrier
* Origin Airport
* Destination Airport

---

# Assumptions

| Assumption                                                    | Rationale                               |
| ------------------------------------------------------------- | --------------------------------------- |
| Market Fare represents average route pricing                  | Required for revenue estimation         |
| Revenue can be estimated using passenger volume and fare data | Core analytical model                   |
| Estimated revenue is sufficient for commercial analysis       | No actual route-level revenue available |
| Route-level analysis provides meaningful commercial insights  | Aligns with stakeholder needs           |

---

# Risks

| Risk                                                                 | Impact |
| -------------------------------------------------------------------- | ------ |
| Revenue is estimated rather than actual                              | Medium |
| DB1B fare sampling may introduce bias                                | Medium |
| Carrier code inconsistencies may require standardization             | Medium |
| Quarterly and monthly granularity differences require transformation | Medium |

---

# Planning Phase Conclusion

The Planning Phase is complete.

### Outcome

The project now has:

* Defined business objectives
* Defined stakeholder perspective
* Defined analytical scope
* Defined KPI framework
* Defined analytical framework
* Defined dashboard requirements

### Decision

Proceed to the Execution Phase.

The first stage of execution will focus on data preparation, transformation strategy, and dataset integration design.
