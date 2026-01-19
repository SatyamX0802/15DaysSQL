USE jobopenings;
DESCRIBE janjobopenings;
SELECT * FROM janjobopenings limit 10;

-- Update some columns
SET SQL_SAFE_UPDATES = 0;
UPDATE janjobopenings
SET salary_year_avg=NULL 
WHERE salary_year_avg=0;
UPDATE janjobopenings
SET salary_hour_avg=NULL 
WHERE salary_hour_avg=0;
UPDATE janjobopenings
SET job_schedule_type = 'Not Specified'
where job_schedule_type = '';

/* Level 1 – Foundation (Aggregation Basics)
1. Total job postings
Count the total number of job postings in the dataset.

2. Jobs with salary information
Count how many jobs have a non-NULL yearly average salary.

3. Distinct job titles
Find the number of unique short job titles (job_title_short).

4. Highest & lowest yearly salary
Find the maximum and minimum salary_year_avg.

5. Average yearly salary
Calculate the overall average yearly salary. */

-- Count the total number of job postings in the dataset.
SELECT COUNT(*) 
FROM janjobopenings;

-- Count how many jobs have a non-NULL yearly average salary.
SELECT COUNT(salary_year_avg)
FROM janjobopenings;

-- Find the number of unique short job titles (job_title_short).
SELECT COUNT(DISTINCT job_title_short)
FROM janjobopenings;

-- Find the maximum and minimum salary_year_avg.
SELECT MAX(salary_year_avg) AS Max_Salary, MIN(salary_year_avg) AS Min_Salary
FROM janjobopenings;

-- Calculate the overall average yearly salary.
SELECT AVG(salary_year_avg)
FROM janjobopenings;

/* LEVEL 2 – GROUP BY Mastery
6️. Average salary per job title
Find the average yearly salary for each job title.

7️. Job count per country
Display the number of job postings per country.

8️. Average salary per country
Find the average yearly salary per country.

9️. Job count by work-from-home status
Count jobs grouped by job_work_from_home.

10. Average salary by schedule type
Calculate the average yearly salary for each job schedule type (Full-time, Contract, etc.). */

-- Find the average yearly salary for each job title.
SELECT job_title, AVG(salary_year_avg)
FROM janjobopenings
GROUP BY job_title;

-- Display the number of job postings per country.
SELECT job_country, COUNT(*) AS job_count
FROM janjobopenings
GROUP BY job_country 
ORDER BY job_count DESC;

-- Find the average yearly salary per country.
SELECT job_country, AVG(salary_year_avg)
FROM janjobopenings
GROUP BY job_country;

-- Count jobs grouped by job_work_from_home.
SELECT job_work_from_home, COUNT(*) AS job_count
FROM janjobopenings
GROUP BY job_work_from_home;

-- Calculate the average yearly salary for each job schedule type (Full-time, Contract, etc.).
SELECT job_schedule_type, AVG(salary_year_avg)
FROM janjobopenings
GROUP BY job_schedule_type;

/* LEVEL 3 – GROUP BY + WHERE
1️1. Average salary for remote jobs
Find the average yearly salary of jobs where job_work_from_home = TRUE.

1️2.  Job count per company (USA only)
Show number of job postings per company for jobs located in the United States.

1️3. Average salary for jobs not requiring a degree
Calculate the average yearly salary where job_no_degree_mention = TRUE.

1️4. Country-wise average salary for full-time jobs
Find average yearly salary per country for full-time jobs only. */

-- Find the average yearly salary of jobs where job_work_from_home = TRUE.
SELECT AVG(salary_year_avg)
FROM janjobopenings
WHERE job_work_from_home = 1;

-- Show number of job postings per company for jobs located in the United States.
SELECT company_name, COUNT(*) AS job_count
FROM janjobopenings
WHERE job_location = 'United States'
GROUP BY company_name;

-- Calculate the average yearly salary where job_no_degree_mention = TRUE.
SELECT AVG(salary_year_avg)
FROM janjobopenings
WHERE job_no_degree_mention = 1;

-- Find average yearly salary per country for full-time jobs only.
SELECT job_country, AVG(salary_year_avg)
FROM janjobopenings
WHERE job_schedule_type = 'full-time'
GROUP BY job_country;

/* LEVEL 4 – HAVING (Filtering Groups)
1️5.  Job titles with high average salary
Show job titles where average yearly salary > 100,000.

1️6.  Countries with strong job market
Find countries having more than 50 job postings.

1️7.  Companies with multiple job postings
List companies that have posted more than 10 jobs.

18. Job titles with sufficient salary data
Find job titles where at least 20 jobs have salary information. */

-- Show job titles where average yearly salary > 100,000.
SELECT job_title_short, AVG(salary_year_avg) as average_salary
FROM janjobopenings
GROUP BY job_title_short
HAVING AVG(salary_year_avg)>100000
ORDER BY average_salary DESC;

-- Find countries having more than 50 job postings.
SELECT job_country, COUNT(*) AS job_count
FROM janjobopenings
GROUP BY job_country
HAVING COUNT(*)>50;

-- List companies that have posted more than 10 jobs.
SELECT company_name, COUNT(*) AS job_count
FROM janjobopenings
GROUP BY company_name
HAVING COUNT(*)>10;

-- Find job titles where at least 20 jobs have salary information.
SELECT job_title,
       COUNT(*) AS salary_jobs_count
FROM janjobopenings
WHERE salary_year_avg IS NOT NULL
   OR salary_hour_avg IS NOT NULL
GROUP BY job_title
HAVING COUNT(*) >= 20;

/* LEVEL 5 – Analytical / Report-Style Thinking
19. Top paying job titles
List job titles with average salary, but show only those with at least 10 postings, ordered by highest average salary.

20. Remote-friendly high-paying roles
Find job titles where:
Jobs are work from home
Average yearly salary > 90,000
At least 5 postings exist. */

-- List job titles with average salary, but show only those with at least 10 postings, ordered by highest average salary.
SELECT job_title, 
		AVG(salary_year_avg) as average_salary, 
		COUNT(*) AS job_count
FROM janjobopenings
GROUP BY job_title
HAVING COUNT(*)>=10
ORDER BY average_salary DESC;

-- Find job titles where:
-- Jobs are work from home
-- Average yearly salary > 90,000
-- At least 5 postings exist.
SELECT job_title,
		COUNT(*) AS job_count,
		AVG(salary_year_avg) AS avg_work_from_home_salary
FROM janjobopenings
WHERE job_work_from_home=1
GROUP BY job_title
HAVING COUNT(*)>=5 
	AND avg_work_from_home_salary>90000
ORDER BY avg_work_from_home_salary DESC;