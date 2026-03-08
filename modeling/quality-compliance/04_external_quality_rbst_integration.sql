/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Integration / External Quality (RBST)
 * PURPOSE: 
 * Unified view of External Quality Audits (RBST) performed by AMEX Analysts.
 * This script bridges the legacy survey storage with the new 2024 structure
 * using a UNION ALL approach and SCD (Slowly Changing Dimensions) Roster logic.
 ********************************************************************************/

/* --- LEGACY SOURCE (PRE-AUG 2024) --- */
SELECT DISTINCT
    CASE 
        WHEN ros.[roster_empdaterange_key] IS NULL THEN '-1' 
        ELSE ros.[roster_empdaterange_key]
    END AS roster_key,
    CREATEDATE(GETYEAR(rbsts.[interaction_date]), GETMONTH(rbsts.[interaction_date]), GETDAY(rbsts.[interaction_date])) AS date_key,
    rbsts.quarter,
    rbstS.[month],
    rbsts.recorded_date,
    rbsts.agent_max_sine,
    rbsts.has_the_bst_error_been_coached,
    rbsts.agent,
    rbsts.team_leader,
    rbsts.manager,
    rbsts.director,
    rbsts.interaction_date,
    rbsts.amex_record_locator,
    rbsts.inquiry_type,
    rbsts.transaction_type,
    rbsts.call_type,
    rbsts.call_category,
    rbsts.rbst_bst_feedback,
    rbsts.additional_coaching_feedback,
    rbsts.coaching_opportunity_comments,
    rbsts.call_id,
    rbsts.[total_met],
    rbsts.[total_opportunities],
    rbsts.[total_not_met]
FROM rbst_survey_storage AS rbsts
LEFT JOIN operations_master_roster AS roster
    ON TOSTRING(roster.[max_sine_id]) = TOSTRING(rbsts.[agent_max_sine])
    OR roster.[Contractor ID] = rbsts.[agent_max_sine]
LEFT JOIN ods_daterange_roster AS ros
    ON TOSTRING(roster.[workday_id]) = TOSTRING(ros.[employee_id])
    AND CREATEDATE(GETYEAR(rbsts.[interaction_date]), GETMONTH(rbsts.[interaction_date]), GETDAY(rbsts.[interaction_date]))
    BETWEEN ros.[effective_from] AND CASE WHEN ros.[effective_to] IS NULL THEN CREATEDATE(2099,01,01) ELSE ros.[effective_to] END

UNION ALL 

/* --- NEW SOURCE (AUG 1, 2024 ONWARDS) --- */
SELECT DISTINCT
    CASE 
        WHEN ros.[roster_empdaterange_key] IS NULL THEN '-1' 
        ELSE ros.[roster_empdaterange_key]
    END AS roster_key,
    CREATEDATE(GETYEAR(rbsts2.[Interaction date]), GETMONTH(rbsts2.[Interaction date]), GETDAY(rbsts2.[Interaction date])) AS date_key,
    rbsts2.quarter AS quarter,
    rbsts2.month AS month,
    rbsts2.[Recorded Date] AS recorded_date,
    rbsts2.[Employee ID] AS agent_max_sine,
    rbsts2.[Has the RBST Error been coached?] AS has_the_bst_error_been_coached,
    rbsts2.[Agent] AS agent,
    rbsts2.[Team Leader] AS team_leader,
    rbsts2.[Manager] AS manager,
    rbsts2.[Director] AS director,
    rbsts2.[Interaction date] AS interaction_date,
    rbsts2.[Amex Record Locator] AS amex_record_locator,
    rbsts2.[Inquiry Type:] AS inquiry_type,
    rbsts2.[Transaction Type:] AS transaction_type,
    rbsts2.[Call Type] AS call_type,
    rbsts2.[Call Category] AS call_category,
    rbsts2.[RBST/BST feedback] AS rbst_bst_feedback,
    rbsts2.[Additional coaching feedback] AS additional_coaching_feedback,
    rbsts2.[Coaching opportunity comments] AS coaching_opportunity_comments,
    TOSTRING(TOINT(rbsts2.[Call ID#:])) AS call_id,
    rbsts2.[Total Met] AS total_met,
    rbsts2.[Total Opportunities] AS total_opportunities,
    rbsts2.[Total Opportunities] AS total_not_met
FROM rbst_2024_survey_str AS rbsts2 
LEFT JOIN operations_master_roster AS roster
    ON TOSTRING(roster.[max_sine_id]) = TOSTRING(rbsts2.[Employee ID])
    OR roster.[Contractor ID] = rbsts2.[Employee ID]
LEFT JOIN ods_daterange_roster AS ros
    ON TOSTRING(roster.[workday_id]) = TOSTRING(ros.[employee_id])
    AND CREATEDATE(GETYEAR(rbsts2.[Interaction date]), GETMONTH(rbsts2.[Interaction date]), GETDAY(rbsts2.[Interaction date]))
    BETWEEN ros.[effective_from] AND CASE WHEN ros.[effective_to] IS NULL THEN CREATEDATE(2099,01,01) ELSE ros.[effective_to] END;
