-- TASK 3 — Risk Monitoring 

--Core
SELECT*
FROM core.accounts;

SELECT*
FROM core.customers;

SELECT*
FROM core.transactions;

--Public
SELECT*
FROM public.accounts;

SELECT*
FROM public.customers;

SELECT*
FROM public.transactions;

--Risk
SELECT*
FROM risk.exposure_snapshot;


--
SELECT
    core.customers.customer_name,
    risk.exposure_snapshot.account_id,
    risk.exposure_snapshot.exposure_amount,
    risk.exposure_snapshot.past_due_days,
    risk.exposure_snapshot.stage
FROM risk.exposure_snapshot
JOIN core.customers
    ON risk.exposure_snapshot.customer_id = core.customers.customer_id
WHERE
    risk.exposure_snapshot.past_due_days >= 30
    OR risk.exposure_snapshot.stage >= 2
ORDER BY
   risk.exposure_snapshot.exposure_amount DESC;



SELECT
    core.customers.customer_name,
    risk.exposure_snapshot.account_id,
    risk.exposure_snapshot.exposure_amount,
    risk.exposure_snapshot.past_due_days,
    risk.exposure_snapshot.stage
FROM risk.exposure_snapshot
JOIN core.customers
    ON risk.exposure_snapshot.customer_id = core.customers.customer_id
ORDER BY
   risk.exposure_snapshot.exposure_amount DESC;




SELECT
    core.customers.customer_name AS name,
    --risk.exposure_snapshot.account_id,
    risk.exposure_snapshot.exposure_amount AS amount
FROM
    risk.exposure_snapshot
JOIN core.customers
ON risk.exposure_snapshot.customer_id = core.customers.customer_id
ORDER BY
    risk.exposure_snapshot.exposure_amount DESC;
-----------------------------------------------------
SELECT
    core.customers.customer_name AS name,
    risk.exposure_snapshot.risk_weight AS weight,
    risk.exposure_snapshot.past_due_days AS past_due_days,
    risk.exposure_snapshot.exposure_type AS type
FROM    
    risk.exposure_snapshot
JOIN core.customers
ON risk.exposure_snapshot.customer_id = core.customers.customer_id
ORDER BY
    risk.exposure_snapshot.exposure_amount DESC;
-------------------------------------------
SELECT
    core.customers.customer_name AS name,
    risk.exposure_snapshot.risk_weight AS weight,
    risk.exposure_snapshot.past_due_days AS past_due_days,
    risk.exposure_snapshot.exposure_type AS type
FROM    
    risk.exposure_snapshot

JOIN core.customers
ON risk.exposure_snapshot.customer_id = core.customers.customer_id
WHERE
    risk.exposure_snapshot.exposure_type = 'mortgage'
ORDER BY
    risk.exposure_snapshot.exposure_amount DESC;