# Day 2: SQL Data Retrieval & Filtering

## Table of Contents

1. [SELECT Statement](#1-select-statement)
2. [WHERE Clause](#2-where-clause)
3. [BETWEEN Operator](#3-between-operator)
4. [LIKE Operator](#4-like-operator)
5. [IN Operator](#5-in-operator)
6. [DISTINCT Keyword](#6-distinct-keyword)
7. [ORDER BY Clause](#7-order-by-clause)
8. [Combined Filtering Examples](#8-combined-filtering-examples)
9. [Day 2 Key Takeaways](#day-2-key-takeaways)

---

## 1. SELECT Statement

Used to retrieve data from a table.

### Syntax

```sql
SELECT column1, column2
FROM table_name;
```

### Examples

```sql
SELECT * FROM employees;
SELECT name, salary FROM employees;
```

📌 `*` selects all columns.

---

## 2. WHERE Clause

Used to filter rows based on conditions.

### Syntax

```sql
SELECT columns
FROM table_name
WHERE condition;
```

### Operators

| Operator     | Meaning                     |
| ------------ | --------------------------- |
| =            | Equal                       |
| != / <>      | Not equal                   |
| >, <, >=, <= | Comparison                  |
| AND          | All conditions must be true |
| OR           | Any condition can be true   |

### Examples

```sql
SELECT * FROM employees
WHERE department = 'IT';

SELECT * FROM students
WHERE age > 18;
```

---

## 3. BETWEEN Operator

Used to select values within a range (inclusive).

### Syntax

```sql
WHERE column BETWEEN value1 AND value2;
```

### Examples

```sql
SELECT * FROM employees
WHERE salary BETWEEN 30000 AND 60000;

SELECT * FROM students
WHERE age BETWEEN 18 AND 22;
```

📌 Works with numbers, dates, and strings.

---

## 4. LIKE Operator

Used for pattern matching.

### Wildcards

| Symbol | Meaning                  |
| ------ | ------------------------ |
| %      | Any number of characters |
| _      | Exactly one character    |

### Examples

```sql
SELECT * FROM employees
WHERE name LIKE 'A%';   -- starts with A

SELECT * FROM students
WHERE name LIKE '%an%'; -- contains 'an'

SELECT * FROM employees
WHERE name LIKE '_a%';  -- second letter is 'a'
```

---

## 5. IN Operator

Used to match multiple values in a column.

### Syntax

```sql
WHERE column IN (value1, value2, ...);
```

### Examples

```sql
SELECT * FROM employees
WHERE department IN ('IT', 'HR');

SELECT * FROM students
WHERE course IN ('BCA', 'MCA', 'B.Tech');
```

📌 Cleaner alternative to multiple `OR` conditions.

---

## 6. DISTINCT Keyword

Used to remove duplicate values.

### Syntax

```sql
SELECT DISTINCT column
FROM table_name;
```

### Examples

```sql
SELECT DISTINCT department FROM employees;
SELECT DISTINCT course FROM students;
```

📌 Applies to the entire selected columns, not individual rows.

---

## 7. ORDER BY Clause

Used to sort results.

### Syntax

```sql
ORDER BY column ASC | DESC;
```

### Examples

```sql
SELECT * FROM employees
ORDER BY salary ASC;

SELECT * FROM students
ORDER BY age DESC;
```

📌 Default sorting order is `ASC` (ascending).

---

## 8. Combined Filtering Examples

### Employees Table

```sql
SELECT name, department, salary
FROM employees
WHERE department = 'IT'
AND salary BETWEEN 40000 AND 80000
ORDER BY salary DESC;

SELECT DISTINCT department
FROM employees
ORDER BY department;
```

### Students Table

```sql
SELECT name, age, course
FROM students
WHERE age > 18
AND course IN ('BCA', 'MCA')
ORDER BY age;

SELECT * FROM students
WHERE name LIKE 'S%';
```

---

## Day 2 Key Takeaways

* **SELECT** → Fetch data
* **WHERE** → Filter rows
* **BETWEEN** → Range filtering
* **LIKE** → Pattern matching
* **IN** → Match multiple values
* **DISTINCT** → Remove duplicates
* **ORDER BY** → Sort results


*End of Day 2 – SQL Data Retrieval and Filtering*