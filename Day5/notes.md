# Day 5 – SQL

## Multi-table Queries • Self Join • Cross Join

---

## 📑 Table of Contents

1. [Why Multi-Table Queries Matter](#why-multi-table-queries-matter)
2. [The 3-Table Relationship Model](#the-3-table-relationship-model)
3. [INNER JOIN (Multi-Table)](#inner-join-multi-table)
4. [LEFT JOIN with Multiple Tables](#left-join-with-multiple-tables)
5. [JOIN Order Matters](#join-order-matters)
6. [CROSS JOIN (Cartesian Product)](#cross-join-cartesian-product)
7. [SELF JOIN](#self-join)
8. [Table Aliases](#table-aliases)
9. [WHERE vs JOIN Condition](#where-vs-join-condition)
10. [NULL Handling in JOINs](#null-handling-in-joins)

---

## Why Multi-Table Queries Matter

### Big Picture

Real-world databases are **normalized**, meaning:

* Data is split into multiple tables
* Tables are connected using **keys**
* Meaningful information is rebuilt using **JOINs**

### Example

| Table    | Represents |
| -------- | ---------- |
| students | Who        |
| courses  | What       |
| teachers | By whom    |

👉 **JOINs are how relational databases talk to each other.**

---

## The 3-Table Relationship Model

### 🎓 Student – Course – Teacher

### Table Structures

**students**
| student_id | student_name | course_id |

**courses**
| course_id | course_name | teacher_id |

**teachers**
| teacher_id | teacher_name |

### Relationship Flow

```
students → courses → teachers
```

### Key Relationships

* `students.course_id` → `courses.course_id`
* `courses.teacher_id` → `teachers.teacher_id`

---

## INNER JOIN (Multi-Table)

### Syntax (3 Tables)

```sql
SELECT columns
FROM table1
JOIN table2 ON condition
JOIN table3 ON condition;
```

### Example

```sql
SELECT
    s.student_name,
    c.course_name,
    t.teacher_name
FROM students s
JOIN courses c ON s.course_id = c.course_id
JOIN teachers t ON c.teacher_id = t.teacher_id;
```

📌 **INNER JOIN returns only matching records from all tables.**

---

## LEFT JOIN with Multiple Tables

### Why LEFT JOIN?

To include **all records from the left (primary) table**, even if related data is missing.

### Example

```sql
SELECT
    s.student_name,
    c.course_name,
    t.teacher_name
FROM students s
LEFT JOIN courses c ON s.course_id = c.course_id
LEFT JOIN teachers t ON c.teacher_id = t.teacher_id;
```

✔ Includes students even if:

* Course is not assigned
* Teacher is missing

---

## JOIN Order Matters

⚠️ **Interview Favorite Question**

```sql
FROM students s
LEFT JOIN courses c ON s.course_id = c.course_id
LEFT JOIN teachers t ON c.teacher_id = t.teacher_id;
```

### Key Points

* LEFT JOIN preserves rows from **students**
* Reversing table order changes results

👉 Always ask: **Which table is primary?**

---

## CROSS JOIN (Cartesian Product)

### What is a CROSS JOIN?

Combines **every row from table A with every row from table B**.

### Syntax

```sql
SELECT *
FROM students
CROSS JOIN courses;
```

### Example Output Size

* 5 students
* 4 courses

➡ Result = **20 rows**

### When is it Useful?

* Generate combinations
* Timetables
* Test data generation
* Pairing scenarios

⚠️ **Dangerous on large tables** — row count can explode.

---

## SELF JOIN

⭐ **One of the most important JOINs**

### What is a Self Join?

Joining a table with **itself**.

### Used For

* Hierarchies
* Manager–Employee
* Mentor–Student
* Parent–Child

### Example Table: employees

| emp_id | emp_name | manager_id |

### Goal

Find each employee’s manager.

### Query

```sql
SELECT
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.emp_id;
```

**Key Idea**

* Same table
* Different aliases
* Relationship within itself

---

## Table Aliases

### Examples

```sql
students s
courses c
teachers t
```

### Benefits

* Cleaner queries
* Mandatory for SELF JOINs
* Expected in interviews

---

## WHERE vs JOIN Condition

### ❌ Old & Incorrect Style

```sql
FROM students s, courses c
WHERE s.course_id = c.course_id;
```

### ✔ Correct & Modern SQL

```sql
FROM students s
JOIN courses c ON s.course_id = c.course_id;
```

👉 Always use **explicit JOIN syntax**.

---

## NULL Handling in JOINs

### Example

```sql
WHERE teacher_name IS NULL;
```

### Used To Find

* Students without courses
* Courses without teachers
* Employees without managers

---

## ✅ Day 5 Takeaway

* Multi-table JOINs rebuild meaning from normalized data
* JOIN order impacts results
* CROSS JOIN = combinations
* SELF JOIN = hierarchical power
* Aliases and explicit JOINs are mandatory skills

*End of Day 5 – Multi-table Queries + Self Join + Cross Join*
