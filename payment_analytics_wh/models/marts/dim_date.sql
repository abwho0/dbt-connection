-- dim_dates.sql

WITH dates AS (
  SELECT
    day AS date_day,
    EXTRACT(YEAR FROM day) AS year,
    EXTRACT(MONTH FROM day) AS month,
    FORMAT_DATE('%Y-%m', day) AS year_month,
    -- FORMAT_DATE('%Y-%m-%d', day) AS full_date,
    EXTRACT(WEEK FROM day) AS week,
    CASE
      WHEN EXTRACT(DAY FROM day) <= 7 THEN 'First Week'
      WHEN EXTRACT(DAY FROM day) <= 14 THEN 'Second Week'
      WHEN EXTRACT(DAY FROM day) <= 21 THEN 'Third Week'
      ELSE 'Fourth Week'
    END AS week_of_month,
    FORMAT_DATE('%A', day) AS day_name
  FROM UNNEST(GENERATE_DATE_ARRAY('2015-01-01', CURRENT_DATE(), INTERVAL 1 DAY)) AS day
)

SELECT * FROM dates