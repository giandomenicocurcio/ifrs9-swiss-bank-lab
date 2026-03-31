/*
We split impairment into:

Stage 1 impact
Stage 2 impact
Stage 3 impact
*/
-- =========================================================
-- 08_impairment_driver_analysis_2026_04.sql
-- Purpose: Explain impairment movement by stage
-- =========================================================

SELECT
    a.stage,

    COUNT(*) AS exposures,

    SUM(m.ecl_amount) AS ecl_march,
    SUM(a.ecl_amount) AS ecl_april,

    SUM(a.ecl_amount - m.ecl_amount) AS impairment_delta

FROM risk.ifrs9_provision_snapshot a
JOIN risk.ifrs9_provision_snapshot m
    ON a.exposure_id = m.exposure_id

WHERE a.snapshot_date = '2026-04-30'
  AND m.snapshot_date = '2026-03-31'

GROUP BY a.stage
ORDER BY a.stage;

