
# Day 7 -- SQL Window Functions

## Table of Contents

1.  [What are Window Functions?](#what-are-window-functions)
2.  [Basic Syntax](#basic-syntax)
3.  [GROUP BY vs Window Functions](#group-by-vs-window-functions)
4.  [ROW_NUMBER()](#row_number)
5.  [RANK()](#rank)
6.  [DENSE_RANK()](#dense_rank)
7.  [ROW_NUMBER vs RANK vs DENSE_RANK](#comparison)
8.  [LAG()](#lag)
9.  [LEAD()](#lead)
10. [LAG vs LEAD](#lag-vs-lead)
11. [Leaderboard Queries](#leaderboard)
12. [Remove Duplicates](#remove-duplicates)
13. [Common Mistakes](#common-mistakes)

------------------------------------------------------------------------

## What are Window Functions?

A **window function** performs calculations across a set of rows related
to the current row **without collapsing rows** (unlike `GROUP BY`).

**Key idea:**\
\> I want aggregated or ranked data while still seeing every row.

------------------------------------------------------------------------

## Basic Syntax

``` sql
function_name(expression)
OVER (
    PARTITION BY column_name
    ORDER BY column_name
)
```

  Clause         Purpose
  -------------- ---------------------------------------------------
  OVER()         Converts a normal function into a window function
  PARTITION BY   Divides rows into logical groups
  ORDER BY       Defines row order within each partition

------------------------------------------------------------------------

## GROUP BY vs Window Functions

  GROUP BY            Window Function
  ------------------- -----------------------------
  Reduces rows        Keeps all rows
  Aggregates data     Adds calculated columns
  One row per group   One row per original record

------------------------------------------------------------------------

## ROW_NUMBER()

Assigns a **unique sequential number** to each row.

``` sql
ROW_NUMBER() OVER (
    PARTITION BY department
    ORDER BY salary DESC
)
```

**Use cases** - Remove duplicates\
- Top 1 per group\
- Pagination

------------------------------------------------------------------------

## RANK()

Assigns rank and **skips numbers** when ties occur.

  Salary   Rank
  -------- ------
  90000    1
  90000    1
  80000    3

------------------------------------------------------------------------

## DENSE_RANK()

Assigns rank **without gaps**.

  Salary   Dense Rank
  -------- ------------
  90000    1
  90000    1
  80000    2

------------------------------------------------------------------------

## ROW_NUMBER vs RANK vs DENSE_RANK

  Function     Handles Ties   Gaps
  ------------ -------------- ------
  ROW_NUMBER   ❌             ❌
  RANK         ✅             ✅
  DENSE_RANK   ✅             ❌

------------------------------------------------------------------------

## LAG()

Accesses previous row value.

``` sql
LAG(column, offset, default)
OVER (ORDER BY column)
```

**Use cases** - Day-over-day comparison\
- Trend analysis

------------------------------------------------------------------------

## LEAD()

Accesses next row value.

``` sql
LEAD(column)
OVER (ORDER BY column)
```

**Use cases** - Future comparison\
- Time-series logic

------------------------------------------------------------------------

## LAG vs LEAD

  Function   Direction
  ---------- --------------
  LAG        Previous row
  LEAD       Next row

------------------------------------------------------------------------

## Leaderboard Queries

**Top 3 employees per department**

``` sql
SELECT *
FROM (
    SELECT employee_name, department, salary,
    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rank_num
    FROM employees
) t
WHERE rank_num <= 3;
```

------------------------------------------------------------------------

## Remove Duplicates

``` sql
DELETE FROM employees
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY id
        ) AS rn
        FROM employees
    ) t
    WHERE rn > 1
);
```

------------------------------------------------------------------------

## Common Mistakes ⚠️

-   Using `GROUP BY` instead of window functions\
-   Forgetting `ORDER BY`\
-   Confusing `RANK()` vs `DENSE_RANK()`\
-   Expecting window functions to filter rows directly

👉 Use **subqueries or CTEs** for filtering

---

**End of Day 7 Notes (SQL Window Functions)**