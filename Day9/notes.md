# Day 9 – Normalization & Database Design

---

## 📚 Table of Contents

1. [What is Database Normalization?](#1️⃣-what-is-database-normalization)
2. [Why Normalization is Important (Anomalies)](#2️⃣-why-normalization-is-important-anomalies)
3. [First Normal Form (1NF)](#3️⃣-first-normal-form-1nf)
4. [Second Normal Form (2NF)](#4️⃣-second-normal-form-2nf)
5. [Third Normal Form (3NF)](#5️⃣-third-normal-form-3nf)
6. [1NF vs 2NF vs 3NF (Summary)](#6️⃣-summary-1nf-vs-2nf-vs-3nf)
7. [Denormalization (When & Why)](#7️⃣-denormalization-when--why)
8. [Database Relationships](#8️⃣-database-relationships)
9. [Schema Design: Student Management System](#9️⃣-schema-design-student-management-system)
10. [Schema Design: E-Commerce System](#🔟-schema-design-e-commerce-system)
11. [Keys Used in Database Design](#1️⃣1️⃣-keys-used-in-design)

---

## 1️⃣ What is Database Normalization?

**Normalization** is the process of organizing data in a database to:

* Reduce data redundancy
* Avoid update / insert / delete anomalies
* Improve data integrity & consistency

👉 **Core idea:**

> *One fact → stored in one place → only once*

---

## 2️⃣ Why Normalization is Important (Anomalies)

### 🔴 Insert Anomaly

* Cannot insert data without other related data.
* **Example:** Cannot add a new course unless a student enrolls.

### 🔴 Update Anomaly

* Same data stored in multiple rows → inconsistency.
* **Example:** Teacher name updated in one row but not others.

### 🔴 Delete Anomaly

* Deleting one record removes useful information.
* **Example:** Deleting the last student of a course removes course details.

👉 **Normalization prevents all three anomalies.**

---

## 3️⃣ First Normal Form (1NF)

### ✅ Rules of 1NF

* Each column contains **atomic (indivisible) values**
* No repeating groups or multi-valued columns
* Each row can be uniquely identified (Primary Key)

### ❌ NOT in 1NF

| student_id | name  | subjects      |
| ---------- | ----- | ------------- |
| 1          | Rahul | Math, Science |

### ✅ 1NF Version

| student_id | name  | subject |
| ---------- | ----- | ------- |
| 1          | Rahul | Math    |
| 1          | Rahul | Science |

👉 **One cell = one value**

---

## 4️⃣ Second Normal Form (2NF)

### ✅ Rules of 2NF

* Must already be in **1NF**
* No **partial dependency**
* Non-key attributes must depend on the **entire primary key**

### 🔴 Partial Dependency Problem

Composite Primary Key: `(student_id, course_id)`

| student_id | course_id | student_name | course_name |
| ---------- | --------- | ------------ | ----------- |

* `student_name` depends only on `student_id`
* `course_name` depends only on `course_id`

❌ **Violation of 2NF**

### ✅ 2NF Decomposition

**Students**
| student_id | student_name |

**Courses**
| course_id | course_name |

**Enrollments**
| student_id | course_id |

---

## 5️⃣ Third Normal Form (3NF)

### ✅ Rules of 3NF

* Must be in **2NF**
* No **transitive dependency**
* Non-key column should depend **only on PK**, not on another non-key

### 🔴 Transitive Dependency Example

| emp_id | emp_name | dept_id | dept_name |
| ------ | -------- | ------- | --------- |

* `dept_name` depends on `dept_id`
* `dept_id` depends on `emp_id`

❌ **Violation of 3NF**

### ✅ 3NF Decomposition

**Employees**
| emp_id | emp_name | dept_id |

**Departments**
| dept_id | dept_name |

---

## 6️⃣ Summary: 1NF vs 2NF vs 3NF

| Normal Form | Fixes                                     |
| ----------- | ----------------------------------------- |
| 1NF         | Repeating groups / multivalued attributes |
| 2NF         | Partial dependency                        |
| 3NF         | Transitive dependency                     |

---

## 7️⃣ Denormalization (When & Why)

### 🔁 What is Denormalization?

Intentional duplication of data for:

* Faster queries
* Fewer joins
* Reporting systems

### 🟢 When to Denormalize

* Read-heavy systems
* Analytics & dashboards
* Performance-critical queries

### 🔴 Trade-offs

* Increased storage
* Risk of inconsistency
* Complex updates

👉 **OLTP systems → Normalized**
👉 **OLAP systems → Denormalized**

---

## 8️⃣ Database Relationships

### 🔹 One-to-One (1–1)

* One record ↔ One record
* **Example:** User ↔ UserProfile

```
user(id PK)
user_profile(user_id PK, FK)
```

### 🔹 One-to-Many (1–M)

* One record ↔ Many records
* **Example:** Customer → Orders

```
orders.customer_id → customers.id
```

### 🔹 Many-to-Many (M–M)

* Many ↔ Many
* Requires junction table

**Example:** Students ↔ Courses

```
enrollments(student_id, course_id)
```

---

## 9️⃣ Schema Design: Student Management System

### 🎓 Core Entities

* Students
* Courses
* Teachers
* Enrollments

### 📐 Tables (3NF)

**STUDENTS**

```
student_id PK
name
email
```

**COURSES**

```
course_id PK
course_name
teacher_id FK
```

**TEACHERS**

```
teacher_id PK
teacher_name
```

**ENROLLMENTS**

```
enrollment_id PK
student_id FK
course_id FK
enroll_date
```

✔ No redundancy
✔ Fully normalized
✔ Scalable

---

## 🔟 Schema Design: E-Commerce System

### 🛒 Core Entities

* Users
* Products
* Orders
* Order_Items
* Payments

### 📐 Interview-Ready Tables

**USERS**

```
user_id PK
name
email
```

**PRODUCTS**

```
product_id PK
product_name
price
```

**ORDERS**

```
order_id PK
user_id FK
order_date
status
```

**ORDER_ITEMS**

```
order_item_id PK
order_id FK
product_id FK
quantity
price_at_purchase
```

**PAYMENTS**

```
payment_id PK
order_id FK
payment_method
payment_status
```

👉 `ORDER_ITEMS` resolves **M–M** between Orders & Products

---

## 1️⃣1️⃣ Keys Used in Design

| Key Type      | Purpose                   |
| ------------- | ------------------------- |
| Primary Key   | Uniquely identifies a row |
| Foreign Key   | Creates relationships     |
| Composite Key | Multiple columns as PK    |
| Surrogate Key | Auto-generated identifier |

---

**End of Day 9** 
