USE jobopenings;

ALTER TABLE janjobopenings
ADD COLUMN row_id BIGINT AUTO_INCREMENT PRIMARY KEY;

-- Question 1
EXPLAIN 
SELECT *
FROM janjobopenings
WHERE job_title_short = 'Data Analyst';

CREATE INDEX job_title_idx 
ON janjobopenings(job_title_short);
-- type - ref
-- rows - 982
-- key - job_title_idx

DROP INDEX job_title_idx
ON janjobopenings;

-- Question 2
EXPLAIN
SELECT *
FROM janjobopenings
WHERE job_title_short = 'Data Scientist'
  AND job_country = 'India';
  
CREATE INDEX job_idx_composite
ON janjobopenings(job_title_short, job_country);
-- type - ref
-- rows - 16
-- key - job_title_idx

DROP INDEX job_idx_composite
ON janjobopenings;

-- Question 3
EXPLAIN
SELECT COUNT(*)
FROM janjobopenings
WHERE job_work_from_home = TRUE;
-- type - ALL
-- rows - 3003

CREATE INDEX wfh_idx
ON janjobopenings(job_work_from_home);
-- type - ref
-- rows - 569

DROP INDEX wfh_idx
ON janjobopenings;
-- Indexing speed up how fast qualifying rows are located. Hence, count becomes faster.

-- Question 4
EXPLAIN
SELECT job_title, company_name
FROM janjobopenings
WHERE job_posted_date >= '2024-01-15';

CREATE INDEX job_posted_idx
ON janjobopenings(job_posted_date);
-- type - range
-- rows - 1

DROP INDEX job_posted_idx
ON janjobopenings;


-- Question 8
EXPLAIN
SELECT *
FROM janjobopenings
WHERE job_skills LIKE 'Python%';

CREATE INDEX job_skills_idx
ON janjobopenings(job_skills(100));
-- "Like%" -> index can work for these LIKE conditions
-- NOT for "%LIKE%", internally index costs more without any starting point for B-tree to jump to.

DROP INDEX job_skills_idx
ON janjobopenings;