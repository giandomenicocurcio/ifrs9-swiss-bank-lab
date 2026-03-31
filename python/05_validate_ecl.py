#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
05_validate_ecl.py

Purpose:
Recalculate ECL in Python and compare with database values.

Business meaning:
This is a validation control ensuring IFRS9 calculation consistency.
"""

import pandas as pd


# ---------------------------------------------------
# LOAD DATA
# ---------------------------------------------------
df = pd.read_csv("output/2026-04-30/risk_ifrs9_provision_snapshot.csv")


# ---------------------------------------------------
# RECOMPUTE ECL
# ---------------------------------------------------
df["ecl_python"] = (
    df["exposure_amount"] *
    df["pd_rate"] *
    df["lgd_rate"]
)


# ---------------------------------------------------
# COMPARE
# ---------------------------------------------------
df["diff"] = df["ecl_amount"] - df["ecl_python"]


print("\n=== ECL VALIDATION ===")
print(df[[
    "exposure_id",
    "exposure_amount",
    "pd_rate",
    "lgd_rate",
    "ecl_amount",
    "ecl_python",
    "diff"
]].to_string(index=False))


# ---------------------------------------------------
# SUMMARY
# ---------------------------------------------------
total_diff = df["diff"].sum()

print("\n=== SUMMARY ===")
print(f"Total difference: {total_diff:.6f}")