import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

base_path = Path("/home/gcquant/swiss_bank_lab")
output_file = base_path / "reports" / "csv" / "ifrs9_final_summary.csv"

engine = create_engine("postgresql+psycopg2:///swiss_bank_lab")

query = """
SELECT
    snapshot_date,
    total_ifrs9_provision,
    prior_ifrs9_provision,
    pnl_impairment_charge
FROM finance.impairment_report
ORDER BY snapshot_date;
"""

df = pd.read_sql(query, engine)

df["movement_type"] = df["pnl_impairment_charge"].apply(
    lambda x: "Expense increase" if x > 0 else ("Release" if x < 0 else "No movement")
)

df["absolute_movement"] = df["pnl_impairment_charge"].abs()

df["commentary"] = df["pnl_impairment_charge"].apply(
    lambda x: "Provision increased versus prior period"
    if x > 0 else (
        "Provision released versus prior period"
        if x < 0 else "No change versus prior period"
    )
)

print("\n=== FINAL IFRS9 SUMMARY ===")
print(df)

df.to_csv(output_file, index=False)

print(f"\nSaved final summary to:\n{output_file}")
