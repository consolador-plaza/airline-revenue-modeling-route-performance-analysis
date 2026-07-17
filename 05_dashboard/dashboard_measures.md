Average Load Factor = 
AVERAGE(route_performance_analytics[load_factor])

Average Weighted Fare = 
DIVIDE(
    SUMX(
        route_performance_analytics,
        route_performance_analytics[weighted_avg_fare] *
        route_performance_analytics[passengers_db1b]
    ),
    SUM(route_performance_analytics[passengers_db1b])
)

Highest Airport Pair Passengers = 
MAXX(
    VALUES(route_performance_analytics[Airport Pair]),
    [Total Passengers]
)

Highest Airport Pair Revenue = 
MAXX(
    VALUES(route_performance_analytics[Airport Pair]),
    [Total Estimated Passenger Revenue]
)

Highest Load Factor = 
MAX(route_performance_analytics[load_factor])

Highest Passenger Airport Pair = 
VAR TopRoute =
    TOPN(
        1,
        SUMMARIZE(
            route_performance_analytics,
            route_performance_analytics[Airport Pair],
            "Passengers", [Total Passengers]
        ),
        [Passengers],
        DESC
    )

RETURN
MAXX(
    TopRoute,
    route_performance_analytics[Airport Pair]
)

Median Estimated Passenger Revenue = 
MEDIAN(route_performance_analytics[estimated_revenue])

Median Passengers = 
MEDIAN(route_performance_analytics[passengers])

Revenue per Passenger = 
DIVIDE(
    [Total Estimated Passenger Revenue],
    [Total Passengers]
)

Routes >100% Load Factor = 
CALCULATE(
    COUNTROWS(route_performance_analytics),
    FILTER(
        route_performance_analytics,
        route_performance_analytics[load_factor] > 1 &&
        route_performance_analytics[passengers] > 0
    )
)

Top 10% Revenue Contribution = 0.568

Total Estimated Passenger Revenue = 
SUM(route_performance_analytics[estimated_revenue])

Total Passengers = 
SUM(route_performance_analytics[passengers])

Weighted Load Factor = 
DIVIDE(
    SUM(route_performance_analytics[passengers]),
    SUM(route_performance_analytics[seats])
)