SELECT
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS number_of_jobs
FROM skills_job_dim
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
LEFT JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE   
    job_postings_fact.job_location = 'Anywhere' AND
    job_postings_fact.job_title LIKE '%Data Analyst%'
GROUP BY skills_job_dim.skill_id, skills_dim.skills
ORDER BY number_of_jobs DESC
LIMIT 100
