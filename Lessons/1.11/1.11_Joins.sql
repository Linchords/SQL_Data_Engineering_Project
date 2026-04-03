--Joins
-- There are 4 types of Joins (Left Join, Right Join, Inner Join and Full Outer Join)

-- LEFT JOIN 
-- Left returns all records from the left most table(Table A) and the matching rows from the right table

SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM 
    job_postings_fact AS jpf 
LEFT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
LIMIT 10;


-- RIGHT JOIN
-- Returns all records from the right table and matching values from the left table.
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM 
    job_postings_fact AS jpf 
RIGHT JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
LIMIT 10;

-- INNER JOIN
-- Returns records only if theres a match in both tables being joined
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM 
    job_postings_fact AS jpf 
INNER JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
LIMIT 10;

-- FULL OUTER JOIN
-- Returns all records from both tables..This ensures data completeness
SELECT
    jpf.job_id,
    jpf.job_title_short,
    cd.company_id,
    cd.name AS company_name,
    jpf.job_location
FROM 
    job_postings_fact AS jpf 
FULL OUTER JOIN company_dim AS cd 
    ON jpf.company_id = cd.company_id
LIMIT 10;

SHOW TABLES FROM data_jobs;

DESC skills_dim;


SELECT 
    * 
FROM 
    skills_dim
LIMIT 
    10;

SELECT 
    * 
FROM 
    skills_job_dim
LIMIT 10;

SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skillS
FROM 
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;


SELECT 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skillS
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id;

--HOW DOES SQL WORK
-- write a query > sent to > database engine <> Results or output are sent to local machine.
 -- DATABASE ENGINE
     -- Three main components of a database engine (Parser, Optimizer, Executor) 
 -- PARSER 
    -- PARSER Validates SQL text; builds out an internal tree structure called parse tree
 -- OPTIMIZER 
    -- Finds the most efficient ways to run your query faster.
-- EXECUTOR
    -- Runs the optimize plans step by step; reads data applies filters and return records.
-- SQL CLAUSE ORDER
    -- S -> SELECT column 1, column 2 ...
    -- F -> FROM table 1
    -- J -> JOIN table 2
        -- ON join_condition
    -- W -> WHERE condition 
    -- G -> GROUP BY column
    -- H -> HAVING condition
    -- O -> ORDER BY column
    -- L -> LIMIT number

--EXAMPLE
-- EXPLAIN STATEMENT -> Explains the execution plan of your code.

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY cd.name
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC
LIMIT 10;





