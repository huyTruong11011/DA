WITH top_demanded_skills AS (
    SELECT 
        COUNT(job_postings.job_id) AS number_skills,
        skills_dim.skills
    FROM job_postings_fact job_postings
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings.job_title_short = 'Data Analyst' AND
        job_postings.job_work_from_home = TRUE
    GROUP BY skills_dim.skills
    ORDER BY number_skills DESC
)

SELECT *
FROM top_demanded_skills
LIMIT 5;