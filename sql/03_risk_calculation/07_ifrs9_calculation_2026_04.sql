
-- =========================================================
-- 07_ifrs9_calculation_2026_04.sql
-- Purpose: Calculate IFRS9 provisions for April 2026
-- =========================================================

INSERT INTO risk.ifrs9_provision_snapshot (
    snapshot_date,
    exposure_id,
    customer_id,
    account_id,
    stage,
    exposure_amount,
    pd_rate,
    lgd_rate,
    ecl_amount,
    provision_type,
    created_at
)
SELECT
    e.snapshot_date,
    e.exposure_id,
    e.customer_id,
    e.account_id,
    e.stage,
    e.exposure_amount,

    -- PD by stage
    CASE 
        WHEN e.stage = 1 THEN 0.01
        WHEN e.stage = 2 THEN 0.05
        WHEN e.stage = 3 THEN 0.20
    END AS pd_rate,

    -- LGD by product
    CASE
        WHEN e.exposure_type = 'Mortgage' THEN 0.20
        WHEN e.exposure_type = 'Loan' THEN 0.45
        WHEN e.exposure_type = 'Credit Card' THEN 0.75
    END AS lgd_rate,

    -- ECL calculation
    e.exposure_amount *
    CASE 
        WHEN e.stage = 1 THEN 0.01
        WHEN e.stage = 2 THEN 0.05
        WHEN e.stage = 3 THEN 0.20
    END *
    CASE
        WHEN e.exposure_type = 'Mortgage' THEN 0.20
        WHEN e.exposure_type = 'Loan' THEN 0.45
        WHEN e.exposure_type = 'Credit Card' THEN 0.75
    END AS ecl_amount,

    -- Provision type (very important for finance)
    CASE
        WHEN e.stage = 1 THEN '12M_ECL'
        WHEN e.stage IN (2,3) THEN 'LIFETIME_ECL'
    END AS provision_type,

    NOW() AS created_at

FROM risk.exposure_snapshot e
WHERE e.snapshot_date = '2026-04-30';
--\q
-- — quick validation (just check)
SELECT
    snapshot_date,
    stage,
    COUNT(*) AS exposures,
    SUM(ecl_amount) AS total_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = '2026-04-30'
GROUP BY snapshot_date, stage
ORDER BY stage;


SELECT
    SUM(e.exposure_amount) AS total_exposure,

    SUM(
        e.exposure_amount *
        CASE 
            WHEN e.stage = 1 THEN 0.01
            WHEN e.stage = 2 THEN 0.05
            WHEN e.stage = 3 THEN 0.20
        END *
        CASE
            WHEN e.exposure_type = 'Mortgage' THEN 0.20
            WHEN e.exposure_type = 'Loan' THEN 0.45
            WHEN e.exposure_type = 'Credit Card' THEN 0.75
        END
    ) AS recalculated_ecl,

    SUM(p.ecl_amount) AS stored_ecl,

    SUM(p.ecl_amount) -
    SUM(
        e.exposure_amount *
        CASE 
            WHEN e.stage = 1 THEN 0.01
            WHEN e.stage = 2 THEN 0.05
            WHEN e.stage = 3 THEN 0.20
        END *
        CASE
            WHEN e.exposure_type = 'Mortgage' THEN 0.20
            WHEN e.exposure_type = 'Loan' THEN 0.45
            WHEN e.exposure_type = 'Credit Card' THEN 0.75
        END
    ) AS difference

FROM risk.exposure_snapshot e
JOIN risk.ifrs9_provision_snapshot p
    ON e.exposure_id = p.exposure_id
   AND e.snapshot_date = p.snapshot_date

WHERE e.snapshot_date = '2026-04-30';