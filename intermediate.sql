-- INNER JOIN
SELECT
    ed.employee_id,
    ed.first_name,
    ed.last_name,
    ed.age,
    ed.gender,
    ed.birth_date,
    es.occupation,
    es.salary
FROM employee_demographics AS ed
    INNER JOIN employee_salary AS es
        ON ed.employee_id = es.employee_id;

-- LEFT OUTER JOIN
SELECT
    ed.employee_id,
    ed.first_name,
    ed.last_name,
    ed.age,
    ed.gender,
    ed.birth_date,
    es.occupation,
    es.salary
FROM employee_demographics AS ed
    LEFT OUTER JOIN employee_salary AS es
        ON ed.employee_id = es.employee_id;

-- RIGHT OUTER JOIN
SELECT
    es.employee_id,
    es.first_name,
    es.last_name,
    ed.age,
    ed.gender,
    ed.birth_date,
    es.occupation,
    es.salary
FROM employee_demographics AS ed
    RIGHT OUTER JOIN employee_salary AS es
        ON ed.employee_id = es.employee_id;

-- SELF JOIN
SELECT
    les.employee_id AS id_santa,
    les.first_name  AS first_name_santa,
    les.last_name   AS last_name_santa,
    res.employee_id AS id_emp,
    res.first_name  AS first_name_emp,
    res.last_name   AS last_name_emp
FROM employee_salary AS les
    JOIN employee_salary AS res
        ON les.employee_id + 1 = res.employee_id;

-- Joining multiple tables
SELECT
    ed.employee_id,
    ed.first_name,
    ed.last_name,
    ed.age,
    ed.gender,
    ed.birth_date,
    es.occupation,
    es.salary,
    pd.department_name
FROM employee_demographics AS ed
    INNER JOIN employee_salary AS es
        ON ed.employee_id = es.employee_id
    LEFT OUTER JOIN parks_departments pd
        ON es.dept_id = pd.department_id;

-- UNION
-- by default UNION is set to DISTINCT
SELECT employee_id, first_name, last_name
FROM employee_demographics
UNION
SELECT employee_id, first_name, last_name
FROM employee_salary;

-- we can change this behavior with ALL
SELECT employee_id, first_name, last_name
FROM employee_demographics
UNION ALL
SELECT employee_id, first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, '40+ Man' AS label
FROM employee_demographics
WHERE age > 40
  AND gender = 'Male'
UNION ALL
SELECT first_name, last_name, '40+ Lady' AS label
FROM employee_demographics
WHERE age > 40
  AND gender = 'Female'
UNION ALL
SELECT first_name, last_name, 'Highly Paid' AS label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

-- String Functions

-- LENGTH give how many character a string have
SELECT first_name, LENGTH(first_name) as first_name_length
FROM employee_demographics
ORDER BY first_name_length;

-- UPPER make a string uppercase
SELECT UPPER('sky');

-- LOWER make a string lowercase
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name) as first_name_uppercase
FROM employee_demographics;

-- TRIM remove spaces before and after
SELECT TRIM('       sky        ');

-- LTRIM remove spaces before
SELECT LTRIM('       sky        ');

-- RTRIM remove spaces after
SELECT RTRIM('       sky        ');

-- LEFT take n characters from the start
SELECT
    first_name,
    LEFT(first_name, 4)
FROM employee_demographics;

-- RIGHT take n characters from the end
SELECT
    first_name,
    RIGHT(first_name, 4)
FROM employee_demographics;

-- SUBSTRING take two arguments, position and length
-- position is where we start(if is a negative number, we count from the end)
-- length is how many character we should take (if not present, it take until the end of the string)
SELECT
    first_name,
    SUBSTRING(first_name, 3, 2)
FROM employee_demographics;

-- can be used with dates
SELECT
    birth_date,
    SUBSTRING(birth_date, 6, 2)
FROM employee_demographics;

-- REPLACE match and replace, it's case sensitive
SELECT
    first_name,
    REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

-- LOCATE show the position where it match in a string
-- isn't case sensitive
SELECT LOCATE('b', 'Clebson');

SELECT
    first_name,
    LOCATE('an', first_name)
FROM employee_demographics;

-- CONCAT concatenate strings
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) as full_name
FROM employee_demographics;

-- Case Statements, it's like if in programing languages
SELECT
    first_name,
    last_name,
    age,
    CASE
        WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 and 49 THEN 'Old'
        WHEN age >= 50 THEN "On Death's Door"
    END AS age_bracket
FROM employee_demographics;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus
SELECT
    CONCAT(first_name, ' ', last_name) as full_name,
    salary,
    dept_id,
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary > 50000 THEN salary * 1.07
    END AS new_salary,
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
    END AS bonus
FROM employee_salary;

-- Window Functions
-- Both GROUP BY and window functions are powerful tools in SQL.
-- Choosing between them depends on the specific requirements of your query
-- and the kind of analysis you want to perform.
-- If you need to create summaries (e.g., total sales by product), use GROUP BY.
-- If you need to analyze data while maintaining the detail
-- (e.g., cumulative totals or rankings), use window functions.
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id
GROUP BY ed.gender;

-- PARTITION BY
SELECT
    ed.first_name,
    gender,
    AVG(salary) OVER(PARTITION BY gender) AS avg_salary
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- PARTITION BY with ORDER BY
SELECT
    ed.first_name,
    gender,
    salary,
    SUM(salary) OVER(PARTITION BY gender ORDER BY es.employee_id) AS rolling_total
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

-- ROW NUMBER
SELECT
    ed.first_name,
    gender,
    es.salary,
    ROW_NUMBER() OVER (PARTITION BY gender ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics AS ed
JOIN employee_salary AS es
    ON ed.employee_id = es.employee_id;

