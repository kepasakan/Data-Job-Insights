--HARDEST QUESTION

SELECT
    company_dim.name AS company_name,
    COUNT(job_post.job_id) AS job_count
FROM
    job_postings_fact AS job_post
LEFT JOIN
    company_dim
    ON job_post.company_id = company_dim.company_id
WHERE
    job_post.job_health_insurance = TRUE
    AND
    (
            job_post.job_posted_date::DATE >= '2023-04-01'
        AND
            job_post.job_posted_date::DATE <= '2023-06-30'
    ) --It can be EXTRACT(QUARTER FROM job_post.job_posted_date) = 2
GROUP BY
    company_dim.name
ORDER BY 
    job_count DESC
LIMIT 100