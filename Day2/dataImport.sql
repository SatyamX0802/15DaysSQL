create database jobOpenings;

use jobOpenings;

CREATE TABLE janjobopenings (
    job_title_short        VARCHAR(100),
    job_title              VARCHAR(255),
    job_location           VARCHAR(150),
    job_via                VARCHAR(100),
    job_schedule_type      VARCHAR(50),
    job_work_from_home     BOOLEAN,
    search_location        VARCHAR(150),
    job_posted_date        DATE,
    job_no_degree_mention  BOOLEAN,
    job_health_insurance   BOOLEAN,
    job_country            VARCHAR(100),
    salary_rate            VARCHAR(50),
    salary_year_avg DECIMAL(10),
    salary_hour_avg DECIMAL(10),
    company_name           VARCHAR(150),
    job_skills             TEXT
);

-- Insert for sample one row data, testing the format and all.
INSERT INTO janjobopenings (
    job_title_short,
    job_title,
    job_location,
    job_via,
    job_schedule_type,
    job_work_from_home,
    search_location,
    job_posted_date,
    job_no_degree_mention,
    job_health_insurance,
    job_country,
    salary_rate,
    salary_year_avg,
    salary_hour_avg,
    company_name,
    job_skills
) VALUES (
    'Data Analyst',
    'Junior Data Analyst',
    'Bengaluru, India',
    'LinkedIn',
    'Full-time',
    1,
    'India',
    '2024-12-15',
    0,
    1,
    'India',
    'year',
    750000,
    NULL,
    'ABC Tech Solutions',
    'SQL, Excel, Python, Power BI'
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- query for executing using command line.
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\Desktop\\15DaysSQL\\Day2\\JanJobOpenings.csv'
INTO TABLE job_postings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Corrected query for executing using command line.
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\Desktop\\15DaysSQL\\Day2\\JanJobOpenings.csv'
INTO TABLE janjobopenings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  -- safer for Windows CSV
IGNORE 1 ROWS;

select * from janjobopenings limit 10;

select count(*) from janjobopenings;

