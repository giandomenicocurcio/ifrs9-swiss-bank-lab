/*
 🧠 Naming Convention (VERY important)
 
 We follow a bank-style standard:
 
 [sequence]_[type]_[topic]_[period].sql
 Example:
 01_reconciliation_ifrs9_2026_04.sql
 02_stage_migration_2026_04.sql
 03_impairment_bridge_2026_04.sql
 
 👉 This gives you:
 
 order
 clarity
 scalability (months / versions)
 🧠 File Types (you will use these)
 Type	Meaning
 reconciliation	controls & checks
 calculation	risk logic
 report	finance outputs
 analysis	management insights
 🧠 Folder Logic (your final structure)
 sql/
 │
 ├── 01_ddl
 ├── 02_seed
 ├── 03_risk_calculation
 ├── 04_finance_reporting
 └── 05_controls   ✅ (new)
 */