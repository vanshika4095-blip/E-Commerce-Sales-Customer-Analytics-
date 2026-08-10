--1.Customer segmentation
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

customer_segments AS (
    SELECT
        customer_id,
        customer_name,
        total_spent,
        CASE
            WHEN total_spent >= 100000 THEN 'High Value'
            WHEN total_spent >= 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_sales
)

SELECT
    customer_segment,
    COUNT(*) AS customers,
    ROUND(SUM(total_spent), 2) AS revenue,
    ROUND(AVG(total_spent), 2) AS average_customer_value
FROM customer_segments
GROUP BY customer_segment
ORDER BY revenue DESC;

--2.Revenue contribution by customer segment
WITH customer_sales AS (
    SELECT
        c.customer_id,
        SUM(oi.sales_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id
),

customer_segments AS (
    SELECT
        customer_id,
        total_spent,
        CASE
            WHEN total_spent >= 100000 THEN 'High Value'
            WHEN total_spent >= 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_sales
),

segment_summary AS (
    SELECT
        customer_segment,
        COUNT(*) AS customers,
        SUM(total_spent) AS revenue
    FROM customer_segments
    GROUP BY customer_segment
)

SELECT
    customer_segment,
    customers,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS revenue_contribution
FROM segment_summary
ORDER BY revenue DESC;

--3.Category × Region analysis
SELECT
    o.region,
    p.category,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    ROUND(SUM(oi.profit), 2) AS profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    o.region,
    p.category
ORDER BY
    o.region,
    revenue DESC;

--4.Monthly growth    
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.sales_amount) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),

monthly_growth AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)

SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue)
        / previous_month_revenue * 100,
        2
    ) AS mom_growth_percentage
FROM monthly_growth
ORDER BY month;