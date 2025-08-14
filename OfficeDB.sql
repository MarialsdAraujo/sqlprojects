Q1: Create a departments table to categorize employees.

Q2: Retrieve a list of employees with their office location and department.

Q3: Find all employees who do not have a direct manager (reportsTo is NULL).

Q1. 

USE classicmodels;
CREATE TABLE departments (
    department_id INT NULL,  
    department VARCHAR(20) NULL, 
    employeeNumber INT PRIMARY KEY,
    manager_id INT, 
    jobTitle VARCHAR (50) NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(employeeNumber)
);

USE classicmodels;
INSERT INTO departments (department_id, department, employeeNumber, manager_id, jobTitle)
VALUE (10, 'Executive', 1002, NULL, 'President'),
	  (10, 'Executive', 1056, 1002, 'VP Sales'),
      (10, 'Executive', 1076, 1002, 'VP Marketing'),
      (12, 'Sales (APAC)', 1088, 1056, 'Sales Manager (APAC)'),
      (14, 'Sales (EMEA)', 1102, 1056, 'Sale Manager (EMEA)'),
      (16, 'Sales (NA)', 1143, 1056, 'Sales Manager (NA)'),
      (16, 'Sales (NA)', 1165, 1143, 'Sale Rep'),
      (16, 'Sales (NA)', 1166, 1143, 'Sale Rep'),
      (16, 'Sales (NA)', 1188, 1143, 'Sale Rep'),
      (16, 'Sales (NA)', 1216, 1143, 'Sale Rep'),
      (16, 'Sales (NA)', 1286, 1143, 'Sale Rep'),
      (16, 'Sales (NA)', 1323, 1143, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1337, 1102, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1370, 1102, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1401, 1102, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1501, 1102, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1504, 1102, 'Sale Rep'),
      (12, 'Sales (APAC)', 1611, 1088, 'Sale Rep'),
      (12, 'Sales (APAC)', 1612, 1088, 'Sale Rep'),
      (12, 'Sales (APAC)', 1619, 1088, 'Sale Rep'),
      (24, 'Sales', 1621, 1056, 'Sale Rep'),
      (24, 'Sales', 1625, 1621, 'Sale Rep'),
      (14, 'Sales (EMEA)', 1702, 1102, 'Sale Rep');
	
 USE classicmodels;
 SELECT *
 FROM departments
 ORDER BY department_id
 
Q2. 

USE classicmodels;
SELECT d.department_id, d.department, e.lastName, e.firstName, o.officeCode, o.city, o.state 
FROM employees e
LEFT JOIN offices o
	ON e.officeCode = o.officeCode
LEFT JOIN departments d
	ON d.employeeNumber = e.employeeNumber

/*Count Employees in Each Office 
USE classicmodels;
SELECT o.officeCode, o.city, COUNT(e.employeeNumber) AS total_employees
FROM employees e
LEFT JOIN offices o
    ON e.officeCode = o.officeCode
GROUP BY o.officeCode, o.city;
*/

Q3.

USE classicmodels;
SELECT d.employeeNumber, e.lastName, e.firstName, d.department, d.jobTitle, d.manager_id
FROM departments d
JOIN employees e 
	ON d.employeeNumber = e.employeeNumber
WHERE manager_id IS NULL
