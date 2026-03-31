--TASK 2 — Exposure by Country 
SELECT*
FROM risk.exposure_snapshot;

SELECT
    SUM(exposure_amount) AS total_exposure,
    ROUND(SUM(exposure_amount * risk_weight),1) AS RWA,
    country_code
FROM risk.exposure_snapshot

GROUP BY
    country_code
HAVING
    SUM(exposure_amount) > 50000;


SELECT
    core.customers.customer_name
FROM
    core.customers;

SELECT
    risk.exposure_snapshot.exposure_amount AS amount
FROM
    risk.exposure_snapshot;

/*
SELECT
    core.customers.customer_name AS name,
    risk.exposure_snapshot.exposure_amount AS amount
FROM
    core.customers
JOIN
    risk.exposure_snapshot
ON risk.exposure_snapshot.exposure_amount = core.customers.customer_name;*/