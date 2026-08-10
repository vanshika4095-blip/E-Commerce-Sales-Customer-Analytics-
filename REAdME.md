E-Commerce Sales & Customer Analytics

Project Overview

This project analyzes e-commerce sales data to evaluate business performance across revenue, profitability, customers, products, payment methods, order status, and regional performance.

The project uses SQL to transform raw transactional data into business-focused insights and performance metrics that can support data-driven decision-making.

Business Objectives

Measure overall revenue and profitability
Evaluate order and customer performance
Identify top-performing product categories and products
Analyze customer purchasing behavior
Identify repeat and high-value customers
Compare regional sales performance
Analyze monthly revenue and profit trends
Evaluate order fulfillment and operational performance
Understand payment method usage
Identify key business performance drivers

Project Structure

E-Commerce-Sales-Customer-Analytics

data

raw

customers.csv

products.csv

orders.csv

order_items.csv

sql

01_data_validation.sql

02_kpi_analysis.sql

03_product_analysis.sql

04_customer_analysis.sql

05_time_region_analysis.sql

06_advanced_analysis.sql

README.md

Dataset

The project uses four relational datasets:

Customers

Contains customer-level information used for customer behavior and segmentation analysis.

Products

Contains product details including product category and product identifiers.

Orders

Contains order-level information including order date, customer, region, payment method, order status, revenue, profit, and discount-related information.

Order Items

Contains product-level details associated with individual orders.

Tools and Technologies

SQL

MySQL

Microsoft Excel

SQL Concepts Used

SELECT and WHERE

GROUP BY and Aggregate Functions

JOINs

CASE Statements

Subqueries

Common Table Expressions

Window Functions

Date Functions

Conditional Aggregation

Ranking

Business KPI Analysis

SQL Analysis

Data Validation

Performed data quality checks on:

Duplicate records
Missing values
Invalid dates
Transaction amounts
Customer attributes
Product and category fields
Referential consistency
KPI Analysis

Calculated major business KPIs including:

Total Revenue
Total Profit
Profit Margin
Total Orders
Total Customers
Average Order Value
Total Units Sold
Average Discount
Revenue by Payment Method
Order Status Distribution
Product Analysis

Analyzed product and category performance using:

Revenue by category
Profit by category
Profit margin by category
Top products by revenue
Top products by profit
Low-performing products
Category rankings
Customer Analysis

Analyzed customer behavior through:

Top customers by revenue
Repeat customer analysis
Customer revenue contribution
Customer value segmentation
High-, medium-, and low-value customer groups
Customer purchasing patterns
Time and Regional Analysis

Analyzed business performance across:

Monthly revenue
Monthly profit
Monthly order volume
Month-over-month revenue growth
Regional revenue
Regional profit
Regional profit margins
Regional category performance
Advanced Analysis

Applied advanced SQL techniques to derive deeper business insights using:

CTEs
Subqueries
CASE statements
Window functions
Ranking functions
Month-over-month calculations
Customer segmentation
Region and category analysis

Key Business KPIs

Total Revenue: ₹31.64 Cr

Total Profit: ₹6.79 Cr

Profit Margin: 21.47%

Total Orders: 20,000

Total Customers: 5,000

Average Order Value: ₹15,774.44

Total Units Sold: 61,251

Average Discount: 7.88%

Repeat Customers: 3,213

Repeat Customer Rate: 64.26%

Key Business Insights

Customer Concentration

High-value customers represent approximately 27.7% of customers but contribute 61.44% of total revenue, highlighting the importance of customer retention and high-value customer relationships.

Category Performance

Fashion was the highest-revenue product category, generating approximately ₹7.03 Cr in revenue.

Regional Performance

The West region generated the highest regional revenue at approximately ₹8.08 Cr, followed closely by the South region at approximately ₹8.03 Cr.

Monthly Performance

December 2025 recorded the highest monthly revenue at approximately ₹2.78 Cr, representing 7.0% month-over-month growth.

Operational Performance

82.13% of orders were delivered, while 9.77% were either returned or cancelled, providing an important view of order fulfillment performance.

Payment Method Analysis

UPI generated the highest revenue and order volume among the analyzed payment methods.

UPI: ₹10.72 Cr revenue, 6,829 orders

Credit Card: ₹8.15 Cr revenue, 5,065 orders

Debit Card: ₹5.56 Cr revenue, 3,472 orders

Net Banking: ₹3.74 Cr revenue, 2,385 orders

Cash on Delivery: ₹3.48 Cr revenue, 2,249 orders

Order Status Analysis

Delivered: 16,425 orders, 82.13%

Shipped: 1,621 orders, 8.11%

Returned: 1,002 orders, 5.01%

Cancelled: 952 orders, 4.76%

Product Category Performance

Fashion: ₹7.03 Cr

Electronics: ₹6.33 Cr

Beauty and Personal Care: ₹5.18 Cr

Home and Kitchen: ₹5.00 Cr

Sports: ₹4.25 Cr

Books: ₹3.85 Cr

Regional Performance

West: ₹8.08 Cr revenue, 21.40% profit margin

South: ₹8.03 Cr revenue, 21.58% profit margin

North: ₹7.54 Cr revenue, 21.33% profit margin

East: ₹4.61 Cr revenue, 21.51% profit margin

Central: ₹3.38 Cr revenue, 21.67% profit margin

Monthly Revenue Performance

January 2025: ₹2.69 Cr

February 2025: ₹2.45 Cr

March 2025: ₹2.62 Cr

April 2025: ₹2.55 Cr

May 2025: ₹2.66 Cr

June 2025: ₹2.68 Cr

July 2025: ₹2.72 Cr

August 2025: ₹2.66 Cr

September 2025: ₹2.66 Cr

October 2025: ₹2.59 Cr

November 2025: ₹2.60 Cr

December 2025: ₹2.78 Cr

Future Enhancements

The project will be extended with an Excel analytics dashboard containing KPI cards, monthly revenue trends, revenue by product category, revenue by region, customer segment analysis, order status distribution, and business insights.

Author

Vanshika

B.Tech – Electronics and Communication Engineering

Punjab Engineering College, Chandigarh