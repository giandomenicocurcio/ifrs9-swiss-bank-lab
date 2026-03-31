-- ============================================
-- IFRS9 Waterfall (Feb → Mar)
-- ============================================
WITH current AS (
    SELECT stage,
        SUM(ecl_amount) AS ecl_current
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
    GROUP BY stage
),
previous AS (
    SELECT stage,
        SUM(ecl_amount) AS ecl_previous
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
    GROUP BY stage
)
SELECT c.stage,
    c.ecl_current,
    COALESCE(p.ecl_previous, 0) AS ecl_previous,
    c.ecl_current - COALESCE(p.ecl_previous, 0) AS ecl_delta
FROM current c
    LEFT JOIN previous p ON c.stage = p.stage
UNION ALL
-- Total line
SELECT 99 AS stage,
    SUM(c.ecl_current),
    SUM(COALESCE(p.ecl_previous, 0)),
    SUM(c.ecl_current - COALESCE(p.ecl_previous, 0))
FROM current c
    LEFT JOIN previous p ON c.stage = p.stage
ORDER BY stage;
--calculate expected credit loss (ECL)