-- ============================================
-- IFRS9 DASHBOARD DATASET
-- ============================================

WITH provision AS (
    SELECT
        snapshot_date,
        total_ifrs9_provision,
        prior_ifrs9_provision,
        pnl_impairment_charge
    FROM finance.impairment_report
),

stage_breakdown AS (
    SELECT
        snapshot_date,
        SUM(CASE WHEN stage = 1 THEN ecl_amount ELSE 0 END) AS stage1_ecl,
        SUM(CASE WHEN stage = 2 THEN ecl_amount ELSE 0 END) AS stage2_ecl,
        SUM(CASE WHEN stage = 3 THEN ecl_amount ELSE 0 END) AS stage3_ecl
    FROM risk.ifrs9_provision_snapshot
    GROUP BY snapshot_date
),

top_driver AS (
    SELECT
        snapshot_date,
        customer_id,
        SUM(ecl_amount) AS customer_ecl,
        RANK() OVER (PARTITION BY snapshot_date ORDER BY SUM(ecl_amount) DESC) AS rnk
    FROM risk.ifrs9_provision_snapshot
    GROUP BY snapshot_date, customer_id
)

SELECT
    p.snapshot_date,
    p.total_ifrs9_provision,
    p.prior_ifrs9_provision,
    p.pnl_impairment_charge,
    s.stage1_ecl,
    s.stage2_ecl,
    s.stage3_ecl,
    td.customer_id AS top_customer,
    td.customer_ecl AS top_customer_ecl
FROM provision p
LEFT JOIN stage_breakdown s
    ON p.snapshot_date = s.snapshot_date
LEFT JOIN top_driver td
    ON p.snapshot_date = td.snapshot_date
   AND td.rnk = 1
ORDER BY p.snapshot_date

TO '/home/gcquant/swiss_bank_lab/reports/csv/ifrs9_dashboard_dataset.csv'
WITH CSV HEADER;