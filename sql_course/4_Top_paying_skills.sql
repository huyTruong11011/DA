/*
Answer: What are the top skills based on salary?

- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
helps identify the most financially rewarding skills to acquire or improve
*/

-- SQL 1: Phân tích kỹ năng có nhu cầu cao nhất và lương cao nhất.
WITH top_demanded_skills AS (
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demanded_for_skill
    FROM job_postings_fact job_postings
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings.job_title_short = 'Data Analyst'
    GROUP BY skills_dim.skill_id, skills_dim.skills
    ORDER BY demanded_for_skill DESC
)

SELECT 
    top_demanded_skills.skills,
    ROUND(AVG(job_postings.salary_year_avg),0) AS avg_salary
FROM top_demanded_skills
INNER JOIN skills_job_dim ON skills_job_dim.skill_id = top_demanded_skills.skill_id
INNER JOIN job_postings_fact job_postings ON job_postings.job_id = skills_job_dim.job_id
WHERE job_postings.salary_year_avg IS NOT NULL
    AND job_postings.job_title = 'Data Analyst'
GROUP BY top_demanded_skills.skills
ORDER BY avg_salary DESC
LIMIT 10;


--SQL 2: Chỉ tập trung lương trung bình theo mỗi kỹ năng.
SELECT 
    skills_dim.skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE   
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY avg_salary DESC
LIMIT 25