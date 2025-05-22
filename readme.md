## 🌾  Agriculture SQL Project – Crop Production Analysis ##

This project showcases comprehensive analysis of Indian agricultural crop production using advanced SQL techniques. It is designed to demonstrate data analytics skills relevant to agriculture and business intelligence roles.


---

### 📁  Dataset Overview ###

Source: Kaggle (1M+ rows)

Format: crop_data.csv

Table Structure: Defined in create_crop_data.sql

Key Fields: state_name, crop, crop_type, nitrogen, rainfall, ph, temperature, production_in_tons, yield_ton_per_hec



---

### 🗄 Database Configuration ###

SQL Engine: PostgreSQL (can be adapted to MySQL, MS SQL Server)

Table Name: crop_data

Data Size: Over 1 million rows, 12+ fields

---

### 🧩 File Structure ###

📦 Agriculture_sql_project

  📄 Crop_data.csv  --> Dataset 

  📄 create_crop_data.sql --> Table schema 

  📄 analysis_queries.sql --> All advanced SQL queries 

  📄 README.md  --> Project documentation

---

### ⚙️ Project Setup ###

To run this project locally:

1. Load the dataset using the provided create_crop_data.sql in PostgreSQL.


2. Import Crop_data.csv into the crop_data table.


3. Execute queries from analysis_queries.sql for insights.

---

### 🔍 SQL Analysis Performed ###

All queries are available in analysis_queries.sql. Below are the insights derived using advanced SQL queries:

### 1️⃣ Top 5 Crops by Average Yield  ###

```sql
SELECT crop, 
ROUND(AVG(yield_ton_per_hec), 2) AS avg_yield
FROM crop_data
GROUP BY crop
ORDER BY avg_yield DESC
LIMIT 5;
``` 

### 2️⃣ Second Most Productive Crop in Each State ###

```sql...
WITH ranked AS (
  SELECT crop, state_name, 
  SUM(production_in_tons) AS total_production,
     RANK() OVER (PARTITION BY state_name 
     ORDER BY SUM(production_in_tons) DESC) AS rank
  FROM crop_data
  GROUP BY crop, state_name
)
SELECT * FROM ranked WHERE rank = 2;

```

### 3️⃣ State with Highest Total Cotton Production ###

```sql...
SELECT state_name, 
SUM(production_in_tons) AS total_cotton_production
FROM crop_data
WHERE LOWER(crop) = 'cotton'
GROUP BY state_name
ORDER BY total_cotton_production DESC
LIMIT 1;
```

### 4️⃣ Avg. Rainfall & Temp by Crop Type (pH 6-7.5) ###

```sql...
SELECT crop_type,
 ROUND(AVG(rainfall), 2) AS avg_rainfall,
 ROUND(AVG(temperature), 2) AS avg_temperature
FROM crop_data
WHERE ph BETWEEN 6 AND 7.5
GROUP BY crop_type;
```

### 5️⃣ Crop Rank in Each State by Production ###

```sql...
SELECT state_name, 
crop, 
SUM(production_in_tons) AS total_production,
 RANK() OVER (PARTITION BY state_name 
 ORDER BY SUM(production_in_tons) DESC) AS rank
FROM crop_data
GROUP BY state_name, crop;
```

### 6️⃣ Crops Grown in More Than One Crop Type ###

```sql...
SELECT crop, 
COUNT(DISTINCT crop_type) AS crop_type_count
FROM crop_data
GROUP BY crop
HAVING COUNT(DISTINCT crop_type) > 1;
```

### 7️⃣ Top 3 Crops by Average Yield per State ###

```sql...
WITH ranked AS (
  SELECT state_name, 
  crop,
  ROUND(AVG(yield_ton_per_hec), 4) AS average_yield,
   RANK() OVER (PARTITION BY state_name 
   ORDER BY AVG(yield_ton_per_hec) DESC) AS rank
  FROM crop_data
  GROUP BY state_name, crop
)
SELECT * FROM ranked
 WHERE rank <= 3;
```

### 8️⃣ Low-Yield Crops Grown in at Least 3 States ###

```sql
SELECT crop,
 ROUND(AVG(yield_ton_per_hec), 4) AS avg_yield,
  COUNT(DISTINCT state_name) AS number_of_states
FROM crop_data
GROUP BY crop
HAVING AVG(yield_ton_per_hec) < 1 AND COUNT(DISTINCT state_name) >= 3;
```

---

 ### ✅ What I Learned ###

Practical experience with large datasets
Usage of complex SQL clauses: WITH, RANK() OVER, HAVING, and GROUP BY Agricultural insights using real-world data Learned to apply complex SQL techniques like CTE, RANK(), and conditional filters on real data.

---

### 📊 Key Insights & Learnings ###

Gujarat leads in cotton production, confirming its status as India’s top cotton-producing state.

Rice and Wheat remain the most widely cultivated crops across multiple states with consistent high yield per hectare.

Maharashtra and Madhya Pradesh show strong performance in soybean and pulses production respectively.

Crops like Millets are grown in diverse agro-climatic zones but often have lower average yields.

Some crops like cotton and maize are cultivated across multiple crop types (Kharif, Rabi, Zaid).

States with pH between 6 to 7.5 show better average yield and rainfall balance, ideal for balanced crop growth.




---

🔗 Connect with Me

LinkedIn Profile
[LinkedIn –Girisudhan](https://www.linkedin.com/in/girisudhan)


