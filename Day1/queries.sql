/*Create a table named Employee with the following fields:
emp_id (int, primary key)
name (varchar(50))
age (int)
salary (decimal(10,2))
department (varchar(30))*/

CREATE DATABASE PRACTICE1;
USE PRACTICE1;
CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
name varchar(50),
age int,
salary decimal(10,2),
department varchar(30));

-- Insert 5 employees into the Employee table with different departments and salaries.
INSERT INTO Employee (emp_id, name, age, salary, department) VALUES(238, 'Satyam', 22, 50000, 'AI/ML'),
(293, 'Vaibav', 23, 23000, 'Sales'), (288, 'Rohit', 34, 54000, 'Security'), (294, 'Pawan', 27, 23000, 'Sales'), 
(224, 'Pooja', 24, 20000, 'HR');

select * from Employee;

-- Increase salary of employees in the IT department by 15%.
Update Employee set department='IT' where emp_id IN (238, 288);
select * from Employee;

set sql_safe_updates = 0;
Update Employee set salary = salary*1.15 where department = 'IT';

-- Change the datatype of the age column from INT to SMALLINT using ALTER.
Alter table Employee Modify age smallint;
desc Employee;

-- Add a new column email (varchar(100)) to the Employee table using ALTER.
Alter table Employee add column email varchar(100);

-- Delete employees who have a salary less than ₹25,000.
delete from Employee where salary<25000;
select * from Employee;

-- Rename the Employee table to Staff.
Alter table Employee rename Staff;
select * from Staff;

-- Update the name and department of the employee whose emp_id = 238.
Update staff set name='Hari', department='Tech' where emp_id=238;
select * from staff;

-- Remove the email column from the Staff table.
Alter table staff drop column email;
select * from staff;

/*Create a table Department with:
dept_id (primary key)
dept_name (unique)
Then add a foreign key in the Staff table referencing dept_id.*/

create table department (
dept_id int primary key, dept_name varchar(30) unique);

Alter table staff add column dept_id int, 
add constraint foreign key (dept_id) references department(dept_id);

