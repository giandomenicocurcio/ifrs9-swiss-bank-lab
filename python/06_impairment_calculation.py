#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
06_impairment_calculation.py

Purpose:
Calculate IFRS9 impairment movement between two snapshot dates.

Business meaning:
Impairment charge = current period ECL - prior period ECL

This script:
1. Connects to PostgreSQL
2. Extracts IFRS9 provision snapshot for two dates
3. Aggregates ECL
4. Calculates impairment movement
"""

import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine, text
import sys
from datetime import datetime
from dateutil.relativedelta import relativedelta

# --- Get reporting date from pipeline ---
if len(sys.argv) > 1:
    CURRENT_DATE = sys.argv[1]
else:
    CURRENT_DATE = "2026-04-30"  # fallback

# --- Compute prior date automatically ---
current_dt = datetime.strptime(CURRENT_DATE, "%Y-%m-%d")
prior_dt = current_dt - relativedelta(months=1)
PRIOR_DATE = prior_dt.strftime("%Y-%m-%d")

print(f"Current snapshot: {CURRENT_DATE}")
print(f"Prior snapshot:   {PRIOR_DATE}")

# ---------------------------------------------------
# CONFIG
# ---------------------------------------------------



# ---------------------------------------------------
# LOAD ENVIRONMENT
# ---------------------------------------------------
load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")


# ---------------------------------------------------
# CONNECTION
# ---------------------------------------------------
def get_engine():
    conn_str = (
        f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )
    return create_engine(conn_str)


# ---------------------------------------------------
# EXTRACT PROVISION SNAPSHOT
# ---------------------------------------------------
def load_provision_snapshot(engine, snapshot_date: str) -> pd.DataFrame:
    query = text("""
        SELECT
            snapshot_date,
            exposure_id,
            customer_id,
            account_id,
            stage,
            exposure_amount,
            pd_rate,
            lgd_rate,
            ecl_amount,
            provision_type
        FROM risk.ifrs9_provision_snapshot
        WHERE snapshot_date = :snapshot_date
        ORDER BY exposure_id
    """)

    df = pd.read_sql(query, engine, params={"snapshot_date": snapshot_date})
    return df


# ---------------------------------------------------
# MAIN
# ---------------------------------------------------
def main():
    print("Connecting to DB...")
    engine = get_engine()
    print("Connected.\n")

    print(f"Loading prior snapshot:   {PRIOR_DATE}")
    df_prior = load_provision_snapshot(engine, PRIOR_DATE)
    print(f"Rows loaded: {len(df_prior)}\n")

    print(f"Loading current snapshot: {CURRENT_DATE}")
    df_current = load_provision_snapshot(engine, CURRENT_DATE)
    print(f"Rows loaded: {len(df_current)}\n")

    prior_total_ecl = df_prior["ecl_amount"].sum() if not df_prior.empty else 0.0
    current_total_ecl = df_current["ecl_amount"].sum() if not df_current.empty else 0.0
    impairment_charge = current_total_ecl - prior_total_ecl

    print("=== IMPAIRMENT SUMMARY ===")
    print(f"Prior snapshot date:   {PRIOR_DATE}")
    print(f"Current snapshot date: {CURRENT_DATE}")
    print(f"Prior total ECL:       {prior_total_ecl:.2f}")
    print(f"Current total ECL:     {current_total_ecl:.2f}")
    print(f"P&L impairment charge: {impairment_charge:.2f}")

    summary_df = pd.DataFrame([{
        "prior_snapshot_date": PRIOR_DATE,
        "current_snapshot_date": CURRENT_DATE,
        "prior_total_ecl": prior_total_ecl,
        "current_total_ecl": current_total_ecl,
        "pnl_impairment_charge": impairment_charge
    }])

    output_file = f"output/impairment_summary_{PRIOR_DATE}_vs_{CURRENT_DATE}.csv"
    summary_df.to_csv(output_file, index=False)

    print(f"\nSaved: {output_file}")


if __name__ == "__main__":
    main()
