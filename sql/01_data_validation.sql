CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(100),
    state VARCHAR(100),
    signup_date DATE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    unit_cost DECIMAL(10,2),
    selling_price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    region VARCHAR(50),
    payment_method VARCHAR(50),
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    unit_price DECIMAL(10,2),
    sales_amount DECIMAL(12,2),
    cost_amount DECIMAL(12,2),
    profit DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
USE ecommerce_analytics;

SHOW TABLES;
SELECT COUNT(*) AS customers
FROM customers;

SELECT COUNT(*) AS products
FROM products;

SELECT COUNT(*) AS orders
FROM orders;

SELECT COUNT(*) AS order_items
FROM order_items;
SELECT * FROM customers LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_items LIMIT 5;

USE ecommerce_analytics;

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM customers

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items;

SELECT customer_id, COUNT(*) AS occurrences
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS occurrences
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(customer_name IS NULL) AS missing_name,
    SUM(gender IS NULL) AS missing_gender,
    SUM(age IS NULL) AS missing_age,
    SUM(city IS NULL) AS missing_city,
    SUM(state IS NULL) AS missing_state,
    SUM(signup_date IS NULL) AS missing_signup_date
FROM customers;

SELECT
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(product_name IS NULL) AS missing_name,
    SUM(category IS NULL) AS missing_category,
    SUM(sub_category IS NULL) AS missing_subcategory,
    SUM(unit_cost IS NULL) AS missing_cost,
    SUM(selling_price IS NULL) AS missing_price
FROM products;

SELECT
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(order_date IS NULL) AS missing_date,
    SUM(region IS NULL) AS missing_region,
    SUM(payment_method IS NULL) AS missing_payment,
    SUM(order_status IS NULL) AS missing_status
FROM orders;

SELECT
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(quantity IS NULL) AS missing_quantity,
    SUM(discount IS NULL) AS missing_discount,
    SUM(unit_price IS NULL) AS missing_unit_price,
    SUM(sales_amount IS NULL) AS missing_sales,
    SUM(cost_amount IS NULL) AS missing_cost,
    SUM(profit IS NULL) AS missing_profit
FROM order_items;

SELECT *
FROM order_items
WHERE quantity <= 0;

SELECT *
FROM order_items
WHERE discount < 0
   OR discount > 1;

SELECT *
FROM products
WHERE unit_cost <= 0
   OR selling_price <= 0;
   
SELECT *
FROM customers
WHERE age < 18
   OR age > 100;
   
SELECT DISTINCT order_status
FROM orders;

SELECT DISTINCT payment_method
FROM orders;

SELECT COUNT(*) AS orphan_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_products
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT
    COUNT(*) AS incorrect_sales_records
FROM order_items
WHERE ABS(
    sales_amount -
    (quantity * unit_price * (1 - discount))
) > 0.01;

SELECT
    COUNT(*) AS incorrect_profit_records
FROM order_items
WHERE ABS(
    profit - (sales_amount - cost_amount)
) > 0.01;   