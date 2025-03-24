WITH top_demanded_skills AS (
    -- Tính số lượng công việc (demand) cho mỗi kỹ năng
    SELECT 
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(job_postings.job_id) AS number_of_jobs
    FROM job_postings_fact job_postings
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings.job_title_short = 'Data Analyst' 
        AND job_postings.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skills, skills_dim.skill_id
),

skill_salary AS (
    -- Tính lương trung bình cho mỗi kỹ năng
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings.salary_year_avg),0) AS avg_salary
    FROM job_postings_fact job_postings
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings.job_title_short = 'Data Analyst'
        AND job_postings.salary_year_avg IS NOT NULL
        AND job_postings.job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id, skills_dim.skills
)

SELECT 
    top_demanded_skills.skills,
    top_demanded_skills.number_of_jobs,
    skill_salary.avg_salary
FROM top_demanded_skills
INNER JOIN skill_salary ON top_demanded_skills.skill_id = skill_salary.skill_id
WHERE skill_salary.avg_salary IS NOT NULL
    AND number_of_jobs > 10
    AND skill_salary.job_work_from_home = TRUE
ORDER BY top_demanded_skills.number_of_jobs DESC , skill_salary.avg_salary DESC
LIMIT 10;
