/*=========================================================================
Project:
Airline Route Performance & Estimated Passenger Revenue Analysis

File:
04_analysis.sql

Purpose:
Perform exploratory data analysis (EDA) on the validated
route_performance_analytics dataset. This script contains the SQL analyses
that support the findings documented in the Analytical Evidence
Specification (Document 05) and the Power BI dashboard.

Input:
    dbo.route_performance_analytics

Output:
    Analytical evidence and business insights

Version:
2.0
=========================================================================*/

/*-----------------------------------------------------------------------
Execution Prerequisites

✓ 03_validation.sql completed

Required Table
• dbo.route_performance_analytics

Related Documentation
• 05_Analytical_Evidence_Specification.md
• 06_Dashboard_Design_Specification.md

-----------------------------------------------------------------------*/

/*-----------------------------------------------------------------------
Analytical Workflow

Validated Dataset
        ↓
Revenue Analysis
        ↓
Demand Analysis
        ↓
Capacity & Utilization
        ↓
Route Performance
        ↓
Time-Series & Statistical Analysis
        ↓
Analytical Evidence

-----------------------------------------------------------------------*/

/*=======================================================================
SECTION 1
Executive Overview
Supports: AE-02, AE-03, AE-06
=======================================================================*/
--Executive Summary--
SELECT
    COUNT(*) AS total_routes,

    SUM(estimated_revenue) AS total_estimated_revenue,

    SUM(passengers) AS total_passengers,

    SUM(seats) AS total_seats,

    AVG(load_factor) AS avg_load_factor,

    SUM(weighted_avg_fare * passengers_db1b)
        / NULLIF(SUM(passengers_db1b), 0)
        AS avg_weighted_fare,

    SUM(CASE
            WHEN is_zero_passenger = 1 THEN 1
            ELSE 0
        END) AS zero_passenger_routes,

    SUM(CASE
            WHEN is_load_factor_anomaly = 1 THEN 1
            ELSE 0
        END) AS load_factor_anomalies

FROM dbo.route_performance_analytics;
---
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

--Revenue Concentration--
WITH RankedRevenue AS
(
    SELECT
        estimated_revenue,
        ROW_NUMBER() OVER (ORDER BY estimated_revenue DESC) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM dbo.route_performance_analytics
)

SELECT
    SUM(CASE
            WHEN rn <= CEILING(total_rows * 0.01)
            THEN estimated_revenue
            ELSE 0
        END) AS top_1pct_revenue,

    SUM(CASE
            WHEN rn <= CEILING(total_rows * 0.05)
            THEN estimated_revenue
            ELSE 0
        END) AS top_5pct_revenue,

    SUM(CASE
            WHEN rn <= CEILING(total_rows * 0.10)
            THEN estimated_revenue
            ELSE 0
        END) AS top_10pct_revenue,

    SUM(estimated_revenue) AS total_revenue

FROM RankedRevenue;
--Revenue Distribution Summary-- 
WITH RevenueDeciles AS
(
    SELECT
        estimated_revenue,

        NTILE(10) OVER
        (
            ORDER BY estimated_revenue DESC
        ) AS revenue_decile

    FROM dbo.route_performance_analytics
)

SELECT

    revenue_decile,

    COUNT(*) AS route_quarters,

    SUM(estimated_revenue) AS revenue,

    CAST
    (
        100.0 *
        SUM(estimated_revenue)
        /
        SUM(SUM(estimated_revenue)) OVER ()
        AS DECIMAL(10,2)
    ) AS revenue_pct

FROM RevenueDeciles

GROUP BY revenue_decile

ORDER BY revenue_decile;

--Quarterly Business Summary--
SELECT
    YEAR,
    QUARTER,

    SUM(estimated_revenue) AS total_estimated_revenue,

    SUM(passengers) AS total_passengers,

    SUM(seats) AS total_seats,

    SUM(weighted_avg_fare * passengers_db1b)
        / NULLIF(SUM(passengers_db1b),0)
        AS weighted_avg_fare,

    AVG(load_factor) AS avg_load_factor

FROM dbo.route_performance_analytics

GROUP BY
    YEAR,
    QUARTER

ORDER BY
    YEAR,
    QUARTER;

--Quarter-over-Quarter Growth--
WITH QuarterlySummary AS
(
    SELECT
        YEAR,
        QUARTER,

        SUM(estimated_revenue) AS total_estimated_revenue,

        SUM(passengers) AS total_passengers

    FROM dbo.route_performance_analytics

    GROUP BY
        YEAR,
        QUARTER
)

