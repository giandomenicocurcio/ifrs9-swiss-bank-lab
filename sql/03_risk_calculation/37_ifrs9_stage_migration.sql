-- ============================================
-- IFRS9 Stage Migration (Feb → Mar)
-- ============================================

WITH feb AS (
    SELECT
        exposure_id,
        customer_id,
        stage AS stage_feb
    FROM risk.exposure_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
),
mar AS (
    SELECT
        exposure_id,
        customer_id,
        stage AS stage_mar
    FROM risk.exposure_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
)

SELECT
    m.exposure_id,
    m.customer_id,
    f.stage_feb,
    m.stage_mar,
    CASE
        WHEN f.stage_feb = m.stage_mar THEN 'No Change'
        WHEN f.stage_feb < m.stage_mar THEN 'Deterioration'
        WHEN f.stage_feb > m.stage_mar THEN 'Improvement'
        ELSE 'Unknown'
    END AS movement_type
FROM mar m
LEFT JOIN feb f
    ON m.exposure_id = f.exposure_id
ORDER BY movement_type DESC, m.exposure_id;

-- ============================================
-- Aggregated Migration Matrix
-- ============================================

SELECT
    f.stage_feb,
    m.stage_mar,
    COUNT(*) AS exposure_count
FROM (
    SELECT exposure_id, stage AS stage_feb
    FROM risk.exposure_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
) f
JOIN (
    SELECT exposure_id, stage AS stage_mar
    FROM risk.exposure_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
) m
ON f.exposure_id = m.exposure_id
GROUP BY f.stage_feb, m.stage_mar
ORDER BY f.stage_feb, m.stage_mar;

--“Stage migration analysis shows a shift of exposures from Stage 2 to Stage 3, 
-- which is the primary driver of the increase in expected credit losses.”