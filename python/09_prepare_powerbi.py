import pandas as pd

# Load data
df = pd.read_csv("output/2026-04-30/risk_ifrs9_provision_snapshot.csv")
df_imp = pd.read_csv("output/impairment_summary_2026_03_31_vs_2026_04_30.csv")

# -------------------------
# FACT ECL
# -------------------------
fact_ecl = df[[
    "snapshot_date",
    "exposure_id",
    "stage",
    "ecl_amount"
]]

fact_ecl.to_csv("output/pbi_fact_ecl.csv", index=False)

# -------------------------
# FACT IMPAIRMENT
# -------------------------
fact_impairment = df_imp.copy()
fact_impairment.to_csv("output/pbi_fact_impairment.csv", index=False)

# -------------------------
# DIM STAGE
# -------------------------
dim_stage = pd.DataFrame({
    "stage": [1, 2, 3],
    "stage_desc": ["Performing", "Underperforming", "Default"]
})

dim_stage.to_csv("output/pbi_dim_stage.csv", index=False)

print("Power BI datasets created.")