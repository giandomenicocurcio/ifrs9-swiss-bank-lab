-- ============================================
-- IFRS9 Aggregation Layer
-- ============================================
-- Step 1 — Total provision
SELECT snapshot_date,
    SUM(ecl_amount) AS total_ifrs9_provision
FROM risk.ifrs9_provision_snapshot
GROUP BY snapshot_date;
-- Step 2 — Provision per customer
SELECT customer_id,
    SUM(ecl_amount) AS customer_ecl
FROM risk.ifrs9_provision_snapshot
GROUP BY customer_id
ORDER BY customer_ecl DESC;
-- Step 3 — Provision by stage
SELECT stage,
    SUM(ecl_amount) AS stage_ecl
FROM risk.ifrs9_provision_snapshot
GROUP BY stage
ORDER BY stage;
--Adding date filter
SELECT customer_id,
    SUM(ecl_amount) AS customer_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
GROUP BY customer_id
ORDER BY customer_ecl DESC;
-- With date filter column
SELECT customer_id,
    snapshot_date,
    SUM(ecl_amount) AS customer_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
GROUP BY customer_id,
    snapshot_date
ORDER BY customer_ecl DESC;
--

SELECT customer_id,
    MIN(snapshot_date) AS snapshot_date,
    SUM(ecl_amount) AS customer_ecl
FROM risk.ifrs9_provision_snapshot
GROUP BY customer_id;
--
SELECT
customer_id,
snapshot_date,
SUM(ecl_amount) AS customer_ecl
FROM risk.ifrs9_provision_snapshot
WHERE snapshot_date = DATE '2026-03-31'
GROUP BY customer_id,
    snapshot_date
ORDER BY customer_ecl DESC;