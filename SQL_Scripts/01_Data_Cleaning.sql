SELECT * FROM swiggy_data;

-- Data Validation & Cleaning
-- Null check

SELECT
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS null_state,
	SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS null_city,
	SUM(CASE WHEN Order_Date IS  NULL THEN 1 ELSE 0 END) AS null_order_date,
	SUM(CASE WHEN Restaurant_Name IS NULL THEN 1 ELSE 0 END) AS null_restaurant,
	SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS null_location,
	SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS null_category,
	SUM(CASE WHEN Dish_Name IS NULL THEN 1 ELSE 0 END) AS null_dish,
	SUM(CASE WHEN Price_INR IS NULL THEN 1 ELSE 0 END) AS null_price,
	SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
	SUM(CASE WHEN Rating_Count IS NULL THEN 1 ELSE 0 END) AS null_rating_count
FROM swiggy_data;

-- Blank or Empty String
SELECT * 
FROM swiggy_data
WHERE
State = '' OR City = '' OR Restaurant_Name = '' OR Location = '' OR Dish_Name = '';


-- Dullicate Detection

SELECT 
	State, City,Order_Date, restaurant_name, location, category,
	dish_name, price_INR, rating, rating_count, count(*) as CNT
FROM swiggy_data
GROUP BY
State, City,Order_Date, restaurant_name, location, category,
dish_name, price_INR, rating, rating_count
Having count(*)  > 1;


-- Delete Dulication

WITH CTE AS (
SELECT *, ROW_NUMBER() OVER(
	PARTITION BY State, City,Order_Date, restaurant_name, location, category,
dish_name, price_INR, rating, rating_count
ORDER BY (SELECT NULL)
) AS rn
FROM swiggy_data
)
DELETE FROM CTE WHERE rn >1; 
