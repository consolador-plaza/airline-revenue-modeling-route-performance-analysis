/*==============================================================================
Project:
Airline Route Performance & Estimated Passenger Revenue Analysis

File:
05_route_performance_analytics.sql

Purpose:
Create the final analytical dataset used throughout the project.

This deployment script integrates the prepared operational and fare datasets
into a single analytical dataset for SQL validation, exploratory analysis,
and Power BI reporting.

Inputs:
    dbo.t100_route_quarterly
    dbo.db1b_market_route_quarterly

Output:
    dbo.route_performance_analytics

Author:
<Your Name>

Version:
2.0

==============================================================================*/

/*------------------------------------------------------------------------------
Execution Prerequisites

✓ 01_data_preparation.sql completed
✓ 02_transformation.sql completed

Required Tables

• dbo.t100_route_quarterly
• dbo.db1b_market_route_quarterly

This script may be executed independently once the prerequisite
datasets have been created.

------------------------------------------------------------------------------*/

/*------------------------------------------------------------------------------
Business Rules

Estimated Passenger Revenue
---------------------------
Passengers × Weighted Average Fare

Weighted Average Fare
---------------------
SUM(Fare × Passengers)
÷
SUM(Passengers)

Load Factor
-----------
Passengers ÷ Seats

Analytical Grain
----------------
Year
Quarter
Origin Airport
Destination Airport

------------------------------------------------------------------------------*/

GO

/*==============================================================================
Create Analytical Dataset
==============================================================================*/

DROP TABLE IF EXISTS dbo.route_performance_analytics;

SELECT

    t.YEAR,
    t.QUARTER,

    t.ORIGIN,
    t.DEST,

    CONCAT(t.ORIGIN, ' - ', t.DEST) AS airport_pair,

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

    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

GO

/*==============================================================================
Validation
==============================================================================*/

PRINT 'Validating analytical dataset...';

SELECT COUNT(*) AS analytical_rows
FROM dbo.route_performance_analytics;

SELECT TOP (10) *
FROM dbo.route_performance_analytics;

SELECT

    SUM(passengers) AS total_passengers,
    SUM(estimated_revenue) AS total_estimated_revenue,
    AVG(weighted_avg_fare) AS average_weighted_fare,
    AVG(load_factor) AS average_load_factor

FROM dbo.route_performance_analytics;

GO

/*==============================================================================
Deployment Summary

Dataset Created

✓ dbo.route_performance_analytics

Primary Use

✓ SQL Validation
✓ Exploratory Analysis
✓ Power BI Semantic Model
✓ Dashboard Reporting
✓ Project Documentation

Related SQL Scripts

01_data_preparation.sql
02_transformation.sql
03_validation.sql
04_analysis.sql

Status

Deployment Complete

==============================================================================*/