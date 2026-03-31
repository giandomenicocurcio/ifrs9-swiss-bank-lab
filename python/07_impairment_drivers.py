#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
07_impairment_drivers.py

Purpose:
Analyze drivers of IFRS9 impairment movement.

Business meaning:
Break down P&L into:
- exposure changes
- stage migration
- risk changes
"""

import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine, text


PRIOR_DATE = "2026-03-31"
CURRENT_DATE = "2026-04-30"


load_dotenv()

engine = create_engine(
    f"postgresql+psycopg2://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@"
    f"{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
)


def load_data(date):
    query = text("""
        SELECT exposure_id, stage, exposure_amount, ecl_amount
        FROM risk.ifrs9_provision_snapshot
        WHERE snapshot_date = :date
    """)
    return pd.read_sql(query, engine, params={"date": date})


df_prior = load_data(PRIOR_DATE)
df_current = load_data(CURRENT_DATE)


# ---------------------------------------------------
# MERGE DATASETS
# ---------------------------------------------------
df = df_prior.merge(
    df_current,
    on="exposure_id",
    how="outer",
    suffixes=("_prior", "_current")
)


df.fillna(0, inplace=True)


# ---------------------------------------------------
# CALCULATE CHANGES
# ---------------------------------------------------
df["delta_ecl"] = df["ecl_amount_current"] - df["ecl_amount_prior"]


# ---------------------------------------------------
# DRIVER: STAGE CHANGE
# ---------------------------------------------------
df["stage_change"] = df["stage_prior"].astype(str) + "->" + df["stage_current"].astype(str)


# ---------------------------------------------------
# OUTPUT
# ---------------------------------------------------
print("\n=== IMPAIRMENT DRIVERS ===")
print(df[[
    "exposure_id",
    "stage_prior",
    "stage_current",
    "ecl_amount_prior",
    "ecl_amount_current",
    "delta_ecl"
]].to_string(index=False))


# ---------------------------------------------------
# AGGREGATION
# ---------------------------------------------------
summary = df.groupby("stage_change")["delta_ecl"].sum()

print("\n=== STAGE DRIVER SUMMARY ===")
print(summary)


print("\n=== TOTAL CHECK ===")
print(f"Total delta ECL: {df['delta_ecl'].sum():.2f}")