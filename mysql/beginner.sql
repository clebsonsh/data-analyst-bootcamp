SELECT *
FROM employee_demographics;

SELECT first_name,
       last_name,
       birth_date,
       age,
       (age + 10) * 10 + 10
FROM employee_demographics;
-- PEMDAS stands for Parentheses, Exponents, Multiplication, Division, Addition, and Subtraction,
-- which is the order of operations in math. It helps you solve expressions correctly by following this sequence.

SELECT DISTINCT first_name, gender
FROM employee_demographics;

SELECT *
FROM employee_salary
WHERE salary <= 50000;

SELECT *
FROM employee_demographics
WHERE gender = 'Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

-- AND, OR, NOT -- Logical Operators
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
  AND gender = 'Male';

SELECT *
FROM employee_demographics
WHERE (
    first_name = 'Leslie'
        AND age = 44
    )
   OR age > 55;

-- LIKE Statement % or _
-- We use % to say anything before or after it
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

-- We use _ to say an character in this spot
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';

-- We can combine both
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%';

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '197_%';

-- GROUP BY
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(*)
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

-- ORDER BY
SELECT *
FROM employee_salary
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY gender, age;

-- HAVING vs WHERE
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;

-- LIMIT
SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;

-- Aliasing
SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;
