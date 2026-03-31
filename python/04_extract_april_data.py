#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
04_extract_april_data.py

Purpose:
Extract April 2026 IFRS9 data from PostgreSQL into pandas.

Business meaning:
This is the Python ingestion layer of the IFRS9 pipeline.
We replicate the reporting population used in SQL to enable validation.
"""

import os
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import sys

if len(sys.argv) > 1:
    REPORTING_DATE = sys.argv[1]
else:
    REPORTING_DATE = "2026-04-30"  # fallback (optional)

# ---------------------------------------------------
# CONFIG
# ---------------------------------------------------
REPORTING_DATE = "2026-04-30"


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
    conn_str = f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    return create_engine(conn_str)


# ---------------------------------------------------
# EXTRACTION FUNCTION
# ---------------------------------------------------
def extract_table(engine, schema, table):
    print(f"\n--- Extracting {schema}.{table} ---")

    # Map correct date column per table
    date_column_map = {
        "exposure_snapshot": "snapshot_date",
        "ifrs9_provision_snapshot": "snapshot_date",
        "impairment_report": "snapshot_date",
    }
    
    date_col = date_column_map.get(table)

    if date_col:
        query = text(f"""
            SELECT *
            FROM {schema}.{table}
            WHERE {date_col} = :reporting_date
        """)
        df = pd.read_sql(query, engine, params={"reporting_date": REPORTING_DATE})
    else:
        # fallback (no date filtering)
        query = text(f"""
            SELECT *
            FROM {schema}.{table}
        """)
        df = pd.read_sql(query, engine)

    print(f"Rows: {len(df)}")
    print(f"Columns: {len(df.columns)}")

    if not df.empty:
        print("\nPreview:")
        print(df.head().to_string(index=False))
    else:
        print("⚠️ No data found")

    return df


# ---------------------------------------------------
# MAIN
# ---------------------------------------------------
def main():
    print("Connecting to DB...")
    engine = get_engine()
    print("Connected.\n")

    tables = [
        ("risk", "exposure_snapshot"),
        ("risk", "ifrs9_provision_snapshot"),
        ("finance", "impairment_report"),
    ]

    output_dir = Path("output") / REPORTING_DATE
    output_dir.mkdir(parents=True, exist_ok=True)

    results = {}

    for schema, table in tables:
        df = extract_table(engine, schema, table)

        file_path = output_dir / f"{schema}_{table}.csv"
        df.to_csv(file_path, index=False)

        print(f"Saved: {file_path}")

        results[f"{schema}.{table}"] = df

    print("\n=== SUMMARY ===")
    for k, v in results.items():
        print(f"{k}: {len(v)} rows")

    print("\nDone.")


if __name__ == "__main__":
    main()

## \q