# 📘 Day 1 – SQL Basics

## 📑 Table of Contents

1. [What is SQL?](#what-is-sql)
2. [Types of SQL Commands](#types-of-sql-commands)
3. [DDL – Data Definition Language](#ddl--data-definition-language)
4. [DML – Data Manipulation Language](#dml--data-manipulation-language)
5. [DCL – Data Control Language](#dcl--data-control-language)
6. [TCL – Transaction Control Language](#tcl--transaction-control-language)
7. [CREATE TABLE](#create-table)
8. [INSERT INTO](#insert-into)
9. [UPDATE](#update)
10. [DELETE](#delete)
11. [ALTER TABLE](#alter-table)

---

## What is SQL?

**SQL (Structured Query Language)** is a standard language used to interact with relational databases. It allows you to:

* Store data
* Retrieve data
* Update data
* Delete data

### Examples of databases using SQL

* MySQL
* PostgreSQL
* Oracle
* SQL Server

---

## Types of SQL Commands

SQL commands are divided into four main categories:

| Type | Full Form                    | Purpose                         |
| ---- | ---------------------------- | ------------------------------- |
| DDL  | Data Definition Language     | Defines database structure      |
| DML  | Data Manipulation Language   | Works with data inside tables   |
| DCL  | Data Control Language        | Controls access and permissions |
| TCL  | Transaction Control Language | Manages transactions            |

---

## DDL – Data Definition Language

Used to create, modify, and delete database objects.

### Common DDL Commands

* CREATE
* ALTER
* DROP
* TRUNCATE

### Example

```
CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    age INT
);
```

👉 This creates a table named **students**.

---

## DML – Data Manipulation Language

Used to insert, update, and delete data inside tables.

### Common DML Commands

* INSERT
* UPDATE
* DELETE
* SELECT *(often categorized separately, but commonly used with DML)*

---

## DCL – Data Control Language

Used to control database access and permissions.

### Common DCL Commands

* GRANT
* REVOKE

### Example

```
GRANT SELECT ON students TO user1;
```

👉 Allows **user1** to read data from the **students** table.

---

## TCL – Transaction Control Language

Used to manage transactions in a database.

### Common TCL Commands

* COMMIT
* ROLLBACK
* SAVEPOINT

### Example

```
ROLLBACK;
```

👉 Undoes changes made in the current transaction.

---

## CREATE TABLE

Used to create a new table in the database.

### Syntax

```
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype
);
```

### Example

```
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT
);
```

---

## INSERT INTO

Used to add data into a table.

### Insert a single row

```
INSERT INTO employees VALUES (1, 'Rahul', 30000);
```

### Insert multiple rows

```
INSERT INTO employees VALUES
(2, 'Amit', 35000),
(3, 'Neha', 40000);
```

---

## UPDATE

Used to modify existing data in a table.

### Syntax

```
UPDATE table_name
SET column = value
WHERE condition;
```

### Example

```
UPDATE employees
SET salary = 45000
WHERE emp_id = 3;
```

⚠️ **Without `WHERE`, all rows will be updated.**

---

## DELETE

Used to remove data from a table.

### Syntax

```
DELETE FROM table_name
WHERE condition;
```

### Example

```
DELETE FROM employees
WHERE emp_id = 2;
```

⚠️ **Without `WHERE`, all rows will be deleted.**

---

## ALTER TABLE

### What is ALTER?

**ALTER** is a DDL command used to change the structure of an existing table (not the data).

### Used to:

* Add or remove columns
* Modify column data types
* Rename columns or tables
* Add or drop constraints

### General Syntax

```
ALTER TABLE table_name
ACTION column_name datatype constraints;
```

---

## Summary (Day 1 – SQL Basics)
---

- **SQL (Structured Query Language)** is used to create, read, update, and delete data in relational databases.
- SQL is commonly used with databases such as **MySQL, PostgreSQL, Oracle, and SQL Server**.
- SQL commands are categorized into **four main types**: DDL, DML, DCL, and TCL.
- **DDL (Data Definition Language)** defines and manages database structure using commands like `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`.
- **DML (Data Manipulation Language)** works with data inside tables using `INSERT`, `UPDATE`, `DELETE`, and `SELECT`.
- **DCL (Data Control Language)** controls user access and permissions through `GRANT` and `REVOKE`.
- **TCL (Transaction Control Language)** manages transactions using `COMMIT`, `ROLLBACK`, and `SAVEPOINT`.
- `CREATE TABLE` is used to define the structure of a table before inserting data.
- `INSERT INTO` adds new records, while `UPDATE` and `DELETE` modify or remove existing records.
- Using a `WHERE` clause in `UPDATE` and `DELETE` statements is critical to avoid affecting all rows.
- `ALTER TABLE` is used to change table structure without modifying existing data.

📌 These concepts form the **foundation of SQL** and are essential before learning JOINs, constraints, aggregations, and advanced queries.

---

*End of Day 1 – SQL Basics Notes*
