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

    JOIN part_1 AS p1 ON p1.employee_id =  e.employee_id

    join part_2 as p2 on p2.employee_id = p1.employee_id ;

```



This SQL query retrieves employee information, their highest salary, the number of projects they're involved in, and then ranks them based on salary and project count. Let's break it down step by step:

WITH part_1 AS (...): This defines a Common Table Expression (CTE) called part_1. CTEs are like temporary tables that exist only for the duration of the query.

select * from (...): This selects all columns from a subquery.
select *, dense_rank() over(PARTITION BY employee_id order by effective_date desc) as rank FROM salary_history: This subquery selects all columns from the salary_history table and adds a rank column using the dense_rank() window function. As explained before, this ranks each employee's salary records by effective_date in descending order (most recent first), with the most recent salary getting rank 1.
WHERE rank = 1: This filters the results of the subquery to include only the rows where rank is 1. This effectively selects the most recent salary record for each employee.
WITH part_2 AS (...): This defines another CTE called part_2.

SELECT employee_id, COUNT(1) AS total_project FROM employee_projects GROUP BY employee_id: This counts the number of projects each employee is involved in. It groups the employee_projects table by employee_id and counts the number of rows in each group, aliasing the count as total_project.
SELECT ... FROM employees e ...: This is the main query.

e.name: Selects the employee's name from the employees table (aliased as e).
p1.salary: Selects the employee's highest salary (from part_1).
p2.total_project: Selects the total number of projects the employee is involved in (from part_2).
RANK() OVER(ORDER BY p1.salary DESC, p2.total_project DESC) as rank: This calculates the rank of each employee based on their highest salary and the number of projects. It orders the employees first by p1.salary in descending order (highest salary first) and then by p2.total_project in descending order (most projects first). The RANK() function assigns ranks, with gaps if there are ties.
FROM employees e JOIN part_1 AS p1 ON p1.employee_id = e.employee_id JOIN part_2 as p2 on p2.employee_id = p1.employee_id: This joins the employees table with part_1 (highest salary) and part_2 (project count) using the employee_id as the join key. This ensures that the correct salary and project count are associated with each employee.
In summary: The query retrieves each employee's name, their highest salary, the number of projects they are involved in, and their rank based on salary (highest salary first) and project count (most projects first).  It uses CTEs to make the query more readable and organized.  part_1 finds the highest salary for each employee, and part_2 counts the number of projects for each employee. The main query then combines this information and calculates the final rank.
