# Dataset Integration Report

## Project

Airline Revenue Modeling & Route Performance Analysis

## Phase

Execution

## Stage

Execution Stage 2 – Dataset Integration

## Objective

The purpose of this stage was to transform, aggregate, validate, and integrate the T100 and DB1B_MARKET datasets into a single analytical dataset suitable for KPI development, analysis, and dashboarding.

---

# Source Tables

## T100

### Raw Dataset

| Metric |     Value |
| ------ | --------: |
| Rows   | 1,270,481 |

### Role

Operational and traffic activity dataset.

Provides:

* Passenger volume
* Seats
* Departures
* Air time
* Freight

---

## DB1B_MARKET

### Raw Dataset

| Metric |      Value |
| ------ | ---------: |
| Rows   | 90,062,793 |

### Role

Fare and pricing dataset.

Provides:

* Market Fare
* Passenger sample volume

---

# Integration Design Validation

## Initial Design

The initial integration design was:

YEAR
QUARTER
CARRIER
ORIGIN
DEST

### Validation Result

Carrier-level integration produced:

| Metric      |   Value |
| ----------- | ------: |
| Joined Rows | 168,885 |
| Coverage    |   46.5% |

### Observation

Carrier compatibility significantly reduced join coverage.

---

# Revised Integration Design

The integration grain was revised to:

YEAR
QUARTER
ORIGIN
DEST

### Rationale

The project's primary objective is route-level revenue analysis rather than carrier-level analysis.

This approach:

* Improves integration coverage
* Aligns with business objectives
* Supports route-level decision making
* Reduces carrier compatibility issues

---

# T100 Transformation

## Intermediate Table

t100_quarterly

### Grain

YEAR
QUARTER
UNIQUE_CARRIER
ORIGIN
DEST

### Result

| Metric |   Value |
| ------ | ------: |
| Rows   | 363,052 |

---

## Route-Level Table

t100_route_quarterly

### Grain

YEAR
QUARTER
ORIGIN
DEST

### Result

| Metric |   Value |
| ------ | ------: |
| Rows   | 207,741 |

### Metrics Included

* passengers
* seats
* departures_performed
* air_time
* freight

---

# DB1B_MARKET Transformation

## Data Quality Finding

PASSENGERS was imported as CHAR data despite containing numeric values.

### Resolution

Validated successful conversion to numeric values.

---

## Intermediate Table

db1b_market_quarterly

### Grain

YEAR
QUARTER
OPERATING_CARRIER
ORIGIN
DEST

### Result

| Metric |     Value |
| ------ | --------: |
| Rows   | 1,819,000 |

---

## Fare Methodology

Weighted Average Fare

Formula:

SUM(MARKET_FARE × PASSENGERS)
÷
SUM(PASSENGERS)

### Rationale

Provides a more representative fare than a simple average and aligns with revenue management practices.

---

## Route-Level Table

db1b_market_route_quarterly

### Grain

YEAR
QUARTER
ORIGIN
DEST

### Result

| Metric |   Value |
| ------ | ------: |
| Rows   | 804,443 |

### Metrics Included

* passengers_db1b
* weighted_avg_fare

---

# Join Validation

## Carrier-Level Join

Join Keys:

YEAR
QUARTER
CARRIER
ORIGIN
DEST

### Result

| Metric      |   Value |
| ----------- | ------: |
| Joined Rows | 168,885 |
| Coverage    |   46.5% |

---

## Route-Level Join

Join Keys:

YEAR
QUARTER
ORIGIN
DEST

### Result

| Metric                         |   Value |
| ------------------------------ | ------: |
| Joined Routes                  | 118,500 |
| Coverage vs T100 Route Dataset |   57.0% |

Calculation:

118,500 ÷ 207,741

### Assessment

Coverage is sufficient for revenue estimation and route-level analysis.

# Additional Coverage Validation

## Route Coverage Assessment