SELECT

    YEAR,
    QUARTER,

    total_estimated_revenue,

    LAG(total_estimated_revenue)
        OVER(ORDER BY YEAR, QUARTER)
        AS previous_revenue,

    CAST(
        100.0 *
        (
            total_estimated_revenue
            -
            LAG(total_estimated_revenue)
                OVER(ORDER BY YEAR, QUARTER)
        )
        /
        NULLIF(
            LAG(total_estimated_revenue)
                OVER(ORDER BY YEAR, QUARTER),
            0
        )
        AS DECIMAL(10,2)
    ) AS revenue_qoq_growth_pct,

    total_passengers,

    LAG(total_passengers)
        OVER(ORDER BY YEAR, QUARTER)
        AS previous_passengers,

    CAST(
        100.0 *
        (
            total_passengers
            -
            LAG(total_passengers)
                OVER(ORDER BY YEAR, QUARTER)
        )
        /
        NULLIF(
            LAG(total_passengers)
                OVER(ORDER BY YEAR, QUARTER),
            0
        )
        AS DECIMAL(10,2)
    ) AS passenger_qoq_growth_pct

FROM QuarterlySummary

ORDER BY
    YEAR,
    QUARTER;

--Year-over-Year Business Validation--
WITH QuarterlySummary AS
(
    SELECT
        YEAR,
        QUARTER,

        SUM(estimated_revenue) AS total_estimated_revenue,

        SUM(passengers) AS total_passengers,

        SUM(seats) AS total_seats,

        SUM(weighted_avg_fare * passengers_db1b)
            / NULLIF(SUM(passengers_db1b),0)
            AS weighted_avg_fare,

        AVG(load_factor) AS avg_load_factor

    FROM dbo.route_performance_analytics

    GROUP BY
        YEAR,
        QUARTER
)

SELECT

    curr.YEAR,
    curr.QUARTER,

    curr.total_estimated_revenue,

    prev.total_estimated_revenue AS previous_year_revenue,

    CAST
    (
        100.0 *
        (
            curr.total_estimated_revenue
            -
            prev.total_estimated_revenue
        )
        /
        NULLIF(prev.total_estimated_revenue,0)

        AS DECIMAL(10,2)

    ) AS revenue_yoy_pct,



    curr.total_passengers,

    prev.total_passengers AS previous_year_passengers,

    CAST
    (
        100.0 *
        (
            curr.total_passengers
            -
            prev.total_passengers
        )
        /
        NULLIF(prev.total_passengers,0)

        AS DECIMAL(10,2)

    ) AS passenger_yoy_pct,



    curr.weighted_avg_fare,

    prev.weighted_avg_fare AS previous_year_fare,

    CAST
    (
        100.0 *
        (
            curr.weighted_avg_fare
            -
            prev.weighted_avg_fare
        )
        /
        NULLIF(prev.weighted_avg_fare,0)

        AS DECIMAL(10,2)

    ) AS fare_yoy_pct,



    curr.avg_load_factor,

    prev.avg_load_factor AS previous_year_load_factor,

    CAST
    (
        100.0 *
        (
            curr.avg_load_factor
            -
            prev.avg_load_factor
        )
        /
        NULLIF(prev.avg_load_factor,0)

        AS DECIMAL(10,2)

    ) AS load_factor_yoy_pct

FROM QuarterlySummary curr

LEFT JOIN QuarterlySummary prev

    ON curr.QUARTER = prev.QUARTER
   AND curr.YEAR = prev.YEAR + 1

ORDER BY
    curr.YEAR,
    curr.QUARTER;

/*=======================================================================
SECTION 2
Revenue Analysis
Supports: AE-02, AE-03, AE-09
=======================================================================*/
SELECT
    COUNT(*) AS route_quarters,

    MIN(estimated_revenue) AS min_revenue,

    AVG(estimated_revenue) AS mean_revenue,

    MAX(estimated_revenue) AS max_revenue,

    STDEV(estimated_revenue) AS stddev_revenue
FROM dbo.route_performance_analytics;
--Revenue Quartiles--
SELECT DISTINCT

    PERCENTILE_CONT(0.25)
        WITHIN GROUP (ORDER BY estimated_revenue)
        OVER () AS q1,

    PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY estimated_revenue)
        OVER () AS median,

    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY estimated_revenue)
        OVER () AS q3

