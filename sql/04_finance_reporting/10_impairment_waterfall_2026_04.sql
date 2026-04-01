-- =========================================================
-- 10_impairment_waterfall_2026_04.sql
-- Purpose: Impairment waterfall explanation
-- =========================================================
SELECT CASE
        WHEN m.stage = a.stage THEN 'STABLE'
        WHEN m.stage < a.stage THEN 'DETERIORATION'
        WHEN m.stage > a.stage THEN 'IMPROVEMENT'
    END AS movement_type,
    COUNT(*) AS exposures,
    SUM(a.ecl_amount - m.ecl_amount) AS impact
FROM risk.ifrs9_provision_snapshot a
    JOIN risk.ifrs9_provision_snapshot m ON a.exposure_id = m.exposure_id
WHERE a.snapshot_date = '2026-04-30'
    AND m.snapshot_date = '2026-03-31'
GROUP BY CASE
        WHEN m.stage = a.stage THEN 'STABLE'
        WHEN m.stage < a.stage THEN 'DETERIORATION'
        WHEN m.stage > a.stage THEN 'IMPROVEMENT'
    END
ORDER BY movement_type;