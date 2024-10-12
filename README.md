# Introduction
The goal is to get insights to help me work smarter with my new job position search. Example questions: what are the most popular skills in the market? wich ones are better payed?...
SQL queries: [sql_queries folder](/sql_queries/)
# Tools
- SQL (PostgreSQL)
- Visual Code
- Git/Github
# Analysis
### 1. Identify highest-paying roles
```sql
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
```
![Top Paying Roles Graph](assets\arbol rosa.jpg)

### Conclusions:
-
-
-
