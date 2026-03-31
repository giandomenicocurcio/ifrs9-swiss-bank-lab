--IFRS9 snapshot table
CREATE TABLE risk.ifrs9_provision_snapshot (
    snapshot_date DATE NOT NULL,
    exposure_id INT NOT NULL,
    customer_id INT NOT NULL,
    account_id INT NOT NULL,
    stage INT NOT NULL CHECK (stage IN (1, 2, 3)),
    exposure_amount NUMERIC(18, 2) NOT NULL,
    pd_rate NUMERIC(10, 6) NOT NULL,
    lgd_rate NUMERIC(10, 6) NOT NULL,
    ecl_amount NUMERIC(18, 2) NOT NULL,
    provision_type TEXT NOT NULL DEFAULT 'IFRS9',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (snapshot_date, exposure_id)
);