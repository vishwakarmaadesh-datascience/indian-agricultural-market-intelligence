CREATE DATABASE mandi_intelligence;
USE mandi_intelligence;
CREATE TABLE mandi_prices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    State VARCHAR(100),
    District VARCHAR(100),
    Market VARCHAR(150),
    Commodity VARCHAR(100),
    Variety VARCHAR(150),
    Grade VARCHAR(100),
    Arrival_Date DATE,
    Min_x0020_Price DECIMAL(12,2),
    Max_x0020_Price DECIMAL(12,2),
    Modal_x0020_Price DECIMAL(12,2)
);
USE mandi_intelligence;
-- 1.Summarise the overall coverage of the dataset
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT State) AS total_states,
    COUNT(DISTINCT District) AS total_districts,
    COUNT(DISTINCT Market) AS total_markets,
    COUNT(DISTINCT Commodity) AS total_commodities,
    MIN(Arrival_Date) AS first_date,
    MAX(Arrival_Date) AS last_date
FROM mandi_prices;

-- 2.Count records and distinct markets in each state
SELECT
    State,
    COUNT(*) AS total_records,
    COUNT(DISTINCT Market) AS total_markets,
    COUNT(DISTINCT Commodity) AS total_commodities
FROM mandi_prices
GROUP BY State
ORDER BY total_records DESC;

-- 3.Rank commodities by number of price records
SELECT
    Commodity,
    COUNT(*) AS total_records,
    COUNT(DISTINCT State) AS states_covered,
    COUNT(DISTINCT Market) AS markets_covered,
    ROUND(AVG(Modal_x0020_Price), 2) AS avg_modal_price
FROM mandi_prices
GROUP BY Commodity
ORDER BY total_records DESC
LIMIT 15;

-- 4.Calculate the average price range for each commodity
SELECT
    Commodity,
    COUNT(*) AS total_records,
    ROUND(AVG(Min_x0020_Price), 2) AS avg_min_price,
    ROUND(AVG(Modal_x0020_Price), 2) AS avg_modal_price,
    ROUND(AVG(Max_x0020_Price), 2) AS avg_max_price,

    -- Difference between average maximum and minimum prices
    ROUND(
        AVG(Max_x0020_Price) - AVG(Min_x0020_Price),
        2
    ) AS avg_price_range

FROM mandi_prices
WHERE Min_x0020_Price >= 0
  AND Max_x0020_Price >= Min_x0020_Price
GROUP BY Commodity
HAVING COUNT(*) >= 5
ORDER BY avg_price_range DESC;

-- 5.Calculate the average modal price for each state and commodity
SELECT
    State,
    Commodity,
    COUNT(*) AS records,
    ROUND(AVG(Modal_x0020_Price), 2) AS avg_modal_price
FROM mandi_prices
WHERE Modal_x0020_Price > 0
GROUP BY State, Commodity
HAVING COUNT(*) >= 3
ORDER BY State, avg_modal_price DESC;

-- 6.Aggregate price records by state and district
SELECT
    State,
    District,
    COUNT(*) AS total_records,
    COUNT(DISTINCT Market) AS markets_covered,
    COUNT(DISTINCT Commodity) AS commodities_covered,
    ROUND(AVG(Modal_x0020_Price), 2) AS avg_modal_price
FROM mandi_prices
WHERE Modal_x0020_Price > 0
GROUP BY State, District
HAVING COUNT(*) >= 5
ORDER BY State, avg_modal_price DESC;

-- 7.Count distinct commodities reported by each market
SELECT
    State,
    District,
    Market,
    COUNT(DISTINCT Commodity) AS commodity_count,
    COUNT(*) AS total_records
FROM mandi_prices
GROUP BY State, District, Market
ORDER BY commodity_count DESC, total_records DESC
LIMIT 20;

-- 8.Calculate the price spread for every observation
SELECT
    State,
    District,
    Market,
    Commodity,
    Variety,
    Arrival_Date,
    Min_x0020_Price,
    Modal_x0020_Price,
    Max_x0020_Price,

    -- Absolute price difference
    ROUND(
        Max_x0020_Price - Min_x0020_Price,
        2
    ) AS price_spread,

    -- Spread relative to the minimum price
    ROUND(
        100.0 * (Max_x0020_Price - Min_x0020_Price)
        / NULLIF(Min_x0020_Price, 0),
        2
    ) AS spread_percentage

FROM mandi_prices
WHERE Min_x0020_Price > 0
  AND Max_x0020_Price >= Min_x0020_Price
ORDER BY price_spread DESC
LIMIT 20;

-- 9.First calculate the average modal price for each commodity
WITH commodity_averages AS (
    SELECT
        Commodity,
        AVG(Modal_x0020_Price) AS avg_price
    FROM mandi_prices
    WHERE Modal_x0020_Price > 0
    GROUP BY Commodity
)

-- Compare each record with its commodity's average
SELECT
    m.Commodity,
    CASE
        WHEN m.Modal_x0020_Price < a.avg_price * 0.80
            THEN 'Below 80% of average'
        WHEN m.Modal_x0020_Price <= a.avg_price * 1.20
            THEN 'Within 80%-120% of average'
        ELSE 'Above 120% of average'
    END AS price_band,

    COUNT(*) AS record_count
FROM mandi_prices AS m
JOIN commodity_averages AS a
    ON m.Commodity = a.Commodity
WHERE m.Modal_x0020_Price > 0
GROUP BY
    m.Commodity,
    price_band

ORDER BY m.Commodity, record_count DESC;

-- 10.Summarise modal prices by commodity and date
SELECT
    Commodity,
    Arrival_Date,
    COUNT(*) AS observations,
    ROUND(AVG(Modal_x0020_Price), 2) AS daily_avg_modal_price
FROM mandi_prices
WHERE Modal_x0020_Price > 0
GROUP BY Commodity, Arrival_Date
ORDER BY Commodity, Arrival_Date;

-- 11:-Step 1: Calculate the average price by commodity and market

WITH market_prices AS (
    SELECT
        Commodity,
        State,
        Market,
        COUNT(*) AS records,
        AVG(Modal_x0020_Price) AS avg_modal_price
    FROM mandi_prices
    WHERE Modal_x0020_Price > 0
    GROUP BY Commodity, State, Market
    HAVING COUNT(*) >= 2
),

-- Step 2: Rank markets separately within each commodity

ranked_markets AS (
    SELECT
        Commodity,
        State,
        Market,
        records,
        avg_modal_price,
        ROW_NUMBER() OVER (
            PARTITION BY Commodity
            ORDER BY avg_modal_price DESC
        ) AS market_rank
    FROM market_prices
)

-- Step 3: Return the top 3 markets for each commodity

SELECT
    Commodity,
    State,
    Market,
    records,
    ROUND(avg_modal_price, 2) AS avg_modal_price,
    market_rank
FROM ranked_markets
WHERE market_rank <= 3
ORDER BY Commodity, market_rank;

USE mandi_intelligence;

SELECT
    State,
    District,
    Market,
    Commodity,
    Variety,
    Grade,
    Arrival_Date,
    Min_x0020_Price,
    Max_x0020_Price,
    Modal_x0020_Price
FROM mandi_prices;