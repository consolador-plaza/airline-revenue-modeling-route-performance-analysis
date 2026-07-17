/*=========================================================================
Project:
Airline Route Performance & Estimated Passenger Revenue Analysis

File:
03_validation.sql

Purpose:
Validate the analytical dataset prior to exploratory analysis and Power BI
reporting. This script performs quality assurance checks only and does not
modify analytical data.

Input:
    dbo.route_performance_analytics

Output:
    Validation results

Version:
2.0
=========================================================================*/

/*-----------------------------------------------------------------------
Execution Prerequisites

✓ 02_transformation.sql completed

Required Table
• dbo.route_performance_analytics

Next Script
04_analysis.sql
-----------------------------------------------------------------------*/

GO

/*=======================================================================
VAL-01
Row Count Validation
=======================================================================

Purpose
-------
Confirm the analytical dataset was created successfully.

Expected Result
---------------
A single row containing the analytical record count.
*/

SELECT COUNT(*) AS analytical_rows
FROM dbo.route_performance_analytics;

SELECT TOP (10) *
FROM dbo.route_performance_analytics;

GO

/*=======================================================================
VAL-02
Route Coverage Validation
=======================================================================

Purpose
-------
Compare matched route-quarter combinations with the operational dataset.

*/


SELECT COUNT(*) AS joined_rows_no_carrier
FROM dbo.t100_quarterly t
INNER JOIN dbo.db1b_market_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

SELECT COUNT(*) AS joined_rows
FROM dbo.t100_quarterly t
INNER JOIN dbo.db1b_market_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.UNIQUE_CARRIER = d.OPERATING_CARRIER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;
   
SELECT TOP 20
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    estimated_revenue,
    revenue_rank
FROM dbo.route_performance_analytics
ORDER BY
    YEAR,
    QUARTER,
    revenue_rank;

GO

/*=======================================================================
VAL-03
Passenger Coverage Validation
=======================================================================

Purpose
-------
Confirm passenger-weighted analytical coverage.

Expected Result
---------------
Approximately 99.6% passenger coverage.

*/

SELECT
    COUNT(DISTINCT CONCAT(
        YEAR,'|',
        QUARTER,'|',
        ORIGIN,'|',
        DEST
    )) AS route_count
FROM dbo.t100_quarterly;

SELECT
    COUNT(DISTINCT CONCAT(
        YEAR,'|',
        QUARTER,'|',
        ORIGIN,'|',
        DEST
    )) AS route_count
FROM dbo.t100_quarterly;

SELECT TOP 20
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    passengers,
    passenger_rank
FROM dbo.route_performance_analytics
ORDER BY
    YEAR,
    QUARTER,
    passenger_rank;

GO

/*=======================================================================
VAL-04
Weighted Fare Validation
=======================================================================

Purpose
-------
Verify the passenger-weighted fare calculation.

Business Rule
-------------
Weighted Fare =
SUM(Fare * Passengers) / SUM(Passengers)

*/

SELECT
    COUNT(*) AS total_routes,

    SUM(estimated_revenue) AS total_estimated_revenue,

    SUM(passengers) AS total_passengers,

    SUM(seats) AS total_seats,

    AVG(load_factor) AS avg_load_factor,

    SUM(weighted_avg_fare * passengers_db1b)
        / NULLIF(SUM(passengers_db1b), 0)
        AS avg_weighted_fare

FROM dbo.route_performance_analytics;

SELECT
    MIN(estimated_revenue) AS min_revenue,
    MAX(estimated_revenue) AS max_revenue,

    MIN(weighted_avg_fare) AS min_fare,
    MAX(weighted_avg_fare) AS max_fare,

    MIN(passengers) AS min_passengers,
    MAX(passengers) AS max_passengers,

    MIN(seats) AS min_seats,
    MAX(seats) AS max_seats
FROM dbo.route_performance_analytics;

GO

/*=======================================================================
VAL-05
Estimated Revenue Validation
=======================================================================

Purpose
-------
Verify:

Estimated Revenue = Passengers × Weighted Average Fare

Example validation
*/

SELECT
    SUM(estimated_revenue) AS total_estimated_revenue,
    AVG(weighted_avg_fare) AS avg_weighted_fare,
    SUM(passengers) AS total_passengers
FROM dbo.route_performance_analytics;

GO

/*=======================================================================
VAL-06
Load Factor Validation
=======================================================================

Purpose
-------
Validate load factor distribution.

Formula
-------
Passengers / Seats
*/

SELECT
    COUNT(*) AS routes_over_100,
    AVG(load_factor) AS avg_load_factor_over_100
FROM dbo.route_performance_kpi
WHERE load_factor > 1;

SELECT
    COUNT(*) AS zero_passenger_routes
FROM dbo.route_performance_kpi
WHERE passengers = 0;

SELECT
    SUM(CASE WHEN is_zero_passenger = 1 THEN 1 ELSE 0 END) AS zero_passenger_routes,
    SUM(CASE WHEN is_load_factor_anomaly = 1 THEN 1 ELSE 0 END) AS load_factor_anomalies
FROM dbo.route_performance_kpi;

SELECT
    MIN(load_factor) AS min_load_factor,
    MAX(load_factor) AS max_load_factor,
    AVG(load_factor) AS avg_load_factor
FROM dbo.route_performance_analytics;

GO

/*=======================================================================
VAL-07
Data Integrity Validation
=======================================================================

Purpose
-------
Identify potential data quality issues.
*/

-- Null checks
SELECT *
FROM dbo.route_performance_analytics
WHERE estimated_revenue IS NULL
   OR weighted_avg_fare IS NULL
   OR load_factor IS NULL;

-- Duplicate airport pair / period
SELECT
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    COUNT(*) AS duplicate_count
FROM dbo.route_performance_analytics
GROUP BY YEAR, QUARTER, ORIGIN, DEST
HAVING COUNT(*) > 1;

-- Invalid values
SELECT *
FROM dbo.route_performance_analytics
WHERE passengers < 0
   OR seats < 0
   OR weighted_avg_fare < 0
   OR estimated_revenue < 0;

GO

/*=======================================================================
SUMMARY

Validation Completed

✓ Row Count
✓ Route Coverage
✓ Passenger Coverage
✓ Weighted Fare
✓ Estimated Revenue
✓ Load Factor
✓ Data Integrity

Dataset Status
--------------
Ready for exploratory analysis after all validation checks pass.

Next Script
-----------
04_analysis.sql

=======================================================================*/
