# 📊 **SQL Job Market Analysis: Uncovering In-Demand Skills & Trends in Data Roles**

## **Introduction**


Welcome to my SQL Portfolio Project, where I delve into the data job market with a focus on data analyst roles. This project is a personal exploration into identifying the top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.

Check out my SQL queries here: [project_sql](project_sql)

## 📖 Table of Contents  
- [Introduction](#introduction)  
- [Background](#background)  
- [Tools I Used](#tools-i-used)  
- [The Analysis](#the-analysis)  
- [What I Learned](#what-i-learned)  
- [Conclusion](#conclusion)  

## **Background**
The motivation behind this project comes from my desire to understand the job market for data roles more effectively. I wanted to identify which skills are most in demand and whether a degree is still a crucial requirement. By analyzing real job postings, I aim to gain insights that can help job seekers focus on the right skills and qualifications.

The data for this analysis comes from [Insert Data Source], which includes job postings with details on job titles, required skills, and degree preferences.

The key questions I wanted to answer through my SQL queries are:

1. What are the most in-demand job roles in data-related fields?
2. What skills are required for these roles?
3. Which skills are most frequently listed across job postings?
4. How important is a degree for securing a data-related job?

This analysis provides valuable insights for job seekers, recruiters, and industry professionals looking to stay ahead in the evolving job market.

## **Tools I Used**

In this project, I utilized a variety of tools to conduct my analysis:

- **SQL (Structured Query Language):** Used to query the database, extract insights, and answer key questions about job market trends.
- **PostgreSQL:** Served as the database management system for storing and analyzing job posting data.
- **Visual Studio Code:** Used as my SQL development environment for writing and executing queries efficiently.

## **The Analysis**

### **1. Dataset Overview: Job Postings by Country**

To understand the origin of this dataset, we first analyze the proportion of job postings by country. This helps identify where the majority of job postings come from and provides insight into the geographical distribution of hiring trends.

SQL Query:
```sql
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
```
### Explanation:

- Counts the total number of job postings per country.
- Calculates the percentage of job postings for each country relative to the entire dataset.
- Groups the data by country and sorts it in descending order based on the proportion of job postings.

The results will help determine which countries contribute the most job postings in this dataset.

### **Findings:**

- The United States dominates the dataset, contributing over 26% of total job postings. This suggests a strong demand for data professionals in the U.S.
- India, United Kingdom, France, and Germany follow, each having a significant share of job postings. These countries are key players in the global job market for data-related roles.
- Countries like Spain, Singapore, and Sudan also show notable hiring activity, highlighting potential opportunities outside traditional job markets.
- This geographical distribution suggests that the dataset primarily reflects job trends in North America and Europe, with emerging markets also contributing to job postings.



![proportion of country](asset\1_country_proportion.png)
*A bar chart was created to display the top 10 countries with the highest proportion of job postings.*

---

### **2. Job Role Distribution in the Dataset**

To analyze which job roles are most prevalent in the dataset, we look at the proportion of job postings by job title.

SQL Query:

```sql
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
```
### Explanation:

- Counts the number of job postings for each job title in the dataset.
- Groups the data by job_title_short to aggregate job postings per role.
- Orders the results in descending order to highlight the most common job roles.

#### **Top 10 Job Titles by Number of Postings**  
| Job Title                  | Number of Job Postings |
|----------------------------|------------------------|
| Data Analyst               | 196,593                |
| Data Engineer              | 186,679                |
| Data Scientist             | 172,726                |
| Business Analyst           | 49,160                 |
| Software Engineer          | 45,019                 |
| Senior Data Engineer       | 44,692                 |
| Senior Data Scientist      | 37,076                 |
| Senior Data Analyst        | 29,289                 |
| Machine Learning Engineer  | 14,106                 |
| Cloud Engineer             | 12,346                 |



#### **Proportion of Key Data Roles in the Dataset**  

To focus on the three main roles (Data Analyst, Data Scientist, Data Engineer) along with their senior positions, we analyze their relative proportions.

| Job Title                  | Number of Job Postings | Proportion of Total (%) |
|----------------------------|------------------------|-------------------------|
| Data Analyst               | 196,593                | 29.47%                  |
| Senior Data Analyst        | 29,289                 | 4.39%                   |
| Data Engineer              | 186,679                | 27.99%                  |
| Senior Data Engineer       | 44,692                 | 6.70%                   |
| Data Scientist             | 172,726                | 25.89%                  |
| Senior Data Scientist      | 37,076                 | 5.56%                   |

#### **Findings:**  
- **Data Analyst** roles make up the largest proportion of job postings among the three roles.  
- **Senior positions** (Senior Data Analyst, Senior Data Engineer, Senior Data Scientist) have significantly lower numbers, indicating that most job postings cater to **mid and entry-level professionals**.  
- The demand for **Data Engineers and Data Scientists** is also high, with engineering-focused roles appearing slightly more frequently than pure data science positions.  

These proportions provide insight into hiring trends, showing that while **senior-level roles exist, the majority of hiring is focused on entry and mid-level data professionals**.  

---

### **3. Top 5 In-Demand Skills for Data Analysts**

To identify the most sought-after skills for Data Analyst roles, we analyze the job postings to determine which technical competencies are most frequently mentioned.

SQL Query:

```sql
WITH skill_demand AS
(
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
    COUNT(id_job) AS demand_count
FROM
    skill_demand
WHERE
    job_role = 'Data Analyst'
GROUP BY
    skill
ORDER BY
    demand_count DESC
LIMIT 5;
```

#### **Top 5 Skills for Data Analysts**  

| Skill     | Number of Job Postings Mentioning Skill |
|-----------|-------------------------------------|
| SQL       | 92,628                              |
| Excel     | 67,031                              |
| Python    | 57,326                              |
| Tableau   | 46,554                              |
| Power BI  | 39,468                              |


#### **Findings:**  

- SQL is the most in-demand skill for Data Analysts, appearing in over 92,000 job postings.
- Excel remains a fundamental tool, reinforcing its importance despite the rise of modern BI tools.
- Python is widely used, reflecting the increasing need for programming skills in data analysis.
- Tableau and Power BI are the top data visualization tools, indicating a strong demand for reporting and dashboarding expertise.

These findings highlight the essential skills that aspiring Data Analysts should focus on to maximize their employability.

---

### **4. Degree Requirement for Data Analysts**

To analyze whether a degree is required for **Data Analyst** roles, we examine job postings mentioning degree requirements.

#### **SQL Query:**
```sql
SELECT
    job_no_degree_mention,
    COUNT(*) AS no_of_job
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_no_degree_mention;
```

#### **Degree Requirement for Data Analyst Roles**
| Degree Mentioned? | Number of Job Postings |
|-------------------|------------------------|
| Yes (Degree Required) | 120,536 |
| No (Degree Not Mentioned) | 76,057 |

#### **Findings:**
- **Approximately 39%** of Data Analyst job postings **do not explicitly require a degree**, suggesting that many employers prioritize skills over formal education.
- The majority (**61%**) still mention a degree requirement, indicating that formal education remains relevant but is not always a strict necessity.

These insights highlight the importance of skill-based hiring trends in the data industry.

---

### **Top 5 Skills for Each Data Role** 

### *Data Analyst*  
| Entry/Mid-Level | Senior-Level |
|----------------|--------------|
| SQL           | SQL          |
| Excel         | Python       |
| Python        | Tableau      |
| Tableau       | Excel        |
| Power BI      | R            |

### *Data Scientist*  
| Entry/Mid-Level | Senior-Level |
|----------------|--------------|
| Python        | Python       |
| SQL          | SQL          |
| R            | R            |
| SAS          | AWS          |
| Tableau      | Spark        |

### *Data Engineer* 
| Entry/Mid-Level | Senior-Level |
|----------------|--------------|
| SQL           | Python       |
| Python        | SQL          |
| AWS          | AWS          |
| Azure        | Azure        |
| Spark        | Spark        |

---

### **Degree Requirement Percentage for Each Data Role**

| Role                     | Degree Required (%) | No Degree Required (%) |
|--------------------------|--------------------|------------------------|
| **Data Analyst**         | 61.3%              | 38.7%                  |
| **Data Scientist**       | 94.0%              | 6.0%                   |
| **Data Engineer**        | 56.5%              | 43.5%                  |
| **Senior Data Analyst**  | 63.8%              | 36.2%                  |
| **Senior Data Scientist**| 94.2%              | 5.8%                   |
| **Senior Data Engineer** | 56.7%              | 43.3%                  |

#### **Findings:**  
- Data Scientists *(both entry and senior level)* have the highest degree requirement **(~94%)**.
- Data Engineers have the lowest degree requirement, with **~43%** of jobs not requiring a degree.
- Data Analysts fall in between, with **~38%** of jobs open to candidates without a degree.

## **What I Learned**


Throughout this project, I refined several SQL skills and analytical techniques:  

- **Proportional Data Analysis**: Used **aggregate functions (`COUNT()`, `ROUND()`)** to calculate the percentage of job postings per country, providing insights into job market distribution.  
- **Job Market Breakdown**: Applied **`GROUP BY`** and **`ORDER BY`** to count and rank job postings based on their titles, identifying the most in-demand roles.  
- **Skill Demand Analysis**: Utilized **CTEs (`WITH` clauses)** and **JOIN operations** to extract the most sought-after skills for each data role, enhancing understanding of industry needs.  
- **Filtering & Conditional Queries**: Implemented **`WHERE` clauses** to analyze job requirements dynamically for different roles without altering the core query structure.  


### **Insight :**  

Throughout this project, I gained valuable insights into data roles, industry requirements, and hiring trends:  

- **Most In-Demand Data Roles**: **Data analysts and data engineers** have a higher volume of job postings compared to data scientists, indicating a broader demand for these roles in the industry.  
- **Degree vs. No Degree Insights**: While **data science roles** still heavily favor candidates with degrees (~94%), **data analyst and data engineer roles** offer more flexibility, with around **40% of job postings** not requiring a degree.  
- **Top Skill Requirements Per Role**: **SQL, and Python** dominate the entry/mid-level job market, while senior-level roles shift toward **big data technologies, leadership, and cloud computing**.  
- **Data-Driven Career Planning**: Leveraging job market data can help professionals tailor their learning paths, ensuring alignment with industry demands for both technical and business-oriented competencies.  

## Conclusion

This project provided a data-driven perspective on the job market for data professionals, offering key insights into hiring trends, skill requirements, and the importance of degrees.  

- **Entry & Mid-Level Roles Dominate**: The majority of job postings cater to **entry and mid-level positions**, with fewer opportunities for senior roles. This suggests that breaking into the field is more accessible, but career growth requires continuous upskilling.  
- **Degree vs. Skills Debate**: While a **degree is almost mandatory for data scientists (~94%)**, **data analysts and engineers** have more opportunities without formal degrees (~40% of postings don’t require one). This highlights the growing importance of skills over traditional education.  
- **Most Demanded Skills**: **SQL and Python** are the top technical skills employers seek, making them essential for anyone pursuing a career in data. These skills are consistently mentioned across job postings and are crucial for both entry and advanced roles.  
- **Strategic Career Planning**: Understanding these hiring patterns allows job seekers to align their skill development with **real-world industry demands**, making data-driven career decisions.  

By leveraging SQL for analysis, this project demonstrated how **structured job market data can provide actionable insights**, helping professionals navigate the competitive landscape of data roles.  
