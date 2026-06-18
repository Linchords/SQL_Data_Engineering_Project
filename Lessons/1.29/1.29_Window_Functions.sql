-- Window functions
-- Window functions lets you add context without destroying rows which is bassically the job
-- Count Rows - Aggreagation Only

SELECT 
    COUNT(*)
FROM 
    job_postings_fact;

-- Count Rows -- Window Function
SELECT 
    job_id,
    COUNT(*) OVER () -- the key word 'OVER' indicates that it is a windows function
FROM 
    job_postings_fact;
-- Syntax 
-- 3 buckets for window function
-- Aggregate , Row & Rank , Navigation 

-- Breaking down partition by
SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
-- ORDER BY 
--     RANDOM() DESC
LIMIT 10;

-- PARTITION BY & ORDER BY - Running Average Hourly Salary
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL AND
    job_title_short = 'Data Engineer'
ORDER BY
    job_title_short,
    job_posted_date
LIMIT 10;


-- Using Rank Example for moth partition by and order by
SELECT 
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC,
    job_title_short
LIMIT 10;

-- AGGREGATE FUNCTIONS
SELECT 
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    MAX(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_avg_hourly_by_title
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL AND
    job_title_short = 'Data Engineer'
ORDER BY
    job_title_short,
    job_posted_date
LIMIT 10;

-- ROW & RANK FUNCTIONS
-- DENSE RANK 
SELECT 
    job_id,
    job_title_short,
    salary_hour_avg,
    DENSE_RANK() OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY
    salary_hour_avg DESC
LIMIT 140;

-- ROW_NUMBER() -- PROVIDING A NEW Jjob_id
SELECT 
    *,
    ROW_NUMBER() OVER(
        ORDER BY job_posted_date
    )
FROM 
    job_postings_fact
ORDER BY 
    job_posted_date
LIMIT 20;


-- NAVIGATION FUNCTION
-- LAG - TIME BASED COMPARISON OF COMPANY YEARLY SALARY
SELECT 
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LAG(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_postings_salary,
    salary_year_avg - LAG(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change,
FROM  
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY
    company_id, 
    job_posted_date
LIMIT 60;

-- LEAD - TIME BASED COMPARISON OF COMPANY YEARLY SALARY
SELECT 
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LEAD(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_postings_salary,
    salary_year_avg - LEAD(salary_year_avg) OVER(
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change,
FROM  
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
ORDER BY
    company_id, 
    job_posted_date
LIMIT 60;

