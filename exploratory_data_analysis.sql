-- Life Expectancy Project (Exploratory Data Analysis)

SELECT *
FROM life_expectancy;

-- Searching the min and max value for country and comparing the expectancy increase in 15 years
SELECT 
	Country, 
	MIN(`Life expectancy`) AS minimum_life_expectancy, 
	MAX(`Life expectancy`) AS maximum_life_expectancy
FROM life_expectancy
GROUP BY Country
ORDER BY Country;

-- We found data quality issues, like 0's for few countries
SELECT 
	Country, 
	MIN(`Life expectancy`) AS minimum_life_expectancy, 
	MAX(`Life expectancy`) AS maximum_life_expectancy,
    ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0 AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years;

-- Looking for the year with more Life expectancy in the dataset
SELECT Year, ROUND(AVG(`Life expectancy`), 2) AS avg_life_expectancy
FROM life_expectancy
WHERE `Life expectancy` <> 0
AND `Life expectancy` <> 0
GROUP BY Year
ORDER BY avg_life_expectancy DESC;