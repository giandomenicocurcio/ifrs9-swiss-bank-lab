--Exercise 1 Show all transactions after '2026-01-12'
SELECT
    amount,
    transaction_date
FROM
    transactions
WHERE
    transaction_date > '2023-02-19'::DATE
ORDER BY
    transaction_date


--Exercise 1 Show all transactions after '2026-01-12' with customer_name
SELECT
    customer_name,
    amount,
    transaction_date
FROM
    customers
JOIN
accounts
ON customers.customer_id = accounts.customer_id
JOIN transactions
ON accounts.account_id = transactions.account_id
WHERE
    transaction_date > '2026-01-12'::DATE
ORDER BY
    transaction_date


--Exercise 2 Total transaction amount per customer

SELECT
    customer_name,
    SUM(amount) AS total_transaction_amount
FROM
    customers
JOIN
    accounts
ON customers.customer_id = accounts.customer_id
JOIN transactions
ON accounts.account_id = transactions.account_id
GROUP BY 
    customer_name
ORDER BY 
    total_transaction_amount DESC;

-- Exercise 3 Show customers with total transaction amount greater than 500--------------------------------
SELECT
    customer_name,
    SUM(amount) AS total_transaction_amount
FROM
    customers
JOIN accounts
ON customers.customer_id = accounts.customer_id
JOIN transactions
ON accounts.account_id = transactions.account_id
GROUP BY 
    customer_name
HAVING
    SUM(amount) > 500;
-- Exercise 4 Show total balance by country**********************

SELECT
    customers.country,
    SUM(accounts.balance) AS country_balance
FROM
    customers
JOIN accounts
ON customers.customer_id = accounts.customer_id
GROUP BY 
    customers.country;


SELECT
    customer_name,
   -- balance,
    country
FROM
    customers

SELECT
    --customer_name,
    SUM(balance) AS total_balance
    --country
FROM
    accounts


-- Exercise 5 Show the top 2 customers by total transaction amount--------------------------------
SELECT
    customer_name,
    SUM(amount) AS total_transaction_amount
FROM
    customers
JOIN accounts
ON customers.customer_id = accounts.customer_id
JOIN transactions
ON accounts.account_id = transactions.account_id
GROUP BY 
    customer_name
ORDER BY total_transaction_amount DESC
LIMIT 2


------------------------------DATE--------------------

SELECT
    COUNT(job_id)AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    MONTH
HAVING
    EXTRACT(MONTH FROM job_posted_date) = 1
ORDER BY
    job_posted_count DESC;
