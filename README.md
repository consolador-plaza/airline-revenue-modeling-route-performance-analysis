# Airline Route Performance & Estimated Passenger Revenue Analysis

> End-to-end analytics engineering and business intelligence project using SQL Server and Power BI to analyze U.S. airline route performance through operational and commercial datasets published by the U.S. Bureau of Transportation Statistics (BTS).

![Project Status](https://img.shields.io/badge/status-complete-success)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Documentation](https://img.shields.io/badge/Documentation-Version%202.0-green)

---

# Executive Summary

This project integrates operational flight activity from the **BTS T100 Segment** dataset with passenger fare information from the **BTS DB1B Market** dataset to estimate passenger revenue and evaluate airline route performance across the United States.

The project demonstrates a complete analytics engineering workflow:

- Data preparation
- SQL transformation
- Data validation
- Exploratory analysis
- Power BI dashboard development
- Technical documentation
- Governance and quality assurance

Rather than focusing solely on dashboard development, the project emphasizes **reproducibility, traceability, and analytical governance**.

---

# Dashboard Preview

> ![Executive Overview]()

```
08_assets/dashboard/
```

Recommended screenshots:

- Executive Overview
- Revenue Analysis
- Demand Analysis
- Capacity & Utilization
- Route Performance

---

# Business Problem

Airline performance is often evaluated using operational metrics such as passenger volume or flight counts.

However, understanding the **commercial value of individual routes** requires combining operational activity with passenger fare information.

This project answers questions such as:

- Which airport pairs generate the highest estimated passenger revenue?
- Which routes carry the greatest passenger demand?
- Which markets exhibit the highest operational efficiency?
- How concentrated is airline revenue across the network?
- How do fare, passenger demand, and load factor interact?

---

# Project Objectives

- Integrate BTS operational and fare datasets.
- Develop a passenger-weighted revenue estimation methodology.
- Build a validated analytical dataset.
- Create an interactive Power BI dashboard.
- Document the complete analytical workflow.

---

# Data Sources

| Dataset | Purpose |
|----------|---------|
| BTS T100 Segment | Operational flight activity |
| BTS DB1B Market | Passenger fare survey |

Both datasets are published by the U.S. Bureau of Transportation Statistics.

---

# Technology Stack

| Category | Technology |
|----------|------------|
| Database | SQL Server |
| Query Language | Transact-SQL |
| Visualization | Power BI Desktop |
| Documentation | Markdown |
| Version Control | Git & GitHub |

---

# Repository Structure

```text
Airline-Route-Performance-Estimated-Passenger-Revenue-Analysis/
│
├── 01_raw_data/
├── 02_processed_data/
├── 03_sql/
├── 04_analysis/
├── 05_outputs/
├── 06_dashboard/
├── 07_docs/
├── 08_assets/
│
└── README.md
```

---

# SQL Workflow

```
Raw BTS Data
        │
        ▼
01_data_preparation.sql
        │
        ▼
02_transformation.sql
        │
        ▼
03_validation.sql
        │
        ▼
04_analysis.sql
        │
        ▼
Power BI Dashboard
```

The SQL workflow creates the validated analytical dataset:

```text
dbo.route_performance_analytics
```

which serves as the project's analytical source of truth.

---

# Dashboard Pages

## Executive Overview

Provides a high-level summary of network performance, including estimated revenue, passenger volume, average fare, and operational efficiency.

---

## Revenue Analysis

Analyzes revenue concentration, leading airport pairs, revenue distribution, and quarterly revenue trends.

---

## Demand Analysis

Explores passenger demand, passenger concentration, and the relationship between demand and commercial performance.

---

## Capacity & Utilization

Evaluates seat capacity, load factor, and operational efficiency across airport pairs.

---

## Route Performance

Compares commercial and operational performance using revenue, fare, passenger volume, and load factor.

---

# Analytical Methodology

## Estimated Passenger Revenue

```
Passengers × Weighted Average Fare
```

---

## Weighted Average Fare

```
SUM(Fare × Passengers)
÷
SUM(Passengers)
```

---

## Load Factor

```
Passengers
÷
Seats
```

The project uses passenger-weighted aggregation to preserve the influence of high-volume markets and reduce statistical distortion.

---

# Documentation

Comprehensive project documentation is available in:

```
07_docs/
```

The documentation includes:

- Data Understanding Report
- Planning Report
- Transformation Strategy Report
- Dataset Integration Report
- Analytical Evidence Specification
- Dashboard Design Specification
- Master Traceability Matrix
- QA Audit Report
- Change Log
- Project Closure Report

---

# Key Deliverables

- SQL transformation pipeline
- Validated analytical dataset
- Power BI dashboard
- Technical documentation
- Governance framework
- Analytical evidence register

---

# Project Highlights

- End-to-end analytics engineering workflow
- Passenger-weighted revenue estimation
- SQL-based validation framework
- Five-page interactive Power BI dashboard
- Complete documentation suite
- Fully traceable analytical implementation

---

# Future Enhancements

Potential future improvements include:

- Interactive geospatial route visualization
- Predictive demand forecasting
- Route profitability estimation
- Airline-level benchmarking
- Incremental ETL pipeline
- Automated data refresh

---

# Acknowledgements

This project uses publicly available data published by the U.S. Bureau of Transportation Statistics (BTS).

---

# License

This repository is provided for educational and portfolio purposes.

Please review the BTS data usage policies before redistributing source datasets.