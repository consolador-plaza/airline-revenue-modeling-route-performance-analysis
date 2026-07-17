# Glossary

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document Type:** Reference

**Version:** 2.0

**Status:** Final

---

# Purpose

This glossary defines the business, analytical, and technical terminology used throughout the Airline Route Performance & Estimated Passenger Revenue Analysis project.

The objective is to ensure consistent interpretation across SQL scripts, Power BI reports, project documentation, and analytical findings.

---

# Business Terms

## Airport Pair

A directional route between two airports represented by the combination of:

```
Origin Airport
↓

Destination Airport
```

Example:

```
LAX → JFK
```

The project represents Airport Pair as:

```
Origin + ' - ' + Destination
```

Example:

```
LAX - JFK
```

---

## Route

A directional flight market between an origin airport and a destination airport.

Routes are treated as directional.

Example:

```
LAX → JFK
```

is different from

```
JFK → LAX
```

---

## Passenger

A transported traveler reported within the BTS T100 Segment dataset.

Passenger counts represent transported passengers rather than booked or ticketed passengers.

---

## Seat Capacity

The total number of seats made available for sale by operating carriers.

Seat capacity is used to calculate Load Factor.

---

## Estimated Passenger Revenue

Estimated commercial revenue calculated using passenger-weighted fares.

Business Rule

```
Estimated Passenger Revenue

=

Passengers

×

Weighted Average Fare
```

This metric represents an analytical estimate rather than reported airline revenue.

---

## Weighted Average Fare

Average passenger fare weighted by passenger volume.

Formula

```
SUM(Fare × Passengers)

÷

SUM(Passengers)
```

Passenger weighting prevents statistical distortion caused by low-volume observations.

---

## Revenue per Passenger

Average estimated revenue generated per transported passenger.

Formula

```
Estimated Passenger Revenue

÷

Passengers
```

---

## Load Factor

Operational efficiency metric representing seat utilization.

Formula

```
Passengers

÷

Seats
```

Load Factor is expressed as a percentage within the dashboard.

---

# Analytical Terms

## Analytical Grain

The lowest level of detail represented within the analytical dataset.

For this project:

```
Year

Quarter

Origin Airport

Destination Airport
```

Every record within the analytical dataset represents one airport pair for one calendar quarter.

---

## Route Coverage

Percentage of operational routes successfully matched between the T100 Segment and DB1B Market datasets.

Route coverage measures dataset compatibility rather than passenger representativeness.

---

## Passenger Coverage

Percentage of transported passengers represented within the integrated analytical dataset.

Passenger coverage is considered the primary measure of analytical representativeness.

The project achieved approximately **99.6% passenger coverage**.

---

## Route-Level Aggregation

Aggregation of operational activity from carrier-level observations to airport-pair observations.

---

## Passenger-Weighted Methodology

Methodology that weights commercial fare information using passenger counts before aggregation.

This approach preserves the influence of high-volume markets.

---

## Analytical Dataset

The validated SQL dataset supporting the project.

```
dbo.route_performance_analytics
```

This dataset serves as the analytical source of truth.

---

# SQL Terms

## Raw Dataset

Original BTS datasets imported into SQL Server without analytical transformation.

Examples:

- `dbo.t100`
- `dbo.db1b_market`

---

## Processed Dataset

Intermediate datasets created during preparation and transformation.

Examples:

- `dbo.t100_quarterly`
- `dbo.db1b_market_quarterly`

---

## Validation Script

SQL script used exclusively to verify analytical correctness.

Validation scripts do not modify analytical data.

---

## Deployment Script

SQL script used to create or recreate the analytical dataset.

---

# Power BI Terms

## Semantic Model

The collection of tables, relationships, calculated columns, and measures used by the Power BI report.

---

## Measure

A dynamic DAX calculation evaluated at query time.

Examples include:

- Total Revenue
- Total Passengers
- Average Fare
- Load Factor

---

## KPI (Key Performance Indicator)

A business metric used to evaluate commercial or operational performance.

Examples:

- Estimated Passenger Revenue
- Passenger Volume
- Average Fare
- Load Factor

---

## Slicer

An interactive filtering control within Power BI used to refine report visuals.

Examples:

- Year
- Quarter
- Origin Airport
- Destination Airport

---

# Documentation Terms

## Analytical Evidence

A validated analytical finding supported by SQL queries and represented within the dashboard.

Each analytical finding is documented within the **Analytical Evidence Specification**.

---

## Traceability

The ability to connect business objectives, SQL implementation, analytical findings, dashboard visuals, and documentation through a documented chain of evidence.

---

## Source of Truth

The authoritative analytical dataset from which all project findings are derived.

For this project:

```
dbo.route_performance_analytics
```

---

## Governance

Processes that ensure the analytical solution is accurate, documented, validated, and reproducible.

Governance documents include:

- Master Traceability Matrix
- QA Audit Report
- Change Log
- Project Closure Report

---

# Acronyms

| Acronym | Definition |
|----------|------------|
| BTS | Bureau of Transportation Statistics |
| DB1B | Origin and Destination Survey (10% Airline Ticket Sample) |
| T100 | T100 Domestic Segment Dataset |
| SQL | Structured Query Language |
| T-SQL | Transact-SQL |
| DAX | Data Analysis Expressions |
| KPI | Key Performance Indicator |
| QA | Quality Assurance |
| EDA | Exploratory Data Analysis |
| ETL | Extract, Transform, Load |
| PBIX | Power BI Desktop Project File |

---

# Relationship to Project Documentation

This glossary serves as the common vocabulary for:

- SQL scripts
- Power BI dashboard
- Technical reports
- Specifications
- Governance documentation

Terms defined here should be used consistently throughout the project.

---

# Version Information

| Attribute | Value |
|-----------|-------|
| Version | 2.0 |
| Status | Final |
| Last Updated | July 2026 |