# Student-Management-System-SQL
# Student Management System | SQL Data Analysis Project

## Overview

This project is a relational database and SQL analysis project built using **Microsoft SQL Server**.

The project manages student-related data across departments, courses, enrollments, and academic marks. It demonstrates how SQL can be used not only to store and manage data, but also to extract meaningful insights from a relational database.

The project was created as part of my journey toward becoming a **Data Analyst** and focuses on practical SQL concepts commonly used in data-related roles.

---

## Tools & Technologies

* **Microsoft SQL Server**
* **SQL Server Management Studio (SSMS)**
* **SQL**
* **dbdiagram.io**

---

## Database Tables

The database consists of five main tables:

| Table         | Description                         |
| ------------- | ----------------------------------- |
| `Departments` | Stores department information       |
| `Students`    | Stores student details              |
| `Courses`     | Stores course information           |
| `Enrollments` | Records student course enrollments  |
| `Marks`       | Stores student academic performance |

These tables are connected using **Primary Keys** and **Foreign Keys** to maintain data integrity and represent real-world relationships.

---

## Project Structure

```text id="mdywba"
Student-Management-System-SQL/
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_sql_queries.sql
│   └── 03_analysis_queries.sql
│
├── schema/
│   └── database_schema.png
│
└── README.md
```

### File Description

**01_database_setup.sql**
Creates the database tables and inserts sample data.

**02_sql_queries.sql**
Contains SQL queries demonstrating fundamental and intermediate SQL concepts.

**03_analysis_queries.sql**
Contains analytical SQL queries used to generate insights from the student database.

---

## SQL Skills Demonstrated

This project covers:

* Database and table creation
* Data insertion and retrieval
* Filtering with `WHERE`
* Sorting with `ORDER BY`
* Aggregate functions
* `GROUP BY` and `HAVING`
* `INNER JOIN` and other joins
* `CASE WHEN`
* String and mathematical functions
* Subqueries
* Data analysis queries
* Window functions
* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`

---

## Analysis Performed

The SQL analysis queries explore different aspects of the student data, including:

* Student distribution across departments
* Course and enrollment information
* Student academic performance
* Average and overall marks analysis
* Department-level insights
* Identification of high-performing students
* Student rankings
* Analytical insights using SQL window functions

---

## Database Schema

The database follows a relational structure connecting:

```text id="h96u8m"
Departments
    │
    ├── Students
    │      │
    │      ├── Enrollments ─── Courses
    │      │
    │      └── Marks ───────── Courses
    │
    └── Courses
```

The complete database schema diagram is available in the **schema** folder.

---

## How to Use This Project

1. Clone or download this repository.
2. Open **SQL Server Management Studio (SSMS)**.
3. Run `01_database_setup.sql` to create the tables and insert the data.
4. Run `02_sql_queries.sql` to explore SQL concepts and queries.
5. Run `03_analysis_queries.sql` to view the final data analysis queries.

---

## Key Takeaways

Through this project, I gained practical experience in:

* Designing a relational database
* Working with multiple related tables
* Writing SQL queries for data analysis
* Combining data using joins
* Summarizing data using aggregate functions
* Performing analytical calculations with window functions
* Extracting meaningful insights from structured data
