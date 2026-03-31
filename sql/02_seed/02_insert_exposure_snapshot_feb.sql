-- February snapshot (slightly different values)

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
VALUES
    (1, '2026-02-28', 1, 101, 'mortgage',   455000, 0.35, 'CH',  0,  1),
    (2, '2026-02-28', 1, 102, 'overdraft',   12000, 1.00, 'CH',  5,  1),
    (3, '2026-02-28', 2, 103, 'loan',        85000, 1.00, 'IT', 60,  2),
    (4, '2026-02-28', 3, 104, 'mortgage',   325000, 0.35, 'CH',  0,  1),
    (5, '2026-02-28', 4, 105, 'derivative',  20000, 1.00, 'DE',  0,  1),
    (6, '2026-02-28', 5, 106, 'loan',       110000, 0.75, 'FR', 20,  1),
    (7, '2026-02-28', 2, 107, 'overdraft',    5000, 1.00, 'IT',  0,  1);