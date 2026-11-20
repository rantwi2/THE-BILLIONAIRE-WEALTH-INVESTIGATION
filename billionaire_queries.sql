-- Billionaire Wealth Investigation (MySQL syntax)
-- Table: billionaires(serial_number, rank, name, age, country, networth_billion_US_dollars, industry)
-- Note: `rank` is a reserved word in MySQL 8, so it is wrapped in backticks if used.

-- Q1: 20 richest billionaires
SELECT * FROM billionaires ORDER BY networth_billion_US_dollars DESC LIMIT 20;

-- Q2: Five youngest billionaires
SELECT name, age, country, industry, networth_billion_US_dollars
FROM billionaires ORDER BY age ASC LIMIT 5;

-- Q3: Average age and average net worth
SELECT ROUND(AVG(age),1) AS avg_age, ROUND(AVG(networth_billion_US_dollars),2) AS avg_net_worth
FROM billionaires;

-- Q4: Five most represented countries
SELECT country, COUNT(*) AS billionaire_count FROM billionaires
GROUP BY country ORDER BY billionaire_count DESC LIMIT 5;

-- Q5: Combined net worth per country
SELECT country, ROUND(SUM(networth_billion_US_dollars),2) AS total_net_worth
FROM billionaires GROUP BY country ORDER BY total_net_worth DESC;

-- Q6: Five industries with the most billionaires
SELECT industry, COUNT(*) AS billionaire_count FROM billionaires
GROUP BY industry ORDER BY billionaire_count DESC LIMIT 5;

-- Q7: Countries with at least five billionaires
SELECT country, COUNT(*) AS billionaire_count FROM billionaires
GROUP BY country HAVING COUNT(*) >= 5 ORDER BY billionaire_count DESC;

-- Q8: Total wealth of billionaires younger than 50
SELECT ROUND(SUM(networth_billion_US_dollars),2) AS total_wealth_under_50, COUNT(*) AS people
FROM billionaires WHERE age < 50;

-- Q9: Billionaires above the overall average net worth
SELECT name, country, industry, networth_billion_US_dollars FROM billionaires
WHERE networth_billion_US_dollars > (SELECT AVG(networth_billion_US_dollars) FROM billionaires)
ORDER BY networth_billion_US_dollars DESC;

-- Q10: Industry with the highest average net worth
SELECT industry, ROUND(AVG(networth_billion_US_dollars),2) AS avg_net_worth, COUNT(*) AS people
FROM billionaires GROUP BY industry ORDER BY avg_net_worth DESC LIMIT 1;

-- Extra 1: Age group breakdown
SELECT CASE WHEN age < 40 THEN 'Under 40' WHEN age BETWEEN 40 AND 59 THEN '40-59'
            WHEN age BETWEEN 60 AND 79 THEN '60-79' ELSE '80+' END AS age_group,
       COUNT(*) AS total, ROUND(AVG(networth_billion_US_dollars),2) AS avg_net_worth
FROM billionaires GROUP BY age_group ORDER BY total DESC;

-- Extra 2: Share of total wealth held by the top 10
SELECT ROUND(SUM(networth_billion_US_dollars)*100.0/(SELECT SUM(networth_billion_US_dollars) FROM billionaires),2) AS top10_share_pct
FROM (SELECT networth_billion_US_dollars FROM billionaires ORDER BY networth_billion_US_dollars DESC LIMIT 10) t;
