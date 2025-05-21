# 🌾 Agriculture SQL Project – Crop Production Analysis

This project explores a large-scale agricultural dataset using advanced SQL techniques. The dataset contains over 1 million rows and includes detailed information about crop type, nutrients, production, rainfall, pH, and temperature across Indian states.

## 🗂 Dataset
- Source: Kaggle (1M+ rows)
- Stored in: `crop_data.csv`
- Table structure: Defined in `create_crop_data.sql`
- Key fields: `state_name`, `crop_type`, `nitrogen`, `rainfall`, `production_in_tons`, `yield_ton_per_hec`, etc.

## 🛠 Database
- SQL Engine: PostgreSQL (or your SQL Server if different)
- Table: `crop_data`
- Rows: 1,000,000+
- Columns: 12+

## 🔍 Analysis Performed

All queries are stored in `analysis_queries.sql`.
```sql
### ✔️ Advanced SQL Queries
query to get the top 5 crops (distinct names) based on the average yield per hectare across all states.
#### 1️⃣ Top 5 Crops by Average Yield (Across All States)

SELECT crop, 
       ROUND(avg(yield_ton_per_hec), 2) AS avg_yield
FROM crop_data
GROUP BY crop
ORDER BY avg_yield DESC
LIMIT 5; 

query to find the second most productive crop in each state
(based on total production_in_tons)
#### 2️⃣ N-th Most Productive Crop in Each State

WITH ranked AS (
  SELECT crop, state_name, 
         SUM(production_in_tons) AS total_production,
         RANK() OVER (PARTITION BY state_name ORDER BY SUM(production_in_tons) DESC) AS rank
  FROM crop_data
  GROUP BY crop, state_name
)
SELECT * FROM ranked WHERE rank = 2;

 query to find the state with the highest total cotton production.
####3️⃣ State with Highest Total Cotton Production
 
 SELECT state_name,
       SUM(production_in_tons) AS total_cotton_production
FROM crop_data
WHERE LOWER(crop) = 'cotton'
GROUP BY state_name
ORDER BY total_cotton_production DESC
LIMIT 1;

query to get the average rainfall and temperature for each crop type (crop_type), only for records 
where pH is between 6 and 7.5.
####4️⃣ Average Rainfall & Temperature by Crop Type (for pH between 6 and 7.5)

SELECT crop_type,
       ROUND(AVG(rainfall), 2) AS avg_rainfall,
       ROUND(AVG(temperature), 2) AS avg_temperature
FROM crop_data
WHERE ph BETWEEN 6 AND 7.5
GROUP BY crop_type;

 query to rank crops within each state based on their total production, in descending order.
####5️⃣ Rank Crops in Each State by Total Production

SELECT state_name, crop, 
       SUM(production_in_tons) AS total_production,
       RANK() OVER (PARTITION BY state_name ORDER BY SUM(production_in_tons) DESC) AS rank
FROM crop_data
GROUP BY state_name, crop;

 query to find all crops that are grown in more than one crop_type
(Example: If cotton is grown in both Kharif and Zaid, it should be included).
####6️⃣ Crops Grown in More Than One Crop Type
SELECT crop,
       COUNT(DISTINCT crop_type) AS number_of_crop_types
FROM crop_data
GROUP BY crop
HAVING COUNT(DISTINCT crop_type) > 1;

query to find the top 3 crops (by average yield) in each state.
####7️⃣ Top 3 Crops by Average Yield in Each State

WITH ranked AS (
  SELECT state_name, crop,
         ROUND(AVG(yield_ton_per_hec), 4) AS average_yield,
         RANK() OVER (PARTITION BY state_name ORDER BY AVG(yield_ton_per_hec) DESC) AS rank
  FROM crop_data
  GROUP BY state_name, crop
)
SELECT * FROM ranked WHERE rank <= 3;

Find all crops that have an average yield (across all states) less than 1 ton per hectare,
and are grown in at least 3 different states.
####8️⃣ Low-Yield Crops Grown in at Least 3 States

SELECT crop,
       ROUND(AVG(yield_ton_per_hec), 4) AS avg_yield,
       COUNT(DISTINCT state_name) AS number_of_states
FROM crop_data
GROUP BY crop
HAVING AVG(yield_ton_per_hec) < 1
   AND COUNT(DISTINCT state_name) >= 3;