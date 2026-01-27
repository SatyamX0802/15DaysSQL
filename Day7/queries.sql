USE practice2;

INSERT INTO employees VALUES
(110, 'Vinod', 90000, '2019-02-06', 1, 'Software Engineer', 101),
(111, 'Raghav', 50000, '2022-02-26', 3, 'Sales Intern', 105),
(112, 'Junaid', 40000, '2021-08-20', 2, 'HR Intern', 103);

-- LEVEL 1: Foundation (Understanding Behavior)
-- Assign a unique row number to employees within each department ordered by salary (highest first).
SELECT name, salary, department_id,
					ROW_NUMBER() 
                    OVER(PARTITION BY department_id ORDER BY salary DESC) AS Unique_num
FROM employees;

/* Rank employees company-wide based on salary using:
ROW_NUMBER()
RANK()
DENSE_RANK()
Compare the results.*/
SELECT name, salary, 
			ROW_NUMBER() OVER(ORDER BY salary DESC) AS emp_no,
            RANK() OVER(ORDER BY salary DESC) AS emp_RANK,
            DENSE_RANK() OVER(ORDER BY salary DESC) AS emp_dense_RANK
FROM employees;

-- Display employees along with their salary rank inside their department.
SELECT name, department_id, salary,
			RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- Find employees who share the same salary and show how RANK() and DENSE_RANK() behave for them.
SELECT name, salary,
			RANK() OVER(ORDER BY salary DESC) AS salary_rank,
            DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_dense_rank
FROM employees;

-- Show employees ordered by hire date and display the previous employee’s hire date.
SELECT name, hire_date, department_id,
			LAG(hire_date, 1, 'N/A') OVER(ORDER BY hire_date) AS previous_hiring
FROM employees;

-- Find the top 2 highest-paid employees per department.
SELECT name, department_id, salary, salary_rank
FROM (
	SELECT name, salary, department_id,
				DENSE_RANK() OVER (
					PARTITION BY department_id 
					ORDER BY salary DESC
                ) AS salary_rank
	FROM employees) x
WHERE salary_rank<=2;

-- Show employees whose salary is higher than the previous employee in salary order.
SELECT name, salary, previous_salary
FROM (
	SELECT name, salary,
			LAG(salary, 1, 'N/A') OVER (
				ORDER BY salary
			) AS previous_salary
	FROM employees) x
WHERE salary>previous_salary;

-- Calculate the salary difference between each employee and the previous employee.
SELECT name, salary, prev_salary-salary AS salary_diff
FROM (
	SELECT name, salary,
			LAG(salary) OVER(
				ORDER BY salary
			) AS prev_salary
	FROM employees
) x;

-- Display each employee’s salary and the next higher salary in the company.
SELECT name, salary, next_highest
FROM (
	SELECT name, salary, 
			LEAD(salary, 1) OVER(
				ORDER BY salary
			) AS next_highest
	FROM employees
) x;

-- Find employees who are ranked exactly 3rd in salary within their department.
SELECT name, salary
FROM (
	SELECT name, salary,
			DENSE_RANK() OVER (
				PARTITION BY department_id 
                ORDER BY salary
			) AS salary_rank
	FROM employees
) x
WHERE salary_rank=3;

/* LEVEL 3: Real-World Business Problems
Create a company leaderboard showing:
employee name
department
salary
company rank */
SELECT E.name, D.department_name, E.salary,
		DENSE_RANK() OVER (
			ORDER BY salary DESC
		) AS company_rank
FROM employees AS E
JOIN departments AS D
ON E.department_id=D.department_id;

-- Identify employees whose salary is below the department average, but still in the top 3 ranks.
SELECT E.name, 
	   D.department_name, 
       E.salary, 
       E.company_rank
FROM (
	SELECT name, department_id, salary,
			DENSE_RANK() OVER (
				PARTITION BY department_id
				ORDER BY salary DESC
			) AS company_rank,
            AVG(salary) OVER (
				PARTITION BY department_id
			) AS dept_avg
	FROM employees 
) AS E
JOIN departments AS D
ON E.department_id=D.department_id
WHERE E.company_rank<=3
AND E.salary<E.dept_avg;

