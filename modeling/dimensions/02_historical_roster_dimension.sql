/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Dimension / Historical (SCD Type 2)
 * PURPOSE: 
 * Historical employee dimension with point-in-time attribution.
 * Includes a dummy record (-1) to maintain referential integrity for 
 * orphaned fact records and mapped keys for all operational modules.
 ********************************************************************************/

SELECT
    ros.*,
    ros2024.[Date of Hire],
    
    /* --- Fact Table Relationship Keys --- */
    -- Mapping the Surrogate Key (roster_empdaterange_key) to each specific Fact
    ros.[roster_empdaterange_key] AS rbst_key,
    ros.[roster_empdaterange_key] AS writeoff_key,
    ros.[roster_empdaterange_key] AS rtf_key,
    ros.[roster_empdaterange_key] AS cod_cht_key,
    ros.[roster_empdaterange_key] AS postappeal_key,
    ros.[roster_empdaterange_key] AS adherence_key,
    ros.[roster_empdaterange_key] AS absenteeism_key,
    ros.[roster_empdaterange_key] AS m1_internal_compliance_fact_key,
    ros.[roster_empdaterange_key] AS m1_internal_compliance2_fact_key,
    ros.[roster_empdaterange_key] AS fact_training_key,
    ros.[roster_empdaterange_key] AS fact_ce_key,
    ros.[roster_empdaterange_key] AS fact_btp_key,
    ros.[roster_empdaterange_key] AS workday_key,
    ros.[roster_empdaterange_key] AS fact_aux_key,
    ros.[roster_empdaterange_key] AS fact_vibes_key,
    ros.[roster_empdaterange_key] AS fact_vibes_call_id_key,
    ros.[roster_empdaterange_key] AS rbst_2024_key,
    ros.[roster_empdaterange_key] AS training_completion_key,
    ros.[roster_empdaterange_key] AS audit_completion_key,
    ros.[roster_empdaterange_key] AS training_audits_key,
    ros.[roster_empdaterange_key] AS rbst_2025_key,
    ros.[roster_empdaterange_key] AS test_key

FROM (
    /* Base Historical Data */
    SELECT * FROM ods_daterange_roster
    
    UNION ALL
    
    /* Referential Integrity Record (Handles NULLs/Orphans) */
    SELECT 
        '-1' AS roster_empdaterange_key,
        '-1' AS employee_id,
        CREATEDATE(2000, 1, 1) AS effective_from,
        CREATEDATE(2099, 12, 31) AS effective_to,
        'Undefined' AS employee_name,
        'Undefined' AS team_leader_name,
        'Undefined' AS manager_name,
        'Undefined' AS director_name,
        'Undefined' AS lob_name,
        'Undefined' AS location_name,
        'Undefined' AS status,
        'Undefined' AS role,
        'Undefined' AS business_unit,
        'Undefined' AS department,
        'Undefined' AS shift,
        'Undefined' AS email,
        'Undefined' AS workday_id_v2,
        'Undefined' AS supervisor_id,
        'Undefined' AS cost_center
) AS ros

LEFT JOIN operations_master_roster AS ros2024
    ON ros2024.workday_id = ros.employee_id;
