SELECT 
    table_name,
    column_name,
    data_type
FROM 
    information_schema.columns
WHERE table_name = 'job_postings_fact';

-- Cast Operators 
-- Cast is used to convert a certain value in a particular data type to another data type 

SELECT CAST(123 AS VARCHAR);

-- Example 2
SELECT 
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR), -- "More" unique identifier / || is used to concatenate 
    CAST(job_work_from_home AS INT) AS job_work_from_home, -- from boolean to numeric value
    CAST(job_posted_date AS DATE) AS job_posted_date, -- from timestamp to date only
    CAST(salary_year_avg AS DECIMAL(10, 0)) AS salary_year_avg -- from double to no decimal places
FROM
job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;


-- In other DBs you can change a data type by using the ::
SELECT 
    job_id::VARCHAR || '-' || company_id::VARCHAR AS unique_id, -- "More" unique identifier / || is used to concatenate 
    job_work_from_home::INT AS job_work_from_home, -- from boolean to numeric value
    job_posted_date::DATE AS job_posted_date, -- from timestamp to date only
    salary_year_avg::DECIMAL(10,0) AS salary_year_avg  -- from double to no decimal places
FROM 
    job_postings_fact
LIMIT 10;

-- DQL (Data Query Language) e.g SELECT, FROM , WHERE, ORDER BY, GROUP BY
-- DML (Data Manipulation Language) e.g INSERT, UPDATE, DELETE
-- DDL (Data Definitionn Language) e.g CREATE, DROP, ALTER...TRUNCATE


