-- =========================================================
-- 07_seed_exposure_snapshot_2026_04.sql
-- Purpose: Seed April 2026 exposure snapshot with realistic
--          month-on-month credit movements
-- Reporting date: 2026-04-30
-- =========================================================

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
    (1, '2026-04-30', 1, 101, 'Mortgage', 9400.00, 0.35, 'CH', 0, 1),
    (2, '2026-04-30', 2, 102, 'Loan', 15200.00, 0.75, 'CH', 38, 2),
    (3, '2026-04-30', 3, 103, 'Credit Card', 8300.00, 1.00, 'CH', 96, 3),
    (4, '2026-04-30', 4, 104, 'Loan', 11800.00, 0.40, 'CH', 12, 1),
    (5, '2026-04-30', 5, 105, 'Mortgage', 21400.00, 0.35, 'CH', 4, 1),
    (6, '2026-04-30', 6, 106, 'Loan', 9700.00, 0.80, 'CH', 44, 2),
    (7, '2026-04-30', 7, 107, 'Credit Card', 6900.00, 1.00, 'CH', 122, 3),
    (8, '2026-04-30', 8, 108, 'Loan', 12400.00, 0.30, 'CH', 0, 1);
