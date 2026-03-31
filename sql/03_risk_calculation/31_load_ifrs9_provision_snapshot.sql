-- Load IFRS9 provision snapshot
-- Calculate ECL and insert results
INSERT INTO risk.ifrs9_provision_snapshot (
        snapshot_date,
        exposure_id,
        customer_id,
        account_id,
        stage,
        exposure_amount,
        pd_rate,
        lgd_rate,
        ecl_amount
    )
SELECT e.snapshot_date,
    e.exposure_id,
    e.customer_id,
    e.account_id,
    e.stage,
    e.exposure_amount,
    r.pd_rate,
    r.lgd_rate,
    ROUND(e.exposure_amount * r.pd_rate * r.lgd_rate, 2) AS ecl_amount
FROM risk.exposure_snapshot e
    JOIN risk.ifrs9_stage_rule r ON e.stage = r.stage
WHERE e.snapshot_date = DATE '2026-03-31';
--changing date
INSERT INTO risk.ifrs9_provision_snapshot (
        snapshot_date,
        exposure_id,
        customer_id,
        account_id,
        stage,
        exposure_amount,
        pd_rate,
        lgd_rate,
        ecl_amount
    )
SELECT e.snapshot_date,
    e.exposure_id,
    e.customer_id,
    e.account_id,
    e.stage,
    e.exposure_amount,
    r.pd_rate,
    r.lgd_rate,
    ROUND(e.exposure_amount * r.pd_rate * r.lgd_rate, 2) AS ecl_amount
FROM risk.exposure_snapshot e
    JOIN risk.ifrs9_stage_rule r ON e.stage = r.stage
WHERE e.snapshot_date = DATE '2026-02-28';