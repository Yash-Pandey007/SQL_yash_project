#NORMAL

# name the list of top 10  country by GDP this year
select country , _2024 from GDP order by _2024 desc  limit 10;

#list of top 5 least populated country in 2020
select country,_2020 from population order by _2020 asc limit 5 offset 2;

#list of country starting with name "a" most unemployment rate in year 2010
select country,_2010 from unemployment_rate where country like "a%"order by _2010 desc;

#contry with most projected PPP in 2026 top 15
select country,_2026 from ppp order by _2026 desc limit 15;

#country with most goverment debt most debt per gdp for last 5 years
select country_debt,_2019,_2020,_2021,_2022,_2023,_2024 from
 government_debt_per order by _2021 desc limit 1;
 
 
 #SUB QUERYS
 # country with more unemployment rate than avg of world unemployement this year
 select country,_2024 from unemployment_rate
 where _2024 > (select avg(_2024) from unemployment_rate);
 
 # list countries this year with population more than russia in 2000
select country,_2024 from population 
where _2024 > (select _2000 from population where country = "Russian Federation") order by _2024;

#contry whith second highest gdp in year 2009
select country, _2009 from GDP where _2009 <(select max(_2009) from GDP )order by _2009 desc limit 1;

# count contry with more than avg PPP of contrys whith letter A in 2019
select count(country) from PPP where _2019 > (SELECT avg(_2019)
 from PPP where country like "a%") order by _2019 desc ;
 
#country with higher than avg poulation growth rate Projection next year
SELECT country, (_2025/_2024) as growth_rate_next_year from population where 
(_2025/_2024)>(SELECT avg(_2025/_2024)from population) order by growth_rate_next_year desc;



# joins 

#This query retrieves all countries from GDP and their corresponding government
# debt percentages, even if some countries do not have debt data.
SELECT g.country, g._2021 AS GDP_2021, d._2021 AS Debt_Percentage_2021
FROM GDP g
LEFT JOIN government_debt_per d ON g.country = d.country_debt;

-- This simulates a FULL OUTER JOIN between GDP and unemployment rates.
SELECT g.country, g._2021 AS GDP_2021, u._2021 AS Unemployment_Rate_2021
FROM GDP g
LEFT JOIN unemployment_rate u ON g.country = u.country
UNION
SELECT g.country, g._2021 AS GDP_2021, u._2021 AS Unemployment_Rate_2021
FROM GDP g
RIGHT JOIN unemployment_rate u ON g.country = u.country;

-- This query retrieves countries with GDP over a certain threshold alongside their unemployment rate.
SELECT g.country, g._2021 AS GDP_2021, u._2021 AS Unemployment_Rate_2021
FROM GDP g
INNER JOIN unemployment_rate u ON g.country = u.country
WHERE g._2021 > 1000000;

-- This query retrieves GDP and unemployment rate for each country.
SELECT g.country, g._2021 AS GDP_2021, u._2021 AS Unemployment_Rate_2021
FROM GDP g
INNER JOIN unemployment_rate u ON g.country = u.country;
-- This query retrieves GDP, government debt percentage, and unemployment rate for each country.
SELECT g.country, g._2021 AS GDP_2021, d._2021 AS Debt_Percentage_2021, u._2021 AS Unemployment_Rate_2021
FROM GDP g
LEFT JOIN government_debt_per d ON g.country = d.country_debt
LEFT JOIN unemployment_rate u ON g.country = u.country;