FROM dbo.route_performance_analytics;
--Revenue Leaders--
SELECT TOP (20)

    YEAR,
    QUARTER,

    ORIGIN,
    DEST,

    estimated_revenue,

    passengers,

    weighted_avg_fare,

    load_factor,

    revenue_rank

FROM dbo.route_performance_analytics

ORDER BY
    estimated_revenue DESC;
--Cumulative Revenue--
WITH RevenueRank AS
(
    SELECT

        estimated_revenue,

        ROW_NUMBER() OVER
        (
            ORDER BY estimated_revenue DESC
        ) AS revenue_rank,

        SUM(estimated_revenue) OVER() AS total_revenue

    FROM dbo.route_performance_analytics
)

SELECT

    revenue_rank,

    estimated_revenue,

    SUM(estimated_revenue) OVER
    (
        ORDER BY revenue_rank
    ) AS cumulative_revenue,

    CAST
    (
        100.0 *

        SUM(estimated_revenue) OVER
        (
            ORDER BY revenue_rank
        )

        /

        MAX(total_revenue) OVER()

        AS DECIMAL(10,2)

    ) AS cumulative_pct

FROM RevenueRank;

/*=======================================================================
SECTION 3
Demand Analysis
Supports: AE-04, AE-05
=======================================================================*/
--Passenger Distribution Summary--
SELECT
    COUNT(*) AS route_quarters,

    MIN(passengers) AS min_passengers,

    AVG(passengers) AS mean_passengers,

    MAX(passengers) AS max_passengers,

    STDEV(passengers) AS stddev_passengers
FROM dbo.route_performance_analytics;

--Passenger Quartiles--
SELECT DISTINCT

    PERCENTILE_CONT(0.25)
        WITHIN GROUP (ORDER BY passengers)
        OVER () AS q1,

    PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY passengers)
        OVER () AS median,

    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY passengers)
        OVER () AS q3

FROM dbo.route_performance_analytics;

--Passenger Concentration--
WITH RankedPassengers AS
(
    SELECT
        passengers,
        ROW_NUMBER() OVER (ORDER BY passengers DESC) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM dbo.route_performance_analytics
)

SELECT

    SUM(CASE WHEN rn <= CEILING(total_rows * 0.01) THEN passengers ELSE 0 END) AS top_1pct_passengers,

    SUM(CASE WHEN rn <= CEILING(total_rows * 0.05) THEN passengers ELSE 0 END) AS top_5pct_passengers,

    SUM(CASE WHEN rn <= CEILING(total_rows * 0.10) THEN passengers ELSE 0 END) AS top_10pct_passengers,

    SUM(passengers) AS total_passengers

FROM RankedPassengers;

--Revenue vs Passenger Volume--
SELECT TOP (1000)
    passengers,
    estimated_revenue
FROM dbo.route_performance_analytics
ORDER BY NEWID();

--Demand Leaders--
SELECT TOP (20)

    YEAR,
    QUARTER,

    ORIGIN,
    DEST,

    passengers,

    estimated_revenue,

    weighted_avg_fare,

    load_factor,

    passenger_rank

FROM dbo.route_performance_analytics

ORDER BY
    passengers DESC;

--Fare vs Passenger Volume--
SELECT TOP (1000)
    passengers,
    weighted_avg_fare
FROM dbo.route_performance_analytics
ORDER BY NEWID();

/*=======================================================================
SECTION 4
Capacity & Utilization
Supports: AE-07, AE-08
=======================================================================*/
--Network Efficiency Summary--
SELECT
    COUNT(*) AS route_quarters,

    AVG(load_factor) AS avg_load_factor,

    MIN(load_factor) AS min_load_factor,

    MAX(load_factor) AS max_load_factor,

    STDEV(load_factor) AS stddev_load_factor

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL;

--Load Factor Quartiles--
SELECT DISTINCT

    PERCENTILE_CONT(0.25)
        WITHIN GROUP (ORDER BY load_factor)
        OVER() AS q1,

    PERCENTILE_CONT(0.50)
        WITHIN GROUP (ORDER BY load_factor)
        OVER() AS median,

    PERCENTILE_CONT(0.75)
        WITHIN GROUP (ORDER BY load_factor)
        OVER() AS q3

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL;

--Highest Operational Efficiency--
SELECT TOP (20)

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    passengers,
    seats,

    load_factor,

    estimated_revenue

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL

ORDER BY
    load_factor DESC,
    estimated_revenue DESC;

--Lowest Operational Efficiency--
SELECT TOP (20)

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    passengers,
    seats,

    load_factor,

    estimated_revenue

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL

