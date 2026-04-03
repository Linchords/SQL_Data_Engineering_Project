# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Project 1 Overview](../Images/1_1_Project1_EDA.png)

A SQL-based project exploring the data scientist job market through real-world job posting data, showcasing my ability to **build efficient queries, perform advanced analysis, and extract meaningful business insights from data**.

## Executive Summary

- ✅ **Project scope:** Built **3 analytical queries** that answer key questions about the data scientist job market
- ✅ **Data Modelling:** Used **multi-table joins** across fact and dimension tables to extract insights
- ✅ **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value
- ✅ **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns

If you only have a minute, review these:

1. [01_top_demanded_skills.sql](./01_top_demanded_skills.sql) - demand analysis with multi-table joins
2. [02_top_paying_skills.sql](./02_top_paying_skills.sql) - salary analysis with aggregations
3. [03_optimal_skills.sql](./03_optimal_skills.sql) - combined demand/salary optimization query

## Problem & Contaxt

Job market analysis need to answer questions like:

- 🎯 **Most in-demand:** _Which skills are most in-demand for data scientist?_
- 💰 **Highest paid:** _Which skills command the highest salaries?_
- 💻 **Best trade-off:** _What is the optimal skill set balancing demand and compensation?_

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:  
![Data Warehouse](../Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings _fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimension Tables:**
  - `company_dim` - Company information linked to job postings
  - `skills_dim` - Skills catalog with the skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for data scientist roles.

## Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries.
- 📕 **Language:** SQL (ANSI-style with analytical functions)
- 📊 **Data Model** Star schema with the fact + dimension + bridge tables.
- ⚒️ **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
- 📦 **Version Control:** Git/Github for versioned SQL scripts

## Analysis Overview

### Query Structure.

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** - Identifies the 10 most in-demand skills for data scientist postions in the united states
2. **[Top Paying Skills](./02_top_paying_skills.sql)** - Analyzes the 25 highest-paying skills with salary and demand metrics
3. **[Optimal Skills](./03_optimal_skills.sql)** - Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights

- 🧠 Core Languages: Python SQL and R each appear in ~76,000, ~53,000 to 44,000 job postings respectively, making them the most demanded skills
- ☁️ Analytics and Business Intelligence (BI) platforms: SAS and Tableau are critical for modern day data scientist roles
- 🧱 Infra & Tooling: AWS and Azure are associated with premium salaries
- 🔥 Big Data Tools: Apache Spark shows strong demand with competitve compensation
- 🤖 ML / AI Frameworks: TensorFlow shows some importance for specialized ML roles but Python and SQL are more essential for most data scientists.

## SQL Skills Demonstrated

### Query Design and Optimization

- **Complex Joins:** Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations:** `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering:** Boolean logic with `WHERE` clauses and multiple conditions `(job_title_short`, `job_work_from_home`, `salary_year_avg` `IS NOT NULL`)
- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

## Data Analysis Techniques

- **Grouping:** `GROUP BY` for categorical analysis by skill
- **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause:** Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)
