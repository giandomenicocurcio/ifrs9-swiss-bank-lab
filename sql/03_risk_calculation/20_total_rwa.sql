SELECT*
FROM risk.exposure_snapshot;
--TASK 1 — Total Exposure & RWA
SELECT
    snapshot_date AS snapshot_date,
    ROUND(SUM(exposure_amount), 1) AS total_exposure,
    ROUND(SUM(exposure_amount * risk_weight),1) AS total_RWA
FROM risk.exposure_snapshot
GROUP BY
    snapshot_date;


