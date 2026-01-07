
-- KPI'S

-- Total Orders
SELECT Count(*) AS Total_Orders
FROM fact_swiggy_orders;

-- Total  Revnue (INR Million)
SELECT
FORMAT(SUM(CONVERT(Float,price_INR))/1000000,'N2') + ' INR Million'
AS Total_Revenue
FROM fact_swiggy_orders;

-- Average Dish Price
SELECT
FORMAT(AVG(CONVERT(FLOAT,price_INR)),'N2') + ' INR'
AS Average_Price
FROM fact_swiggy_orders;

-- Average Rating
SELECT 
FORMAT(AVG(CONVERT(int,Rating)),'N0') AS Avg_Rating
FROM fact_swiggy_orders;

-- Deep - Dive Bisiness Analysis

-- Monthly Order Trends
SELECT
	d.year,
	d.month,
	d.month_name,
	Count(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN
dim_date d ON f.date_id = d.date_id
Group by d.year,d.Month,d.Month_Name
ORDER BY count(*) DESC;

-- Total Revnue
SELECT
	d.year,
	d.month,
	d.month_name,
	SUM(price_INR) as Total_Revnue
FROM fact_swiggy_orders f
JOIN
dim_date d ON
f.date_id = d.date_id
GROUP  BY d.year,d.month,d.Month_Name
ORDER BY Total_Revnue desc;

-- Quaterly Trends
SELECT
	d.year,
	d.Quater,
	Count(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN 
dim_date d ON
f.date_id = d.date_id
Group by d.year,d.Quater
Order by Total_Orders desc;

-- Yearly trand
SELECT 
	d.year,
	count(*) AS Total_Yearly
FROM fact_swiggy_orders f
JOIN
dim_date d ON
f.date_id = d.date_id
GROUP BY d.year
ORDER BY count(*) DESC

-- Oder by Day od week (Mon - Sun)
SELECT
	DATENAME(WEEKDAY, d.Full_Date) as day_name,
	count(*) AS Total_Orders
FROM fact_swiggy_orders f
JOIN
dim_date d ON
f.date_id = d.date_id
GROUP BY DATENAME(WEEKDAY,d.Full_Date),DATEPART(WEEKDAY,d.Full_date)
ORDER BY DATEPART (WEEKDAY,d.Full_Date)

-- Top 10 cities by Orders volume
SELECT TOP 10
	l.City,
	SUM(f.Price_INR)AS Total_Revenue
FROM fact_swiggy_orders f 
JOIN dim_location l ON
f.location_id = l.location_id
GROUP BY l.City
ORDER BY Total_Revenue desc;

-- Revnue Contribution by states
SELECT 
	l.State,
	SUM(f.price_INR) AS State_Revnue
FROM fact_swiggy_orders f
JOIN
dim_location l ON
f.location_id = l.location_id
GROUP BY l.State
ORDER BY State_Revnue DESC;

-- 10 Restaurants by orders
SELECT TOP 10 
	r.Restaurant_Name,
	SUM(f.Price_INR) AS Total_Revenue
FROM fact_swiggy_orders f
JOIN dim_restaurant r ON
f.restaurant_id = r.restaurant_id
GROUP BY r.Restaurant_Name
ORDER BY SUM(f.Price_INR) DESC;

-- Top Categories by orders Volumn
SELECT 
	c.category,
	COUNT(*) AS Total_Order
FROM fact_swiggy_orders f
JOIN
dim_category c ON
f.category_id = c.category_id
GROUP BY c.category
ORDER BY Total_Order DESC;

-- Most Orders Dishes
SELECT TOP 10
	d.Dish_Name,
	COUNT(*) AS order_count
FROM fact_swiggy_orders f
JOIN
dim_dish d ON
f.dish_id = d.dish_id
GROUP BY d.Dish_Name
ORDER BY order_count DESC;

-- Cuisine Performance (Orders + Avg Rating)
SELECT
	c.category,
	COUNT(*) AS total_orders,
	FORMAT(AVG(CONVERT(FLOAT,f.rating)),'N0') AS avg_rating
FROM fact_swiggy_orders f
JOIN
dim_category c ON
f.category_id = c.category_id
GROUP BY c.category
ORDER BY total_orders DESC;

-- Total Order by Price Range
SELECT
	CASE
		WHEN CONVERT (FLOAT, price_inr) < 100 THEN '100'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE '500+'
	END AS price_range,
	COUNT(*) AS Total_orders
FROM fact_swiggy_orders
GROUP BY
	CASE
		WHEN CONVERT (FLOAT, price_inr) < 100 THEN '100'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 100 AND 199 THEN '100 - 199'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 200 AND 299 THEN '200 - 299'
		WHEN CONVERT (FLOAT, price_inr) BETWEEN 300 AND 499 THEN '300 - 499'
		ELSE '500+'
	END
ORDER BY Total_orders DESC;

select * from fact_swiggy_orders;
	
-- Rating Count Distribution (1 - 5)
SELECT
	rating,
	COUNT(*) AS rating_count
FROM fact_swiggy_orders
GROUP BY rating
ORDER BY rating DESC;

