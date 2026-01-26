# DAY 6 – SQL

## Subqueries & CTEs (WITH Clause)

---

## 📑 Table of Contents

1. [What is a Subquery?](#what-is-a-subquery)
2. [Where Can Subqueries Be Used?](#where-can-subqueries-be-used)
3. [Types of Subqueries](#types-of-subqueries)

   * Single-Row Subquery
   * Multi-Row Subquery (IN, ANY, ALL, EXISTS)
4. [Correlated Subqueries](#correlated-subqueries)
5. [Subqueries in SELECT Clause](#subqueries-in-select-clause)
6. [Subqueries in FROM Clause (Derived Tables)](#subqueries-in-from-clause-derived-tables)
7. [Subqueries vs JOIN](#subqueries-vs-join)
8. [What is a CTE (WITH Clause)?](#what-is-a-cte-with-clause)
9. [Simple CTE Example](#simple-cte-example)
10. [CTE with Aggregation](#cte-with-aggregation)
11. [CTE with JOIN](#cte-with-join)
12. [Multiple CTEs](#multiple-ctes)
13. [CTE vs Subquery](#cte-vs-subquery)
14. [Recursive CTE (Advanced)](#recursive-cte-advanced)

---

## What is a Subquery?

A **subquery** is a query written inside another SQL query.

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

📌 **Execution Flow**:

* Inner query runs first
* Outer query uses the result

---

## Where Can Subqueries Be Used?

| Location                 | Usage                |
| ------------------------ | -------------------- |
| SELECT                   | Calculated columns   |
| FROM                     | Derived tables       |
| WHERE                    | Filtering            |
| HAVING                   | Aggregated filtering |
| INSERT / UPDATE / DELETE | Data modification    |

---

## Types of Subqueries

### 🔹 A. Single-Row Subquery

* Returns **one value only**
* Used with: `=, >, <, >=, <=, <>`

```sql
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

⚠️ Error occurs if more than one row is returned.

---

### 🔹 B. Multi-Row Subquery

Returns **multiple rows**.

#### 🔸 IN

```sql
SELECT name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE country = 'India'
);
```

#### 🔸 ANY

Condition true if **any one** value matches.

```sql
SELECT name, salary
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE department = 'IT'
);
```

#### 🔸 ALL

Condition true if **all** values match.

```sql
SELECT name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department = 'HR'
);
```

📌 **ANY vs ALL**

* `> ANY` → greater than **minimum**
* `> ALL` → greater than **maximum**

#### 🔸 EXISTS

Checks **existence**, not actual values.

```sql
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
);
```

✔ Fast
✔ Often used with correlated subqueries

---

## Correlated Subqueries

A **correlated subquery** depends on the outer query.

```sql
SELECT e1.name, e1.salary, e1.department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

📌 Key Points:

* Runs once per row of outer query
* Inner query references outer query
* Cannot run independently

---

## Subqueries in SELECT Clause

```sql
SELECT
    name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;
```

⚠️ May impact performance if overused.

---

## Subqueries in FROM Clause (Derived Tables)

```sql
SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg
WHERE avg_salary > 50000;
```

📌 Alias is **mandatory** for derived tables.

---

## Subqueries vs JOIN

| Subquery           | JOIN               |
| ------------------ | ------------------ |
| Easier to read     | Faster (usually)   |
| Nested logic       | Flat structure     |
| Good for filtering | Best for reporting |
| May be slower      | Optimized by DB    |

👉 **Rule of Thumb**:

* Multiple tables → **JOIN**
* Conditional logic → **Subquery**

---

## What is a CTE (WITH Clause)?

CTE = **Common Table Expression**

* Temporary named result set
* Improves readability
* Easier maintenance

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
```

---

## Simple CTE Example

```sql
WITH avg_salary_cte AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT name, salary
FROM employees
WHERE salary > (SELECT avg_salary FROM avg_salary_cte);
```

✔ Cleaner than subquery
✔ Easier debugging

---

## CTE with Aggregation

```sql
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM dept_avg
WHERE avg_salary > 60000;
```

---

## CTE with JOIN

```sql
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT d.department_name, da.avg_salary
FROM dept_avg da
JOIN departments d
ON da.department_id = d.department_id;
```

---

## Multiple CTEs

```sql
WITH high_paid AS (
    SELECT *
    FROM employees
    WHERE salary > 80000
),
dept_count AS (
    SELECT department_id, COUNT(*) AS emp_count
    FROM high_paid
    GROUP BY department_id
)
SELECT *
FROM dept_count;
```

📌 Think of CTEs as a **step-by-step pipeline**.

---

## CTE vs Subquery

| CTE                | Subquery        |
| ------------------ | --------------- |
| More readable      | More compact    |
| Reusable           | Not reusable    |
| Easier debugging   | Harder to debug |
| Supports recursion | No recursion    |

---

## Recursive CTE (Advanced)

Used for:

* Hierarchies
* Org charts
* Tree structures

```sql
WITH RECURSIVE emp_hierarchy AS (
    SELECT employee_id, manager_id, name
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.manager_id, e.name
    FROM employees e
    JOIN emp_hierarchy eh
    ON e.manager_id = eh.employee_id
)
SELECT *
FROM emp_hierarchy;
```

📌 Optional for now — focus on understanding the concept.

---

**End of Day 6 Notes**
