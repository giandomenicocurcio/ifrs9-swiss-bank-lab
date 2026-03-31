SELECT snapshot_date,
    SUM(ecl_amount) AS total_ecl
FROM risk.ifrs9_provision_snapshot
GROUP BY snapshot_date
ORDER BY snapshot_date;