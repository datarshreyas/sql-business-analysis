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
