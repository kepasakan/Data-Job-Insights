-- This SQL query identifies the top 5 most in-demand skills for each data role.
-- It joins job postings with the required skills to analyze skill demand.

WITH skill_demand AS (
    SELECT
        job_postings_fact.job_id AS id_job,
        skills_dim.skills AS skill,
        job_postings_fact.job_title_short AS job_role
    FROM
        job_postings_fact
        LEFT JOIN skills_job_dim
            ON job_postings_fact.job_id = skills_job_dim.job_id
        LEFT JOIN skills_dim
            ON skills_job_dim.skill_id = skills_dim.skill_id
)

SELECT
    skill,
    COUNT(id_job)
FROM
    skill_demand
WHERE
   job_role = 'Data Analyst'
--   job_role = 'Data Scientist'
--   job_role = 'Data Engineer'
--   job_role = 'Senior Data Analyst'
--   job_role = 'Senior Data Scientist'
--   job_role = 'Senior Data Engineer'
GROUP BY
    skill
ORDER BY
    COUNT(id_job) DESC
LIMIT 5;
