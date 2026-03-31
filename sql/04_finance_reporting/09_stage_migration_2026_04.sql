-- =========================================================
-- 09_stage_migration_2026_04.sql
-- Purpose: Stage migration March → April
-- =========================================================
SELECT m.stage AS stage_march,
    a.stage AS stage_april,
    COUNT(*) AS exposures,
    SUM(m.ecl_amount) AS ecl_march,
    SUM(a.ecl_amount) AS ecl_april,
    SUM(a.ecl_amount - m.ecl_amount) AS impact
FROM risk.ifrs9_provision_snapshot a
    JOIN risk.ifrs9_provision_snapshot m ON a.exposure_id = m.exposure_id
WHERE a.snapshot_date = '2026-04-30'
    AND m.snapshot_date = '2026-03-31'
GROUP BY m.stage,
    a.stage
ORDER BY m.stage,
    a.stage;
