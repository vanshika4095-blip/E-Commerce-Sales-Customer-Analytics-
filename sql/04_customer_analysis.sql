--1.Revenue by customer
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.sales_amount), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

--2.Top 10 customers
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.sales_amount), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC
LIMIT 10;

--3.Number of orders per customer
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC;

--4.Repeat customers
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) >= 2
) AS repeat_customer_list;

SELECT
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customers),
        2
    ) AS repeat_customer_percentage
FROM (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) >= 2
) AS repeat_customer_list;

--5.Customer ranking using a window function
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.sales_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name
)

SELECT
    customer_id,
    customer_name,
    ROUND(total_spent, 2) AS total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_sales
ORDER BY customer_rank;

--6.Revenue contribution of top 10 customers
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.sales_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_id,
        c.customer_name
),

top_customers AS (
    SELECT
        total_spent
    FROM customer_sales
    ORDER BY total_spent DESC
    LIMIT 10
)

SELECT
    ROUND(SUM(total_spent), 2) AS top_10_revenue,
    ROUND(
        SUM(total_spent) /
        (SELECT SUM(total_spent) FROM customer_sales) * 100,
        2
    ) AS revenue_contribution_percentage
FROM top_customers;

--7.Customer analysis by city
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS customers,
    ROUND(SUM(oi.sales_amount), 2) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY revenue DESC
LIMIT 10;