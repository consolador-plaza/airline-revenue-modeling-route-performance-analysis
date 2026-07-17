SELECT TOP 20
    YEAR,
    MONTH,
    UNIQUE_CARRIER,
    ORIGIN,
    DEST,
    COUNT(*) AS row_count
FROM t100
GROUP BY
    YEAR,
    MONTH,
    UNIQUE_CARRIER,
    ORIGIN,
    DEST
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

SELECT *
FROM t100
WHERE YEAR = 2024
  AND MONTH = 6
  AND UNIQUE_CARRIER = 'UA'
  AND ORIGIN = 'IAD'
  AND DEST = 'EWR';

SELECT
    YEAR,
    QUARTER,
    UNIQUE_CARRIER,
    ORIGIN,
    DEST,
    SUM(PASSENGERS)            AS passengers,
    SUM(SEATS)                 AS seats,
    SUM(DEPARTURES_PERFORMED)  AS departures_performed,
    SUM(AIR_TIME)              AS air_time,
    SUM(FREIGHT)               AS freight
INTO dbo.t100_quarterly
FROM t100
GROUP BY
    YEAR,
    QUARTER,
    UNIQUE_CARRIER,
    ORIGIN,
    DEST

SELECT COUNT(*) AS rows
FROM t100_quarterly;

SELECT TOP 10 *
FROM t100_quarterly;

--Creating db1b quarterly--
-- DB1B Schema--
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DB1B_MARKET'
AND COLUMN_NAME IN ('PASSENGERS','MARKET_FARE');

SELECT TOP 20 PASSENGERS
FROM dbo.DB1B_MARKET;

SELECT COUNT(*) AS non_numeric_rows
FROM dbo.DB1B_MARKET
WHERE TRY_CAST(PASSENGERS AS BIGINT) IS NULL
      AND PASSENGERS IS NOT NULL;

SELECT COUNT(*) AS convertible_rows
FROM dbo.DB1B_MARKET
WHERE TRY_CAST(PASSENGERS AS DECIMAL(18,2)) IS NOT NULL;

ALTER TABLE dbo.DB1B_MARKET
ALTER COLUMN PASSENGERS DECIMAL(18,2);

SELECT
    YEAR,
    QUARTER,
    OPERATING_CARRIER,
    ORIGIN,
    DEST,

    SUM(PASSENGERS) AS passengers_db1b,

    SUM(MARKET_FARE * PASSENGERS)
        / NULLIF(SUM(PASSENGERS),0) AS weighted_avg_fare

INTO dbo.db1b_market_quarterly

FROM dbo.DB1B_MARKET

GROUP BY
    YEAR,
    QUARTER,
    OPERATING_CARRIER,
    ORIGIN,
    DEST;

SELECT COUNT(*) AS rows
FROM dbo.db1b_market_quarterly;

SELECT TOP 10 *
FROM dbo.db1b_market_quarterly;

SELECT DISTINCT UNIQUE_CARRIER
FROM dbo.t100_quarterly

EXCEPT

SELECT DISTINCT OPERATING_CARRIER
FROM dbo.db1b_market_quarterly;

SELECT DISTINCT OPERATING_CARRIER
FROM dbo.db1b_market_quarterly

EXCEPT

SELECT DISTINCT UNIQUE_CARRIER
FROM dbo.t100_quarterly;

SELECT COUNT(*) AS joined_rows
FROM dbo.t100_quarterly t
INNER JOIN dbo.db1b_market_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.UNIQUE_CARRIER = d.OPERATING_CARRIER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

SELECT COUNT(*) AS t100_rows
FROM dbo.t100_quarterly;

SELECT COUNT(*) AS joined_rows_no_carrier
FROM dbo.t100_quarterly t
INNER JOIN dbo.db1b_market_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

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
FROM dbo.db1b_market_quarterly;

--t100 route quaterly table creation--
SELECT
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    SUM(passengers) AS passengers,
    SUM(seats) AS seats,
    SUM(departures_performed) AS departures_performed,
    SUM(air_time) AS air_time,
    SUM(freight) AS freight

INTO dbo.t100_route_quarterly

FROM dbo.t100_quarterly

GROUP BY
    YEAR,
    QUARTER,
    ORIGIN,
    DEST;

SELECT COUNT(*) AS rows
FROM dbo.t100_route_quarterly;

SELECT TOP 10 *
FROM dbo.t100_route_quarterly;

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

