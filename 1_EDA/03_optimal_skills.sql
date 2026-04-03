/*
Question: What are the optimal skills for data scientist-balancing both demand and salary?
- Create a ranking column that combines demand and median salary to identify the msot valuable skills.
- Focus only on United States Data Scientist positions with specified annual salaries.
- Why?
    - This approach highlilghts skills tha balance the market demand and financial reward. it weighs core skills appropriately, rather than letting rare, outlier skills distort the results.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    -- COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score,
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Scientist'
    AND jpf.job_country = 'United States'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING 
 COUNT(jpf.*) > 100
ORDER BY
   optimal_score DESC
LIMIT 25;

/*

🔑 Key Insight + Takeaway (Optimal Score)
The highest optimal scores—which balance salary and demand—are seen in Python (score: 1.18, $132,500), SQL (1.14, $131,867), and R (1.09, $130,000). These skills don’t have the absolute highest salaries, but they have very strong demand, making them the most valuable overall.
Mid-tier skills like Spark ($140,000, score: 1.02), AWS ($135,000, 1.01), and PyTorch ($145,000, 1.0) still offer a strong balance of pay and demand.

Lower scores—like Express ($157,000, 0.81) and Airflow ($150,000, 0.80)—show that even with high salaries, lower demand reduces overall value.


👉 Takeaway:
The best skills aren’t the highest-paying—they’re the ones with the best balance of salary and demand, like Python, SQL, and R, making them the smartest long-term choices.


┌──────────────┬───────────────┬─────────────────┬───────────────┐
│    skills    │ median_salary │ ln_demand_count │ optimal_score │
│   varchar    │    double     │     double      │    double     │
├──────────────┼───────────────┼─────────────────┼───────────────┤
│ python       │      132500.0 │             8.9 │          1.18 │
│ sql          │      131867.0 │             8.6 │          1.14 │
│ r            │      130000.0 │             8.4 │          1.09 │
│ spark        │      140000.0 │             7.3 │          1.02 │
│ aws          │      135000.0 │             7.5 │          1.01 │
│ pytorch      │      145000.0 │             6.9 │           1.0 │
│ tensorflow   │      138500.0 │             7.1 │          0.98 │
│ tableau      │      125000.0 │             7.6 │          0.95 │
│ azure        │      130000.0 │             7.1 │          0.93 │
│ scala        │      140000.0 │             6.6 │          0.92 │
│ sas          │      119550.0 │             7.6 │          0.91 │
│ pandas       │      137500.0 │             6.6 │          0.91 │
│ scikit-learn │      139375.0 │             6.5 │          0.91 │
│ numpy        │      140000.0 │             6.3 │          0.89 │
│ go           │      140000.0 │             6.3 │          0.88 │
│ hadoop       │      129890.0 │             6.8 │          0.88 │
│ java         │      125000.0 │             6.9 │          0.86 │
│ matlab       │      137750.0 │             6.2 │          0.85 │
│ snowflake    │      135000.0 │             6.3 │          0.85 │
│ pyspark      │      142300.0 │             5.8 │          0.82 │
│ express      │      157000.0 │             5.1 │          0.81 │
│ gcp          │      127275.0 │             6.3 │           0.8 │
│ databricks   │      126000.0 │             6.4 │           0.8 │
│ airflow      │      150000.0 │             5.4 │           0.8 │
│ excel        │      114000.0 │             7.0 │          0.79 │
├──────────────┴───────────────┴─────────────────┴───────────────┤
│ 25 rows                                              4 columns │
└────────────────────────────────────────────────────────────────┘
*/
