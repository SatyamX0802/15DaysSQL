Use jobopenings;

select * from febjobopenings limit 400;

set sql_safe_updates = 0;
UPDATE febjobopenings
SET salary_year_avg=null
WHERE salary_year_avg=0;
UPDATE febjobopenings
SET salary_hour_avg=null
WHERE salary_hour_avg=0;
UPDATE febjobopenings
SET job_schedule_type = 'Not Specified'
where job_schedule_type = '';