SELECT COUNT(*) AS rows
FROM dbo.db1b_market_route_quarterly;

SELECT TOP 10 *
FROM dbo.db1b_market_route_quarterly;

SELECT COUNT(*) AS joined_routes
FROM dbo.t100_route_quarterly t
INNER JOIN dbo.db1b_market_route_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

SELECT
    t.YEAR,
    t.QUARTER,
    t.ORIGIN,
    t.DEST,

    t.passengers,
    t.seats,
    t.departures_performed,
    t.air_time,
    t.freight,

    d.passengers_db1b,
    d.weighted_avg_fare

INTO dbo.route_performance_fact

FROM dbo.t100_route_quarterly t
INNER JOIN dbo.db1b_market_route_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

SELECT TOP 10 *
FROM dbo.route_performance_fact;

SELECT
    SUM(passengers) AS total_passengers
FROM dbo.t100_route_quarterly;

2448591489.0000000000
2437950608.0000000000

SELECT
    SUM(t.passengers) AS matched_passengers
FROM dbo.t100_route_quarterly t
INNER JOIN dbo.db1b_market_route_quarterly d
    ON t.YEAR = d.YEAR
   AND t.QUARTER = d.QUARTER
   AND t.ORIGIN = d.ORIGIN
   AND t.DEST = d.DEST;

SELECT
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,

    passengers,
    seats,
    departures_performed,
    air_time,
    freight,

    passengers_db1b,
    weighted_avg_fare,

    CAST(
        passengers * weighted_avg_fare
        AS DECIMAL(18,2)
    ) AS estimated_revenue,

    CAST(
        passengers * 1.0
        / NULLIF(seats,0)
        AS DECIMAL(10,4)
    ) AS load_factor,

    CAST(
        (passengers * weighted_avg_fare)
        / NULLIF(passengers,0)
        AS DECIMAL(18,2)
    ) AS revenue_per_passenger

INTO dbo.route_performance_kpi

FROM dbo.route_performance_fact;

SELECT TOP 10 *
FROM dbo.route_performance_kpi;

SELECT
    MIN(load_factor) AS min_load_factor,
    MAX(load_factor) AS max_load_factor,
    AVG(load_factor) AS avg_load_factor
FROM dbo.route_performance_kpi;

SELECT TOP 20
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    passengers,
    seats,
    load_factor
FROM dbo.route_performance_kpi
ORDER BY load_factor DESC;

SELECT TOP 20
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    passengers,
    seats,
    load_factor
FROM dbo.route_performance_kpi
WHERE load_factor = 0
ORDER BY passengers DESC;

SELECT
    COUNT(*) AS routes_over_100,
    AVG(load_factor) AS avg_load_factor_over_100
FROM dbo.route_performance_kpi
WHERE load_factor > 1;

SELECT
    COUNT(*) AS zero_passenger_routes
FROM dbo.route_performance_kpi
WHERE passengers = 0;


ALTER TABLE dbo.route_performance_kpi
ADD
    is_zero_passenger BIT,
    is_load_factor_anomaly BIT;

UPDATE dbo.route_performance_kpi
SET
    is_zero_passenger =
        CASE
            WHEN passengers = 0 THEN 1
            ELSE 0
        END,

    is_load_factor_anomaly =
        CASE
            WHEN load_factor > 1 THEN 1
            ELSE 0
        END;

SELECT
    SUM(CASE WHEN is_zero_passenger = 1 THEN 1 ELSE 0 END) AS zero_passenger_routes,
    SUM(CASE WHEN is_load_factor_anomaly = 1 THEN 1 ELSE 0 END) AS load_factor_anomalies
FROM dbo.route_performance_kpi;

EXEC sp_rename 'route_performance_kpi.revenue_per_passenger', 'average_revenue_per_passenger', 'COLUMN';

SELECT
    *,

    DENSE_RANK() OVER (
        PARTITION BY YEAR, QUARTER
        ORDER BY estimated_revenue DESC
    ) AS revenue_rank,

    DENSE_RANK() OVER (
        PARTITION BY YEAR, QUARTER
        ORDER BY passengers DESC
    ) AS passenger_rank

INTO dbo.route_performance_analytics

FROM dbo.route_performance_kpi;

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

ALTER TABLE dbo.route_performance_analytics
ADD revenue_contribution_pct DECIMAL(9,6);

UPDATE r
SET revenue_contribution_pct =
    estimated_revenue /
    NULLIF(total_revenue, 0)
