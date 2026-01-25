# Day 4 – SQL Joins

## 📑 Table of Contents

1. [Why Do We Need JOINs?](#why-do-we-need-joins)
2. [Types of SQL JOINs (Big Picture)](#types-of-sql-joins-big-picture)
3. [INNER JOIN (Most Important)](#inner-join-most-important)
4. [Table Aliasing (Must-Know)](#table-aliasing-must-know)
5. [LEFT OUTER JOIN](#left-outer-join)
6. [RIGHT OUTER JOIN](#right-outer-join)
7. [FULL OUTER JOIN](#full-outer-join)
8. [INNER vs OUTER JOIN (Interview Favorite)](#inner-vs-outer-join-interview-favorite)
9. [Joining 3 Tables (Very Important)](#joining-3-tables-very-important)
10. [JOIN with WHERE Clause](#join-with-where-clause)
11. [Common Mistakes to Avoid](#common-mistakes-to-avoid)
12. [Best Practices](#best-practices)

---

## Why Do We Need JOINs?

In real-world databases:

* Data is **normalized**
* Related information is stored in **multiple tables**

### Example Tables

* `jobs` → job details
* `companies` → company information
* `locations` → country, city

👉 **JOIN** allows us to combine rows from two or more tables using a related column.

---

## Types of SQL JOINs (Big Picture)

| JOIN Type       | Meaning                             |
| --------------- | ----------------------------------- |
| INNER JOIN      | Only matching rows                  |
| LEFT JOIN       | All rows from left table + matches  |
| RIGHT JOIN      | All rows from right table + matches |
| FULL OUTER JOIN | All rows from both tables           |
| CROSS JOIN      | Cartesian product (rare)            |
| SELF JOIN       | Table joined with itself            |

📌 **Day 4 Focus**

* INNER JOIN
* OUTER JOIN (LEFT, RIGHT, FULL)
* Table aliasing
* 2-table & 3-table joins

---

## INNER JOIN (Most Important)

### Concept

* Returns **only rows that exist in both tables**

### Visual

* Table A ∩ Table B

### Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.common_column = table2.common_column;
```

### Example

```sql
SELECT j.job_title, c.company_name
FROM jobs j
INNER JOIN companies c
ON j.company_id = c.company_id;
```

✔ Only jobs with matching companies are returned
❌ Jobs without `company_id` are excluded

---

## Table Aliasing (Must-Know)

### Why Use Aliases?

* Shorter queries
* Mandatory when columns have same names
* Improves readability

### Syntax

```sql
FROM table_name AS alias
```

(`AS` is optional)

### Example

```sql
SELECT j.job_title, c.company_name
FROM jobs AS j
JOIN companies AS c
ON j.company_id = c.company_id;
```

📌 **Rule**: Once aliased, use alias everywhere

* ❌ `jobs.job_title`
* ✅ `j.job_title`

---

## LEFT OUTER JOIN

### Concept

Returns:

* ALL rows from LEFT table
* Matching rows from RIGHT table
* NULLs when no match exists

### Visual

* Table A + matching rows from Table B

### Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON condition;
```

### Example

```sql
SELECT j.job_title, c.company_name
FROM jobs j
LEFT JOIN companies c
ON j.company_id = c.company_id;
```

✔ Jobs without companies still appear
❌ Company columns become NULL

📌 Very common in analytics

---

## RIGHT OUTER JOIN

### Concept

* All rows from RIGHT table
* Matching rows from LEFT table

### Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
ON condition;
```

### Example

```sql
SELECT j.job_title, c.company_name
FROM jobs j
RIGHT JOIN companies c
ON j.company_id = c.company_id;
```

📌 **Tip**: Rarely used — can usually be rewritten using LEFT JOIN

---

## FULL OUTER JOIN

### Concept

Returns:

* All rows from both tables
* Matches where possible
* NULLs where no match exists

### Visual

* Table A ∪ Table B

### Syntax

```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2
ON condition;
```

⚠️ **Note**

* ❌ Not supported directly in MySQL
* ✔ Supported in PostgreSQL, SQL Server

### MySQL Workaround

```sql
SELECT * FROM A
LEFT JOIN B ON condition
UNION
SELECT * FROM A
RIGHT JOIN B ON condition;
```

---

## INNER vs OUTER JOIN (Interview Favorite)

| Feature        | INNER JOIN      | OUTER JOIN        |
| -------------- | --------------- | ----------------- |
| Unmatched rows | ❌ Excluded      | ✔ Included        |
| NULL values    | Rare            | Common            |
| Use case       | Strict matching | Data completeness |
| Performance    | Faster          | Slightly slower   |

🔑 **Key Insight**

* INNER JOIN filters rows
* OUTER JOIN preserves rows

---

## Joining 3 Tables (Very Important)

### Concept

* JOINs are evaluated **step by step**

### Syntax

```sql
SELECT columns
FROM table1
JOIN table2 ON condition1
JOIN table3 ON condition2;
```

### Example

```sql
SELECT j.job_title, c.company_name, l.job_country
FROM jobs j
JOIN companies c
ON j.company_id = c.company_id
JOIN locations l
ON j.job_id = l.job_id;
```

📌 Each JOIN has its own ON condition

---

## JOIN with WHERE Clause

### Conceptual Order of Execution

1. FROM
2. JOIN
3. ON
4. WHERE
5. SELECT

### Example

```sql
SELECT j.job_title, c.company_name
FROM jobs j
JOIN companies c
ON j.company_id = c.company_id
WHERE j.job_country = 'India';
```

📌 WHERE filters rows **after** JOIN

---

## Common Mistakes to Avoid ❌

* Forgetting ON condition → CROSS JOIN
* Using WHERE instead of ON in OUTER JOIN
* Not aliasing tables
* Joining on wrong columns
* Filtering OUTER JOIN data in WHERE

### Wrong Example

```sql
LEFT JOIN companies c
ON j.company_id = c.company_id
WHERE c.company_name IS NOT NULL;
```

❌ Converts LEFT JOIN into INNER JOIN

---

## Best Practices ✅

* Always use aliases
* Clearly define join keys
* Use LEFT JOIN for analytics
* Verify row counts after join
* Use INNER JOIN for strict matches

---

*End of Day 4 – SQL Joins Notes*
