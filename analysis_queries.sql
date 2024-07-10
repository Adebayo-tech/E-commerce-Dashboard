-- Total Sales By Category
SELECT price, quantity, (price * quantity) AS sale
FROM ecommerce;

ALTER TABLE ecommerce
ADD sales;

UPDATE ecommerce
SET sales = (price * quantity);

SELECT category, SUM(sales) AS Total_Sales
FROM ecommerce
GROUP BY category;

-- Monthly Sales Trend
WITH Months AS (
    SELECT sales, SUM(sales) AS total_sales, order_date, strftime('%m', order_date) AS Month
    FROM ecommerce
    GROUP BY Month
)
SELECT 
    strftime('%m', order_date) AS Month, 
    SUM(sales) AS Total_Sales,
    (CASE
         WHEN Month='01' THEN 'Jan'
         WHEN Month='02' THEN 'Feb'
         WHEN Month='03' THEN 'Mar'
         WHEN Month='04' THEN 'Apr'
         WHEN Month='05' THEN 'May'
         WHEN Month='06' THEN 'Jun'
         WHEN Month='07' THEN 'Jul'
         WHEN Month='08' THEN 'Aug'
         WHEN Month='09' THEN 'Sept'
         WHEN Month='10' THEN 'Oct'
         WHEN Month='11' THEN 'Nov'
         WHEN Month='12' THEN 'Dec'
         ELSE 'Unknown'
    END) AS MonthName 
FROM Months
GROUP BY Month;

-- Top 5 Customers By Lifetime Value
SELECT customer_id, customer_name,
(price * quantity) AS lifetime_Value 
FROM ecommerce
GROUP BY customer_id, customer_name
ORDER BY lifetime_Value DESC
LIMIT 5;

-- Customer Distribution By City
SELECT city, COUNT(DISTINCT customer_id) AS no_of_customers
FROM ecommerce
GROUP BY city 
ORDER BY no_of_customers;

-- Average Shipping Time
SELECT AVG(julianday(ship_date) - julianday(order_date)) AS avg_shipping_time
FROM ecommerce;

-- Orders By Shipping Mode
SELECT ship_mode, COUNT(order_id) AS total_orders
FROM ecommerce
GROUP BY ship_mode;

-- Product Profit
SELECT product_name, SUM(profit) AS total_profit
FROM ecommerce
GROUP BY product_name;
