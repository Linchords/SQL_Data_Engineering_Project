/*
QUESTION
What are the most in-demand skills for data scientist
* Identify the top 10 in-demand skills for data scientist 
* Focus on country(united states);
    - WHY ?
        Retrieves the top 10 skills with the highest demand in the country of the united states market, providing insights into the most valuable skills for data scientist seeking jobs in the united states
*/

SHOW TABLES FROM data_jobs;
DESC job_postings_fact;
DESC skills_job_dim;
DESC skills_dim;
DESC company_dim;


SELECT 
    * 
FROM job_postings_fact
LIMIT 10;

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Scientist'
    AND jpf.job_country = 'United States'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
Heres a breakdown of the most demanded skills for Data Scientist in the united states: Python, SQL and R are by far the most in-demand skills, with around 76,000 job postings each nearly double the next
Analytics and Business Intelligence (BI) platforms round out the top skills, with Sas leading at 24,000 postings, followed by Tableau which completes the top 5, highlighting the importance of  Data Visualization & Business Intelligence Platform 



────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │        76602 │
│ sql        │        53882 │
│ r          │        44859 │
│ sas        │        24484 │
│ tableau    │        23694 │
│ aws        │        19680 │
│ spark      │        17103 │
│ tensorflow │        13884 │
│ azure      │        13380 │
│ java       │        12595 │
├────────────┴──────────────┤
│ 10 rows         2 columns │
└───────────────────────────┘

*/
