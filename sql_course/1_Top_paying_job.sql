SELECT 
	jb.job_id, 
	jb.job_title, 
	jb.job_location, 
	jb.job_schedule_type, 
	jb.salary_year_avg, 
	jb.job_posted_date,
	cd.name
FROM job_postings_fact AS jb
LEFT JOIN company_dim AS cd ON jb.company_id = cd.company_id
WHERE 
	jb.job_title_short = 'Data Analyst' AND
	jb.job_location = 'Anywhere' AND
	jb.salary_year_avg IS NOT NULL
ORDER BY
	jb.salary_year_avg DESC
LIMIT 10;