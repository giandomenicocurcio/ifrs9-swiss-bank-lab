-- RWA calculation (Basel style)
SELECT snapshot_date,
    SUM(exposure_amount) AS total_exposure,
    SUM(exposure_amount * risk_weight) AS rwa
FROM risk.exposure_snapshot
GROUP BY snapshot_date;
--RWA breakdown
SELECT exposure_type,
    SUM(exposure_amount) AS exposure,
    SUM(exposure_amount * risk_weight) AS rwa
FROM risk.exposure_snapshot
WHERE snapshot_date = '2026-03-31'
GROUP BY exposure_type
ORDER BY rwa DESC;
-- Default / non-performing exposures
SELECT customer_id,
    account_id,
    exposure_amount,
    past_due_days,
    stage
FROM risk.exposure_snapshot
WHERE past_due_days >= 90
ORDER BY exposure_amount DESC;
--Join with CORE
SELECT c.customer_name,
    SUM(e.exposure_amount) AS total_exposure,
    SUM(e.exposure_amount * e.risk_weight) AS rwa
FROM risk.exposure_snapshot e
    JOIN core.customers c ON e.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY rwa DESC;
SELECT *
FROM public.transactions;