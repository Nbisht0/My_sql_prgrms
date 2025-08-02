-- SHOW DATABASES;

-- CREATE DATABASE Organisation_project;
-- use Organisation_project;

CREATE TABLE Department(
 department_id INT PRIMARY KEY auto_increment,
 department_name VARCHAR(50) NOT NULL,
 department_location VARCHAR(50) NOT NULL
 );

CREATE TABLE Employees(
emp_id INT PRIMARY KEY auto_increment,
emp_name VARCHAR(50) NOT NULL,
department_id INT NOT NULL,
joining_date DATE,
FOREIGN KEY (department_id ) REFERENCES Department (department_id)
);

CREATE TABLE Projects(
project_id INT PRIMARY KEY auto_increment,
project_name VARCHAR(100) NOT NULL,
department_id INT NOT NULL,
FOREIGN KEY(department_id) REFERENCES Department(department_id)
);

CREATE TABLE Salaries(
emp_id INT PRIMARY KEY auto_increment,
FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
salary DECIMAL,
bonus Decimal
);

-- drop table Attendance;
CREATE TABLE Attendance(
emp_id INT,
PRIMARY KEY(emp_id , attendance),
FOREIGN KEY(emp_id) REFERENCES Employees(emp_id),
attendance DATE,
status VARCHAR(50)
);

INSERT INTO Department( department_name , department_location)
VALUES( "marketing" , "delhi"),
( "production" , "mumbai"),
( "HR" , "bangalore"),
( "Designing " , "pune"),
( "IT support " , "hyderabad"),
("mrketing" , "hyderabad");


INSERT INTO Employees(emp_id , emp_name , department_id , joining_date)
VALUES(1001 , "Amit Sharma" , 1 , '2022-06-10'),
(1002 , "Nidhi Verma" , 2, '2023-01-15'),
(1003 , "Anurag Pandey" , 3, '2022-11-03'),
(1004 , "Parth Mehra" , 4 , '2022-08-21'),
(1005 , "Kartik Tyagi" , 5 , '2023-06-10');

-- truncate TABLE Projects;
-- SELECT * FROM Projects;
ALTER TABLE Projects auto_increment = 201;
INSERT INTO Projects(project_id , project_name , department_id)
VALUES (201 , "ad campaign" , 1),
(202 , "product launch" , 2),
(203 , "reccruitment drive" , 3),
(204 , "ui redesign" , 4),
(205 , "it support " ,  5) ;

INSERT INTO Salaries(emp_id , salary , bonus)
VALUES(1001, 5500.00 , 5500),
(1002 , 6000.00 , 2000),
(1003 , 7000.00 , 1000),
(1004 , 3000.00 , 2000),
(1005 ,5000.00 , 4000);

INSERT INTO Attendance(emp_id , attendance , status)
VALUES(1001 , "2025-08-01" , "PRESENT"),
(1002 , "2025-08-01" , "PRESENT"),
(1003 , "2025-08-01" , "ABSENT"),
(1004 , "2025-08-01" , "PRESENT"),
(1005 , "2025-08-01" , "PRESENT"),
(1001 , "2025-08-02" , "PRESENT"),
(1002 , "2025-08-02" , "ABSENT"),
(1003 , "2025-08-03" , "ABSENT"),
(1004 , "2025-08-04" , "PRESENT"),
(1005 , "2025-08-05" , "PRESENT");

-- USE Organisation_project;
-- SELECT * FROM Department;
-- SELECT * FROM Employees;
-- SELECT * FROM Projects;
-- SELECT * FROM Attendance;
-- SELECT * FROM Salaries;


-- Q1.Show all the departments located in delhi
SELECT * FROM Department WHERE department_location = 'delhi';


-- Q2.list all the employees hired after 2022
SELECT * FROM Employees WHERE joining_date > '2022-01-01';


-- q3.display employees name along with their department names
SELECT Employees.emp_name AS Employee_name , Department.department_name AS Department_Name 
FROM Employees
INNER JOIN Department
ON Employees.department_id = Department.department_id;


-- q4.Find total number of each employee in each department
SELECT department_name , COUNT(*) AS total_employees
FROM Department 
GROUP BY department_id;


-- q5.Get the highest salary among employee
SELECT Employees.emp_name , Salaries.salary 
FROM Employees
JOIN Salaries
ON Employees.emp_id = Salaries.emp_id 
WHERE Salaries.salary = (SELECT MAX(salary) FROM Salaries);


-- Q6. show all the employees who earn more than 5000    --(two things)
SELECT Employees.emp_name , Salaries.salary 
FROM Employees
JOIN Salaries
ON Employees.emp_id = Salaries.emp_id
WHERE Salaries.salary > 5000;


-- Q7.list all the employees who are absent on 2025-08-01      --(three things)
SELECT Employees.emp_name , Attendance.attendance , Attendance.status 
FROM Employees
JOIN Attendance
ON Employees.emp_id = Attendance.emp_id
WHERE Attendance.status = 'ABSENT' AND Attendance.attendance = '2025-08-01';


-- Q8.COUNT HOW MANY TIMES EACH EMPLOYEE WAS ABSENT
SELECT Employees.emp_name ,  COUNT(*) as Absent_count
FROM Employees
JOIN Attendance
ON Employees.emp_id = Attendance.emp_id
WHERE Attendance.status = 'ABSENT' GROUP BY Employees.emp_name; 

