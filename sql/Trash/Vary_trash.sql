--FILE TO CHECK
SELECT customer_id,
    customer_name,
    country,
    risk_rating
FROM customers;
-- from 01_ddl/02_core_create_accounts.sql
SELECT account_id,
    customer_id,
    balance,
    currency
FROM accounts -- from 01_ddl/03_core_create_transactions.sql
SELECT *
FROM transactions;
--from 01_ddl/exposure_snapshot.sql
-- Validate the results
SELECT snapshot_date,
    exposure_id,
    customer_id,
    account_id,
    stage,
    exposure_amount,
    pd_rate,
    lgd_rate,
    ecl_amount
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
ORDER BY customer_id,
    exposure_id;
-- From 02_seed/07_seed_exposure_snapshot_2026_04.sql
SELECT *
FROM risk.exposure_snapshot
WHERE snapshot_date = '2026-04-30'
ORDER BY exposure_id;