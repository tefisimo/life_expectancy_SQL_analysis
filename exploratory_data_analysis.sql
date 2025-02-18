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

-- Searching correlation between life expectancy and GDP
SELECT 
	Country, 
	ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy, 
    ROUND(AVG(GDP), 1) AS GDP
FROM life_expectancy
GROUP BY Country
HAVING avg_life_expectancy > 0 AND GDP > 0
ORDER BY GDP DESC -- The highest avg life expectency is the country with the highest GDP
;

-- Comparing average life expectancy by country status
SELECT 
	Status,
    COUNT(DISTINCT Country) AS count_country_by_status,
    ROUND(AVG(`Life expectancy`), 1) AS avg_life_expectancy
FROM life_expectancy
GROUP BY Status;

-- adding the adult mortality rate per year
SELECT Country,
	Year,
    `Life expectancy`,
	`Adult Mortality`,
    SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS rolling_total
FROM life_expectancy;