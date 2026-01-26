USE practice2;

-- LEVEL 1: Single-Row Subqueries (Basics)
-- Find all employees whose salary is greater than the average salary of the company.
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary)
				FROM employees);

-- Retrieve employees earning the minimum salary in the company.
SELECT name, salary
FROM employees 
WHERE salary = (SELECT MIN(salary)
				FROM employees);

-- List employees whose salary is equal to the maximum salary in the IT department.
SELECT name, job_title, salary
FROM employees
WHERE salary = (SELECT MAX(salary)
				FROM employees 
                WHERE department_id = (select department_id 
									   from departments 
                                       where department_name='IT'));

-- Using joins
select e.name, e.job_title, e.salary
from employees as e
join departments as d
on e.department_id = d.department_id
where d.department_name = 'IT'
and e.salary = (select max(salary) from employees where department_id = d.department_id);

-- Find departments where the average salary is higher than the overall company average.
SELECT D.department_name, AVG(E.salary) AS dept_avg
FROM departments AS D
JOIN employees AS E
ON D.department_id = E.department_id
GROUP BY D.department_id
HAVING dept_avg > (select avg(salary) from employees);

-- Display employees hired after the earliest hire date in the company.
SELECT name, hire_date 
FROM employees 
WHERE hire_date > (select min(hire_date) from employees);


-- LEVEL 2: Multi-Row Subqueries (IN, ANY, ALL)
-- Find employees who work in departments located in India or the United States.
SELECT name
FROM employees 
WHERE department_id IN (SELECT department_id FROM departments WHERE country = 'India' OR country = 'USA');

-- Using joins
SELECT E.name, D.department_name, D.country
FROM employees AS E
JOIN departments AS D
ON E.department_id = D.department_id
WHERE D.country = 'India' OR D.country = 'USA';

-- List employees whose salary is higher than ALL salaries of the HR department.
SELECT name, salary
FROM employees
WHERE salary > All (SELECT salary FROM employees
                    WHERE department_id = (SELECT department_id 
											FROM departments WHERE department_name='HR'));
								
SELECT e.name, e.salary
FROM employees e
WHERE e.salary > ALL (
    SELECT e2.salary
    FROM employees e2
    JOIN departments d
      ON e2.department_id = d.department_id
    WHERE d.department_name = 'HR'
);

-- Find employees whose salary is greater than ANY salary in the Sales department.
SELECT name, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees
					WHERE department_id = (SELECT department_id FROM departments
											WHERE department_name = 'Sales'));
                                            
SELECT name, salary
FROM employees
WHERE salary > ANY (SELECT E.salary from employees AS E
					JOIN departments AS D
                    ON E.department_id = D.department_id WHERE department_name='Sales');

-- Retrieve all products that have never been ordered.
SELECT product_name
FROM products 
WHERE product_id NOT IN (
	SELECT product_id FROM orders
); 

-- Find customers who have placed more than one order.
SELECT C.customer_name, COUNT(O.order_id) AS order_count
FROM customers AS C
JOIN orders AS O
ON C.customer_id = O.customer_id
GROUP BY C.customer_id 
HAVING COUNT(O.order_id) > 1;

-- LEVEL 3: EXISTS & Correlated Subqueries
-- List all departments that have at least one employee.
SELECT department_name
FROM departments AS D
WHERE EXISTS (SELECT E.department_id 
			FROM employees AS E
            WHERE E.department_id=D.department_id);

-- Find employees who earn more than the average salary of their own department.
SELECT E.name, E.salary
FROM employees AS E
WHERE salary > (SELECT AVG(salary)
				FROM employees AS E2
                GROUP BY department_id
                HAVING E.department_id = E2.department_id);

-- Retrieve employees who do not belong to any department.
SELECT E.name
FROM employees AS E
WHERE NOT EXISTS (SELECT D.department_id
					FROM departments AS D
                    WHERE D.department_id=E.department_id);

-- Find customers who have never placed an order using EXISTS.
SELECT C.customer_name
FROM customers AS C
WHERE NOT EXISTS (SELECT O.order_id
					FROM orders AS O
                    WHERE C.customer_id = O.customer_id);

-- Display products that are ordered by at least one customer from India.
SELECT P.product_name
FROM products AS P
WHERE EXISTS (SELECT O.order_id
				FROM orders AS O
                JOIN customers AS C
                ON O.customer_id=C.customer_id
                WHERE O.product_id=P.product_id and C.country='India');

-- LEVEL 4: Subqueries in SELECT & FROM
-- Display employee name, salary, and the average salary of their department.
WITH dept_avg AS (
	SELECT department_id, AVG(salary) AS dept_avg_salary
	FROM employees
	GROUP BY department_id
)
SELECT E.name, E.salary, Da.dept_avg_salary
FROM employees AS E
JOIN dept_avg AS Da
ON E.department_id=Da.department_id;

-- Find departments where the number of employees is greater than 5 (using subquery in FROM).


-- Show job titles along with the highest salary for each job title.

-- LEVEL 5: CTEs (WITH Clause)
-- Using a CTE, find employees whose salary is above their department’s average salary.

-- Create a CTE that calculates total sales per customer, then display customers whose total sales exceed ₹1,00,000.