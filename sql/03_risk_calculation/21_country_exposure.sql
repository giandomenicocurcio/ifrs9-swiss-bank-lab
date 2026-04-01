-- Exposure by Country 
SELECT *
FROM risk.exposure_snapshot;
SELECT SUM(exposure_amount) AS total_exposure,
    ROUND(SUM(exposure_amount * risk_weight), 1) AS RWA,
    country_code
FROM risk.exposure_snapshot
GROUP BY country_code
HAVING SUM(exposure_amount) > 50000;
SELECT core.customers.customer_name
FROM core.customers;
SELECT risk.exposure_snapshot.exposure_amount AS amount
FROM risk.exposure_snapshot;