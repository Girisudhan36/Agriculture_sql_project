1.  Top 5 Crops by Average Yield (Across All States)

SELECT crop, 
       ROUND(avg(yield_ton_per_hec), 2) AS avg_yield
FROM crop_data
GROUP BY crop
ORDER BY avg_yield DESC
LIMIT 5;

2.  query to find the  N th most productive crop in each state
    based on total production_in_tons 

WITH ranked AS (
  SELECT  crop , 
   state_name ,
   sum(production_in_tons)as total_production,
   rank() over 
   (partition by state_name
    order by sum(production_in_tons)desc )as rank     
FROM crop_data
   group by crop , state_name)
SELECT *
FROM ranked
WHERE rank=2         

3. State with Highest Total Cotton Production
 
 SELECT state_name,
       SUM(production_in_tons) AS total_cotton_production
FROM crop_data
WHERE LOWER(crop) = 'cotton'
GROUP BY state_name
ORDER BY total_cotton_production DESC
LIMIT 1;

4. Average Rainfall & Temperature by Crop Type (for pH between 6 and 7.5)

SELECT crop_type,
       ROUND(AVG(rainfall), 2) AS avg_rainfall,
       ROUND(AVG(temperature), 2) AS avg_temperature
FROM crop_data
WHERE ph BETWEEN 6 AND 7.5
GROUP BY crop_type;

5. Rank Crops in Each State by Total Production

SELECT state_name, crop, 
       SUM(production_in_tons) AS total_production,
       RANK() OVER (PARTITION BY state_name ORDER BY SUM(production_in_tons) DESC) AS rank
FROM crop_data
GROUP BY state_name, crop;

6. Crops Grown in More Than One Crop Type

SELECT crop,
       COUNT(DISTINCT crop_type) AS number_of_crop_types
FROM crop_data
GROUP BY crop
HAVING COUNT(DISTINCT crop_type) > 1;

7.  Top 3 Crops by Average Yield in Each State

WITH ranked AS (
  SELECT state_name, crop,
         ROUND(AVG(yield_ton_per_hec), 4) AS average_yield,
         RANK() OVER (PARTITION BY state_name ORDER BY AVG(yield_ton_per_hec) DESC) AS rank
  FROM crop_data
  GROUP BY state_name, crop
)
SELECT * FROM ranked WHERE rank <= 3;

8.  Low-Yield Crops Grown in at Least 3 States

SELECT crop,
       ROUND(AVG(yield_ton_per_hec), 4) AS avg_yield,
       COUNT(DISTINCT state_name) AS number_of_states
FROM crop_data
GROUP BY crop
HAVING AVG(yield_ton_per_hec) < 1
   AND COUNT(DISTINCT state_name) >= 3;