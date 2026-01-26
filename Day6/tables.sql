CREATE DATABASE practice2;

USE practice2;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    country VARCHAR(50)
);
INSERT INTO departments VALUES
(1, 'IT', 'India'),
(2, 'HR', 'United States'),
(3, 'Sales', 'India'),
(4, 'Finance', 'United States'),
(5, 'Marketing', 'Germany');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    hire_date DATE,
    department_id INT,
    job_title VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
INSERT INTO employees VALUES
(101, 'Amit', 80000, '2019-06-15', 1, 'Software Engineer', NULL),
(102, 'Neha', 90000, '2018-03-10', 1, 'Senior Engineer', 101),
(103, 'Ravi', 40000, '2020-01-20', 2, 'HR Executive', NULL),
(104, 'Priya', 50000, '2021-07-05', 3, 'Sales Executive', 105),
(105, 'Arjun', 70000, '2017-11-12', 3, 'Sales Manager', NULL),
(106, 'Kiran', 120000, '2016-09-01', 4, 'Finance Manager', NULL),
(107, 'Sara', 60000, '2022-02-18', NULL, 'Consultant', NULL),
(108, 'John', 45000, '2023-04-01', 2, 'HR Intern', 103),
(109, 'Meena', 95000, '2019-12-10', 1, 'Tech Lead', 102);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);
INSERT INTO customers VALUES
(1, 'Rahul', 'India'),
(2, 'Ananya', 'India'),
(3, 'Michael', 'United States'),
(4, 'Sophia', 'Germany'),
(5, 'David', 'United States');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);
INSERT INTO products VALUES
(201, 'Laptop', 70000),
(202, 'Mobile Phone', 30000),
(203, 'Tablet', 40000),
(204, 'Monitor', 15000),
(205, 'Keyboard', 2000);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO orders VALUES
(301, 1, 201, '2023-01-10', 1),
(302, 1, 202, '2023-02-15', 2),
(303, 2, 203, '2023-03-20', 1),
(304, 3, 201, '2023-04-05', 1),
(305, 3, 204, '2023-04-18', 2),
(306, 5, 202, '2023-05-01', 1);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_amount INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO sales VALUES
(401, 1, 50000, '2023-01-10'),
(402, 1, 60000, '2023-02-10'),
(403, 2, 30000, '2023-03-15'),
(404, 3, 80000, '2023-04-01'),
(405, 3, 30000, '2023-04-20'),
(406, 5, 20000, '2023-05-10');
