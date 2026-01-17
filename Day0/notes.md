<details>
<summary>📑 Table of Contents</summary>

* [What is a Database?](#what-is-a-database)
* [Why Do We Need Databases?](#why-do-we-need-databases)
* [Types of Databases (High-Level)](#types-of-databases-high-level)
* [Types of Databases (Detailed)](#types-of-databases-detailed)
* [SQL vs NoSQL (Very Important)](#sql-vs-nosql-very-important)
* [ACID Properties (Must Know)](#acid-properties-must-know)
* [Schema vs Schema-less](#schema-vs-schema-less)
* [OLTP vs OLAP (Very Important for Data Roles)](#oltp-vs-olap-very-important-for-data-roles)
* [Database vs DBMS](#database-vs-dbms)
* [Primary Key & Foreign Key](#primary-key--foreign-key)
* [Normalization (Basic Idea)](#normalization-basic-idea)
* [When to Use SQL vs NoSQL?](#when-to-use-sql-vs-nosql)
* [Summary](#summary)

</details>

# Day 0: Database Fundamentals – Essential Notes

---

## What is a Database?

---

A **database** is an organized collection of data that allows:

* Efficient storage
* Easy retrieval
* Secure access
* Data consistency

📌 Instead of storing data in Excel or flat files, databases support multiple users, large volumes of data, and fast querying.

**Examples:**

* Student records
* Bank transactions
* E-commerce orders

---

## Why Do We Need Databases?

---

| Problem without DB | Solution with DB    |
| ------------------ | ------------------- |
| Data duplication   | Centralized storage |
| Slow search        | Fast queries        |
| No security        | Access control      |
| Data loss          | Backup & recovery   |
| Single-user access | Multi-user access   |

---

## Types of Databases (High-Level)

---

### 1️⃣ Relational Databases (SQL)

* Data stored in tables (rows & columns)
* Fixed schema
* Uses SQL

**Examples:**

* MySQL
* PostgreSQL
* Oracle
* SQL Server

📌 Best for **structured data** and **transaction-heavy systems**.

### 2️⃣ Non-Relational Databases (NoSQL)

* Data stored in non-table formats
* Schema-less or flexible schema
* Designed for distributed systems

**Examples:**

* MongoDB
* Cassandra
* Redis
* DynamoDB

📌 Best for **big data**, **real-time apps**, and **high scalability**.

---

## Types of Databases (Detailed)

---

### 🔹 1. Relational Database

* Tables with fixed schema
* Uses primary keys & foreign keys
* ACID compliant

**Example:**

| id | name | age |
| -- | ---- | --- |

---

### 🔹 2. Document Database

* Stores data as JSON-like documents

**Example (MongoDB):**

```json
{
  "name": "Rahul",
  "age": 22,
  "skills": ["SQL", "Python"]
}
```

---

### 🔹 3. Key-Value Database

* Stores data as key–value pairs

**Example:**

```
"user123" : "Rahul"
```

**Used in:**

* Caching
* Session management

**Examples:**

* Redis
* DynamoDB

---

### 🔹 4. Column-Oriented Database

* Stores data column-wise instead of row-wise
* Extremely fast for analytics

**Examples:**

* Cassandra
* HBase

**Used in:**

* Data warehouses
* Analytics systems

---

### 🔹 5. Graph Database

* Data stored as nodes and relationships

**Example:**

```
User --FRIENDS--> User
```

**Examples:**

* Neo4j
* Amazon Neptune

**Used in:**

* Social networks
* Recommendation engines

---

## SQL vs NoSQL (Very Important)

---

| Feature        | SQL          | NoSQL                    |
| -------------- | ------------ | ------------------------ |
| Data model     | Tables       | JSON, Key-Value, Graph   |
| Schema         | Fixed        | Flexible                 |
| Scalability    | Vertical     | Horizontal               |
| Transactions   | ACID         | BASE (usually)           |
| Query language | SQL          | No standard              |
| Use cases      | Banking, ERP | Big data, real-time apps |

---

## ACID Properties (Must Know)

---

ACID ensures reliable database transactions.

| Property    | Meaning                      |
| ----------- | ---------------------------- |
| Atomicity   | All or nothing               |
| Consistency | Data remains valid           |
| Isolation   | Transactions don’t interfere |
| Durability  | Data is permanently saved    |

**Example:**
Bank transfer — money should never disappear or duplicate.

---

## Schema vs Schema-less

---

| Feature    | Schema        | Schema-less |
| ---------- | ------------- | ----------- |
| Structure  | Fixed         | Flexible    |
| Validation | Before insert | On read     |
| Example    | MySQL         | MongoDB     |

---

## OLTP vs OLAP (Very Important for Data Roles)

---

| Feature   | OLTP               | OLAP           |
| --------- | ------------------ | -------------- |
| Purpose   | Daily transactions | Data analysis  |
| Queries   | INSERT, UPDATE     | SELECT         |
| Data size | Small              | Huge           |
| Example   | Banking app        | Data warehouse |

---

## Database vs DBMS

---

| Database           | DBMS                    |
| ------------------ | ----------------------- |
| Collection of data | Software to manage data |
| Passive            | Active                  |
| Example: Tables    | MySQL, PostgreSQL       |

📌 SQL operates on a **DBMS**, not directly on the database.

---

## Primary Key & Foreign Key

---

### Primary Key

* Uniquely identifies each row
* Cannot be NULL

**Example:**

```sql
id INT PRIMARY KEY
```

### Foreign Key

* Links two tables together

**Example:**

```sql
student_id REFERENCES students(id)
```

---

## Normalization (Basic Idea)

---

Normalization is the process of:

* Removing redundancy
* Improving data integrity

**Example:**

* ❌ Repeating student data in multiple tables
* ✅ Separate `students` and `courses` tables

---

## When to Use SQL vs NoSQL?

---

### Use SQL when:

✔ Data is structured
✔ Transactions are critical
✔ Strong consistency is required

### Use NoSQL when:

✔ Very large datasets
✔ High scalability is needed
✔ Schema flexibility is important

---

## Summary

---

This chapter introduced the **foundations of databases**, covering what databases are, why they are needed, and the major types used in modern systems. You learned the key differences between **SQL and NoSQL**, the importance of **ACID properties**, and how concepts like **schema, keys, normalization, OLTP, and OLAP** fit into real-world applications.

📌 These fundamentals are crucial before learning SQL queries, database design, and data engineering concepts.

*End of Day 0 – Database Fundamentals*
