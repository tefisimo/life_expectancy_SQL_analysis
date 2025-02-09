-- World Life Expectancy Project (Data Cleaning)

-- Table Overview
SELECT *
FROM life_expectancy;

-- Looking for duplicates with an artifitial key
SELECT Country, Year, CONCAT(Country, Year) AS ArtKey
FROM life_expectancy;

-- Counting duplicates 
SELECT 
	Country, 
	Year, 
    CONCAT(Country, Year) AS ArtKey, 
    COUNT(CONCAT(Country, Year)) AS Num_Duplicates
FROM life_expectancy
GROUP BY 1,2,3
HAVING Num_Duplicates > 1;

-- Finding Row_ID to proced to delete duplicates
SELECT *
FROM(
	SELECT 
		Row_ID,
		CONCAT(Country, Year),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM life_expectancy
    ) AS Row_table
WHERE Row_Num > 1;

-- Disable safe-updates option by:
SET SQL_SAFE_UPDATES = 0;

-- Deleting duplicates with a subquery
DELETE FROM life_expectancy
WHERE Row_ID IN (
	SELECT Row_ID
FROM(
	SELECT 
		Row_ID,
		CONCAT(Country, Year),
		ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM life_expectancy
    ) AS Row_table
WHERE Row_Num > 1
);

-- Looking for more inconsistencies 
SELECT *
FROM life_expectancy
WHERE Status = '';

-- Finding unique values in 'Status' camp
SELECT DISTINCT(Status) 
FROM life_expectancy
WHERE Status <> '';

-- Finding what countries has 'Status' = 'Developing'
SELECT DISTINCT(Country)
FROM life_expectancy
WHERE Status = 'Developing';

-- Filling blank status with a Self Join
UPDATE life_expectancy t1
JOIN life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status = 'Developing';

-- Reviewing if still exists a row with 'Status' = ''
SELECT *
FROM life_expectancy
WHERE Status = '';

-- Checking what status has 'United States of America' in others records
SELECT Country, Year, Status, `Life expectancy`
FROM life_expectancy
WHERE Country = 'United States of America';

-- Lets update the status for this record
UPDATE life_expectancy t1
JOIN life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status = 'Developed';

