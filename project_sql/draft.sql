-- propportion of dataset for each country -----------------
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


-- job in data set ---------------------------------
SELECT
    job_title_short,
    count(*) AS no_of_job
FROM
    job_postings_fact
GROUP BY
    job_title_short
ORDER BY
    no_of_job DESC;


-- top 5 skill demand each role ---------------------
WITH skill_demand AS
(
    SELECT
        job_postings_fact.job_id AS id_job,
        skills_dim.skills AS skill,
        job_postings_fact.job_title_short AS job_role
    FROM
        job_postings_fact
        LEFT JOIN skills_job_dim
            ON  job_postings_fact.job_id = skills_job_dim.job_id
        LEFT JOIN skills_dim
            ON  skills_job_dim.skill_id = skills_dim.skill_id
)

SELECT
    skill,
    count(id_job)
FROM
    skill_demand
WHERE
   job_role = 'Data Analyst'
--    job_role = 'Data Scientist'
--    job_role = 'Data Engineer'
--    job_role = 'Senior Data Analyst'
--    job_role = 'Senior Data Scientist'
--    job_role = 'Senior Data Engineer'
GROUP BY
    skill
ORDER BY
    count(id_job) DESC
LIMIT 5;

-- degree certificate   -------------------

SELECT
    job_no_degree_mention,
    count(*) AS no_of_job
FROM
    job_postings_fact
WHERE
   job_title_short = 'Data Analyst'
--    job_title_short = 'Data Scientist'
--    job_title_short = 'Data Engineer'
--    job_title_short = 'Senior Data Analyst'
--    job_title_short = 'Senior Data Scientist'
--    job_title_short = 'Senior Data Engineer'
GROUP BY
    job_no_degree_mention;
