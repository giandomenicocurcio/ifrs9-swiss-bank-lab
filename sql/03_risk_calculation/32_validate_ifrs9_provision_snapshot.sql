-- Validate IFRS9 provision snapshot
SELECT *
FROM risk.ifrs9_provision_snapshot
ORDER BY exposure_id;