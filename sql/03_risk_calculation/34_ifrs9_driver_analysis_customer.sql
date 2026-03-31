--STEP 1 — Customer-level delta
-- ============================================
-- IFRS9 Driver Analysis - Customer Level
-- ============================================

WITH current AS (
    SELECT
        customer_id,
        SUM(ecl_amount) AS ecl_current
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
    GROUP BY customer_id
),
previous AS (
    SELECT
        customer_id,
        SUM(ecl_amount) AS ecl_previous
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
    GROUP BY customer_id
)

SELECT
    c.customer_id,
    c.ecl_current,
    COALESCE(p.ecl_previous, 0) AS ecl_previous,
    c.ecl_current - COALESCE(p.ecl_previous, 0) AS ecl_delta
FROM current c
LEFT JOIN previous p
    ON c.customer_id = p.customer_id
ORDER BY ecl_delta DESC;