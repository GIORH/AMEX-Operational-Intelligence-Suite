/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Dimension / Historical (SCD Type 2)
 * PURPOSE: 
 * Historical tracking of employee attributes and leadership hierarchy.
 * This table enables point-in-time reporting, ensuring interactions are 
 * attributed to the correct Team Leader/Manager based on the effective date.
 ********************************************************************************/

SELECT 
    [roster_empdaterange_key], -- Unique Surrogate Key for Fact Joins
    [employee_id] AS workday_id,
    [employee_name],
    [team_leader_name],
    [manager_name],
    [lob_name] AS lob,
    [effective_from],
    
    /* --- SCD Date Handling --- */
    -- Standardizing the end date for active records to a far-future date
    CASE 
        WHEN [effective_to] IS NULL THEN CREATEDATE(2099,01,01) 
        ELSE [effective_to] 
    END AS effective_to

FROM ods_daterange_roster;
