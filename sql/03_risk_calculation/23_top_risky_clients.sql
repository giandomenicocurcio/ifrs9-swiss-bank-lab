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