

-- ===============================================
-- ZOMATO MYSQL PROJECT
-- TABLE NAME : zomato_mysql
-- ===============================================

USE zomato_db;

-- =========================================================
-- BASIC QUERIES
-- =========================================================

-- Q1. View complete dataset
SELECT * FROM zomato_mysql;

-- Q2. View first 10 rows
SELECT * FROM zomato_mysql
LIMIT 10;

-- Q3. Total restaurants
SELECT COUNT(*) AS Total_Restaurants
FROM zomato_mysql;

-- Q4. Number of unique restaurant names
SELECT COUNT(DISTINCT name) AS Unique_Restaurants
FROM zomato_mysql;

-- Q5. Unique locations
SELECT COUNT(DISTINCT location) AS Total_Locations
FROM zomato_mysql;

-- Q6. Unique cuisines
SELECT COUNT(DISTINCT cuisines) AS Total_Cuisines
FROM zomato_mysql;

-- Q7. Unique restaurant types
SELECT COUNT(DISTINCT rest_type) AS Restaurant_Types
FROM zomato_mysql;

-- =========================================================
-- FILTERING
-- =========================================================

-- Q8. Restaurants with online order
SELECT *
FROM zomato_mysql
WHERE online_order='Yes';

-- Q9. Restaurants with table booking
SELECT *
FROM zomato_mysql
WHERE book_table='Yes';

-- Q10. Restaurants having rating above 4
SELECT name,rate
FROM zomato_mysql
WHERE rate>4;

-- Q11. Restaurants costing less than 500
SELECT name,approx_cost
FROM zomato_mysql
WHERE approx_cost<500;

-- Q12. Restaurants with more than 1000 votes
SELECT name,votes
FROM zomato_mysql
WHERE votes>1000;

-- =========================================================
-- SORTING
-- =========================================================

-- Q13. Highest rated restaurants
SELECT name,rate
FROM zomato_mysql
ORDER BY rate DESC
LIMIT 10;

-- Q14. Most voted restaurants
SELECT name,votes
FROM zomato_mysql
ORDER BY votes DESC
LIMIT 10;

-- Q15. Most expensive restaurants
SELECT name,approx_cost
FROM zomato_mysql
ORDER BY approx_cost DESC
LIMIT 10;

-- =========================================================
-- AGGREGATE FUNCTIONS
-- =========================================================

-- Q16. Average rating
SELECT ROUND(AVG(rate),2) AS Average_Rating
FROM zomato_mysql;

-- Q17. Maximum rating
SELECT MAX(rate) AS Highest_Rating
FROM zomato_mysql;

-- Q18. Minimum rating
SELECT MIN(rate) AS Lowest_Rating
FROM zomato_mysql;

-- Q19. Average cost
SELECT ROUND(AVG(approx_cost),2) AS Average_Cost
FROM zomato_mysql;

-- Q20. Total votes
SELECT SUM(votes) AS Total_Votes
FROM zomato_mysql;

-- =========================================================
-- GROUP BY
-- =========================================================

-- Q21. Restaurants in each location
SELECT location,
COUNT(*) AS Restaurants
FROM zomato_mysql
GROUP BY location
ORDER BY Restaurants DESC;

-- Q22. Average rating by location
SELECT location,
ROUND(AVG(rate),2) AS Avg_Rating
FROM zomato_mysql
GROUP BY location
ORDER BY Avg_Rating DESC;

-- Q23. Average cost by location
SELECT location,
ROUND(AVG(approx_cost),2) AS Avg_Cost
FROM zomato_mysql
GROUP BY location
ORDER BY Avg_Cost DESC;

-- Q24. Restaurant count by cuisine
SELECT cuisines,
COUNT(*) AS Total
FROM zomato_mysql
GROUP BY cuisines
ORDER BY Total DESC
LIMIT 10;

-- Q25. Restaurant count by type
SELECT rest_type,
COUNT(*) AS Total
FROM zomato_mysql
GROUP BY rest_type
ORDER BY Total DESC;

-- =========================================================
-- HAVING
-- =========================================================

-- Q26. Locations having more than 100 restaurants
SELECT location,
COUNT(*) AS Total
FROM zomato_mysql
GROUP BY location
HAVING COUNT(*)>100
ORDER BY Total DESC;

-- Q27. Locations with average rating above 4
SELECT location,
ROUND(AVG(rate),2) AS Avg_Rating
FROM zomato_mysql
GROUP BY location
HAVING AVG(rate)>4;

-- =========================================================
-- CASE
-- =========================================================

-- Q28. Rating category
SELECT name,
rate,
CASE
WHEN rate>=4.5 THEN 'Excellent'
WHEN rate>=4 THEN 'Very Good'
WHEN rate>=3 THEN 'Good'
ELSE 'Average'
END AS Rating_Category
FROM zomato_mysql;

-- Q29. Cost category
SELECT name,
approx_cost,
CASE
WHEN approx_cost<500 THEN 'Budget'
WHEN approx_cost<=1000 THEN 'Moderate'
ELSE 'Premium'
END AS Cost_Category
FROM zomato_mysql;

-- =========================================================
-- STRING FUNCTIONS
-- =========================================================

-- Q30. Restaurant names in uppercase
SELECT UPPER(name)
FROM zomato_mysql;

-- Q31. Restaurant names starting with B
SELECT name
FROM zomato_mysql
WHERE name LIKE 'B%';

