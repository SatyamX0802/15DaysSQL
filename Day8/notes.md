# Day 8 -- SQL Constraints & Indexing (Mastery Level)

## Table of Contents

1.  What are Constraints\
2.  Primary Key (PK)\
3.  Foreign Key (FK)\
4.  UNIQUE Constraint\
5.  CHECK Constraint\
6.  Adding Constraints using ALTER\
7.  What is an Index?\
8.  Types of Indexes\
9.  How Index Improves Performance\
10. Using EXPLAIN\
11. When NOT to Use Indexes\
12. Drop Index\
13. Real-World Example\
14. Interview-Ready One-Liners\
15. Practice Tasks

------------------------------------------------------------------------

## 1. What are Constraints?

Constraints are rules enforced by the database to maintain **data
integrity, accuracy, and reliability**.

**Why constraints matter** - Prevent duplicate records\
- Maintain relationships between tables\
- Enforce business rules\
- Reduce application-side validation

------------------------------------------------------------------------

## 2. Primary Key (PK)

**Definition** - Uniquely identifies each row\
- NOT NULL + UNIQUE\
- Only one per table\
- Automatically indexed

``` sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);
```

### Composite Primary Key

``` sql
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id)
);
```

**Interview Tip:** Primary Key = Entity Identity

------------------------------------------------------------------------

## 3. Foreign Key (FK)

**Definition** - Enforces relationships\
- Ensures referential integrity

``` sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

### With Actions

``` sql
ON DELETE CASCADE
ON UPDATE CASCADE
```

  Action      Meaning
  ----------- --------------------
  CASCADE     Auto delete/update
  SET NULL    Set FK to NULL
  RESTRICT    Prevent delete
  NO ACTION   Same as restrict

**Interview Tip:** Foreign Key = Relationship Enforcement

------------------------------------------------------------------------

## 4. UNIQUE Constraint

Ensures no duplicate values.

``` sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```

  Feature        PRIMARY KEY   UNIQUE
  -------------- ------------- ----------
  NULL Allowed   No            Yes
  Count          One           Multiple
  Indexed        Yes           Yes

------------------------------------------------------------------------

## 5. CHECK Constraint

Restricts value ranges.

``` sql
CHECK (salary > 0 AND salary < 200000)
```

**Note:** Fully supported in MySQL 8.0+

------------------------------------------------------------------------

## 6. Adding Constraints (ALTER)

``` sql
ALTER TABLE employees ADD PRIMARY KEY (emp_id);
ALTER TABLE users ADD UNIQUE (email);
ALTER TABLE employees ADD CHECK (salary > 0);
```

------------------------------------------------------------------------

## 7. What is an Index?

Indexes speed up data retrieval by avoiding full table scans.

------------------------------------------------------------------------

## 8. Types of Indexes

-   Single Column\
-   Composite (order matters)\
-   Unique\
-   Implicit (PK, UNIQUE)

------------------------------------------------------------------------

## 9. Performance Improvement

Without index → Full scan\
With index → Fast lookup

------------------------------------------------------------------------

## 10. Using EXPLAIN

``` sql
EXPLAIN SELECT * FROM employees WHERE salary = 80000;
```

  Type Rank
  -------------
  const
  eq_ref
  ref
  range
  index
  ALL (Worst)

------------------------------------------------------------------------

## 11. When NOT to Use Indexes

-   Small tables\
-   Low cardinality columns\
-   Frequently updated columns

------------------------------------------------------------------------

## 12. Drop Index

``` sql
DROP INDEX idx_salary ON employees;
```

------------------------------------------------------------------------

## 13. Real-World Example

``` sql
CREATE INDEX idx_order_date ON orders(order_date);
```

------------------------------------------------------------------------

## 14. Interview One-Liners

-   PK uniquely identifies rows\
-   FK enforces relationships\
-   Index speeds up SELECT\
-   EXPLAIN shows query plan

------------------------------------------------------------------------

## 15. Practice Tasks

-   Create tables with all constraints\
-   Add constraints using ALTER\
-   Compare EXPLAIN before & after index


---

**End of Day 8 Notes**