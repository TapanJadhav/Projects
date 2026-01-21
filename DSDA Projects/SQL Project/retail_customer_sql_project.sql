USE retail_customer_project;		#Using the required database
SHOW TABLES;						#Verifying the tables
DESCRIBE retail_sales_sql;			#Identifying the column names, their DataTypes, null values, etc
SELECT * 
FROM retail_sales_sql;		#All the records from first table 'retail_sales_sql'
DESCRIBE customers_sql;
SELECT * 
FROM customers_sql;		#All the records from first table 'customers_sql'

		# >> BASIC SELECT & FILTERING -
# 1.Select all orders placed in March 2024.
SELECT *
FROM retail_sales_sql
WHERE order_date BETWEEN '2024-03-01' AND '2024-03-31';
# 2.Find all orders where quantity > 3.
SELECT *
FROM retail_sales_sql
WHERE quantity > 3;
# 3.List unique product categories.
SELECT DISTINCT category
FROM retail_sales_sql;
# 4.Show total quantity sold per product.
SELECT product, SUM(quantity) as total_quantity
FROM retail_sales_sql
GROUP BY product;
# 5.Show total revenue generated per product.
SELECT product, SUM(total_price) as total_revenue
FROM retail_sales_sql
GROUP BY product;

		# >> GROUP BY & AGGREGATION -
# 6.Compute monthly revenue totals.
SELECT EXTRACT(month from order_date) as month, SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY month
ORDER BY month;
# 7.Find the top 5 customers by total spending.
SELECT customer_id, SUM(total_price) as total_spent
FROM retail_sales_sql
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
# 8.Calculate average order value (AOV).
SELECT SUM(total_price)/COUNT(*) as avg_order_value
FROM retail_sales_sql;
# 9.Compute category-wise revenue contributions.
SELECT category, SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY category;
# 10.Count number of orders per category.
SELECT category, COUNT(*) as order_count
FROM retail_sales_sql
GROUP BY category;

		# >> DATE & WINDOW FUNCTIONS -
# 11.Find the highest revenue day.
SELECT order_date, SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY order_date
ORDER BY revenue DESC
LIMIT 1;
# 12.Show weekly revenue trends.
SELECT EXTRACT(week from order_date) as week, SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY week
ORDER BY week;
# 13.Rank products by total revenue using RANK().
SELECT product, SUM(total_price) as revenue,
       RANK() OVER (ORDER BY SUM(total_price) DESC) as revenue_rank
FROM retail_sales_sql
GROUP BY product;
# 14.For each category, find the best-selling product.
WITH bs_prod as (
    SELECT category, product, SUM(total_price) as revenue,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(total_price) DESC) as rn
    FROM retail_sales_sql
    GROUP BY category, product
)
SELECT category, product, revenue
FROM bs_prod
WHERE rn = 1;
# 15.For each day, compute cumulative revenue.
SELECT order_date,
       SUM(total_price) as revenue,
       SUM(SUM(total_price)) OVER (ORDER BY order_date) as cumulative_revenue
FROM retail_sales_sql
GROUP BY order_date
ORDER BY order_date;
# 16.Identify customers whose spending is above the overall average.
WITH c as (
  SELECT customer_id, SUM(total_price) as spent
  FROM retail_sales_sql
  GROUP BY customer_id
),
avg_spent as (
  SELECT AVG(spent) as avg_val FROM c
)
SELECT c.customer_id, c.spent
FROM c, avg_spent
WHERE c.spent > avg_spent.avg_val;
# 17.Find the top 1 product per month using ROW_NUMBER().
WITH m_top1 as (
	SELECT EXTRACT(month from order_date) as month,
			product, SUM(total_price) as revenue,
            ROW_NUMBER() OVER (PARTITION BY EXTRACT(month from order_date)
							ORDER BY SUM(total_price) DESC) as rn
	FROM retail_sales_sql
    GROUP BY month, product
)
SELECT month, product, revenue
FROM m_top1
WHERE rn = 1;

		# >> Joins -
