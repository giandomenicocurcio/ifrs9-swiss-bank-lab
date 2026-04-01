--Core -- core  → raw operations
SELECT *
FROM core.accounts;
SELECT *
FROM core.customers;
SELECT *
FROM core.transactions;
-- Finance -- accounting view (P&L, balance sheet)
--Public
SELECT *
FROM public.accounts;
SELECT *
FROM public.customers;
SELECT *
FROM public.transactions;
--Risk -- risk view (exposures, RWA, default)
SELECT *
FROM risk.exposure_snapshot;
SELECT core.customers.customer_name,
    risk.exposure_snapshot.account_id,
    risk.exposure_snapshot.exposure_amount,
    risk.exposure_snapshot.past_due_days,
    risk.exposure_snapshot.stage
FROM risk.exposure_snapshot
    JOIN core.customers ON risk.exposure_snapshot.customer_id = core.customers.customer_id
WHERE risk.exposure_snapshot.past_due_days >= 30
    OR risk.exposure_snapshot.stage >= 2
ORDER BY risk.exposure_snapshot.exposure_amount DESC;
SELECT SUM(balance) AS total_balance,
    SUM(risk.exposure_snapshot.exposure_amount) AS total_exposure
FROM public.accounts
    JOIN risk.exposure_snapshot ON risk.exposure_snapshot.exposure_amount = public.accounts.balance;
SELECT SUM(a.balance) AS total_balance,
    SUM(e.exposure_amount) AS total_exposure
FROM core.accounts a
    JOIN risk.exposure_snapshot e ON e.exposure_amount = a.balance;
--Step 1: total balances per customer
SELECT customer_id,
    SUM(balance) AS total_balance
FROM core.accounts
GROUP BY customer_id;
--Step 2: total exposures per customer
SELECT customer_id,
    SUM(exposure_amount) AS total_exposure
FROM risk.exposure_snapshot
GROUP BY customer_id;
--Step 1 Variation
SELECT *
FROM customers c;
SELECT c.customer_name
FROM customers c;
--
SELECT
a.account_id
FROM accounts a;
SELECT *
FROM accounts a;
--Step 3: join the two aggregated results
SELECT a.customer_id,
    a.total_balance,
    e.total_exposure
FROM (
        SELECT customer_id,
            SUM(balance) AS total_balance
        FROM core.accounts
        GROUP BY customer_id
    ) a
    JOIN (
        SELECT customer_id,
            SUM(exposure_amount) AS total_exposure
        FROM risk.exposure_snapshot
        GROUP BY customer_id
    ) e ON a.customer_id = e.customer_id;
SELECT a.customer_id,
    a.account_id,
    a.balance AS exposure_amount
FROM core.accounts a;