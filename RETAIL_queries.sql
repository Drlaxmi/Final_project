
-- 1. Total Sales
SELECT 
    ROUND(SUM(i.QUANTITY * m."SELLING PRICE"), 2) AS Total_Sales
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID";

-- 2. Total Profit
SELECT 
    ROUND(SUM(i.QUANTITY * (m."SELLING PRICE" - m."BUYING PRIZE")), 2) AS Total_Profit
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID";

-- 3. Profit Percentage
SELECT 
    ROUND(100.0 * SUM(i.QUANTITY * (m."SELLING PRICE" - m."BUYING PRIZE")) 
    / SUM(i.QUANTITY * m."SELLING PRICE"), 2) AS Profit_Percentage
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID";

-- 4. Monthly Sales, Profit, and Profit Percentage
SELECT 
    DATE_TRUNC('month', i.DATE) AS Month,
    ROUND(SUM(i.QUANTITY * m."SELLING PRICE"), 2) AS Sales,
    ROUND(SUM(i.QUANTITY * (m."SELLING PRICE" - m."BUYING PRIZE")), 2) AS Profit,
    ROUND(100.0 * SUM(i.QUANTITY * (m."SELLING PRICE" - m."BUYING PRIZE")) 
        / SUM(i.QUANTITY * m."SELLING PRICE"), 2) AS Profit_Percent
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID"
GROUP BY 1
ORDER BY 1;

-- 5. Top Product by Revenue
SELECT 
    m.PRODUCT,
    SUM(i.QUANTITY * m."SELLING PRICE") AS Revenue
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID"
GROUP BY m.PRODUCT
ORDER BY Revenue DESC
LIMIT 1;

-- 6. Top Category by Revenue
SELECT 
    m.CATEGORY,
    SUM(i.QUANTITY * m."SELLING PRICE") AS Revenue
FROM "Input Data" i
JOIN "Master Data" m ON i."PRODUCT ID" = m."PRODUCT ID"
GROUP BY m.CATEGORY
ORDER BY Revenue DESC
LIMIT 1;

-- 7. Sales Type Distribution
SELECT 
    "SALE TYPE",
    COUNT(*) AS Transactions,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM "Input Data"), 2) AS Percentage
FROM "Input Data"
GROUP BY "SALE TYPE";

-- 8. Payment Mode Distribution
SELECT 
    "PAYMENT MODE",
    COUNT(*) AS Transactions,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM "Input Data"), 2) AS Percentage
FROM "Input Data"
GROUP BY "PAYMENT MODE";
