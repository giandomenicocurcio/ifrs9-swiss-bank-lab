-- =========================================================
-- 01_reconciliation_ifrs9_2026_04.sql
-- Purpose: Validate IFRS9 ECL calculation for April 2026
-- =========================================================

-- ========================================
-- CONTROL 1: ECL by stage
-- ========================================

SELECT
    snapshot_date,
    stage,
    COUNT(*) AS exposures,
    SUM(ecl_amount) AS total_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = '2026-04-30'
GROUP BY snapshot_date, stage
ORDER BY stage;


-- ========================================
-- CONTROL 2: Recalculation check
-- ========================================

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