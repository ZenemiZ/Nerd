-- WHAT ARE THE MOST OPTIMAL SKILLS TO LEARN? ( HIGH DEMAND AND HIGH SALARY)

--OPTION 1 WITH CTEs
WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.skill_id) AS number_of_jobs
    FROM skills_job_dim
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    LEFT JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE   
        job_postings_fact.job_location = 'Anywhere' AND
        job_postings_fact.job_title LIKE '%Data Analyst%' AND
        job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id, skills_dim.skills
    --ORDER BY number_of_jobs DESC
   -- LIMIT 100
), average_salary AS (
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) as media_salario
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings_fact.salary_year_avg IS NOT NULL AND job_postings_fact.job_work_from_home = true 
        AND
        job_postings_fact.job_title LIKE '%Data Analyst%'
    
    GROUP BY skills_dim.skills, skills_dim.skill_id
   -- ORDER BY media_salario DESC
    --LIMIT 100
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    number_of_jobs,
    media_salario
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE number_of_jobs > 10
ORDER BY media_salario DESC, number_of_jobs DESC
LIMIT 25


--OPTION 2, 1 QUERY
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS number_of_jobs,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) AS media_salario
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Scientist%'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING  COUNT(skills_job_dim.job_id) > 10
ORDER BY
     number_of_jobs DESC,
     media_salario DESC
LIMIT 25
