
-- JOINS

SELECT*
FROM skills_dim

--LEFT JOIN

SELECT
    job_id,
    job_title_short,
    company_id
FROM
    job_postings_fact AS job_postings
LIMIT 10

SELECT *
FROM company_dim;

SELECT
    job_postings.job_id,
    job_postings.job_title_short,
    job_postings.company_id,
    companies.company_id,
    companies.name
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
LIMIT 10
-- RIGHT JOIN

SELECT
    job_postings.job_id,
    job_postings.job_title_short,
    companies.name AS companies
FROM
    job_postings_fact AS job_postings
RIGHT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id

-- INNER JOIN

SELECT
    job_postings.job_id,
    job_postings.job_title,
    skills_to_job.skill_id,
    skills.skills
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id;

SELECT *
FROM job_postings_fact
LIMIT 10