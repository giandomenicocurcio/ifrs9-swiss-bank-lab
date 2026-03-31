-- rule table
CREATE TABLE risk.ifrs9_stage_rule (
    stage INT PRIMARY KEY CHECK (stage IN (1, 2, 3)),
    stage_name TEXT NOT NULL,
    pd_rate NUMERIC(10, 6) NOT NULL,
    lgd_rate NUMERIC(10, 6) NOT NULL,
    ecl_basis TEXT NOT NULL
);

-- simple rules

INSERT INTO risk.ifrs9_stage_rule (
    stage,
    stage_name,
    pd_rate,
    lgd_rate,
    ecl_basis
)
VALUES
    (1, 'Stage 1 - Performing',      0.010000, 0.400000, '12M ECL'),
    (2, 'Stage 2 - Underperforming', 0.080000, 0.450000, 'Lifetime ECL'),
    (3, 'Stage 3 - Defaulted',       0.400000, 0.600000, 'Lifetime ECL');