import subprocess
import sys
import argparse

# --- Argument parser ---
parser = argparse.ArgumentParser()
parser.add_argument("--date", required=True, help="Reporting date (YYYY-MM-DD)")
args = parser.parse_args()

REPORTING_DATE = args.date


REPORTING_DATE = REPORTING_DATE

def run_script(script_name):
    print(f"\n--- Running {script_name} ---")
    result = subprocess.run(
        ["python", script_name, REPORTING_DATE],
        capture_output=True,
        text=True
    )
    print(result.stdout)
    if result.returncode != 0:
        print(result.stderr)
        sys.exit(1)

def main():
    print(f"=== MONTHLY IFRS9 PIPELINE ({REPORTING_DATE}) ===")

    run_script("04_extract_april_data.py")
    run_script("05_validate_ecl.py")
    run_script("06_impairment_calculation.py")
    run_script("08_export_excel_report.py")

    print("\n✅ PIPELINE COMPLETED")

if __name__ == "__main__":
    main()