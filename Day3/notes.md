# SQL DAY 3 – Aggregation, Grouping & Filtering Groups

## Table of Contents
1. [What Are Aggregate Functions?](#what-are-aggregate-functions)
2. [Core Aggregate Functions](#core-aggregate-functions)
3. [COUNT() – In Depth](#count--in-depth)
4. [SUM() – In Depth](#sum--in-depth)
5. [AVG()](#avg)
6. [MIN() and MAX()](#min-and-max)
7. [Aggregate Functions & NULL Values](#aggregate-functions--null-values)
8. [Using Aggregate Functions with WHERE](#using-aggregate-functions-with-where)
9. [GROUP BY – Core Concept](#group-by--core-concept)
10. [GROUP BY Rules](#group-by-rules)
11. [GROUP BY with WHERE](#group-by-with-where)
12. [HAVING Clause](#having-clause)
13. [WHERE vs HAVING](#where-vs-having)
14. [HAVING Without GROUP BY](#having-without-group-by)
15. [ORDER BY with Aggregate Functions](#order-by-with-aggregate-functions)
16. [Aliases with Aggregates](#aliases-with-aggregates)
17. [SQL Execution Order](#sql-execution-order)
18. [Common Mistakes to Avoid](#common-mistakes-to-avoid)
19. [Mental Checklist Before Writing Aggregation Queries](#mental-checklist-before-writing-aggregation-queries)
20. [Day 3 Learning Outcome](#day-3-learning-outcome)

---

## What Are Aggregate Functions?
Aggregate functions perform calculations on multiple rows and return a single summarized value.

**Used heavily in:**
- Data analysis  
- Reports  
- Dashboards  
- Interviews  
- Backend APIs  

---

## Core Aggregate Functions

| Function | Description |
|--------|-------------|
| COUNT() | Counts number of rows |
| SUM() | Adds numeric values |
| AVG() | Calculates average |
| MIN() | Returns smallest value |
| MAX() | Returns largest value |

---

## COUNT() – In Depth

### Types of COUNT

**COUNT(*)**
- Counts all rows  
- Includes NULL values  
- Fastest and safest  

```sql
SELECT COUNT(*) FROM employees;
```

**COUNT(column_name)**
- Counts non-NULL values only  

```sql
SELECT COUNT(salary) FROM employees;
```

> 📌 If `salary` has NULL values → those rows are ignored

**COUNT(DISTINCT column_name)**
- Counts unique values  

```sql
SELECT COUNT(DISTINCT department) FROM employees;
```

---

## SUM() – In Depth

**Rules:**
- Works only on numeric columns  
- Ignores NULL values  
- Common in finance & sales data  

```sql
SELECT SUM(salary) FROM employees;
```

> 📌 `SUM()` cannot be used on text columns

---

## AVG()

**Rules:**
- Numeric columns only  
- Ignores NULL values  
- Output is decimal  

```sql
SELECT AVG(salary) FROM employees;
```

> 📌 Even if all values are integers, result is decimal

---

## MIN() and MAX()

**Behavior:**
- Works on numbers, dates, and strings  
- For strings → alphabetical order  

```sql
SELECT MIN(salary), MAX(salary) FROM employees;
SELECT MIN(name), MAX(name) FROM employees;
```

---

## Aggregate Functions & NULL Values

| Function | NULL Behavior |
|-------|---------------|
| COUNT(*) | Includes NULL |
| COUNT(column) | Excludes NULL |
| SUM | Excludes NULL |
| AVG | Excludes NULL |
| MIN / MAX | Excludes NULL |

---

## Using Aggregate Functions with WHERE
`WHERE` filters rows **before** aggregation.

```sql
SELECT AVG(salary)
FROM employees
WHERE department = 'IT';
```

---

## GROUP BY – Core Concept
`GROUP BY` divides rows into groups based on column values, then applies aggregate functions per group.

Example:

| department | salary |
|----------|--------|
| IT | 60000 |
| IT | 70000 |
| HR | 45000 |

Groups created:
- IT → AVG, SUM, COUNT  
- HR → AVG, SUM, COUNT  

---

## GROUP BY Rules

**Rule 1:**  
Every non-aggregated column in `SELECT` must appear in `GROUP BY`

❌ Invalid:
```sql
SELECT department, salary
FROM employees
GROUP BY department;
```

✔ Valid:
```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department;
```

**Rule 2:**  
Aggregate functions do NOT go inside `GROUP BY`

**Rule 3:**  
`GROUP BY` can have multiple columns

```sql
GROUP BY department, location;
```

---

## GROUP BY with WHERE

**Execution Order:**
1. WHERE filters rows  
2. GROUP BY groups rows  
3. Aggregates applied  

```sql
SELECT department, COUNT(*)
FROM employees
WHERE location = 'India'
GROUP BY department;
```

---

## HAVING Clause

### Why HAVING Exists
`WHERE` cannot filter aggregated results.

❌ Invalid:
```sql
WHERE AVG(salary) > 50000
```

✔ Correct:
```sql
HAVING AVG(salary) > 50000
```

**Syntax:**
```sql
SELECT group_column, AGG_FUNCTION()
FROM table
GROUP BY group_column
HAVING AGG_FUNCTION() condition;
```

---

## WHERE vs HAVING

| Feature | WHERE | HAVING |
|------|-------|--------|
| Filters | Rows | Groups |
| Before aggregation | ✔ | ❌ |
| After aggregation | ❌ | ✔ |
| Can use aggregate | ❌ | ✔ |

---

## HAVING Without GROUP BY

✔ Yes (rare case)

```sql
SELECT COUNT(*)
FROM employees
HAVING COUNT(*) > 5;
```

> 📌 Works on entire table as one group

---

## ORDER BY with Aggregate Functions

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;
```

> 📌 `ORDER BY` always comes last

---

## Aliases with Aggregates

- Improves readability  
- Can be used in `ORDER BY`  

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary;
```

---

## SQL Execution Order (MEMORIZE)

1. FROM  
2. WHERE  
3. GROUP BY  
4. HAVING  
5. SELECT  
6. ORDER BY  

---

## Common Mistakes to Avoid ❌

- Using aggregate functions in WHERE  
- Missing GROUP BY columns  
- Mixing grouped & non-grouped columns  
- Using HAVING instead of WHERE  
- Forgetting NULL behavior  

---

## Mental Checklist Before Writing Aggregation Queries

Ask yourself:
- What am I grouping by?  
- What am I aggregating?  
- Do I need row-level filtering (WHERE)?  
- Do I need group-level filtering (HAVING)?  
- Is every non-aggregated column in GROUP BY?  

---

## Day 3 Learning Outcome 🎯

After mastering these notes, you will:
- Fully understand aggregation logic  
- Avoid 90% of SQL mistakes  
- Be ready for report-style queries  
- Handle interview questions confidently  

*End of Day 3 – Aggregation, Grouping & Filtering Groups*