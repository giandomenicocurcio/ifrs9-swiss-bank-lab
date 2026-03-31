#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import pandas as pd

# Load data
df_ecl = pd.read_csv("output/2026-04-30/risk_ifrs9_provision_snapshot.csv")
df_imp = pd.read_csv("output/impairment_summary_2026_03_31_vs_2026_04_30.csv")

# Simple aggregation
ecl_summary = df_ecl.groupby("stage")["ecl_amount"].sum().reset_index()

# Excel output
output_file = "output/ifrs9_report.xlsx"

with pd.ExcelWriter(output_file, engine="openpyxl") as writer:
    df_ecl.to_excel(writer, sheet_name="ECL_Detail", index=False)
    ecl_summary.to_excel(writer, sheet_name="ECL_By_Stage", index=False)
    df_imp.to_excel(writer, sheet_name="Impairment_Summary", index=False)

print(f"Report saved: {output_file}")