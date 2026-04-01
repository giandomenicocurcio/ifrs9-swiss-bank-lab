-------------------------------------------------------------
DROP TABLE IF EXISTS risk.exposure_snapshot;
CREATE TABLE risk.exposure_snapshot (
    exposure_id INT,
    snapshot_date DATE,
    customer_id INT,
    account_id INT,
    exposure_type VARCHAR(50),
    exposure_amount NUMERIC(18, 2),
    risk_weight NUMERIC(5, 2),
    country_code VARCHAR(2),
    past_due_days INT,
    stage INT,
    PRIMARY KEY (snapshot_date, exposure_id)
);
-------------------------------------------------------------
INSERT INTO risk.exposure_snapshot (
        exposure_id,
        snapshot_date,
        customer_id,
        account_id,
        exposure_type,
        exposure_amount,
        risk_weight,
        country_code,
        past_due_days,
        stage
    )
VALUES (
        1,
        '2026-03-31',
        1,
        101,
        'mortgage',
        450000,
        0.35,
        'CH',
        0,
        1
    ),
    (
        2,
        '2026-03-31',
        1,
        102,
        'overdraft',
        15000,
        1.00,
        'CH',
        10,
        2
    ),
    (
        3,
        '2026-03-31',
        2,
        103,
        'loan',
        80000,
        1.00,
        'IT',
        95,
        3
    ),
    (
        4,
        '2026-03-31',
        3,
        104,
        'mortgage',
        320000,
        0.35,
        'CH',
        0,
        1
    ),
    (
        5,
        '2026-03-31',
        4,
        105,
        'derivative',
        25000,
        1.00,
        'DE',
        0,
        1
    ),
    (
        6,
        '2026-03-31',
        5,
        106,
        'loan',
        120000,
        0.75,
        'FR',
        45,
        2
    ),
    (
        7,
        '2026-03-31',
        2,
        107,
        'overdraft',
        7000,
        1.00,
        'IT',
        5,
        1
    );
-------------------------------------------------------------
-- Load IFRS9 provision snapshot
--calculate the ECL and insert the result.
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