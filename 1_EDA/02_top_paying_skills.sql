/*
Question: What are the highest-paying skills for data scientist? 
- Calculate the median salary for each skill required in the data scientist positions.
- Focus on United states with the specified salaries.
- Include skill frequency to identify both salary and demand.
- Why? Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for the skill development priorities.
*/

SELECT 
    * 
FROM job_postings_fact
LIMIT 10;

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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
HAVING 
 COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*

🔑 Key Insight:
The top-paying skills—like Notion ($187,500, demand: 130), Watson ($176,500, demand: 250), and Slack ($175,000, demand: 255) offer the highest salaries but have very low demand.
In contrast, skills like Hugging Face ($173,500, demand: 586), Express ($157,000, demand: 969), and OpenCV ($150,000, demand: 616) still pay well and have much higher demand, making them more practical.


👉 Takeaway:
Don’t chase only the highest salary but focus on skills that combine strong pay and higher demand, like Express or AI-related tools, for better job opportunities.
*/





