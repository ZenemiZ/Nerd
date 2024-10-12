-- WHAT ARE THE SKILLS REQUIRED FOR THOSE TOP-PAYING REMOTE DATA JOBS?

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        companies.name as company_name,
        salary_year_avg

    FROM job_postings_fact

    INNER JOIN company_dim as companies ON job_postings_fact.company_id = companies.company_id

    WHERE 
        salary_year_avg IS NOT NULL AND 
        job_work_from_home = TRUE AND

    job_title LIKE '%Data Analyst%'

    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    skills_job_dim.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_job_dim.skill_id,
    skills_dim.skills,
    company_name
FROM skills_job_dim
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
RIGHT JOIN top_paying_jobs ON skills_job_dim.job_id = top_paying_jobs.job_id

