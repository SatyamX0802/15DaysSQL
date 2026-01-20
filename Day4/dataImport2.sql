USE jobopenings;

CREATE TABLE febjobopenings (
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

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- Corrected query for executing using command line.
-- >>> mysql -u root -p --local-infile=1
LOAD DATA LOCAL INFILE 'C:\\Users\\User\\Desktop\\15DaysSQL\\Day4\\FebJobOpenings.csv'
INTO TABLE febjobopenings
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  -- safer for Windows CSV
IGNORE 1 ROWS;