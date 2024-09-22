-- INNER JOIN
SELECT ed.employee_id,
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
SELECT ed.employee_id,
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
SELECT es.employee_id,
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
SELECT les.employee_id AS id_santa,
       les.first_name AS first_name_santa,
       les.last_name AS last_name_santa,
       res.employee_id AS id_emp,
       res.first_name AS first_name_emp,
       res.last_name AS last_name_emp
FROM employee_salary AS les
    JOIN employee_salary AS res
        ON les.employee_id + 1 = res.employee_id;

-- Joining multiple tables
SELECT ed.employee_id,
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
        ON es.dept_id = pd.department_id

