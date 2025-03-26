-- This SQL query retrieves the number of job postings for each job title.
-- It helps identify which data roles are most in demand.

SELECT
    job_title_short,
    COUNT(*) AS no_of_job
FROM
    job_postings_fact
GROUP BY
    job_title_short
ORDER BY
    no_of_job DESC;
