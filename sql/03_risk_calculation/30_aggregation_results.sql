-- 7. Validate the results
-- Before aggregating, always inspect detailed rows.
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
-- 8. Aggregate provisions per customer
--from exposure detail to customer view.
SELECT p.snapshot_date,
    p.customer_id,
    c.customer_name,
    SUM(p.exposure_amount) AS total_exposure,
    SUM(p.ecl_amount) AS total_ecl
FROM risk.ifrs9_provision_snapshot p
    JOIN core.customers c ON p.customer_id = c.customer_id
WHERE p.snapshot_date = DATE '2026-03-31'
GROUP BY p.snapshot_date,
    p.customer_id,
    c.customer_name
ORDER BY total_ecl DESC;
--
-- 9 Aggregate provisions by stage
--Very important for control and reporting.
SELECT snapshot_date,
    stage,
    SUM(exposure_amount) AS total_exposure,
    SUM(ecl_amount) AS total_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
GROUP BY snapshot_date,
    stage
ORDER BY stage;
-- 10. Aggregate total provision
-- For total portfolio provision:
SELECT snapshot_date,
    SUM(ecl_amount) AS total_ifrs9_provision
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
GROUP BY snapshot_date;