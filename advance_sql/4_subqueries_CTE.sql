SELECT *
FROM (  -- SubQuery start here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS january_job --SubQuery end here


-- -----------------------------------

-- need to start at above (early)
WITH january_job AS
( -- CTE definition start here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FORM job_posted_date) = 1
) -- CTE definiton ends here

SELECT *
FROM january_job;

-- ------------------------------

--average calculation
SELECT
    AVG(salary_year_avg)
FROM
    job_postings_fact



-- no post & total salary each company
SELECT
    job_postings_fact.company_id,
    count(job_postings_fact.job_id) AS no_of_job,
    SUM(job_postings_fact.salary_year_avg) AS salary_total,
    company_dim.name AS name_company
FROM
    job_postings_fact
    INNER JOIN
        company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    job_postings_fact.company_id, company_dim.name
ORDER BY
    job_postings_fact.company_id


-- MY SOLUTION
SELECT 
    name_company
FROM
    (
    SELECT
        job_postings_fact.company_id,
        count(job_postings_fact.job_id) AS no_of_job,
        SUM(job_postings_fact.salary_year_avg) AS salary_total,
        company_dim.name AS name_company
    FROM
        job_postings_fact
        INNER JOIN
            company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        job_postings_fact.company_id, company_dim.name
    ORDER BY
        job_postings_fact.company_id
    ) AS best_company
WHERE
    salary_total / no_of_job > 
    (
        SELECT
            AVG(salary_year_avg)
        FROM
            job_postings_fact
    )

-- --------------------------------------------------------

-- ANSWER SOULTION

SELECT 
    company_dim.name
FROM 
    company_dim
INNER JOIN 
    (
        -- Subquery to calculate average salary per company
        SELECT 
            company_id, 
            AVG(salary_year_avg) AS avg_salary
        FROM 
            job_postings_fact
        GROUP BY 
            company_id
    )   AS company_salaries 
        ON 
            company_dim.company_id = company_salaries.company_id
-- Filter for companies with an average salary greater than the overall average
WHERE 
    company_salaries.avg_salary > 
    (
        -- Subquery to calculate the overall average salary
        SELECT AVG(salary_year_avg)
        FROM job_postings_fact
    );


-- CTE PART

-- need to start at above (early)
WITH january_job AS
( -- CTE definition start here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FORM job_posted_date) = 1
) -- CTE definiton ends here

SELECT *
FROM january_job;

-- ------------------------

-- separate company id
WITH skill_unique_company AS
(
    SELECT
        job_postings_fact.company_id AS id_of_company, 
        COUNT(DISTINCT skills_job_dim.skill_id) AS unique_skill
    FROM
        job_postings_fact
        LEFT JOIN
            skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY
        job_postings_fact.company_id
),

-- calculate max salary each company
maximum_salary AS
(
    SELECT
        company_id,
        MAX(salary_year_avg) AS highest_salary
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name,
    skill_unique_company.unique_skill,
    maximum_salary.highest_salary
FROM
    skill_unique_company
    LEFT JOIN
        maximum_salary
    ON skill_unique_company.id_of_company = maximum_salary.company_id
    LEFT JOIN
        company_dim
    ON skill_unique_company.id_of_company = company_dim.company_id
ORDER BY
    company_dim.name;


-- schema answerr

-- Counts the distinct skills required for each company's job posting
WITH required_skills AS (
  SELECT
    companies.company_id,
    COUNT(DISTINCT skills_to_job.skill_id) AS unique_skills_required
  FROM
    company_dim AS companies 
  LEFT JOIN job_postings_fact as job_postings ON companies.company_id = job_postings.company_id
  LEFT JOIN skills_job_dim as skills_to_job ON job_postings.job_id = skills_to_job.job_id
  GROUP BY
    companies.company_id
),
-- Gets the highest average yearly salary from the jobs that require at least one skills 
max_salary AS (
  SELECT
    job_postings.company_id,
    MAX(job_postings.salary_year_avg) AS highest_average_salary
  FROM
    job_postings_fact AS job_postings
  WHERE
    job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
  GROUP BY
    job_postings.company_id
)
-- Joins 2 CTEs with table to get the query
SELECT
  companies.name,
  required_skills.unique_skills_required as unique_skills_required, --handle companies w/o any skills required
  max_salary.highest_average_salary
FROM
  company_dim AS companies
LEFT JOIN required_skills ON companies.company_id = required_skills.company_id
LEFT JOIN max_salary ON companies.company_id = max_salary.company_id
ORDER BY
	companies.name;