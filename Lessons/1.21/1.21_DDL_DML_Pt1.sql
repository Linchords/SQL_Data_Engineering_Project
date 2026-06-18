-- DQL (Data Query Language) e.g SELECT, FROM , WHERE, ORDER BY, GROUP BY
-- DML (Data Manipulation Language) e.g INSERT, UPDATE, DELETE
-- DDL (Data Definitionn Language) e.g CREATE, DROP, ALTER...TRUNCATE

-- Database creation process: 
-- Check for existing databases
-- 1. Create Database
-- Check for existing schema
-- 2. Create Schema

--  .read Lessons/1.21_DDL_DML_Pt1.sql

USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;

-- Create Database..
CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

-- Create Schema...
SELECT
    *
FROM 
    information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA IF EXISTS staging;

-- Create Tables...
CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

SELECT 
    *
FROM 
    information_schema.tables
WHERE table_catalog = 'jobs_mart';


INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
     (3, 'Software Engineer');

SELECT
    *
FROM 
    staging.preferred_roles;

-- Alter Table 
-- Add Column, Drop Column, Rename Column/Table, Alter Column 


-- Adding 
ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

-- Dropping
-- ALTER TABLE staging.preferred_roles
-- DROP COLUMN preferred_role;

-- Updating table rows or content
UPDATE staging.preferred_roles
SET preferred_role = TRUE 
WHERE role_id = 1 OR role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

-- Renaming Table
ALTER TABLE staging.preferred_roles
RENAME TO priority_roles; --RENAME keyword is used to rename table


SELECT *
FROM staging.priority_roles;

-- Changing Column name 
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

-- Changing column values, type(data_type), set default value, drop default and set not null.  
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;











