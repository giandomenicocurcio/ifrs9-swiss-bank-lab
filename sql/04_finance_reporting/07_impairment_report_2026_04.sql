-- =========================================================
-- 07_impairment_report_2026_04.sql
-- Purpose: Calculate impairment movement March → April
-- =========================================================
SELECT a.exposure_id,
    a.customer_id,
    m.ecl_amount AS ecl_march,
    a.ecl_amount AS ecl_april,
    a.ecl_amount - m.ecl_amount AS impairment_delta
FROM risk.ifrs9_provision_snapshot a
    JOIN risk.ifrs9_provision_snapshot m ON a.exposure_id = m.exposure_id
WHERE a.snapshot_date = '2026-04-30'
    AND m.snapshot_date = '2026-03-31';

-- \q

SELECT
    SUM(a.ecl_amount - m.ecl_amount) AS total_impairment_delta
FROM risk.ifrs9_provision_snapshot a
JOIN risk.ifrs9_provision_snapshot m
    ON a.exposure_id = m.exposure_id
WHERE a.snapshot_date = '2026-04-30'
  AND m.snapshot_date = '2026-03-31';

