-- ============================================
-- Finance: IFRS9 Impairment Report
-- ============================================

INSERT INTO finance.impairment_report (
    snapshot_date,
    total_ifrs9_provision,
    prior_ifrs9_provision,
    pnl_impairment_charge
)
SELECT
    curr.snapshot_date,
    curr.total_ifrs9_provision,
    prev.total_ifrs9_provision AS prior_ifrs9_provision,
    curr.total_ifrs9_provision - COALESCE(prev.total_ifrs9_provision, 0) AS pnl_impairment_charge
FROM (
    -- Current period
    SELECT
        snapshot_date,
        SUM(ecl_amount) AS total_ifrs9_provision
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
    GROUP BY snapshot_date
) curr
LEFT JOIN (
    -- Previous period
    SELECT
        SUM(ecl_amount) AS total_ifrs9_provision
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
) prev
ON 1 = 1;

DELETE FROM finance.impairment_report
WHERE snapshot_date = DATE '2026-03-31';