ORDER BY
    load_factor ASC,
    estimated_revenue DESC;

--Operational Efficiency Bands--
SELECT

    CASE

        WHEN load_factor < 0.50 THEN '<50%'

        WHEN load_factor < 0.70 THEN '50–70%'

        WHEN load_factor < 0.80 THEN '70–80%'

        WHEN load_factor < 0.90 THEN '80–90%'

        ELSE '>90%'

    END AS load_factor_band,

    COUNT(*) AS route_quarters,

    SUM(passengers) AS passengers,

    SUM(estimated_revenue) AS estimated_revenue

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL

GROUP BY

    CASE

        WHEN load_factor < 0.50 THEN '<50%'

        WHEN load_factor < 0.70 THEN '50–70%'

        WHEN load_factor < 0.80 THEN '70–80%'

        WHEN load_factor < 0.90 THEN '80–90%'

        ELSE '>90%'

    END

ORDER BY
    MIN(load_factor);

/*=======================================================================
SECTION 5
Route Performance
Supports: AE-09, AE-010
=======================================================================*/
--Revenue vs Fare--
SELECT TOP (1000)
    weighted_avg_fare,
    estimated_revenue
FROM dbo.route_performance_analytics
ORDER BY NEWID();

--Yield Leaders--
SELECT TOP (20)

    YEAR,
    QUARTER,

    ORIGIN,
    DEST,

    weighted_avg_fare,

    passengers_db1b,

    passengers,

    estimated_revenue

FROM dbo.route_performance_analytics

WHERE
    passengers_db1b >= 100
    AND passengers > 0

ORDER BY
    weighted_avg_fare DESC;

--Underperforming Markets--
SELECT TOP (20)

    YEAR,
    QUARTER,

    ORIGIN,
    DEST,

    estimated_revenue,

    passengers,

    load_factor,

    weighted_avg_fare

FROM dbo.route_performance_analytics

WHERE
    passengers > 0
    AND weighted_avg_fare > 0
    AND estimated_revenue > 0
    AND load_factor < 0.50

ORDER BY
    estimated_revenue ASC,
    passengers ASC;

--Load Factor vs Revenue--
SELECT TOP (1000)
    load_factor,
    estimated_revenue
FROM dbo.route_performance_analytics
WHERE load_factor IS NOT NULL
ORDER BY NEWID();

/*=======================================================================
SECTION 6
Anomaly Detection
Supports: AE-04, AE-05
=======================================================================*/

--Revenue Outliers--
SELECT TOP (20)

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    estimated_revenue,

    passengers,

    weighted_avg_fare,

    load_factor

FROM dbo.route_performance_analytics

ORDER BY
    estimated_revenue DESC;

--Passenger Outliers--
SELECT TOP (20)

    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    passengers,

    seats,

    load_factor,

    estimated_revenue

FROM dbo.route_performance_analytics

ORDER BY
    passengers DESC;
   
--Statistical Outlier Thresholds (IQR Method)--
WITH RevenueQuartiles AS
(
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY estimated_revenue)
            OVER () AS q1,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY estimated_revenue)
            OVER () AS q3

    FROM dbo.route_performance_analytics
)

SELECT

    q1,

    q3,

    (q3 - q1) AS iqr,

    q3 + (1.5 * (q3 - q1)) AS upper_outlier_threshold

FROM RevenueQuartiles;

--Count Statistical Revenue Outliers--
WITH RevenueLimits AS
(
    SELECT DISTINCT

        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY estimated_revenue)
            OVER() AS q1,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY estimated_revenue)
            OVER() AS q3

    FROM dbo.route_performance_analytics
)

SELECT

    COUNT(*) AS revenue_outliers

FROM dbo.route_performance_analytics

CROSS JOIN RevenueLimits

WHERE estimated_revenue >
(
    q3 + (1.5 * (q3 - q1))
);


/*=======================================================================

EXECUTIVE SUMMARY

Primary Analytical Evidence Supported

✓ AE-02 Revenue Concentration
✓ AE-03 Revenue Distribution
✓ AE-04 Passenger Demand
✓ AE-05 Demand vs Revenue
✓ AE-06 Quarterly Trends
✓ AE-07 Capacity Utilization
✓ AE-08 Operational Anomalies
✓ AE-09 Commercial Performance
✓ AE-10 Pricing & Utilization

Primary Consumer
----------------
Power BI Dashboard

=======================================================================*/
