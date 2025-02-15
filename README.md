# SQL_yash_project
Report: Analysis of World Economic Data Using SQL Queries

Introduction

The projects_q.sql file contains a series of SQL queries designed to analyze a dataset of world economic indicators. The dataset includes tables for GDP (Gross Domestic Product), government debt as a percentage of GDP, unemployment rates, population, and purchasing power parity (PPP). The queries aim to extract insights into economic performance, debt levels, unemployment, and population trends across various countries.

Summary of Queries

The SQL queries can be broadly categorized as follows:

1. Basic Selection and Ordering:

Top 10 Countries by GDP (2024): This query identifies the ten countries with the highest projected GDP in 2024.

Top 5 Least Populated Countries (2020): This query finds the five countries with the smallest populations in 2020, skipping the first two.

Countries Starting with "A" with Highest Unemployment (2010): This query filters countries whose names begin with "A" and then lists them in descending order of their unemployment rate in 2010.

Top 15 Countries by Projected PPP (2026): This query identifies the top 15 countries with the highest projected PPP in 2026.

Country with Highest Government Debt (Last 5 Years): This query identifies the country with the highest government debt percentage in 2021 and shows its debt percentage for the last 5 years.

2. Subqueries:

Countries with Above-Average Unemployment (2024): This query identifies countries with an unemployment rate in 2024 that is higher than the average unemployment rate across all countries in the dataset for that year.

Countries with Population Exceeding Russia's (2000): This query finds countries in 2024 with a population greater than Russia's population in 2000.

Second Highest GDP (2009): This query identifies the country with the second-highest GDP in 2009.

Count of Countries with Above-Average PPP (Letter A): This query counts the number of countries with a PPP in 2019 that is higher than the average PPP of countries whose names start with "A" in the same year.

Countries with Higher Than Avg Population Growth Rate Projection Next Year: This query identifies countries with a higher than average population growth rate from 2024 to 2025.

3. Joins:

GDP and Government Debt (LEFT JOIN): This query combines GDP data with government debt data, using a left join to include all countries from the GDP table, even if they don't have corresponding debt information.

GDP and Unemployment (FULL OUTER JOIN): This query attempts to simulate a full outer join (which is not directly supported in MySQL) to combine GDP and unemployment data. It uses a UNION of LEFT JOIN and RIGHT JOIN to achieve this.

GDP and Unemployment (INNER JOIN with GDP Threshold): This query combines GDP and unemployment data, but only for countries with a GDP in 2021 exceeding 1,000,000.

GDP and Unemployment (INNER JOIN): This query combines GDP and unemployment data for each country.

GDP, Government Debt, and Unemployment (LEFT JOINs): This query combines GDP data with both government debt and unemployment data, using left joins to include all countries from the GDP table.

Observations and Potential Improvements

Data Integrity: The accuracy and consistency of the results depend heavily on the quality of the underlying data. Missing values, inconsistencies in country names, and data errors can significantly impact the analysis.

Data Normalization: Consider normalizing the data (e.g., GDP per capita) to provide more meaningful comparisons between countries of different sizes.

Year Selection: Many queries focus on specific years (e.g., 2024, 2010, 2000). It would be beneficial to create queries that analyze trends over time, such as calculating the average GDP growth rate over a decade.

Handling Missing Data: The queries should explicitly handle missing data (e.g., using COALESCE or IFNULL) to avoid unexpected results. For example, if a country has a missing unemployment rate for a particular year, the query might exclude it or use a default value.

Clarity and Readability: Using aliases (e.g., g for GDP, d for government_debt_per) improves readability. Consistent formatting and indentation also enhance clarity.

Full Outer Join Simulation: The UNION approach to simulate a full outer join can be inefficient. Consider alternative strategies if performance is critical. Also, the UNION query is not selecting the country name from the same table in both parts of the union.

Data Type Consistency: Ensure that data types are consistent across tables to avoid implicit conversions and potential errors.

Missing Foreign Key Constraints: The unemployment_rate and ppp tables are missing foreign key constraints to the GDP table. Adding these constraints would improve data integrity.

Descriptive Column Names: While _1980, _1981, etc., are functional, more descriptive column names (e.g., gdp_1980, debt_percentage_1980) would improve readability.

Report on Specific Countries: The queries could be modified to focus on specific countries or regions of interest.

More Complex Analysis: Consider more advanced analytical techniques, such as calculating correlations between different economic indicators (e.g., GDP growth and unemployment rate).

Example Improved Queries

Here are a few examples of improved queries:

-- Top 10 Countries by GDP in 2024 (Handling Missing Data):
SELECT country, _2024
FROM GDP
WHERE _2024 IS NOT NULL  -- Exclude countries with missing GDP data
ORDER BY _2024 DESC
LIMIT 10;

-- Countries with Above-Average Unemployment in 2024 (Handling Missing Data):
SELECT country, _2024
FROM unemployment_rate
WHERE _2024 > (SELECT AVG(_2024) FROM unemployment_rate WHERE _2024 IS NOT NULL)
  AND _2024 IS NOT NULL; -- Exclude countries with missing unemployment data

-- GDP and Government Debt (LEFT JOIN with Handling for Missing Debt):
SELECT
    g.country,
    g._2021 AS GDP_2021,
    COALESCE(d._2021, 'No Data') AS Debt_Percentage_2021  -- Handle missing debt
FROM GDP g
LEFT JOIN government_debt_per d ON g.country = d.country_debt;
content_copy

SQL

Conclusion

The SQL queries in projects_q.sql provide a foundation for analyzing world economic data. By addressing the observations and implementing the suggested improvements, the queries can be made more robust, efficient, and insightful. Further analysis could involve exploring trends over time, calculating correlations between indicators, and focusing on specific regions or countries of interest.