-- Q32. Restaurant names ending with Cafe
SELECT name
FROM zomato_mysql
WHERE name LIKE '%Cafe';

-- =========================================================
-- SUBQUERIES
-- =========================================================

-- Q33. Restaurants above average rating
SELECT name,rate
FROM zomato_mysql
WHERE rate>(
SELECT AVG(rate)
FROM zomato_mysql);

-- Q34. Restaurants above average cost
SELECT name,approx_cost
FROM zomato_mysql
WHERE approx_cost>(
SELECT AVG(approx_cost)
FROM zomato_mysql);

-- =========================================================
-- TOP ANALYSIS
-- =========================================================

-- Q35. Top 10 highest rated locations
SELECT location,
ROUND(AVG(rate),2) Avg_Rating
FROM zomato_mysql
GROUP BY location
ORDER BY Avg_Rating DESC
LIMIT 10;

-- Q36. Top 10 expensive locations
SELECT location,
ROUND(AVG(approx_cost),2) Avg_Cost
FROM zomato_mysql
GROUP BY location
ORDER BY Avg_Cost DESC
LIMIT 10;

-- Q37. Top locations by votes
SELECT location,
SUM(votes) Total_Votes
FROM zomato_mysql
GROUP BY location
ORDER BY Total_Votes DESC
LIMIT 10;

-- =========================================================
-- WINDOW FUNCTIONS
-- =========================================================

-- Q38.
SELECT name,
rate,
RANK() OVER(ORDER BY rate DESC) Ranking
FROM zomato_mysql;

-- Q39.
SELECT name,
votes,
DENSE_RANK() OVER(ORDER BY votes DESC) Ranking
FROM zomato_mysql;

-- Q40.
SELECT name,
approx_cost,
ROW_NUMBER() OVER(ORDER BY approx_cost DESC) RowNum
FROM zomato_mysql;

-- =========================================================
-- CTE
-- =========================================================

-- Q41.
WITH AvgLocation AS
(
SELECT location,
AVG(rate) AvgRate
FROM zomato_mysql
GROUP BY location
)
SELECT *
FROM AvgLocation
ORDER BY AvgRate DESC;

-- =========================================================
-- BUSINESS INSIGHTS
-- =========================================================

-- Q42. Best rated cuisine
SELECT cuisines,
ROUND(AVG(rate),2) Avg_Rating
FROM zomato_mysql
GROUP BY cuisines
ORDER BY Avg_Rating DESC
LIMIT 10;

-- Q43. Best rated restaurant type
SELECT rest_type,
ROUND(AVG(rate),2) Avg_Rating
FROM zomato_mysql
GROUP BY rest_type
ORDER BY Avg_Rating DESC;

-- Q44. Average votes by restaurant type
SELECT rest_type,
ROUND(AVG(votes),0) Avg_Votes
FROM zomato_mysql
GROUP BY rest_type
ORDER BY Avg_Votes DESC;

-- Q45. Locations with maximum votes
SELECT location,
SUM(votes) Total_Votes
FROM zomato_mysql
GROUP BY location
ORDER BY Total_Votes DESC
LIMIT 10;

-- Q46. Restaurant types offering online orders
SELECT rest_type,
COUNT(*) Total
FROM zomato_mysql
WHERE online_order='Yes'
GROUP BY rest_type
ORDER BY Total DESC;

-- Q47. Restaurant types offering table booking
SELECT rest_type,
COUNT(*) Total
FROM zomato_mysql
WHERE book_table='Yes'
GROUP BY rest_type
ORDER BY Total DESC;

-- Q48. Restaurants with highest votes and rating
SELECT name,
rate,
votes
FROM zomato_mysql
ORDER BY rate DESC,votes DESC
LIMIT 20;

-- Q49. Costliest restaurants with rating above 4
SELECT name,
rate,
approx_cost
FROM zomato_mysql
WHERE rate>4
ORDER BY approx_cost DESC
LIMIT 20;

-- Q50. Locations having highest average cost and rating
SELECT location,
ROUND(AVG(rate),2) Avg_Rating,
ROUND(AVG(approx_cost),2) Avg_Cost
FROM zomato_mysql
GROUP BY location
ORDER BY Avg_Rating DESC,Avg_Cost DESC;

-- =========================================================
-- ADVANCED
-- =========================================================

-- Q51.
SELECT listed_city,
COUNT(*) Restaurants
FROM zomato_mysql
GROUP BY listed_city
ORDER BY Restaurants DESC;

-- Q52.
SELECT listed_type,
COUNT(*) Restaurants
FROM zomato_mysql
GROUP BY listed_type
ORDER BY Restaurants DESC;

-- Q53.
SELECT listed_city,
ROUND(AVG(rate),2) Avg_Rating
FROM zomato_mysql
GROUP BY listed_city
ORDER BY Avg_Rating DESC;

-- Q54.
SELECT listed_type,
ROUND(AVG(rate),2) Avg_Rating
FROM zomato_mysql
GROUP BY listed_type
ORDER BY Avg_Rating DESC;

-- Q55.
SELECT location,
COUNT(DISTINCT cuisines) Total_Cuisines
FROM zomato_mysql
GROUP BY location
ORDER BY Total_Cuisines DESC;

-- =========================================================
-- END OF PROJECT
-- =========================================================