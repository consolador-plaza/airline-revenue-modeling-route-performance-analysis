/*=========================================================================
Project:
Airline Route Performance & Estimated Passenger Revenue Analysis

File:
02_transformation.sql

Purpose:
Transform the prepared quarterly datasets into the final analytical
dataset used throughout SQL validation, Power BI, and documentation.

Inputs:
    dbo.t100_quarterly
    dbo.db1b_market_quarterly

Outputs:
    dbo.t100_route_quarterly
    dbo.db1b_market_route_quarterly
    dbo.route_performance_analytics

Version:
2.0
=========================================================================*/

/*-----------------------------------------------------------------------
Execution Prerequisites

✓ 01_data_preparation.sql completed

Required Tables

• dbo.t100_quarterly
• dbo.db1b_market_quarterly

Next Script

03_validation.sql
-----------------------------------------------------------------------*/

/*-----------------------------------------------------------------------
Data Lineage

t100
    ↓
t100_quarterly
    ↓
t100_route_quarterly

db1b_market
    ↓
db1b_market_quarterly
    ↓
db1b_market_route_quarterly

            ↓

route_performance_analytics

-----------------------------------------------------------------------*/

GO

/*=======================================================================
SECTION 1
Create Route-Level T100 Dataset
=======================================================================

Purpose

Aggregate operational activity from carrier-route-quarter to the
project's analytical grain.

Target Grain

• Year
• Quarter
• Origin
• Destination

Output

dbo.t100_route_quarterly

=======================================================================*/

DROP TABLE IF EXISTS dbo.t100_route_quarterly;

SELECT

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    SUM(passengers)              AS passengers,
    SUM(seats)                   AS seats,
    SUM(departures_performed)    AS departures_performed,
    SUM(air_time)                AS air_time,
    SUM(freight)                 AS freight

INTO dbo.t100_route_quarterly

FROM dbo.t100_quarterly

GROUP BY

    YEAR,
    QUARTER,
    ORIGIN,
    DEST;

GO

/*=======================================================================
SECTION 2
Validate Route-Level T100 Dataset
=======================================================================*/

SELECT COUNT(*) AS route_rows
FROM dbo.t100_route_quarterly;

SELECT TOP (10) *
FROM dbo.t100_route_quarterly;

GO

/*=======================================================================
SECTION 3
Create Route-Level DB1B Dataset
=======================================================================

Business Rule

Weighted Average Fare

=

SUM(MARKET_FARE × PASSENGERS)

/

SUM(PASSENGERS)

Purpose

Create passenger-weighted fares at the route-quarter level.

Output

dbo.db1b_market_route_quarterly

=======================================================================*/

DROP TABLE IF EXISTS dbo.db1b_market_route_quarterly;

SELECT

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    SUM(passengers_db1b) AS passengers_db1b,

    SUM(weighted_avg_fare * passengers_db1b)
        / NULLIF(SUM(passengers_db1b),0)
        AS weighted_avg_fare

INTO dbo.db1b_market_route_quarterly

FROM dbo.db1b_market_quarterly

GROUP BY

    YEAR,
    QUARTER,
    ORIGIN,
    DEST;

GO

/*=======================================================================
SECTION 4
Validate Route-Level DB1B Dataset
=======================================================================*/

SELECT COUNT(*) AS route_rows
FROM dbo.db1b_market_route_quarterly;

SELECT TOP (10) *
FROM dbo.db1b_market_route_quarterly;

GO

/*=======================================================================
SECTION 5
Create Final Analytical Dataset
=======================================================================

Purpose

Integrate operational activity with passenger-weighted fare data to
produce the project's analytical source of truth.

Join Keys

• Year
• Quarter
• Origin
• Destination

Output

dbo.route_performance_analytics

=======================================================================*/

DROP TABLE IF EXISTS dbo.route_performance_analytics;

SELECT

    t.YEAR,
    t.QUARTER,

    t.ORIGIN,
    t.DEST,

    CONCAT(t.ORIGIN,' - ',t.DEST) AS airport_pair,

    t.passengers,
    t.seats,
    t.departures_performed,
    t.air_time,
    t.freight,

    d.passengers_db1b,
    d.weighted_avg_fare,

    CAST(
        t.passengers * d.weighted_avg_fare
        AS DECIMAL(18,2)
    ) AS estimated_revenue,

    CAST(
        t.passengers * 1.0
        / NULLIF(t.seats,0)
        AS DECIMAL(10,4)
    ) AS load_factor,

    CAST(
        (t.passengers * d.weighted_avg_fare)
        / NULLIF(t.passengers,0)
        AS DECIMAL(18,2)
    ) AS revenue_per_passenger

INTO dbo.route_performance_analytics

FROM dbo.t100_route_quarterly t

INNER JOIN dbo.db1b_market_route_quarterly d

ON  t.YEAR     = d.YEAR
AND t.QUARTER  = d.QUARTER
AND t.ORIGIN   = d.ORIGIN
AND t.DEST     = d.DEST;

GO

/*=======================================================================
SECTION 6
Validate Final Analytical Dataset
=======================================================================*/

SELECT COUNT(*) AS analytical_rows
FROM dbo.route_performance_analytics;

SELECT TOP (10) *
FROM dbo.route_performance_analytics;

SELECT

    MIN(load_factor) AS min_load_factor,
    MAX(load_factor) AS max_load_factor,
    AVG(load_factor) AS avg_load_factor

FROM dbo.route_performance_analytics;

GO

/*=======================================================================
SUMMARY

Created Tables

✓ dbo.t100_route_quarterly
✓ dbo.db1b_market_route_quarterly
✓ dbo.route_performance_analytics

Derived Metrics

✓ Estimated Passenger Revenue
✓ Weighted Average Fare
✓ Load Factor
✓ Revenue per Passenger

Validation

✓ Route aggregation
✓ Fare aggregation
✓ Dataset integration

Next Script

03_validation.sql

=======================================================================*/