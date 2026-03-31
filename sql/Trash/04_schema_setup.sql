/*
core → operational data (customers, accounts, transactions)
risk → exposures, RWA, IFRS9
finance → GL, P&L, balance sheet
*/
CREATE SCHEMA core;
CREATE SCHEMA risk;
CREATE SCHEMA finance;

-- Move your existing tables into core
ALTER TABLE customers SET SCHEMA core;
ALTER TABLE accounts SET SCHEMA core;
ALTER TABLE transactions SET SCHEMA core;
-- Verify
SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema IN ('core', 'risk', 'finance')
ORDER BY table_schema, table_name;

/*
Before:
SELECT * FROM customers;
Now:
SELECT * FROM core.customers;
*/

-- Test with a real query
----
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'core'
  AND table_name = 'customers';


SELECT
    c.customer_id,
    c.customer_name,
    SUM(a.balance) AS total_balance
FROM core.customers c
JOIN core.accounts a
    ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT * FROM core.customers LIMIT 5;