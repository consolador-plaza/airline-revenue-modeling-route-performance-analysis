# Transformation Strategy Report

## Project

Airline Revenue Modeling & Route Performance Analysis

## Phase

Execution

## Stage

Execution Stage 1 – Data Preparation & Transformation Strategy

## Objective

The purpose of this stage was to define the analytical grain, transformation requirements, aggregation methodology, and integration strategy before performing any dataset integration or KPI development.

This stage establishes the technical foundation for all subsequent analysis and dashboard development.

---

# Source Datasets

## Dataset 1: T100

### Role

Traffic and operational activity dataset.

### Key Metrics

* Passengers
* Seats
* Departures Performed
* Air Time
* Freight

### Key Dimensions

* Year
* Quarter
* Month
* Unique Carrier
* Origin Airport
* Destination Airport

---

## Dataset 2: DB1B_MARKET

### Role

Fare and market pricing dataset.

### Key Metrics

* Market Fare
* Passengers

### Key Dimensions

* Year
* Quarter
* Operating Carrier
* Origin Airport
* Destination Airport

---

# Analytical Grain Decision

## Evaluated Options

### Option A

Route × Quarter

### Option B

Route × Month

---

## Selected Option

Route × Quarter

### Rationale

DB1B_MARKET is reported at the quarterly level.

Using quarterly aggregation:

* Aligns with source data granularity
* Avoids artificial fare allocation assumptions
* Improves methodological transparency
* Simplifies integration logic

### Decision

Approved

---

# Carrier Inclusion Decision

## Evaluated Options

### Option A

Exclude Carrier

### Option B

Include Carrier

---

## Selected Option

Include Carrier

### Rationale

Retaining carrier information enables:

* Carrier filtering
* Revenue attribution
* Supporting carrier analysis
* Future project extensibility

Carrier analysis is not the primary focus of the project but remains valuable contextual information.

### Decision

Approved

---

# Route Definition

## Selected Route Structure

Directional Routes

Examples:

* JFK → LAX
* ATL → ORD
* DFW → DEN

### Rationale

Directional routes preserve the operational structure of the source datasets and maintain consistency with aviation reporting standards.

### Decision

Approved

---

# Route Naming Convention

## Selected Format

Airport Pair Naming

Examples:

* JFK → LAX
* ATL → ORD

### Rationale

Maintains consistency with source data and supports route-level decision-making.

### Decision

Approved

---

# T100 Transformation Requirements

## Current Grain

Carrier × Route × Month

---

## Target Grain

YEAR
QUARTER
UNIQUE_CARRIER
ORIGIN
DEST

---

## Aggregation Rules

| Field                | Aggregation |
| -------------------- | ----------- |
| PASSENGERS           | SUM         |
| SEATS                | SUM         |
| DEPARTURES_PERFORMED | SUM         |
| AIR_TIME             | SUM         |
| FREIGHT              | SUM         |

---

# DB1B_MARKET Transformation Requirements

## Current Grain

Multiple records per:

YEAR
QUARTER
OPERATING_CARRIER
ORIGIN
DEST

---

## Validation Result

| Metric                  |     Value |
| ----------------------- | --------: |
| Duplicate Groups        | 1,463,060 |
| Maximum Rows in a Group |     5,570 |

### Interpretation

DB1B_MARKET cannot be joined in raw form and requires aggregation before integration.

---

## Target Grain

YEAR
QUARTER
OPERATING_CARRIER
ORIGIN
DEST

---

# Fare Aggregation Methodology

## Evaluated Options

### Option A

Simple Average Fare

### Option B

Weighted Average Fare

### Option C

Median Fare

---

## Selected Option

Weighted Average Fare

### Formula

Weighted Average Fare =
SUM(MARKET_FARE × PASSENGERS)
÷
SUM(PASSENGERS)

### Rationale

Weighted averaging reflects actual passenger volume and provides a more representative market fare than a simple average.

This approach aligns with revenue management and commercial analysis practices.

### Decision

Approved

---

# Integration Design

## Final Analytical Grain

YEAR
QUARTER
CARRIER
ORIGIN
DEST

---

## Planned Integration Flow

T100 Raw
→ Quarterly Aggregation
→ T100 Quarterly

DB1B_MARKET Raw
→ Fare Aggregation
→ DB1B_MARKET Quarterly

T100 Quarterly
+
DB1B_MARKET Quarterly
→ Integrated Analytical Dataset

Integrated Analytical Dataset
→ KPI Layer

KPI Layer
→ Power BI Dashboard

---

# Assumptions

| Assumption                                                                    | Rationale                                   |
| ----------------------------------------------------------------------------- | ------------------------------------------- |
| Quarterly analysis is sufficient for business objectives                      | Aligns with fare dataset granularity        |
| Weighted fare represents market pricing more accurately than a simple average | Incorporates passenger volume               |
| Carrier-level integration is desirable even if carrier analysis is secondary  | Supports filtering and future extensibility |
| Directional routes should be preserved                                        | Maintains operational fidelity              |

---

# Risks

| Risk                                                             | Impact |
| ---------------------------------------------------------------- | ------ |
| Carrier code inconsistencies between datasets                    | Medium |
| Quarterly aggregation reduces temporal detail                    | Low    |
| Revenue remains estimated rather than actual                     | Medium |
| Weighted fare depends on passenger sample quality in DB1B_MARKET | Medium |

---

# Stage Conclusion

Execution Stage 1 is complete.

### Outcome

The project now has:

* Defined analytical grain
* Defined transformation rules
* Defined fare aggregation methodology
* Defined integration structure
* Defined route structure
* Defined carrier treatment

### Decision

Proceed to Execution Stage 2 – Dataset Integration.

No additional transformation decisions are required before integration begins.
