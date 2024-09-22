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

