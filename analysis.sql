-- RETAIL SALES ANALYSIS (SQL PROJECT)
-- Dataset: retail_db.retail_small


-- 1. Data Preview
-- Dataset structure
SELECT *
FROM retail_db.retail_small
LIMIT 10;



-- 2. Total Revenue
-- Calculates overall revenue from all transactions
SELECT 
    SUM(Quantity * UnitPrice) AS Total_Revenue
FROM retail_db.retail_small;



-- 3. Revenue by Country
-- Identifies top-performing markets
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM retail_db.retail_small
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 5;



-- 4. Top Customers
-- Finds highest revenue-generating customers
SELECT 
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM retail_db.retail_small
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 5;



-- 5. Most Sold Products
-- Identifies best-selling products by quantity
SELECT 
    Description,
    SUM(Quantity) AS Total_Sold
FROM retail_db.retail_small
GROUP BY Description
ORDER BY Total_Sold DESC
LIMIT 5;



-- 6. Monthly Revenue Trend
-- Shows revenue growth over time
SELECT 
    DATE_FORMAT(
        STR_TO_DATE(TRIM(InvoiceDate), '%d-%m-%Y %H:%i'),
        '%Y-%m'
    ) AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM retail_db.retail_small
WHERE STR_TO_DATE(TRIM(InvoiceDate), '%d-%m-%Y %H:%i') IS NOT NULL
GROUP BY Month
ORDER BY Month;



-- 7. Average Order Value (AOV)
-- Measures average revenue per transaction
SELECT 
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS Avg_Order_Value
FROM retail_db.retail_small;



-- 8. Top Products by Revenue
-- Identifies most profitable products
SELECT 
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM retail_db.retail_small
GROUP BY Description
ORDER BY Revenue DESC
LIMIT 5;



-- 9. Sales by Hour (Customer Behavior Insight)
-- Helps identify peak shopping times
SELECT 
    HOUR(STR_TO_DATE(TRIM(InvoiceDate), '%d-%m-%Y %H:%i')) AS Hour,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Revenue
FROM retail_db.retail_small
WHERE STR_TO_DATE(TRIM(InvoiceDate), '%d-%m-%Y %H:%i') IS NOT NULL
GROUP BY Hour
ORDER BY Hour;



-- 10. Negative Quantity (Returns Analysis)
-- Identifies potential product returns
SELECT *
FROM retail_db.retail_small
WHERE Quantity < 0;