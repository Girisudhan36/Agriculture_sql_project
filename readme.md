🌾 Agriculture SQL Project – Crop Production Analysis

This project showcases comprehensive analysis of Indian agricultural crop production using advanced SQL techniques. It is designed to demonstrate data analytics skills relevant to agriculture and business intelligence roles.


---

📁 Dataset Overview

Source: Kaggle (1M+ rows)

Format: crop_data.csv

Table Structure: Defined in create_crop_data.sql

Key Fields: state_name, crop, crop_type, nitrogen, rainfall, ph, temperature, production_in_tons, yield_ton_per_hec



---

🗄 Database Configuration

SQL Engine: PostgreSQL (can be adapted to MySQL, MS SQL Server)

Table Name: crop_data

Data Size: Over 1 million rows, 12+ fields

🧩 File Structure

📦 Agriculture_sql_project
 ┣ 📄 Crop_data.csv           --> Dataset
 ┣ 📄 create_crop_data.sql    --> Table schema
 ┣ 📄 analysis_queries.sql    --> All advanced SQL queries
 ┗ 📄 README.md               --> Project documentation



---

🔍 SQL Analysis Performed

All queries are available in analysis_queries.sql. Below are the insights derived using advanced SQL queries:

####1️⃣ Top 5 Crops by Average Yield

SELECT crop, ROUND(AVG(yield_ton_per_hec), 2) AS avg_yield
FROM crop_data
GROUP BY crop
ORDER BY avg_yield DESC
LIMIT 5;

####2️⃣ Second Most Productive Crop in Each State

WITH ranked AS (
  SELECT crop, state_name, SUM(production_in_tons) AS total_production,
         RANK() OVER (PARTITION BY state_name ORDER BY SUM(production_in_tons) DESC) AS rank
  FROM crop_data
  GROUP BY crop, state_name
)
SELECT * FROM ranked WHERE rank = 2;

####3️⃣ State with Highest Total Cotton Production

SELECT state_name, SUM(production_in_tons) AS total_cotton_production
FROM crop_data
WHERE LOWER(crop) = 'cotton'
GROUP BY state_name
ORDER BY total_cotton_production DESC
LIMIT 1;

####4️⃣ Avg. Rainfall & Temp by Crop Type (pH 6-7.5)

SELECT crop_type, ROUND(AVG(rainfall), 2) AS avg_rainfall,
       ROUND(AVG(temperature), 2) AS avg_temperature
FROM crop_data
WHERE ph BETWEEN 6 AND 7.5
GROUP BY crop_type;

####5️⃣ Crop Rank in Each State by Production

SELECT state_name, crop, SUM(production_in_tons) AS total_production,
       RANK() OVER (PARTITION BY state_name ORDER BY SUM(production_in_tons) DESC) AS rank
FROM crop_data
GROUP BY state_name, crop;

####6️⃣ Crops Grown in More Than One Crop Type

SELECT crop, COUNT(DISTINCT crop_type) AS crop_type_count
FROM crop_data
GROUP BY crop
HAVING COUNT(DISTINCT crop_type) > 1;

####7️⃣ Top 3 Crops by Average Yield per State

WITH ranked AS (
  SELECT state_name, crop, ROUND(AVG(yield_ton_per_hec), 4) AS average_yield,
         RANK() OVER (PARTITION BY state_name ORDER BY AVG(yield_ton_per_hec) DESC) AS rank
  FROM crop_data
  GROUP BY state_name, crop
)
SELECT * FROM ranked WHERE rank <= 3;

####8️⃣ Low-Yield Crops Grown in at Least 3 States

SELECT crop, ROUND(AVG(yield_ton_per_hec), 4) AS avg_yield,
       COUNT(DISTINCT state_name) AS number_of_states
FROM crop_data
GROUP BY crop
HAVING AVG(yield_ton_per_hec) < 1 AND COUNT(DISTINCT state_name) >= 3;


---

✅ What I Learned

Practical experience with large datasets

Usage of complex SQL clauses: WITH, RANK() OVER, HAVING, and GROUP BY

Agricultural insights using real-world data

Optimization of


