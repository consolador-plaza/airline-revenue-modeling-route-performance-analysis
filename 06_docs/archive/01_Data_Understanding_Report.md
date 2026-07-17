# Data Understanding & Feasibility Assessment Report

## Project

Airline Revenue Modeling & Route Performance Analysis

## Phase

Initiation → Data Understanding & Feasibility Assessment

## Objective

The purpose of this phase was to evaluate whether the selected datasets could support the project's goal of analyzing airline route performance and estimating route-level revenue through the integration of passenger traffic and airfare data.

---

# Datasets Evaluated

## Dataset 1: T-100 Domestic Segment Data

### Role in Project

Provides operational and traffic activity for airline routes.

### Key Metrics Available

* Passengers
* Seats
* Departures Performed
* Freight
* Air Time
* Distance

### Key Dimensions

* Year
* Quarter
* Month
* Carrier
* Origin Airport
* Destination Airport

### Dataset Statistics

| Metric     |     Value |
| ---------- | --------: |
| Rows       | 1,270,481 |
| Year Range | 2022–2024 |

---

## Dataset 2: DB1B Market Fare Data

### Role in Project

Provides airfare information used as a revenue proxy.

### Key Metrics Available

* Market Fare
* Sample Passenger Volume

### Key Dimensions

* Year
* Quarter
* Operating Carrier
* Origin Airport
* Destination Airport

### Dataset Statistics

| Metric     |      Value |
| ---------- | ---------: |
| Rows       | 90,062,793 |
| Year Range |  2022–2024 |

---

# Data Quality Assessment

## Missing Values

Validation was performed on critical analytical fields.

### T100

* PASSENGERS
* ORIGIN
* DEST

### DB1B

* MARKET_FARE
* ORIGIN
* DEST

### Result

No null values were identified in any critical fields.

### Assessment

No immediate data quality issues were found that would prevent analysis or dataset integration.

---

# Route Compatibility Assessment

Distinct routes were evaluated to determine integration feasibility.

| Dataset | Distinct Routes |
| ------- | --------------: |
| T100    |          50,991 |
| DB1B    |         101,268 |

### Assessment

The difference in route counts is expected because:

* DB1B contains broader market coverage.
* T100 contains reported traffic activity.

Both datasets contain:

* ORIGIN
* DEST

which provides a common route identifier structure.

Result: Route-level integration is feasible.

---

# Carrier Assessment

Carrier identifiers were reviewed across both datasets.

### T100

Contains major U.S. carriers including:

* AA
* AS
* B6
* DL
* F9
* UA
* WN

Also contains additional carrier codes and smaller operators.

### DB1B

Contains:

* Major U.S. carriers
* International carriers
* Special values such as:

  * 99

  ---

### Assessment

Carrier identifiers exist in both datasets, but standardization and filtering may be required during later transformation stages.

This is not considered a project blocker.

---

# Integration Feasibility Assessment

A route overlap validation was performed using:

* YEAR
* QUARTER
* ORIGIN
* DEST

### Result

| Metric                     |   Value |
| -------------------------- | ------: |
| Matched Route Combinations | 118,500 |

### Assessment

The overlap is sufficient to support dataset integration and revenue estimation.

The result confirms that both datasets share a substantial number of common route-period combinations.

---

# Confirmed Assumptions

The following assumptions were validated during this phase:

| Assumption                                             | Status    |
| ------------------------------------------------------ | --------- |
| T100 provides passenger demand information             | Confirmed |
| DB1B provides fare information                         | Confirmed |
| Route-level integration is possible                    | Confirmed |
| Revenue estimation can be derived from integrated data | Confirmed |
| Carrier standardization may be required later          | Confirmed |

---

# Risks Identified

| Risk                                                    | Impact |
| ------------------------------------------------------- | ------ |
| Carrier code inconsistencies                            | Medium |
| Special carrier values (99, --)                         | Medium |
| Quarterly vs monthly granularity differences            | Medium |
| Revenue is estimated rather than actual airline revenue | Low    |

---

# Phase Conclusion

The Data Understanding & Feasibility Assessment phase is considered complete.

### Outcome

The selected datasets are suitable for the project objectives and provide sufficient coverage to support:

* Route performance analysis
* Passenger demand analysis
* Fare analysis
* Revenue estimation
* Dashboard development

### Decision

Proceed to the Planning Phase.

No additional datasets are required at this time.

---

# Dataset Validation Snapshot (Reference)

| Metric                     |      T100 |       DB1B |
| -------------------------- | --------: | ---------: |
| Rows                       | 1,270,481 | 90,062,793 |
| Years Covered              | 2022–2024 |  2022–2024 |
| Distinct Routes            |    50,991 |    101,268 |
| Matched Route Combinations |   118,500 |    118,500 |
| Critical Null Values       |         0 |          0 |

Status: PASSED
