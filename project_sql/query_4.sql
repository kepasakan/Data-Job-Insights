-- This SQL query analyzes whether a degree is required for Data Analyst job postings.
-- It helps determine the importance of formal education in hiring decisions.

SELECT
    job_no_degree_mention,
    COUNT(*) AS no_of_job
FROM
    job_postings_fact
WHERE
   job_title_short = 'Data Analyst'
--   job_title_short = 'Data Scientist'
--   job_title_short = 'Data Engineer'
--   job_title_short = 'Senior Data Analyst'
--   job_title_short = 'Senior Data Scientist'
--   job_title_short = 'Senior Data Engineer'
GROUP BY
    job_no_degree_mention;
