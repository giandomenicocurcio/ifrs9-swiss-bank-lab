import pandas as pd
from sqlalchemy import create_engine

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

print("\n=== IFRS9 REPORT FROM POSTGRES ===")
print(df)

df["movement_type"] = df["pnl_impairment_charge"].apply(
    lambda x: "Expense increase" if x > 0 else ("Release" if x < 0 else "No movement")
)

print("\n=== ENRICHED ===")
print(df)