-- Find employees whose salary is equal to the previous employee’s salary.
SELECT name, salary, prev_emp_salary
FROM (
	SELECT name, salary,
			LAG(salary) OVER(
				ORDER BY salary
			) AS prev_emp_salary
	FROM employees
) E
WHERE salary=prev_emp_salary;

/* For each department, show:
highest salary
2nd highest salary
(using window functions only) */
SELECT D.department_name, 
	   MAX(CASE WHEN rnk=1 THEN salary END) AS highest_salary,
       MAX(CASE WHEN rnk=2 THEN salary END) AS second_highest_salary
FROM (
	SELECT department_id, salary,
			DENSE_RANK() OVER (
				PARTITION BY department_id
				ORDER BY salary DESC
			) AS rnk
	FROM employees
) E
JOIN departments AS D
ON E.department_id=D.department_id
GROUP BY D.department_name;

-- Show employees hired immediately before and after each employee (based on hire date).
SELECT name, 
	   employee_id,
       LAG(name) OVER (
			ORDER BY hire_date
		) AS before_emp,
		LEAD(name) OVER (
			ORDER BY hire_date
		) AS after_emp
FROM employees;


-- LEVEL 4: Advanced / Interview Grade
-- Remove duplicate employee records based on emp_name and department, keeping only the earliest hired employee.
DELETE FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM (
        SELECT employee_id,
               ROW_NUMBER() OVER (
                   PARTITION BY name, department_id
                   ORDER BY hire_date ASC
               ) AS rn
        FROM employees
    ) x
    WHERE rn > 1
);


-- Find departments where salary gaps between consecutive employees are greater than 20,000.
SELECT D.department_name, E.cons_emp_salary-E.salary AS salary_diff
FROM departments AS D
JOIN (
	  SELECT department_id, salary,
			 LEAD(salary) OVER (
					PARTITION BY department_id
					ORDER BY salary
			 ) AS cons_emp_salary
	  FROM employees
) E
ON D.department_id = E.department_id
WHERE E.cons_emp_salary-E.salary>20000;

-- Using the sales table, rank employees monthly based on total sales.
SELECT
    emp_id,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
    SUM(amount) AS total_sales,
    DENSE_RANK() OVER (
        PARTITION BY DATE_FORMAT(sale_date, '%Y-%m')
        ORDER BY SUM(amount) DESC
    ) AS monthly_rank
FROM sales
GROUP BY emp_id, DATE_FORMAT(sale_date, '%Y-%m');


-- Identify employees who improved their sales ranking month-over-month.
WITH monthly_sales AS (
    SELECT
        emp_id,
        DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
        SUM(amount) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY DATE_FORMAT(sale_date, '%Y-%m')
            ORDER BY SUM(amount) DESC
        ) AS monthly_rank
    FROM sales
    GROUP BY emp_id, DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    emp_id,
    sale_month,
    monthly_rank,
    prev_rank
FROM (
    SELECT
        emp_id,
        sale_month,
        monthly_rank,
        LAG(monthly_rank) OVER (
            PARTITION BY emp_id
            ORDER BY sale_month
        ) AS prev_rank
    FROM monthly_sales
) x
WHERE monthly_rank < prev_rank;



-- Find the first employee hired in each department and the most recent hire, in a single query.
SELECT D.department_name,
	   MAX(CASE WHEN E.emp_rank1=1 THEN name END) AS first_emp,
       MIN(CASE WHEN E.emp_rank2=1 THEN name END) AS recent_emp
FROM (
      SELECT name, department_id,
			 DENSE_RANK() OVER (
				PARTITION BY department_id
                ORDER BY hire_date
			) AS emp_rank1,
            DENSE_RANK() OVER (
				PARTITION BY department_id
                ORDER BY hire_date DESC
			) AS emp_rank2
	  FROM employees
) E
JOIN departments AS D
ON D.department_id=E.department_id
GROUP BY D.department_name;
