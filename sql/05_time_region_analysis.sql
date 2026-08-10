--1.Monthly revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.sales_amount), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

--2.Monthly profit
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    ROUND(SUM(oi.profit), 2) AS profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month;

--3.Monthly orders
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

--4.Revenue by region
SELECT
    region,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY region
ORDER BY revenue DESC;

--5.Profit by region
SELECT
    o.region,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    ROUND(SUM(oi.profit), 2) AS profit,
    ROUND(
        SUM(oi.profit) / SUM(oi.sales_amount) * 100,
        2
    ) AS profit_margin
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.region
ORDER BY revenue DESC;

--6.Best-performing month
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.sales_amount) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)

SELECT
    month,
    ROUND(revenue, 2) AS revenue
FROM monthly_sales
ORDER BY revenue DESC
LIMIT 1;

--7.Best region
SELECT
    o.region,
    ROUND(SUM(oi.sales_amount), 2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.region
ORDER BY revenue DESC
LIMIT 1;