USE practice1;

CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(50),
    department VARCHAR(50)
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    course_id INT,
    enrollment_year INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);
INSERT INTO teachers VALUES
(1, 'Dr. Sharma', 'Computer Science'),
(2, 'Prof. Mehta', 'Mathematics'),
(3, 'Dr. Khan', 'Physics'),
(4, 'Prof. Rao', 'Data Science'),
(5, 'Dr. Sen', 'AI');
INSERT INTO courses VALUES
(101, 'SQL Fundamentals', 1),
(102, 'Advanced SQL', 1),
(103, 'Data Structures', 2),
(104, 'Machine Learning', 4),
(105, 'Artificial Intelligence', 5),
(106, 'Statistics', 2),
(107, 'Quantum Computing', NULL);
INSERT INTO students VALUES
(1, 'Amit', 101, 2023),
(2, 'Neha', 102, 2023),
(3, 'Ravi', 103, 2022),
(4, 'Sneha', 104, 2023),
(5, 'Rahul', 105, 2022),
(6, 'Pooja', 101, 2024),
(7, 'Ankit', 106, 2023),
(8, 'Kiran', NULL, 2024),
(9, 'Simran', 104, 2023),
(10, 'Arjun', 102, 2022),
(11, 'Divya', 103, 2023),
(12, 'Nikhil', 101, 2022),
(13, 'Isha', NULL, 2024),
(14, 'Suresh', 106, 2023),
(15, 'Meena', 105, 2022);
INSERT INTO employees VALUES
(1, 'CEO', NULL),
(2, 'Manager A', 1),
(3, 'Manager B', 1),
(4, 'Employee X', 2),
(5, 'Employee Y', 2),
(6, 'Employee Z', 3);


/* Level 1 – Core Joins
1️. List all students with their course names and teacher names.
(Only students with valid courses & teachers). */
SELECT S.student_name, C.course_name, T.teacher_name
FROM students AS S
JOIN courses AS C
	ON S.course_id = C.course_id
JOIN teachers AS T
	ON C.teacher_id = T.teacher_id;

/*2️. Display all students and their courses.
Include students who have not enrolled in any course. */
SELECT S.student_name, C.course_name
FROM students AS S
LEFT JOIN courses AS C
ON C.course_id = S.course_id;

/*3️. Show all courses along with assigned teachers.
Include courses without teachers. */
SELECT C.course_name, T.teacher_name
FROM courses AS C 
LEFT JOIN teachers AS T
ON T.teacher_id = C.teacher_id;

/*Level 2 – Filttering + Logic
4️. Find students enrolled after 2022 along with their course & teacher. */
SELECT S.student_name, C.course_name, T.teacher_name
FROM students AS S
JOIN courses AS C
ON S.course_id = C.course_id 
JOIN teachers AS T
ON T.teacher_id = C.teacher_id
WHERE S.enrollment_year>2022;

-- 5️. List all courses that currently have NO students enrolled.
SELECT C.course_name, COUNT(S.student_id) AS enrollment_count
FROM courses AS C
LEFT JOIN students AS S
ON C.course_id = S.course_id
group by C.course_id
having COUNT(S.student_id)=0;

/*6️. Show each teacher and the number of courses they teach.
Include teachers teaching zero courses. */
SELECT T.teacher_name, COUNT(C.course_id) AS course_count
FROM teachers AS T
LEFT JOIN courses AS C
ON C.teacher_id = T.teacher_id
GROUP BY T.teacher_id; 

/*Level 3 – CROSS JOIN & Analysis
7️. Generate all possible student–course combinations.
(Display student name and course name)
👉 Use CROSS JOIN */
SELECT S.student_name, C.course_name
FROM students AS S
CROSS JOIN courses C;

/*Level 4 – SELF JOIN
8️. Display employees and their managers’ names.
Include top-level employees with no manager. */
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
ON e.manager_id = m.emp_id;

-- 9️. Find employees who report directly to the CEO.
SELECT e.emp_name
FROM employees AS e
LEFT JOIN employees AS m
ON e.manager_id = m.emp_id
WHERE m.emp_name = 'CEO';

/*Level 5 – Think Like an Analyst
10. Find students whose course does not have a teacher assigned. */
SELECT S.student_name
FROM students AS S
JOIN courses AS C
ON S.course_id = C.course_id
LEFT JOIN teachers AS T
ON C.teacher_id = T.teacher_id
WHERE T.teacher_id IS NULL;

