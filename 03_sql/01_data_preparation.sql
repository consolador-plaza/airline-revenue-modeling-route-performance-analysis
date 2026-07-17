/*======================================================================

Project:
Airline Route Performance & Estimated Passenger Revenue Analysis

File:
01_data_preparation.sql

Purpose:
Prepare and validate the BTS T100 Segment and DB1B Market datasets for
analytical transformation.

Inputs:
- dbo.t100
- dbo.db1b

Outputs:
- dbo.t100_quarterly
- dbo.db1b_quarterly

Version:
2.0

======================================================================*/

/*======================================================================

SECTION 1
Duplicate Detection

Purpose
-------
Identify duplicate operational records in the raw T100 dataset before
aggregation.

Expected Result
---------------
Very few or no duplicate records requiring investigation.

======================================================================*/

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

/*======================================================================

SECTION 2
Duplicate Record Inspection

Purpose
-------
Inspect sample duplicate records identified during validation to confirm
whether aggregation is appropriate.

======================================================================*/
SELECT *
FROM t100
WHERE YEAR = 2024
  AND MONTH = 6
  AND UNIQUE_CARRIER = 'UA'
  AND ORIGIN = 'IAD'
  AND DEST = 'EWR';

/*======================================================================

SECTION 3
Create Quarterly T100 Dataset

Purpose
-------
Aggregate monthly operational activity into quarterly airport-route
records.

Output
------
dbo.t100_quarterly

======================================================================*/
DROP TABLE IF EXISTS dbo.t100_quarterly;

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
    DEST;

/*======================================================================

SECTION 4
Validate Quarterly T100 Dataset

Purpose
-------
Verify successful creation of the quarterly operational dataset.

Checks
------
• Row count
• Sample records

======================================================================*/

SELECT COUNT(*) AS rows
FROM t100_quarterly;

SELECT TOP 10 *
FROM t100_quarterly;

/*======================================================================

SECTION 5
Create Quarterly DB1B Dataset

Purpose
-------
Aggregate quarterly passenger fare information for later integration
with operational data.

Output
------
dbo.db1b_quarterly

======================================================================*/
DROP TABLE IF EXISTS dbo.db1b_market_quarterly;

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

/*======================================================================

SECTION 6
Schema Verification

Purpose
-------
Verify that the quarterly DB1B table contains the expected analytical
fields before transformation.

======================================================================*/

SELECT *
FROM db1b_market_quarterly

SELECT COUNT(*) AS rows
FROM dbo.db1b_market_quarterly;

SELECT TOP 10 *
FROM dbo.db1b_market_quarterly;

/*======================================================================

END OF FILE

Outputs Produced

✓ dbo.t100_quarterly

✓ dbo.db1b_quarterly

Next Script

02_transformation.sql

======================================================================*/