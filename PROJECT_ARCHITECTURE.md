# Project Architecture

**Project:** Airline Route Performance & Estimated Passenger Revenue Analysis

**Document Type:** Technical Architecture

**Version:** 1.0

**Status:** Final

---

# Purpose

This document describes the technical architecture of the Airline Route Performance & Estimated Passenger Revenue Analysis project.

It explains how raw Bureau of Transportation Statistics (BTS) datasets are transformed into a validated analytical dataset, consumed by Power BI, and governed through a structured documentation framework.

The objective is to provide a high-level technical blueprint for understanding the project's end-to-end analytical workflow.

---

# Architecture Overview

>![Project Architecture](07_assets/diagrams/project_architecture.svg)
---

# Project Layers

The solution follows a layered analytics engineering architecture.

| Layer | Purpose |
|--------|---------|
| Raw Data | Original BTS datasets |
| Data Preparation | Quarterly aggregation and preprocessing |
| Transformation | Route-level integration and business metric creation |
| Validation | Data quality and analytical verification |
| Analysis | Exploratory and business analysis |
| Semantic Model | Power BI data model and DAX measures |
| Visualization | Interactive dashboard |
| Governance | Documentation, QA, and traceability |

---

# Data Sources

## BTS T100 Segment

Provides operational flight activity including:

- Passenger volume
- Seat capacity
- Departures performed
- Air time
- Freight

---

## BTS DB1B Market

Provides commercial passenger fare information including:

- Market fare
- Passenger counts
- Origin airport
- Destination airport

The two datasets are integrated using a common analytical grain.

---

# Analytical Grain

Every observation within the analytical dataset represents:

```
Year

Quarter

Origin Airport

Destination Airport
```

This route-quarter grain was selected after SQL validation demonstrated superior analytical coverage compared to carrier-level integration.

---

# SQL Workflow

```
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
05_route_performance_analytics.sql
```

Each SQL script has a single responsibility and collectively implements the complete analytical workflow.

---

# Analytical Dataset

The central analytical dataset is:

```
dbo.route_performance_analytics
```

This dataset serves as the single source of truth for:

- SQL validation
- Exploratory analysis
- Power BI
- Dashboard measures
- Project documentation

---

# Business Rules

## Estimated Passenger Revenue

```
Passengers
×

Weighted Average Fare
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

These business rules are consistently implemented across SQL, Power BI, and project documentation.

---

# Validation Framework

Validation occurs before any analytical interpretation.

Validation categories include:

- Dataset completeness
- Join validation
- Route coverage
- Passenger coverage
- Weighted fare validation
- Revenue validation
- Load factor validation
- Data integrity checks

Only validated data is used for downstream analysis.

---

# Power BI Architecture

```
route_performance_analytics
            │
            ▼

      Power BI Model

            │

      Relationships

            │

    Calculated Measures

            │

        Dashboard Pages
```

The Power BI semantic model consumes only the validated analytical dataset.

---

# Documentation Architecture

The documentation mirrors the analytical lifecycle.

```
01 Data Understanding
        │
        ▼
02 Planning
        │
        ▼
03 Transformation Strategy
        │
        ▼
04 Dataset Integration
        │
        ▼
05 Analytical Evidence
        │
        ▼
06 Dashboard Design
        │
        ▼
07 Governance
```

This structure provides complete analytical traceability.

---

# Repository Architecture

>![Repository Map](07_assets/diagrams/repository_map.svg)

Each folder represents a distinct stage within the analytical lifecycle.

---

# Design Principles

The project follows several architectural principles.

- Single analytical source of truth
- Reproducible SQL workflow
- Separation of preparation, transformation, validation, and analysis
- Documentation-driven governance
- Business rule consistency
- End-to-end traceability
- Modular repository organization

---

# Future Architecture Enhancements

Potential future enhancements include:

- Automated ETL pipeline
- Incremental data refresh
- Azure SQL deployment
- Power BI Service publication
- CI/CD pipeline for SQL deployment
- Data quality monitoring
- Geospatial visualization layer

---

# Relationship to Repository

This architecture document complements:

- `README.md`
- `03_sql/README.md`
- `07_docs/DOCUMENT_INDEX.md`

It should be used as the primary technical reference for understanding the repository.

---

# Version Information

| Attribute | Value |
|-----------|-------|
| Version | 1.0 |
| Status | Final |
| Repository Release | v1.0.0 |
| Last Updated | July 2026 |
