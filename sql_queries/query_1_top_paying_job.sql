-- WHAT ARE THE TOP-10-PAYING DATA ANALYST REMOTE JOBS?

SELECT
    job_id,
    job_title,
    companies.name,
    salary_year_avg,
    job_location,
    job_schedule_type,
    job_posted_date :: DATE

FROM job_postings_fact

INNER JOIN company_dim as companies ON job_postings_fact.company_id = companies.company_id

WHERE 
    salary_year_avg IS NOT NULL AND 
    job_work_from_home = TRUE AND

job_title LIKE '%Data Scientist%'

ORDER BY salary_year_avg ASC
LIMIT 10
