/*
Question: What are the most in-demand skills for data analysts?

- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/

WITH paying_job_skills AS (
    SELECT 
        job_postings.*, 
        skills
    FROM job_postings_fact AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    ORDER BY salary_year_avg DESC
)
SELECT * FROM paying_job_skills;