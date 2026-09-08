SELECT DB_NAME() AS CurrentDatabase;
USE StudentManagementSystem;

SELECT *
FROM Students;

SELECT first_name, last_name, gender
FROM Students;

SELECT DISTINCT gender
FROM Students;

SELECT TOP 10 *
FROM Students;


SELECT *
FROM Students
ORDER BY first_name ASC;

SELECT *
FROM Students
ORDER BY date_of_birth DESC;


SELECT first_name, last_name
FROM Students
WHERE department_id = 1
AND gender = 'Female';

SELECT *
FROM Students
WHERE department_id = 1
OR department_id = 2;


SELECT *
FROM Students
WHERE NOT department_id = 1;

SELECT *
FROM Students
WHERE department_id IN (1, 2, 3);


SELECT *
FROM Students
WHERE student_id BETWEEN 120 AND 140;


SELECT *
FROM Students
WHERE first_name LIKE 'A%';

SELECT *
FROM Students
WHERE first_name LIKE '%an%';

SELECT *
FROM Students
WHERE date_of_birth < '2005-01-01';

SELECT *
FROM Marks
WHERE course_id = 101
AND marks BETWEEN 70 AND 90;

--Aggregate Functions
--Count() function

SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

SELECT course_id, COUNT(DISTINCT student_id) AS total_students
FROM Enrollments
GROUP BY course_id
ORDER BY total_students DESC;

--Sum() Function
SELECT department_id, SUM(credits) AS total_credits
FROM Courses
GROUP BY department_id;

SELECT 
    e.student_id,
    SUM(c.credits) AS total_credits
FROM Enrollments e
JOIN Courses c
    ON e.course_id = c.course_id
GROUP BY e.student_id
ORDER BY total_credits DESC;

--Avg() Functions
SELECT 
    course_id,
    AVG(marks) AS average_marks
FROM Marks
GROUP BY course_id
ORDER BY average_marks DESC;

SELECT 
    student_id,
    AVG(marks) AS average_marks
FROM Marks
GROUP BY student_id
ORDER BY average_marks DESC;

--Min() Functions
SELECT 
    course_id,
    MIN(marks) AS lowest_marks
FROM Marks
GROUP BY course_id;

SELECT 
    department_id,
    Min(date_of_birth) AS oldest_student_birthdate
FROM Students
GROUP BY department_id;

--Min() Functions
SELECT 
    course_id,
    MAX(marks) AS highest_marks
FROM Marks
GROUP BY course_id;

SELECT 
    course_id,
    MAX(enrollment_date) AS latest_enrollment
FROM Enrollments
GROUP BY course_id;

--GROUPBY AND HAVING 
select avg(marks) as average_marks,course_id
from Marks
group by Course_id
having avg(marks)>75;

select department_id,count(student_id) as total_students
from Students
group by department_id
having count(student_id)>15;

SELECT 
    student_id,
    course_id,
    AVG(marks) AS average_marks
FROM Marks
GROUP BY student_id, course_id;

--Joins

select first_name,last_name,department_name
from Students
join Departments
on Students.department_id=Departments.department_id;

SELECT
    s.first_name,
    c.course_name,
    m.marks
FROM Students s
INNER JOIN Enrollments e
    ON s.student_id = e.student_id
INNER JOIN Courses c
    ON e.course_id = c.course_id
INNER JOIN Marks m
    ON e.student_id = m.student_id
    AND e.course_id = m.course_id;


    SELECT
    s.first_name,
    s.last_name,
    d.department_name
FROM Students s
INNER JOIN Departments d
    ON s.department_id = d.department_id;

--Left Joins
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name
FROM Students s
LEFT JOIN Departments d
    ON s.department_id = d.department_id;

    SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
LEFT JOIN Courses c
    ON e.course_id = c.course_id;

    SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    m.marks
FROM Students s
LEFT JOIN Marks m
    ON s.student_id = m.student_id
LEFT JOIN Courses c
    ON m.course_id = c.course_id;

--Right Joins
SELECT
    d.department_id,
    d.department_name,
    s.student_id,
    s.first_name,
    s.last_name
FROM Students s
RIGHT JOIN Departments d
    ON s.department_id = d.department_id;


SELECT
    c.course_id,
    c.course_name,
    s.student_id,
    s.first_name,
    s.last_name
FROM Students s
RIGHT JOIN Enrollments e
    ON s.student_id = e.student_id
RIGHT JOIN Courses c
    ON e.course_id = c.course_id;

    --Case When
    SELECT
    student_id,
    course_id,
    marks,
    CASE
        WHEN marks >= 50 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM Marks;

SELECT
    student_id,
    course_id,
    marks,
    CASE
        WHEN marks BETWEEN 90 AND 100 THEN 'Excellent'
        WHEN marks BETWEEN 80 AND 89 THEN 'Very Good'
        WHEN marks BETWEEN 70 AND 79 THEN 'Good'
        WHEN marks BETWEEN 60 AND 69 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_level
