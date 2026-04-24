-- Total revenue
SELECT SUM(Sales) AS total_revenue
FROM sales;

-- Monthly revenue trend
SELECT 
    strftime('%Y-%m', "Order Date") AS month,
    SUM(Sales) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- Top 5 products
SELECT 
    "Product Name",
    SUM(Sales) AS total_sales
FROM sales
GROUP BY "Product Name"
ORDER BY total_sales DESC
LIMIT 5;

-- Sales by category
SELECT 
    Category,
    SUM(Sales) AS total_sales
FROM sales
GROUP BY Category
ORDER BY total_sales DESC;

-- Top customers
SELECT 
    "Customer Name",
    COUNT(*) AS orders
FROM sales
GROUP BY "Customer Name"
ORDER BY orders DESC
LIMIT 5;

-- Total revenue by category (JOIN)
SELECT 
    p.Category,
    SUM(s.Sales) AS total_sales
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY total_sales DESC;

-- Revenue by region (JOIN)
SELECT 
    o.Region,
    SUM(s.Sales) AS revenue
FROM sales s
JOIN orders o ON s.OrderID = o.OrderID
GROUP BY o.Region
ORDER BY revenue DESC;

-- Rank top products
SELECT 
    p.ProductName,
    SUM(s.Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(s.Sales) DESC) AS sales_rank
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

-- Running total revenue over time
SELECT 
    o.OrderDate,
    SUM(s.Sales) AS daily_sales,
    SUM(SUM(s.Sales)) OVER (ORDER BY o.OrderDate) AS running_total
FROM sales s
JOIN orders o ON s.OrderID = o.OrderID
GROUP BY o.OrderDate;

-- Top customers using CTE
WITH customer_sales AS (
    SELECT 
        o.CustomerName,
        SUM(s.Sales) AS total_spent
    FROM sales s
    JOIN orders o ON s.OrderID = o.OrderID
    GROUP BY o.CustomerName
)

SELECT *
FROM customer_sales
ORDER BY total_spent DESC
LIMIT 5;