FROM dbo.route_performance_analytics r
INNER JOIN (
    SELECT
        YEAR,
        QUARTER,
        SUM(estimated_revenue) AS total_revenue
    FROM dbo.route_performance_analytics
    GROUP BY
        YEAR,
        QUARTER
) t
    ON r.YEAR = t.YEAR
   AND r.QUARTER = t.QUARTER;

SELECT
    YEAR,
    QUARTER,
    SUM(revenue_contribution_pct) AS total_pct
FROM dbo.route_performance_analytics
GROUP BY
    YEAR,
    QUARTER
ORDER BY
    YEAR,
    QUARTER;

--Execution Stage 4 – Exploratory Data Analysis (EDA)--
--Stage 4.1--
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
-- Step 4.2.1 — Top Revenue Routes --
SELECT TOP 20
    YEAR,
    QUARTER,
    ORIGIN,
    DEST,
    estimated_revenue,
    revenue_contribution_pct,
    revenue_rank,
    passengers,
    load_factor
FROM dbo.route_performance_analytics
ORDER BY estimated_revenue DESC;
--Step 4.2.2 — Revenue Concentration by Top N Routes--
WITH RankedRevenue AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            ORDER BY estimated_revenue DESC
        ) AS overall_rank
    FROM dbo.route_performance_analytics
)

SELECT
    SUM(CASE WHEN overall_rank <= 10 THEN estimated_revenue ELSE 0 END)
        AS top10_revenue,

    SUM(CASE WHEN overall_rank <= 50 THEN estimated_revenue ELSE 0 END)
        AS top50_revenue,

    SUM(CASE WHEN overall_rank <= 100 THEN estimated_revenue ELSE 0 END)
        AS top100_revenue,

    SUM(estimated_revenue) AS total_revenue
FROM RankedRevenue;
--Step 4.2.3 — Revenue Deciles--
WITH RevenueDeciles AS
(
    SELECT
        estimated_revenue,
        NTILE(10) OVER (
            ORDER BY estimated_revenue DESC
        ) AS revenue_decile
    FROM dbo.route_performance_analytics
)

SELECT
    revenue_decile,
    COUNT(*) AS routes,
    SUM(estimated_revenue) AS revenue
FROM RevenueDeciles
GROUP BY revenue_decile
ORDER BY revenue_decile;
-- Revised Step 4..2 --
--Step 4.2.1 — Revenue Concentration by Percentile--
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
-- Step 4.2.2 — Revenue Deciles -- 
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
--Step 4.2.3 — Cumulative Revenue (New)--
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

--Step 4.3.1 – Revenue Distribution Summary--
SELECT
    COUNT(*) AS route_quarters,

    MIN(estimated_revenue) AS min_revenue,

    AVG(estimated_revenue) AS mean_revenue,

    MAX(estimated_revenue) AS max_revenue,

    STDEV(estimated_revenue) AS stddev_revenue
FROM dbo.route_performance_analytics;
--Step 4.3.2 – Revenue Quartiles--
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
--Step 4.3.3 – Revenue Buckets--
SELECT
    CASE
        WHEN estimated_revenue = 0 THEN 'Zero'
        WHEN estimated_revenue < 100000 THEN '<100K'
        WHEN estimated_revenue < 500000 THEN '100K–500K'
        WHEN estimated_revenue < 1000000 THEN '500K–1M'
        WHEN estimated_revenue < 5000000 THEN '1M–5M'
        WHEN estimated_revenue < 10000000 THEN '5M–10M'
        ELSE '>10M'
    END AS revenue_band,

    COUNT(*) AS route_quarters,

    SUM(estimated_revenue) AS revenue

FROM dbo.route_performance_analytics

GROUP BY
    CASE
        WHEN estimated_revenue = 0 THEN 'Zero'
        WHEN estimated_revenue < 100000 THEN '<100K'
        WHEN estimated_revenue < 500000 THEN '100K–500K'
        WHEN estimated_revenue < 1000000 THEN '500K–1M'
        WHEN estimated_revenue < 5000000 THEN '1M–5M'
        WHEN estimated_revenue < 10000000 THEN '5M–10M'
        ELSE '>10M'
    END

ORDER BY
    MIN(estimated_revenue);

--Step 4.4.1 – Passenger Distribution Summary--
SELECT
    COUNT(*) AS route_quarters,

    MIN(passengers) AS min_passengers,

    AVG(passengers) AS mean_passengers,

    MAX(passengers) AS max_passengers,

    STDEV(passengers) AS stddev_passengers
