WITH prior AS (
    SELECT exposure_id,
        stage AS stage_prior,
        ecl_amount AS ecl_prior
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = '2026-03-31'
),
current AS (
    SELECT exposure_id,
        stage AS stage_current,
        ecl_amount AS ecl_current
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = '2026-04-30'
),
joined AS (
    SELECT COALESCE(c.exposure_id, p.exposure_id) AS exposure_id,
        p.stage_prior,
        c.stage_current,
        COALESCE(p.ecl_prior, 0) AS ecl_prior,
        COALESCE(c.ecl_current, 0) AS ecl_current,
        COALESCE(c.ecl_current, 0) - COALESCE(p.ecl_prior, 0) AS delta_ecl
    FROM prior p
        FULL OUTER JOIN current c ON p.exposure_id = c.exposure_id
)
SELECT CONCAT(
        COALESCE(stage_prior::text, '0'),
        '->',
        COALESCE(stage_current::text, '0')
    ) AS stage_change,
    ROUND(SUM(delta_ecl), 2) AS delta_ecl
FROM joined
GROUP BY 1
ORDER BY 1;