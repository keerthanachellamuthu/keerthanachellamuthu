window functions 
window functions


Window functions in SQL perform calculations across a set of rows that are related to the current row, without grouping the rows themselves like a regular aggregate function (e.g., SUM, AVG, COUNT).  They're incredibly powerful for tasks like calculating running totals, ranking, moving averages, and more.

Here's a breakdown of key concepts and examples:

Core Concepts:

OVER() Clause: This is the defining characteristic of a window function. It specifies the "window" of rows the function operates on.
PARTITION BY: Divides the rows into partitions. The window function is applied separately to each partition. If omitted, the function operates on the entire result set.
ORDER BY: Specifies the order of rows within each partition. This is crucial for functions that depend on order (e.g., ROW_NUMBER, LAG, LEAD).
ROWS or RANGE Clause (Optional): Further refines the window within a partition. Allows you to specify a specific range of rows relative to the current row (e.g., "the previous row," "the next two rows," or a range of values). This is sometimes called a "window frame".
Common Window Functions:

Ranking Functions:

ROW_NUMBER(): Assigns a unique sequential integer to each row within a partition.
RANK(): Assigns a rank to each row within a partition, with gaps for ties. If two rows are tied, they get the same rank, and the next rank is skipped.
DENSE_RANK(): Similar to RANK(), but assigns consecutive ranks even with ties. No ranks are skipped.
NTILE(n): Divides the rows within a partition into n groups (tiles) and assigns a tile number to each row.
Value Functions:

LAG(value, offset, default): Accesses data from a row before the current row within the partition.
LEAD(value, offset, default): Accesses data from a row after the current row within the partition.
FIRST_VALUE(value): Returns the first value in the partition.
LAST_VALUE(value): Returns the last value in the partition.
Aggregate Functions as Window Functions:

SUM(), AVG(), COUNT(), MIN(), MAX(): These can be used as window functions to calculate aggregates over a window of rows without grouping.
Examples:

Let's say we have a table called sales with columns order_date, region, and amount.

Running Total:
SQL

SELECT
    order_date,
    region,
    amount,
    SUM(amount) OVER (PARTITION BY region ORDER BY order_date) AS running_total
FROM sales;
This calculates the running total of sales for each region, ordered by order_date.

Rank within Region:
SQL

SELECT
    order_date,
    region,
    amount,
    RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS region_rank
FROM sales;
This assigns a rank to each sale within each region based on the amount (highest amount gets rank 1).

Previous Month's Sales:
SQL

SELECT
    order_date,
    region,
    amount,
    LAG(amount, 1, 0) OVER (PARTITION BY region ORDER BY order_date) AS previous_month_sales
FROM sales;
This shows the sales amount from the previous month for each region.  LAG(amount, 1, 0) means "get the amount from 1 row prior; if there's no previous row, use 0."

Moving Average:
SQL

SELECT
    order_date,
    region,
    amount,
    AVG(amount) OVER (PARTITION BY region ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_average
FROM sales;
This calculates the 3-month moving average of sales for each region. ROWS BETWEEN 2 PRECEDING AND CURRENT ROW defines the window frame.

Key Advantages of Window Functions:

Calculations without Grouping: Perform calculations related to a group of rows without collapsing the rows into a single summary row.
Simplified Queries: Avoid complex self-joins or subqueries for tasks like running totals or rankings.
Improved Performance: Often more efficient than equivalent queries using joins or subqueries.
Window functions are a fundamental part of advanced SQL and are essential for many data analysis tasks.  Understanding how to use them effectively will greatly enhance your ability to work with data.
