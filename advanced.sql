-- CTEs, subquery with better syntax
-- can be used only right after is created
WITH cte_example as (
    SELECT
        ed.gender,
        es.salary,
        AVG(es.salary) AS avg,
        MAX(es.salary) AS max,
        MIN(es.salary) AS min,
        COUNT(es.salary) AS count
    FROM employee_demographics AS ed
    JOIN employee_salary AS es
        ON ed.employee_id = es.employee_id
    GROUP BY ed.gender
)
SELECT *
FROM cte_example;

-- We can have multiple CTEs in row

WITH cte_ed AS (
    SELECT
        employee_id,
        gender,
        birth_date
    FROM employee_demographics
    WHERE birth_date > '1985-01-01'
), cte_es AS (
    SELECT
        employee_id,
        salary
    FROM employee_salary
    WHERE salary > 50000
)
SELECT *
FROM cte_ed
JOIN cte_es
    on cte_ed.employee_id = cte_es.employee_id;

-- Temporary Tables - are only available for the session they where created
-- Create empty temporary table and add data into it
CREATE TEMPORARY TABLE temp_table (
    first_name varchar(50),
    last_name varchar(50),
    favorite_movie varchar(100)
);

INSERT INTO temp_table
VALUES('Clebson', 'Moura', 'Fight Club');

SELECT * FROM temp_table;

-- Create temporary table with a subset of data from another table
CREATE TEMPORARY TABLE salary_over_70k
SELECT *
FROM employee_salary
WHERE salary >= 70000;

SELECT * FROM salary_over_70k;
