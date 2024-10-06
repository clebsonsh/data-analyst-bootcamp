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

-- Store Procedure - A piece of sql code that can be reused
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();

-- Store Procedure with multiple queries
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
    SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
    SELECT *
    FROM employee_salary
    WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries2();

-- Store Procedure with params
DELIMITER $$
CREATE PROCEDURE get_salary_by_employee_id(p_employee_id INT)
BEGIN
    SELECT salary
    FROM employee_salary
    WHERE employee_id = p_employee_id;
END $$
DELIMITER ;

CALL get_salary_by_employee_id(1);

-- Triggers and Events
-- a trigger is code that will run when something occur in a table
DELIMITER $$
CREATE TRIGGER employee_created
    AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
    INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, "Clebson", "Moura", "HTMX CTO", 700000, null);

SELECT * FROM employee_salary;
SELECT * FROM employee_demographics;

-- Events are similar to triggers but they run on a schedule
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
    BEGIN
        DELETE
        FROM employee_demographics
        WHERE age >= 60;
    END $$
DELIMITER ;

-- If events are not running make sure scheduler is on
SHOW VARIABLES LIKE "event%";
SET GLOBAL event_scheduler=ON;
