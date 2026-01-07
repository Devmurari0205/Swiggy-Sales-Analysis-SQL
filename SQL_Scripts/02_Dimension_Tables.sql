
-- Creating Scema
-- Dimen
-- Date Table

CREATE TABLE dim_date(
	date_id INT IDENTITY(1,1) PRIMARY KEY,
	Full_Date DATE,
	Year INT,
	Month INT,
	Month_Name VARCHAR(20),
	Quater INT,
	Day INT,
	Week INT
	)
SELECT * FROM dim_date;

-- dim_ location 

CREATE TABLE dim_location(
	location_id INT IDENTITY(1,1) PRIMARY KEY,
	State VARCHAR(100),
	CIty VARCHAR (100),
	Location VARCHAR(200)
	);
SELECT * FROM dim_location;

-- dim_restaurant

CREATE TABLE dim_restaurant(
	rastaurant_id INT IDENTITY(1,1) PRIMARY KEY,
	Restaurant_Name VARCHAR(200)
	);

exec sp_rename
	'dim_restaurant.rastaurant_id',
	'restaurant_id',
	'column';
	
-- dim category

CREATE TABLE dim_category (
	catagory_id INT IDENTITY(1,1) PRIMARY KEY,
	category VARCHAR (200)
	);
	

-- Dim_dish
CREATE TABLE dim_dish (
	dish_id INT IDENTITY (1,1) PRIMARY KEY,
	Dish_Name VARCHAR(200)
	);

-- FACT TABLE-------

CREATE TABLE fact_swiggy_orders (
	order_id INT IDENTITY (1,1) PRIMARY KEY,

	date_id INT,
	Price_INR DECIMAl(10,2),
	Rating DECIMAL(4,2),
	Rating_Count INT,

	location_id INT,
	restaurant_id INT,
	category_id INT,
	dish_id INT,

	FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
	FOREIGN KEY (location_id) REFERENCES dim_location (location_id),
	FOREIGN KEY (restaurant_id) REFERENCES dim_restaurant(restaurant_id),
	FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
	FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id)
	);
SELECT * FROM fact_swiggy_orders

-- INSERT DATA IN TABLE
-- dim_date

INSERT INTO dim_date (Full_Date,Year,Month, Month_Name, Quater, Day, Week)
SELECT DISTINCT
	Order_Date,
	Year(Order_Date),
	MONTH(Order_Date),
	DATENAME(MONTH,Order_Date),
	DATEPART(QUARTER,Order_Date),
	DAY(Order_Date),
	DATEPART(WEEK, ORDER_DATE)
FROM swiggy_data
WHERE Order_Date IS NOT NULL;

SELECT * FROM dim_date;

-- Dim locations
INSERT INTO dim_location (State, City, Location)
SELECT DISTINCT
	State,
	City,
	Location
FROM swiggy_data;

SELECT * FROM dim_location;

-- dim category
INSERT INTO dim_category(category)
SELECT DISTINCT 
	Category
FROM swiggy_data;

SELECT	 * FROM dim_category;

-- dim_restaurant
INSERT INTO dim_restaurant (Restaurant_Name)
SELECT DISTINCT
	Restaurant_Name
FROM Swiggy_data;

SELECT * FROM dim_restaurant;

-- dim_dish
INSERT INTO dim_dish(Dish_Name)
SELECT DISTINCT
	Dish_Name
FROM swiggy_data;

SELECT * FROM dim_dish;

-- Fact_table 

INSERT INTO fact_swiggy_orders
(
		date_id,
		Price_INR,
		Rating,
		Rating_Count,
		location_id,
		restaurant_id,
		category_id,
		dish_id
)
SELECT
		dd.date_id,
		s.Price_INR,
		s.Rating,
		s.Rating_Count,

		d1.location_id,
		dr.restaurant_id,
		dc.category_id,
		dsh.dish_id
FROM swiggy_data s

JOIN dim_date dd
	ON dd.Full_Date = s.Order_Date

JOIN dim_location d1
	ON d1.State = s.State
	AND d1.City = s.City
	AND d1.Location = s.Location

JOIN dim_restaurant dr
	ON dr.Restaurant_Name = s.Restaurant_Name

JOIN dim_category dc
	ON dc.Category = s.Category

join dim_dish dsh
	on dsh.Dish_Name = s.Dish_Name;


SELECT * FROM fact_swiggy_orders;

SELECT * FROM	fact_swiggy_orders f
JOIN dim_date d ON f.date_id = d.date_id
join dim_location l ON f.location_id = l.location_id
join dim_restaurant r ON f.restaurant_id = r.restaurant_id
JOIN dim_category c ON f.category_id = c.category_id
JOIN dim_dish di ON f.dish_id = di.dish_id;


