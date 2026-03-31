--03_RISK_CALCULATION/21_COUNTRY_EXPOSURE.SQL
-- from 01_ddl/01_core_create_customers.sql
/*
 SELECT
 core.customers.customer_name AS name,
 risk.exposure_snapshot.exposure_amount AS amount
 FROM
 core.customers
 JOIN
 risk.exposure_snapshot
 ON risk.exposure_snapshot.exposure_amount = core.customers.customer_name;*/
-- 22_risk_monitoring.sql
--24_reconciliation_check.sql (there is too much)
--30_aggregation_results.sql (there is too much)
--07_impairment_report_2026_04.sql
/*
 🧠 How YOU explain this (interview level)
 
 Say:
 
 “The impairment decreased by 24k, 
 mainly driven by significant improvements in previously high-risk exposures, 
 partially offset by a small deterioration in one exposure.”
 */
--08_impairment_driver_analysis_2026_04-sql
/*
 🎯 Interview-level answer
 
 If they ask:
 
 👉 “What drove the impairment movement?”
 
 You say:
 
 “The impairment release was mainly driven by a significant reduction in Stage 3 exposures, 
 indicating improvement or resolution of previously defaulted positions, 
 supported by additional improvements in Stage 2 exposures.”
 */
-- \q
-- 09_stage_migration_2026_04.sql
--   \q
/*
 You can say:
 
 “There is a direct migration from Stage 1 to Stage 3, which may indicate a sudden default or a data/model anomaly that should be investigated.”
 
 💥 That’s top-level thinking
 --
 Your full story (ready for interview)
 
 You can now explain:
 
 “The impairment release of 24k is mainly driven by improvements in Stage 3 exposures. 
 However, there is a deterioration from Stage 1 to Stage 3 in one case, 
 which partially offsets the improvement and would require further investigation.”
 */
--10_impairment_waterfall_2026_04.sql
/*
 Large impairment release driven by stable exposures improving,
 partially offset by one deteriorating exposure
 
 🎯 FINAL INTERVIEW ANSWER (you can memorize this)
 
 “The impairment release of 24k is primarily driven by improvements within 
 stable exposures, particularly in Stage 3, indicating reduced credit risk or 
 lower exposure. This is partially offset by a deterioration in one 
 exposure migrating from Stage 1 to Stage 3.”
 */
-- \f