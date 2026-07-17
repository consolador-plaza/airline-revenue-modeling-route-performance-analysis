# 06_Dashboard_Blueprint.md

# Dashboard Blueprint

## Airline Route Performance & Estimated Passenger Revenue Analysis

### Purpose

This document defines the structure, navigation, KPIs, and visualizations for the Power BI dashboard. The dashboard is designed to communicate validated analytical findings from the Analytical Evidence Register and support commercial decision-making for the Revenue Management Team.

Every dashboard element should trace back to one or more entries in the Analytical Evidence Register.

---

# Dashboard Design Principles

The dashboard follows five design principles:

1. Each page answers a specific business question.
2. Every visual supports at least one validated analytical finding.
3. KPIs summarize performance before detailed exploration.
4. Navigation flows from executive overview to detailed analysis.
5. Visualizations prioritize clarity over quantity.

---

# Dashboard Navigation

Page 1 → Executive Overview

↓

Page 2 → Revenue Performance

↓

Page 3 → Passenger Demand

↓

Page 4 → Capacity Utilization

↓

Page 5 → Route Performance

↓

Page 6 → Trends & Growth

---

# Page 1 – Executive Overview

## Business Question

How is the airline network performing overall?

### KPIs

* Total Estimated Passenger Revenue
* Total Passengers
* Passenger-Weighted Average Fare
* Median Estimated Passenger Revenue
* Average Load Factor

### Visuals

* Revenue Concentration (Pareto Chart)
* Revenue by Decile
* Quarterly Revenue Trend (small line chart)

### Supports

* AE-02
* AE-03
* AE-06

---

# Page 2 – Revenue Performance

## Business Question

Where is estimated passenger revenue generated?

### KPIs

* Top 10% Revenue Contribution
* Top 1% Revenue Contribution

### Visuals

* Revenue Distribution Histogram
* Revenue Decile Bar Chart
* Revenue Concentration Pareto Chart
* Top Revenue Leader Table

### Supports

* AE-02
* AE-03
* AE-09

---

# Page 3 – Passenger Demand

## Business Question

Where is passenger demand concentrated?

### KPIs

* Total Passengers
* Median Passengers
* Top 10% Passenger Contribution

### Visuals

* Passenger Distribution
* Passenger Concentration Pareto
* Demand Leader Table
* Passenger vs Estimated Passenger Revenue Scatter Plot

### Supports

* AE-04
* AE-05
* AE-10

---

# Page 4 – Capacity Utilization

## Business Question

How effectively is available seat capacity utilized?

### KPIs

* Average Load Factor
* Median Load Factor

### Visuals

* Load Factor Distribution
* Capacity Utilization Bands
* Quarterly Load Factor Trend
* Low Capacity Utilization Markets Table

### Supports

* AE-07
* AE-09

---

# Page 5 – Route Performance

## Business Question

Which markets drive commercial performance?

### Visuals

* Revenue Leaders
* Demand Leaders
* Yield Leaders
* Comparative Route Matrix

### KPIs

* Highest Revenue Route
* Highest Passenger Route
* Highest Yield Route

### Supports

* AE-09
* AE-10

---

# Page 6 – Trends & Growth

## Business Question

How has commercial performance changed over time?

### KPIs

* Revenue Growth (YoY)
* Passenger Growth (YoY)
* Passenger-Weighted Fare Growth (YoY)

### Visuals

* Quarterly Estimated Passenger Revenue
* Quarterly Passenger Trend
* Passenger-Weighted Average Fare Trend
* YoY Growth Comparison
* QoQ Seasonal Trend

### Supports

* AE-06

---

# Global Filters

The following slicers should be available across all pages:

* Year
* Quarter
* Origin Airport
* Destination Airport
* Airport Pair
* Carrier (where applicable)

---

# Navigation

Each page should contain:

* Home button
* Previous page
* Next page
* Reset Filters button

---

# Dashboard Design Goals

The completed dashboard should enable users to:

* Monitor commercial performance.
* Identify strategically important markets.
* Compare demand and estimated passenger revenue.
* Evaluate capacity utilization.
* Explore quarterly business trends.
* Investigate individual airport pairs.

---

# Dashboard-to-Evidence Mapping

| Dashboard Page       | Evidence Register   |
| -------------------- | ------------------- |
| Executive Overview   | AE-02, AE-03, AE-06 |
| Revenue Performance  | AE-02, AE-03, AE-09 |
| Passenger Demand     | AE-04, AE-05, AE-10 |
| Capacity Utilization | AE-07, AE-09        |
| Route Performance    | AE-09, AE-10        |
| Trends & Growth      | AE-06               |

---

# Success Criteria

The dashboard will be considered complete when:

* Every visual supports at least one Evidence Register finding.
* All KPIs reconcile with the analytical model.
* Users can navigate from high-level performance to route-level detail.
* Dashboard pages collectively answer all primary business questions identified during project planning.
* No visual is included without a defined analytical purpose.