FROM dbo.route_performance_analytics;

--Step 4.4.2 – Passenger Quartiles--
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
--Step 4.4.3 – Passenger Demand Bands--
SELECT

    CASE

        WHEN passengers = 0 THEN 'Zero'

        WHEN passengers < 1000 THEN '<1K'

        WHEN passengers < 10000 THEN '1K–10K'

        WHEN passengers < 50000 THEN '10K–50K'

        WHEN passengers < 100000 THEN '50K–100K'

        ELSE '>100K'

    END AS passenger_band,

    COUNT(*) AS route_quarters,

    SUM(passengers) AS total_passengers,

    SUM(estimated_revenue) AS estimated_revenue

FROM dbo.route_performance_analytics

GROUP BY

    CASE

        WHEN passengers = 0 THEN 'Zero'

        WHEN passengers < 1000 THEN '<1K'

        WHEN passengers < 10000 THEN '1K–10K'

        WHEN passengers < 50000 THEN '10K–50K'

        WHEN passengers < 100000 THEN '50K–100K'

        ELSE '>100K'

    END

ORDER BY
    MIN(passengers);

--Step 4.4.4 – Passenger Concentration--
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
--Step 4.5.1 – Correlation Matrix--
SELECT
    passengers,
    weighted_avg_fare,
    estimated_revenue,
    load_factor
FROM dbo.route_performance_analytics
WHERE load_factor IS NOT NULL;
--Step 4.5.2 – Revenue vs Passenger Volume--
SELECT TOP (1000)
    passengers,
    estimated_revenue
FROM dbo.route_performance_analytics
ORDER BY NEWID();
--Step 4.5.3 – Revenue vs Fare--
SELECT TOP (1000)
    weighted_avg_fare,
    estimated_revenue
FROM dbo.route_performance_analytics
ORDER BY NEWID();
--Step 4.5.4 – Fare vs Passenger Volume--
SELECT TOP (1000)
    passengers,
    weighted_avg_fare
FROM dbo.route_performance_analytics
ORDER BY NEWID();
--Step 4.5.5 – Load Factor vs Revenue--
SELECT TOP (1000)
    load_factor,
    estimated_revenue
FROM dbo.route_performance_analytics
WHERE load_factor IS NOT NULL
ORDER BY NEWID();
--Step 4.6.1 – Quarterly Business Summary--
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

--Step 4.6.2 – Quarter-over-Quarter Growth--
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

--Step 4.6.3 – Revenue Driver Decomposition--
SELECT
    YEAR,
    QUARTER,

    SUM(passengers) AS passengers,

    SUM(weighted_avg_fare * passengers_db1b)
        /
        NULLIF(SUM(passengers_db1b),0)
        AS weighted_avg_fare,

    SUM(estimated_revenue) AS estimated_revenue

FROM dbo.route_performance_analytics

GROUP BY
    YEAR,
    QUARTER

ORDER BY
    YEAR,
    QUARTER;

-- EDA 4.6A – Year-over-Year Business Validation--
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

--Step 4.7.1 – Network Efficiency Summary--
SELECT
    COUNT(*) AS route_quarters,

    AVG(load_factor) AS avg_load_factor,

    MIN(load_factor) AS min_load_factor,

    MAX(load_factor) AS max_load_factor,

    STDEV(load_factor) AS stddev_load_factor

FROM dbo.route_performance_analytics

WHERE load_factor IS NOT NULL;

--Step 4.7.2 – Load Factor Quartiles--
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

--Step 4.7.3 – Operational Efficiency Bands--
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

--Step 4.7.4 – Highest Operational Efficiency--
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

--Step 4.7.5 – Lowest Operational Efficiency--
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

--Step 4.8.1 – Fare Distribution (Upper Tail)--
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

ORDER BY
    weighted_avg_fare DESC;

--Step 4.8.2 – Revenue Outliers--
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

--Step 4.8.3 – Passenger Outliers--
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
   
--Step 4.8.4 – Statistical Outlier Thresholds (IQR Method)--
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

--Step 4.8.5 – Count Statistical Revenue Outliers--
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

--Step 4.9.1 – Revenue Leaders--
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

--Step 4.9.2 – Demand Leaders--
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

--Step 4.9.3 – Yield Leaders--
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

--Step 4.9.4 – Underperforming Markets--
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