SELECT *
FROM customers;
--------------------
SELECT *
FROM accounts;
----------------------
SELECT *
FROM transactions;
--Now we connect customers + accounts.
SELECT customer_name,
    account_id,
    balance,
    currency
FROM customers
    JOIN accounts ON customers.customer_id = accounts.customer_id --Exercise 1 Show the total balance per customer
SELECT customer_name,
    SUM(balance) AS total_balance
FROM customers
    JOIN accounts ON customers.customer_id = accounts.customer_id
GROUP BY customer_name -- Customer name with more than 15000
SELECT customer_name,
    SUM(balance) AS total_balance
FROM customers
    JOIN accounts ON accounts.customer_id = customers.customer_id
GROUP BY customer_name
HAVING SUM(balance) > 15000
ORDER BY total_balance DESC
SELECT customer_name,
    SUM(balance) AS total_balance
FROM customers
    JOIN accounts ON accounts.customer_id = customers.customer_id
GROUP BY customer_name
ORDER BY total_balance DESC -- Exercise 2 — Total balance per currency
SELECT currency,
    SUM(balance) AS total_balance
FROM accounts
GROUP BY currency
ORDER BY total_balance DESC --Next Exercise — Find the Largest Customer Exposure
SELECT customer_name,
    SUM(balance) AS total_balance
FROM customers
    JOIN accounts ON accounts.customer_id = customers.customer_id
GROUP BY customer_name
ORDER BY total_balance DESC
LIMIT 1