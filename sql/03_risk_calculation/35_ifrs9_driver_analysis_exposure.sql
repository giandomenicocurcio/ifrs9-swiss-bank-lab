-- ============================================
-- IFRS9 Driver Analysis - Exposure Level
-- ============================================

WITH current AS (
    SELECT
        exposure_id,
        customer_id,
        stage,
        ecl_amount AS ecl_current
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
),
previous AS (
    SELECT
        exposure_id,
        ecl_amount AS ecl_previous
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
)

SELECT
    c.exposure_id,
    c.customer_id,
    c.stage,
    c.ecl_current,
    COALESCE(p.ecl_previous, 0) AS ecl_previous,
    c.ecl_current - COALESCE(p.ecl_previous, 0) AS ecl_delta
FROM current c
LEFT JOIN previous p
    ON c.exposure_id = p.exposure_id
ORDER BY ecl_delta DESC;