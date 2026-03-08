/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Modeling / Operational Efficiency
 * PURPOSE: 
 * Mapping of Agent Adherence (Scheduled vs. Actual) to track schedule compliance.
 * This model uses SCD Roster keys to ensure historical accuracy of performance.
 ********************************************************************************/

SELECT DISTINCT
    CASE 
        WHEN ros.[roster_empdaterange_key] IS NULL THEN '-1' 
        ELSE ros.[roster_empdaterange_key]
    END AS roster_key,
    CREATEDATE(GETYEAR(adh.[Date]), GETMONTH(adh.[Date]), GETDAY(adh.[Date])) AS date_key,

    /* --- Adherence Metrics --- */
    adh.[Contractor_ID],
    adh.[Agent_Name],
    adh.[Scheduled_Time_Mins],
    adh.[Actual_Time_Mins],
    adh.[In_Adherence_Time_Mins],
    adh.[Out_of_Adherence_Time_Mins],
    
    -- Calculation of Adherence Percentage (Safety Check for division by zero)
    CASE 
        WHEN adh.[Scheduled_Time_Mins] > 0 
        THEN (CAST(adh.[In_Adherence_Time_Mins] AS FLOAT) / adh.[Scheduled_Time_Mins]) 
        ELSE 0 
    END AS adherence_pct

FROM fact_adherence AS adh
LEFT JOIN operations_master_roster AS roster
    ON roster.[Contractor ID] = adh.[Contractor_ID]

LEFT JOIN ods_daterange_roster AS ros
    ON TOSTRING(roster.[workday_id]) = ros.[employee_id]
    AND CREATEDATE(GETYEAR(adh.[Date]), GETMONTH(adh.[Date]), GETDAY(adh.[Date]))
    BETWEEN ros.[effective_from] AND CASE WHEN ros.[effective_to] IS NULL THEN CREATEDATE(2099,01,01) ELSE ros.[effective_to] END;
