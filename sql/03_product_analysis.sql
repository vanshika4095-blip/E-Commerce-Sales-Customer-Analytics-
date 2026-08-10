--1. Revenue by category
SELECT
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

--2.Profit by category
SELECT
    p.category,
    ROUND(SUM(oi.profit), 2) AS profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY profit DESC;

--3.Revenue + profit + margin by category
SELECT
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    ROUND(SUM(oi.profit), 2) AS profit,
    ROUND(
        SUM(oi.profit) / SUM(oi.sales_amount) * 100,
        2
    ) AS profit_margin
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

--4.Top 10 products by revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY revenue DESC
LIMIT 10;

--5.Top 10 products by profit
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    ROUND(SUM(oi.profit), 2) AS profit,
    ROUND(
        SUM(oi.profit) / SUM(oi.sales_amount) * 100,
        2
    ) AS profit_margin
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
HAVING SUM(oi.sales_amount) > 100000
ORDER BY profit_margin ASC
LIMIT 10;

--6. Products with high sales but low margin
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    ROUND(SUM(oi.profit), 2) AS profit,
    ROUND(
        SUM(oi.profit) / SUM(oi.sales_amount) * 100,
        2
    ) AS profit_margin
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
HAVING SUM(oi.sales_amount) > 100000
ORDER BY profit_margin ASC;

--7. Category ranking using a window function
WITH category_sales AS (
    SELECT
        p.category,
        SUM(oi.sales_amount) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY p.category
)

SELECT
    category,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM category_sales;