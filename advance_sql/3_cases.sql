--JANUARY
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--FEBRUARY
CREATE TABLE february_jobs AS
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--MARCH
CREATE TABLE march_jobs AS
    SELECT * 
    FROM job_postings_fact 
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


-- --------------------------------------------------------------

SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN job_title LIKE '%Senior%' THEN 'Senior'
        WHEN job_title LIKE '%Manager%' THEN 'Manager'
        WHEN job_title LIKE '%Lead%' THEN 'Leader'
        WHEN job_title LIKE '%Junior%' THEN 'Junior'
        WHEN job_title LIKE '%Entry%' THEN 'Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home = TRUE THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM
    job_postings_fact
WHERE
        salary_year_avg IS NOT NULL
ORDER BY
    job_id;