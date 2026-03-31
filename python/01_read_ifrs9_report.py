# 01_read_ifrs9_report.py

import pandas as pd
from pathlib import Path

# --------------------------------------------------
# Paths
# --------------------------------------------------
base_path = Path("/home/gcquant/swiss_bank_lab")
input_file = base_path / "reports" / "csv" / "ifrs9_impairment_report.csv"
output_file = base_path / "reports" / "csv" / "ifrs9_impairment_report_enriched.csv"

# --------------------------------------------------
# Read CSV
# --------------------------------------------------
df = pd.read_csv(input_file)

# --------------------------------------------------
# Basic checks
# --------------------------------------------------
print("\n=== RAW IFRS9 IMPAIRMENT REPORT ===")
print(df)
print("\nColumns:")
print(df.columns.tolist())

# --------------------------------------------------
# Add interpretation column
# --------------------------------------------------
df["movement_type"] = df["pnl_impairment_charge"].apply(
    lambda x: "Expense increase" if x > 0 else ("Release" if x < 0 else "No movement")
)

# --------------------------------------------------
# Add absolute movement for reporting
# --------------------------------------------------
df["absolute_movement"] = df["pnl_impairment_charge"].abs()

# --------------------------------------------------
# Print enriched result
# --------------------------------------------------
print("\n=== ENRICHED IFRS9 IMPAIRMENT REPORT ===")
print(df)

# --------------------------------------------------
# Save enriched CSV
# --------------------------------------------------
df.to_csv(output_file, index=False)

print(f"\nEnriched file saved to:\n{output_file}")
