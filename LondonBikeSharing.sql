--Explore the Data
SELECT *
FROM LondonBike

--Row Number
SELECT 
	COUNT(*) AS row_count
FROM LondonBike

--Column Number
SELECT 
	COUNT(*) AS column_count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_catalog = 'LondonBikeSharing' -- the database
AND table_name = 'LondonBike'

--Unique weather codes and counts
SELECT 
	DISTINCT weather_code,
	COUNT(weather_code) AS weather_code_count
FROM LondonBike
GROUP BY weather_code
ORDER BY 1 DESC

--Unique season codes and counts
SELECT 
	DISTINCT season,
	COUNT(season) AS season_count
FROM LondonBike
GROUP BY season
ORDER BY 1 DESC

--Data Cleaning
--Changing the humidty values to percentage
BEGIN TRAN
UPDATE londonbike
SET hum = hum /100
SELECT
	hum
FROM londonbike
ROLLBACK TRAN

--Checking data types for weather_code and season columns
SELECT
	column_name,
	data_type
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	column_name = 'weather_code' OR
	column_name = 'season'

--Adding new columns for weather_code and season value
BEGIN TRAN
ALTER TABLE londonbike
ADD weather nvarchar(255),
	seasons nvarchar(255);
SELECT *
FROM londonbike
ROLLBACK TRAN

--Replacing number values in weather column to their actual names
SELECT 
	DISTINCT weather_code,
	COUNT(weather_code) AS weather_code_count
FROM LondonBike
GROUP BY weather_code
ORDER BY 1 DESC

UPDATE londonbike
SET weather = 'Clear'
WHERE weather_code = 1

UPDATE londonbike
SET weather = 'Scattered clouds'
WHERE weather_code = 2

UPDATE londonbike
SET weather = 'Broken clouds'
WHERE weather_code = 3

UPDATE londonbike
SET weather = 'Cloudy'
WHERE weather_code = 4

UPDATE londonbike
SET weather = 'Rain'
WHERE weather_code = 7

UPDATE londonbike
SET weather = 'Rain with thunderstorm'
WHERE weather_code = 10

UPDATE londonbike
SET weather = 'Snowfall'
WHERE weather_code = 26

SELECT 
	DISTINCT weather,
	COUNT(weather) AS weather_count
FROM LondonBike
GROUP BY weather
ORDER BY 2 DESC

--Replacing number values in season column to their actual names
SELECT 
	DISTINCT season,
	COUNT(weather_code) AS season_count
FROM LondonBike
GROUP BY season
ORDER BY 1 DESC

UPDATE londonbike
SET seasons = 'Spring'
WHERE season = 0

UPDATE londonbike
SET seasons = 'Summer'
WHERE season = 1

UPDATE londonbike
SET seasons = 'Autumn'
WHERE season = 2

UPDATE londonbike
SET seasons = 'Winter'
WHERE season = 3

SELECT 
	DISTINCT seasons,
	COUNT(seasons) AS season_count
FROM LondonBike
GROUP BY seasons
ORDER BY 2 DESC

--Deleting the old two columns
BEGIN TRAN
ALTER TABLE londonbike
DROP COLUMN 
	weather_code,
	season;
SELECT *
FROM londonbike
ROLLBACK TRAN