FROM Marks;

SELECT
    s.first_name,
    s.last_name,
    d.department_name,
    CASE
        WHEN s.department_id = 1 THEN 'Technology'
        WHEN s.department_id = 2 THEN 'Management'
        WHEN s.department_id = 3 THEN 'Science'
        ELSE 'Other'
    END AS student_category
FROM Students s
JOIN Departments d
    ON s.department_id = d.department_id;

    SELECT
    course_id,
    AVG(marks) AS average_marks,
    CASE
        WHEN AVG(marks) BETWEEN 85 AND 100 THEN 'Excellent Course'
        WHEN AVG(marks) BETWEEN 75 AND 84 THEN 'Good Course'
        WHEN AVG(marks) BETWEEN 60 AND 74 THEN 'Average Course'
        ELSE 'Weak Course'
    END AS course_performance
FROM Marks
GROUP BY course_id;

SELECT
    student_id,
    course_id,
    marks,
    CASE
        WHEN marks >= 90 AND course_id = 101
            THEN 'Top Performer - Course 101'
        WHEN marks BETWEEN 90 AND 100
            THEN 'Excellent'
        WHEN marks BETWEEN 75 AND 89
            THEN 'Good'
        WHEN marks BETWEEN 50 AND 74
            THEN 'Pass'
        ELSE 'Fail'
    END AS performance
FROM Marks;

--Subquery
SELECT
    m.student_id,
    m.course_id,
    m.marks
FROM Marks m
WHERE m.marks > (
    SELECT AVG(m2.marks)
    FROM Marks m2
    WHERE m2.course_id = m.course_id
);

SELECT
    student_id,
    course_id,
    marks
FROM Marks m
WHERE marks = (
    SELECT MAX(m2.marks)
    FROM Marks m2
    WHERE m2.course_id = m.course_id
);

SELECT
    course_id,
    AVG(marks) AS course_average
FROM Marks
GROUP BY course_id
HAVING AVG(marks) > (
    SELECT AVG(marks)
    FROM Marks
);

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(m.marks) AS student_average
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
HAVING AVG(m.marks) > (
    SELECT AVG(student_average)
    FROM (
        SELECT
            AVG(marks) AS student_average
        FROM Marks
        GROUP BY student_id
    ) AS StudentAverages
);

--CTEs
WITH AverageMarks AS (
    SELECT AVG(marks) AS overall_average
    FROM Marks
)
SELECT
    m.student_id,
    m.course_id,
    m.marks,
    a.overall_average
FROM Marks m
CROSS JOIN AverageMarks a
WHERE m.marks > a.overall_average;


WITH StudentAverage AS (
    SELECT
        student_id,
        AVG(marks) AS average_marks
    FROM Marks
    GROUP BY student_id
)
SELECT
    student_id,
    average_marks
FROM StudentAverage
WHERE average_marks > 80
ORDER BY average_marks DESC;


WITH StudentPerformance AS (
    SELECT
        s.student_id,
        s.first_name,
        s.last_name,
        s.department_id,
        AVG(m.marks) AS average_marks
    FROM Students s
    JOIN Marks m
        ON s.student_id = m.student_id
    GROUP BY
        s.student_id,
        s.first_name,
        s.last_name,
        s.department_id
),
DepartmentMax AS (
    SELECT
        department_id,
        MAX(average_marks) AS highest_average
    FROM StudentPerformance
    GROUP BY department_id
)
SELECT
    sp.student_id,
    sp.first_name,
    sp.last_name,
    sp.department_id,
    sp.average_marks
FROM StudentPerformance sp
JOIN DepartmentMax dm
    ON sp.department_id = dm.department_id
    AND sp.average_marks = dm.highest_average;

    --Window Functions
SELECT
    student_id,
    course_id,
    marks,
    ROW_NUMBER() OVER (ORDER BY marks DESC) AS row_number
FROM Marks;

SELECT
    student_id,
    course_id,
    marks,
    RANK() OVER (ORDER BY marks DESC) AS student_rank
FROM Marks;

SELECT
    student_id,
    course_id,
    marks,
    DENSE_RANK() OVER (ORDER BY marks DESC) AS student_rank
FROM Marks;

SELECT
    student_id,
    course_id,
    marks,
    RANK() OVER (
        PARTITION BY course_id
        ORDER BY marks DESC
    ) AS course_rank
FROM Marks;

WITH RankedMarks AS (
    SELECT
        student_id,
        course_id,
        marks,
        RANK() OVER (
            PARTITION BY course_id
            ORDER BY marks DESC
        ) AS course_rank
    FROM Marks
)
SELECT
    student_id,
    course_id,
    marks
FROM RankedMarks
WHERE course_rank = 1;

