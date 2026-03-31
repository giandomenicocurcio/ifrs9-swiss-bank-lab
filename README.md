# IFRS9 Swiss Bank Lab

## Overview
This project simulates a banking data platform for IFRS9 Expected Credit Loss (ECL) calculation using PostgreSQL, SQL, Python, and Power BI.

It covers the full workflow from risk data ingestion to finance reporting and dashboard visualization.

## Business Context
Banks must calculate credit risk provisions under IFRS9 using staging (Stage 1, 2, 3) and Expected Credit Loss models.

This project reproduces that process with:
- Exposure snapshots
- Stage classification
- ECL calculation (PD × LGD × Exposure)
- Impairment reporting (period delta)
- Risk-to-finance bridge

## Tech Stack
- PostgreSQL
- SQL
- Python (pandas, SQLAlchemy)
- Power BI
- Excel

## Project Structure
- `sql/01_ddl` → table creation
- `sql/02_seed` → data loading
- `sql/03_risk_calculation` → IFRS9 ECL logic
- `sql/04_finance_reporting` → impairment reporting
- `sql/05_controls` → reconciliation checks
- `python/` → automation and extraction
- `powerbi/` → dashboard
- `reports/` → outputs

## Key Features
- Monthly snapshot-based architecture
- Exposure-level ECL calculation
- Stage migration tracking
- Impairment charge calculation (P&L impact)
- Reconciliation controls
- Dashboard-ready dataset

## Example Workflow
1. Load exposure data
2. Assign IFRS9 stages
3. Calculate ECL
4. Aggregate provisions
5. Compute impairment delta
6. Export results for reporting

## Dashboard
(Screenshots to be added)

## Skills Demonstrated
- IFRS9 provisioning logic
- Financial reporting
- SQL data modeling
- Python automation
- Data validation and controls
- Power BI reporting

## Author
Giandomenico Curcio  
Finance / IFRS9 / Data Analytics