Route-level integration was evaluated by comparing matched route-quarter combinations between T100 and DB1B_MARKET.

### Results

| Metric                             |   Value |
| ---------------------------------- | ------: |
| Route-Quarter Combinations (T100)  | 207,741 |
| Matched Route-Quarter Combinations | 118,500 |
| Route Coverage                     |   57.0% |

### Observation

At face value, route coverage appears moderate. However, route count alone does not measure commercial significance because all routes are weighted equally regardless of passenger volume.

For this reason, passenger coverage was evaluated as the primary representativeness metric.

---

## Passenger Coverage Assessment

Passenger coverage was evaluated by comparing total passenger traffic in T100 against passenger traffic represented within the matched integrated dataset.

### Results

| Metric                                |         Value |
| ------------------------------------- | ------------: |
| Total Passengers (T100 Route Dataset) | 2,448,591,489 |
| Matched Passengers                    | 2,437,950,608 |
| Passenger Coverage                    |        99.57% |
| Unmatched Passengers                  |    10,640,881 |
| Unmatched Passenger Share             |         0.43% |

### Calculation

Passenger Coverage

= Matched Passengers ÷ Total Passengers

= 2,437,950,608 ÷ 2,448,591,489

= 99.57%

---

## Interpretation

Although only 57.0% of route-quarter combinations were matched between datasets, the matched routes account for approximately 99.57% of all passenger traffic.

This indicates that the unmatched routes are predominantly low-volume markets and have minimal impact on overall commercial activity.

As a result, the integrated dataset captures virtually all commercially significant passenger demand within the network.

---

## Representativeness Assessment

### Route Coverage

57.0%

### Passenger Coverage

99.57%

### Assessment

The integrated dataset is considered highly representative of network activity for the purposes of:

* Revenue estimation
* Route performance analysis
* Demand analysis
* Revenue concentration analysis
* Revenue opportunity identification

The remaining unmatched routes are not expected to materially influence project findings due to their extremely small share of total passenger traffic.

---

# Final Integrated Dataset

## Table Name

route_performance_fact

### Grain

YEAR
QUARTER
ORIGIN
DEST

---

## Metrics Included

### Traffic Metrics

* passengers
* seats
* departures_performed
* air_time
* freight

### Fare Metrics

* passengers_db1b
* weighted_avg_fare

---

## Final Row Count

| Metric |   Value |
| ------ | ------: |
| Rows   | 118,500 |

---

# Assumptions

| Assumption                                                 | Rationale                                    |
| ---------------------------------------------------------- | -------------------------------------------- |
| Route-level analysis is the primary analytical requirement | Aligns with business objective               |
| Routes without fare data are excluded                      | Revenue estimation requires fare information |
| Weighted fare is a valid representation of market pricing  | Supported by passenger weighting             |
| Inner join is appropriate                                  | Only matched routes support revenue analysis |

---

# Risks

| Risk                                                                | Impact |
| ------------------------------------------------------------------- | ------ |
| Approximately 43% of route-quarter combinations lack fare data; however, these routes represent only 0.43% of total passenger traffic and are not expected to materially affect revenue analysis results. | Medium |
| Revenue remains estimated rather than actual airline revenue        | Medium |
| DB1B fare data is sample-based                                      | Medium |
| Carrier-level analysis is limited in the primary fact table         | Low    |

---

# Revised Integration Conclusion

The final integrated dataset contains 118,500 route-quarter observations and captures approximately 99.57% of total passenger traffic represented in T100.

While route-level coverage is 57.0%, passenger-level coverage demonstrates that nearly all commercially significant traffic is retained within the integrated analytical dataset.

Therefore, the integrated dataset is considered sufficiently complete and representative for route-level revenue analysis and KPI development.

### Final Assessment

Integration Status: Approved

Analytical Readiness: Approved

Proceed to Execution Stage 3 – KPI Development.
