-- ============================================
-- IFRS9 AUDIT & RECONCILIATION CHECKS
-- ============================================
-- 1. COMPLETENESS CHECK
-- Every exposure must have an ECL
SELECT COUNT(*) AS total_exposures,
    COUNT(ecl_amount) AS exposures_with_ecl,
    COUNT(*) - COUNT(ecl_amount) AS missing_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31';
-- 2. RECONCILIATION CHECK
-- Risk vs Finance must match
WITH risk_total AS (
    SELECT SUM(ecl_amount) AS total_ecl
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
),
finance_total AS (
    SELECT total_ifrs9_provision
    FROM finance.impairment_report
    WHERE snapshot_date = DATE '2026-03-31'
)
SELECT r.total_ecl,
    f.total_ifrs9_provision,
    r.total_ecl - f.total_ifrs9_provision AS difference
FROM risk_total r,
    finance_total f;
-- 3. NEGATIVE / INVALID VALUES CHECK
SELECT *
FROM risk.ifrs9_provision_snapshot
WHERE ecl_amount < 0
    OR pd_rate < 0
    OR lgd_rate < 0;
-- 4. STAGE VALIDATION
SELECT stage,
    COUNT(*) AS exposure_count
FROM risk.ifrs9_provision_snapshot
GROUP BY stage
ORDER BY stage;