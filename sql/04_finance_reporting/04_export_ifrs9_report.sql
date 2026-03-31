-- ============================================
-- Export IFRS9 Report (Final Reporting Layer)
-- ============================================
COPY (
    SELECT i.snapshot_date,
        i.total_ifrs9_provision,
        i.prior_ifrs9_provision,
        i.pnl_impairment_charge
    FROM finance.impairment_report i
    ORDER BY i.snapshot_date
) TO '/home/gcquant/swiss_bank_lab/reports/csv/ifrs9_impairment_report.csv' WITH CSV HEADER;