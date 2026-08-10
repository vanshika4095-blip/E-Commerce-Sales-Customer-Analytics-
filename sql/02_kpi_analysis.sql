-- ==========================================
-- E-COMMERCE SALES & CUSTOMER ANALYTICS
-- CORE BUSINESS KPIs
-- ==========================================

USE ecommerce_analytics;


-- 1. Total Revenue
SELECT
    ROUND(SUM(sales_amount), 2) AS total_revenue
FROM order_items;

-- 2. Total Profit
SELECT
    ROUND(SUM(profit), 2) AS total_profit
FROM order_items;

-- 3. Profit Margin
SELECT
    ROUND(
        SUM(profit) / SUM(sales_amount) * 100,
        2
    ) AS profit_margin_percentage
FROM order_items;

-- 4. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- 5. Total Customers
SELECT
    COUNT(*) AS total_customers
FROM customers;

-- 6. Average Order Value
SELECT
    ROUND(
        SUM(oi.sales_amount) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- 7. Total Units Sold
SELECT
    SUM(quantity) AS total_units_sold
FROM order_items;

-- 8. Average Discount
SELECT
    ROUND(AVG(discount) * 100, 2) AS average_discount_percentage
FROM order_items;

-- 9. Order Status Analysis
SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS percentage_of_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 10. Delivered Revenue
SELECT
    ROUND(SUM(oi.sales_amount), 2) AS delivered_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- 11. Revenue by Payment Method
SELECT
    o.payment_method,
    ROUND(SUM(oi.sales_amount), 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.payment_method
ORDER BY revenue DESC;