# 18.Join order data with customer demographics.
SELECT r.order_id, r.order_date, r.product, r.total_price,
		c.customer_id, c.age, c.gender, c.city, c.loyalty_level
FROM retail_sales_sql r
JOIN customers_sql c ON r.customer_id = c.customer_id;
# 19.Compute CLV (Customer Lifetime Value).
SELECT c.customer_id, c.loyalty_level,
		SUM(r.total_price) as clv
FROM retail_sales_sql r
JOIN customers_sql c ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.loyalty_level
ORDER BY clv DESC;
# 20.Compute how much customer spend per city.
SELECT c.city, SUM(r.total_price) as revenue
FROM retail_sales_sql r
JOIN customers_sql c ON r.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue DESC;
# 21.Find the revenue by customers loyalty tier.
SELECT c.loyalty_level, SUM(r.total_price) as revenue
FROM retail_sales_sql r
JOIN customers_sql c ON r.customer_id = c.customer_id
GROUP BY c.loyalty_level
ORDER BY revenue;
# 22.Find out the repeatining customer percentage.
WITH rt as (
	SELECT customer_id,
			COUNT(DISTINCT EXTRACT(month from order_date)) as active_months
	FROM retail_sales_sql
    GROUP BY customer_id
)
SELECT ROUND(
        SUM(CASE WHEN active_months > 1 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2
			) as repeat_customer_pct
FROM rt;

		# >> BUSINESS-ORIENTED INSIGHTS <<
# 1.Which product has the highest revenue-to-quantity ratio?
SELECT product, SUM(total_price)/SUM(quantity) as revenue_per_unit
FROM retail_sales_sql
GROUP BY product
ORDER BY revenue_per_unit DESC
LIMIT 3;
# 2.Which category drives most revenue?
SELECT category, SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY category
ORDER BY revenue DESC;
# 3..What percentage of revenue comes from repeat customers?
WITH co_count as (
    SELECT customer_id, COUNT(DISTINCT order_id) as orders
    FROM retail_sales_sql
    GROUP BY customer_id
)
SELECT ROUND(
        (SUM(r.total_price) / (SELECT SUM(total_price) FROM retail_sales_sql)) * 100, 2
			) as repeat_revenue_pct
FROM retail_sales_sql r
JOIN co_count c ON r.customer_id = c.customer_id
WHERE c.orders > 1;
# 4.Which products show seasonal trends?
SELECT product,
       MONTH(order_date) as month,
       SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY product, MONTH(order_date)
ORDER BY product, month;
# 5.Predict when a customer is likely to reorder based on history.
WITH freq as (
    SELECT customer_id,
           COUNT(order_id) as total_orders,
           DATEDIFF(MAX(order_date), MIN(order_date)) as days_active
    FROM retail_sales_sql
    GROUP BY customer_id
)
SELECT customer_id,
       total_orders,
       days_active,
       ROUND(days_active / total_orders,1) as avg_days_between_orders
FROM freq
ORDER BY avg_days_between_orders ASC;
# 6.Identify products that should be discounted based on low sales.
SELECT product,
       SUM(quantity) as units_sold,
       SUM(total_price) as revenue
FROM retail_sales_sql
GROUP BY product
ORDER BY units_sold ASC, revenue ASC;
# 7.Identify cross-selling opportunities (products bought together).
SELECT a.product as product_A,
       b.product as product_B,
       COUNT(*) as together_count
FROM retail_sales_sql a
JOIN retail_sales_sql b 
		ON a.customer_id = b.customer_id
		AND a.order_id <> b.order_id
WHERE a.product <> b.product
GROUP BY product_A, product_B
ORDER BY together_count DESC;

/*
>> Insights -
1. Audio category has strongest revenue growth but seasonal demand.
2. Platinum loyalty customers deliver the highest CLV and should be targeted for retention campaigns.
3. Cross-selling opportunities exist between Laptops ↔ Headphones and Monitors ↔ Speakers.
4. Products with low sales velocity such as <X> should be discounted or bundled.
*/