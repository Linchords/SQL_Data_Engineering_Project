-- LENGTH & COUNT
-- Count the number of characters in a string 
SELECT LENGTH('SQL');
SELECT CHAR_LENGTH('SQL');

-- CASE CONVERSION 
-- Used to upper or lower case characters

SELECT LOWER('SQL');
SELECT UPPER('sql');

-- SUBSTRING/EXTRACTION 
SELECT LEFT('SQL', 2); -- Left
SELECT RIGHT('SQL', 2); -- Right
SELECT SUBSTRING('SQL', 2, 2); -- Subtring

-- CONCATENATION
SELECT CONCAT('SQL', '-', 'Functions');
SELECT CONCAT('SQL' || '-' || 'Functions');

-- TRIMMING 
SELECT TRIM('SQL');

-- REPLACEMENT 
SELECT REPLACE('SQL', 'Q', '_');

-- REGEXP 
SELECT  REGEXP_REPLACE('data.nerd@gmail.com', )

-- Final Example - Cleanup this using text function
WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)

SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%'
         AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%'
         AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        WHEN job_title_clean LIKE '%data%'
         AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        ELSE 'Other'
    END AS job_title_category
FROM title_lower
ORDER BY RANDOM()
LIMIT 30;

-- NULL FUNCTIONS 
-- NULLIF Returns null if values are equal 
SELECT NULLIF(5 + 5, 20);

-- Example
SELECT 
    MEDIAN(NULLIF(salary_year_avg, 0)),
    MEDIAN(NULLIF(salary_hour_avg, 0))
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

-- COALESCE
-- Returns first non-NULL value
SELECT COALESCE(0, 1, 2);
SELECT COALESCE(NULL, 1, 2);
SELECT COALESCE(NULL, NULL, 2);

-- Example
SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM 
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

