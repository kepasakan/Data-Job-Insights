-- This SQL query calculates the proportion of job postings for each country in the dataset.
-- It provides insights into which countries contribute the most job listings.

SELECT 
    job_country, 
    COUNT(*) AS total_jobs, 
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2) AS proportion_percent
FROM 
    job_postings_fact
GROUP BY 
    job_country
ORDER BY 
    proportion_percent DESC;
