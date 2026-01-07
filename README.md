# 🍔 Swiggy Sales Analysis | Microsoft SQL Server

## 📌 Project Overview
This project analyzes Swiggy food delivery data using **Microsoft SQL Server**.  
The objective is to clean raw data, design a **Star Schema**, and generate meaningful business insights using SQL queries.

The project follows real-world **business requirements** and focuses on performance, scalability, and analytics-ready data modeling.

---

## 🧩 Business Problem
Swiggy operates across multiple states, cities, restaurants, and cuisines.  
The raw dataset contains issues like:
- Null values
- Blank records
- Duplicate rows
- Non-optimized table design for analytics

The goal is to:
1. Clean and validate data
2. Design a **dimensional model (Star Schema)**
3. Build KPIs and deep-dive analytical reports

---

## 🛠 Tools & Technologies
- **Database:** Microsoft SQL Server  
- **Language:** SQL  
- **Data Source:** Excel (.xlsx)  
- **Modeling:** Star Schema (Dimensional Modeling)

---

## 📂 Dataset Information
- Source: `swiggy_data.xlsx`
- Contains food delivery records including:
  - State
  - City
  - Restaurant Name
  - Category / Cuisine
  - Dish Name
  - Price (INR)
  - Rating
  - Rating Count
  - Order Date

---

## 🧹 Data Cleaning Steps
Performed using SQL:
- Null value checks
- Blank/empty string detection
- Duplicate identification
- Duplicate removal using `ROW_NUMBER()`
- Data validation for analytics readiness

---

## 🧱 Data Modeling (Star Schema)

### Dimension Tables
- `dim_date` → Year, Month, Quarter, Week
- `dim_location` → State, City, Location
- `dim_restaurant` → Restaurant Name
- `dim_category` → Cuisine / Category
- `dim_dish` → Dish Name

### Fact Table
- `fact_swiggy_orders`
  - Price_INR
  - Rating
  - Rating_Count
  - Foreign Keys from all dimensions

This model improves:
- Query performance
- Reporting efficiency
- BI dashboard compatibility

---

## 📊 KPIs & Business Insights

### 🔹 Basic KPIs
- Total Orders
- Total Revenue (INR)
- Average Dish Price
- Average Rating

### 🔹 Time-Based Analysis
- Monthly trends
- Quarterly trends
- Year-wise growth
- Day-of-week ordering pattern

### 🔹 Location Analysis
- Top 10 cities by orders
- Revenue by state

### 🔹 Food Performance
- Top restaurants
- Top cuisines
- Most ordered dishes
- Cuisine vs Rating analysis

### 🔹 Customer Spending Analysis
Order value buckets:
- Under ₹100
- ₹100–199
- ₹200–299
- ₹300–499
- ₹500+

### 🔹 Ratings Distribution
- Rating distribution from 1 to 5

---

## 📈 Key Learnings
- Real-world SQL data cleaning techniques
- Dimensional modeling for analytics
- KPI-driven business analysis
- Writing optimized SQL queries for reporting

---

## 🚀 How to Run This Project
1. Import `swiggy_data.xlsx` into SQL Server
2. Execute SQL scripts in order:
   - Data Cleaning
   - Dimension Tables
   - Fact Table
   - KPI Analysis
3. Validate results using SELECT queries

---

## 📌 Author
**Harsh Devmurari**  
B.Com Graduate | Aspiring Data Analyst  
Skills: SQL, Power BI, Tableau, Python, Data Analytics  

---

⭐ If you found this project helpful, give it a **star**!
