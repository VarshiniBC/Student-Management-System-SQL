/* =========================================
   FINAL SQL ANALYSIS QUERIES
   Student Management System
   ========================================= */


--STUDENT INSIGHTS


-- 1. Total number of students
SELECT COUNT(*) AS total_students
FROM Students;

-- 2. Students by department
SELECT d.department_name, COUNT(s.student_id) AS total_students
FROM Students s
JOIN Departments d
    ON s.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_students DESC;

-- 3. Students who haven't enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e
    ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 4. Students who scored above the overall average
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
WHERE m.marks > (SELECT AVG(marks) FROM Marks);

-- 5. Top-performing students (by average marks)
SELECT TOP 5
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(m.marks) AS average_marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_marks DESC;


-- COURSE INSIGHTS


-- 6. Number of courses per department
SELECT d.department_name, COUNT(c.course_id) AS total_courses
FROM Courses c
JOIN Departments d
    ON c.department_id = d.department_id
GROUP BY d.department_name;

-- 7. Average marks by course
SELECT course_id, AVG(marks) AS average_marks
FROM Marks
GROUP BY course_id
ORDER BY average_marks DESC;

-- 8. Course enrollment counts
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS total_enrolled
FROM Courses c
LEFT JOIN Enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrolled DESC;

-- 9. Student with the highest marks in each course
WITH RankedMarks AS (
    SELECT
        student_id,
        course_id,
        marks,
        RANK() OVER (PARTITION BY course_id ORDER BY marks DESC) AS course_rank
    FROM Marks
)
SELECT student_id, course_id, marks
FROM RankedMarks
WHERE course_rank = 1;



--  DEPARTMENT INSIGHTS


-- 10. Department-wise average marks
SELECT
    d.department_name,
    AVG(m.marks) AS department_average
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
JOIN Departments d
    ON s.department_id = d.department_id
GROUP BY d.department_name
ORDER BY department_average DESC;

-- 11. Department performance summary
SELECT
    d.department_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    AVG(m.marks) AS average_marks,
    MAX(m.marks) AS highest_marks,
    MIN(m.marks) AS lowest_marks
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
JOIN Departments d
    ON s.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_marks DESC;


--  RANKINGS (WINDOW FUNCTIONS)


-- 12. Rank students overall based on average marks
WITH StudentAverage AS (
    SELECT
        student_id,
        AVG(marks) AS average_marks
    FROM Marks
    GROUP BY student_id
)
SELECT
    student_id,
    average_marks,
    RANK() OVER (ORDER BY average_marks DESC) AS overall_rank
FROM StudentAverage
ORDER BY overall_rank;

-- 13. Rank students within each department using ROW_NUMBER()
SELECT
    s.student_id,
    s.first_name,
    s.department_id,
    m.marks,
    ROW_NUMBER() OVER (PARTITION BY s.department_id ORDER BY m.marks DESC) AS dept_row_number
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id;

-- 14. Rank courses by average marks using DENSE_RANK()
SELECT
    course_id,
    AVG(marks) AS average_marks,
    DENSE_RANK() OVER (ORDER BY AVG(marks) DESC) AS course_rank
FROM Marks
GROUP BY course_id;



-- COMBINED / SUMMARY


-- 15. Student performance summary
-- (combines joins, aggregation, and CASE for a full analyst-style report)
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    d.department_name,
    AVG(m.marks) AS average_marks,
    CASE
        WHEN AVG(m.marks) >= 90 THEN 'Excellent'
        WHEN AVG(m.marks) >= 75 THEN 'Good'
        WHEN AVG(m.marks) >= 50 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM Students s
JOIN Marks m
    ON s.student_id = m.student_id
JOIN Departments d
    ON s.department_id = d.department_id
GROUP BY s.student_id, s.first_name, s.last_name, d.department_name
ORDER BY average_marks DESC;
