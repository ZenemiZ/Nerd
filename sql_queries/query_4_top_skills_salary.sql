/* WHAT ARE THE TOP SKILLS BASED ON SALARY? 
-Nos fijaremos en el salario
-Da igual ubicación
*/

SELECT
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),2) as media_salario
FROM job_postings_fact
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_postings_fact.salary_year_avg IS NOT NULL AND job_postings_fact.job_work_from_home = true 
    AND
    job_postings_fact.job_title LIKE '%Data Analyst%'
    /*
    (skills_dim.skills = 'python' OR 
    skills_dim.skills = 'sql' OR 
    skills_dim.skills = 'Tableau') */
GROUP BY skills_dim.skills
 
ORDER BY media_salario DESC