drop table if EXISTS employees
;
drop table if EXISTS departments
;
drop table if EXISTS employee_projects
;
drop TABLE IF EXISTS projects
;
drop table if exists salary_history
;
 
create table employees (employee_id integer, name VARCHAR(100), department_id integer, hire_date DATE)
;
 
insert into employees (employee_id, name, department_id, hire_date)
VALUES 
	('1',' Ant','1','2020-10-20'),
	('2','George','1','2020-08-21'),
	('3','Andrew','2','2010-03-03'),
	('4','Bob','2','2017-04-16'),
	('5','Mark','2','2013-11-18'),
	('6','Mike','3','2010-03-03'),
	('7','Clare','4','2010-03-03'),
	('8','Lucy','4','2010-03-03'),
	('9','Jim','4','2010-03-03'),
	('10','Jane','5','2010-03-03')
 
;
create table employee_projects (employee_id integer, project_id integer, assignment_date date)
;
 
insert into employee_projects (employee_id, project_id, assignment_date)
VALUES 
	('1','4','2022-08-31'),
	('2','1','2021-03-02'),
	('3','6','1997-02-02'),
	('4','2','2021-04-28'),
	('5','2','2021-05-07'),
	('6','4','2022-09-13'),
	('7','4','2022-08-15'),
	('8','5','2020-10-09'),
	('9','5','2020-08-24'),
	('10','1','2021-03-19'),
	('1','1','2021-02-14'),
	('2','6','1997-01-29'),
	('3','2','2021-04-08'),
	('4','3','2022-06-05'),
	('5','4','2022-07-13'),
	('6','1','2021-03-10'),
	('7','1','2021-02-23'),
	('8','5','2020-09-15'),
	('9','5','2020-10-10'),
	('10','1','2021-03-09');
    create table departments (department_id integer, department_name varchar(100))
;
 
insert into departments (department_id, department_name)
VALUES 
	('1','Finance'),
	('2','Foods'),
	('3','Clothing & Home'),
	('4','Retail'),
	('5','International')
 
;
create table departments (department_id integer, department_name varchar(100))
;
 
insert into departments (department_id, department_name)
VALUES 
	('1','Finance'),
	('2','Foods'),
	('3','Clothing & Home'),
	('4','Retail'),
	('5','International')
 
;
 
create table projects (project_id integer, project_name varchar(100), start_date date, end_date date)
;
 
insert into projects (project_id, project_name, start_date, end_date)
VALUES
	('1','Project 1','2021-02-04','2021-03-26'),
	('2','Project 2','2021-04-08','2021-05-08'),
	('3','Project 3','2022-03-04','2022-06-12'),
	('4','Project 4','2022-07-11','2022-09-25'),
	('5','Project 5','2020-08-22','2020-10-11'),
	('6','Project 6','1997-01-01','1997-02-20')
 
;
 
create table salary_history (employee_id integer, effective_date date, salary decimal(10,2))
;
 
insert into salary_history (employee_id, effective_date, salary)
VALUES
	('1','2020-10-20','10000.30'),
	('1','2021-08-20','14000.56'),
	('2','2020-08-21','10000.30'),
	('3','2010-03-03','10000.30'),
	('4','2017-04-16','10000.30'),
	('5','2013-11-18','10000.30'),
	('6','2010-03-03','10000.30'),
	('7','2010-03-03','10000.30'),
	('8','2010-03-03','10000.30'),
	('9','2010-03-03','10000.30'),
	('10','2010-03-03','10000.30')
;
create table salary_history (employee_id integer, effective_date date, salary decimal(10,2))
;
 
insert into salary_history (employee_id, effective_date, salary)
VALUES
	('1','2020-10-20','10000.30'),
	('1','2021-08-20','14000.56'),
	('2','2020-08-21','10000.30'),
	('3','2010-03-03','10000.30'),
	('4','2017-04-16','10000.30'),
	('5','2013-11-18','10000.30'),
	('6','2010-03-03','10000.30'),
	('7','2010-03-03','10000.30'),
	('8','2010-03-03','10000.30'),
	('9','2010-03-03','10000.30'),
	('10','2010-03-03','10000.30')
;
/* 
 Write a SQL query to list the names of all employees and their department names. 
 SELECT e.name, d.department_name FROM employees as e INNER JOIN departments as d on e.department_id = d.department_id;


Write a SQL query to find the number of employees in each department. 
SELECT d.department_name, q.total from departments as d 
join (
select count(1) as total, department_id from employees group by department_id) as q on q.department_id =  d.department_id ;

*/

/* 
Write a SQL query to rank employees based on their current salary and based on the number of projects they have worked on.
Combine these two rankings into a single query that provides: 
1. Employee name 
2. Their current salary 
3. The number of projects they have worked on 
4. A combined rank where the primary ranking is based on current salary and the secondary ranking is based on the number of projects
(e.g., if two employees have the same salary, rank them by the number of projects they have worked on). 
*/

WITH part_1 AS
  (
  select * from (
    select *, dense_rank() over(PARTITION BY employee_id order by effective_date desc) as rank 
    FROM salary_history
  ) WHERE rank = 1
 ),
 
  part_2 AS (
    SELECT employee_id, COUNT(1) AS total_project FROM employee_projects GROUP BY employee_id
    )
    
    select
      e.name, 
      p1.salary, 
      p2.total_project,
      RANK() OVER(ORDER BY p1.salary DESC, p2.total_project DESC ) as rank
    FROM employees e  
    JOIN part_1 AS p1 ON p1.employee_id =  e.employee_id
    join part_2 as p2 on p2.employee_id = p1.employee_id ;
```
 
