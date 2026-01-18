/* Basic SELECT & WHERE
Display all job titles and company names.
Fetch all job postings located in India.
List all jobs that allow work from home.
Show jobs where health insurance is provided.
Retrieve job postings that do not require a degree. */

USE jobopenings;
DESCRIBE JANJOBOPENINGS;

-- Display all job titles and company names.
SELECT job_title, company_name FROM janjobopenings;

-- Fetch all job postings located in India.
SELECT * FROM janjobopenings WHERE job_country="India";

-- List all jobs that allow work from home.
SELECT * FROM janjobopenings WHERE job_work_from_home=1;

-- Show jobs where health insurance is provided.
SELECT * FROM janjobopenings WHERE job_health_insurance=1;

-- Retrieve job postings that do not require a degree.
SELECT * FROM janjobopenings WHERE job_no_degree_mention=1;

/* BETWEEN (Range Filtering)
Find jobs with annual salary between 50,000 and 100,000.
List hourly-based jobs where hourly salary is between 20 and 50. */

-- Find jobs with annual salary between 50,000 and 100,000.
SELECT * FROM janjobopenings WHERE salary_year_avg BETWEEN 50000 AND 100000;

-- List hourly-based jobs where hourly salary is between 20 and 50.
SELECT * FROM janjobopenings WHERE salary_hour_avg BETWEEN 20 AND 50;

/* LIKE (Pattern Matching)
Find all jobs with “Data” in the job title.
Display jobs where required skills include SQL.
Fetch companies whose names start with ‘A’. */

-- Find all jobs with “Data” in the job title.
SELECT * FROM janjobopenings WHERE job_title LIKE "%Data%";

-- Display jobs where required skills include SQL.
SELECT * FROM janjobopenings WHERE job_skills LIKE "%sql%";

-- Fetch companies whose names start with ‘A’.
SELECT * FROM janjobopenings WHERE company_name LIKE "A%";

/* IN (Multiple Values)
Retrieve jobs located in India, United States, or Remote.
Show job postings from companies Google, Amazon, or Microsoft. */

-- Retrieve jobs located in India, United States, or Remote.
SELECT * FROM janjobopenings
WHERE job_country 
IN ("India", "United States")
OR job_work_from_home=1;

-- Show job postings from companies Google, Amazon, or Microsoft.
SELECT * FROM janjobopenings
WHERE company_name 
IN ('Google', 'Amazon Web Services, Inc.', 'Microsoft');
-- Better method ↓
SELECT * 
FROM janjobopenings
WHERE company_name LIKE 'Google%'
	OR company_name LIKE 'Microsoft%'
	OR company_name LIKE 'Amazon%';

/* DISTINCT
Display all unique job titles available in January.
List all distinct job locations. */

-- Display all unique job titles available in January.
SELECT DISTINCT job_title
FROM janjobopenings;

-- List all distinct job locations.
SELECT DISTINCT job_location
FROM janjobopenings;

-- ORDER BY (Sorting)
-- Display job postings sorted by highest annual salary first.
SELECT * 
FROM janjobopenings
ORDER BY salary_year_avg DESC;



---------------------------------------------------------

SELECT * 
FROM janjobopenings
WHERE company_name LIKE 'Google%'
	OR company_name LIKE 'Microsoft%'
	OR company_name LIKE 'Amazon%';
    
SELECT *
FROM janjobopenings
WHERE company_name REGEXP '^(Google|Microsoft|Amazon)';
