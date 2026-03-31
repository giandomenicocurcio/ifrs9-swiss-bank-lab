CREATE TABLE finance.impairment_report (
    snapshot_date             DATE PRIMARY KEY,
    total_ifrs9_provision     NUMERIC(18,2) NOT NULL,
    prior_ifrs9_provision     NUMERIC(18,2),
    pnl_impairment_charge     NUMERIC(18,2),
    created_at                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*
Meaning
total_ifrs9_provision = current closing allowance
prior_ifrs9_provision = previous month closing allowance
pnl_impairment_charge = movement booked to profit & loss
*/

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
    SELECT
        snapshot_date,
        SUM(ecl_amount) AS total_ifrs9_provision
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-03-31'
    GROUP BY snapshot_date
) curr
LEFT JOIN (
    SELECT
        SUM(ecl_amount) AS total_ifrs9_provision
    FROM risk.ifrs9_provision_snapshot
    WHERE snapshot_date = DATE '2026-02-28'
) prev
    ON 1 = 1;