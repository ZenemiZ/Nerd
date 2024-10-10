/* WITH remote_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE job_location = 'Anywhere'
)

SELECT
    skills_job_dim.skill_id,
    COUNT(remote_jobs.job_id) AS count_remote_jobs,
    skills_dim.skills AS skill_name
FROM skills_job_dim
INNER JOIN remote_jobs ON remote_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skills_job_dim.skill_id

SELECT
    count(skills_job_dim.skill_id),
    skills_dim.skills AS skill_name
FROM skills_job_dim
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY skill_name */




SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date :: date,
    salary_year_avg
FROM (
    SELECT  *
    FROM january_jobs

    UNION ALL

    SELECT  *
    FROM february_jobs
) AS Q1_jobs

WHERE Q1_jobs.salary_year_avg > 70000 AND   job_title_short = 'Data Analyst'
ORDER BY salary_year_avg ASC