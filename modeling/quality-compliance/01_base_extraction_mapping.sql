/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Staging / Data Extraction
 * PURPOSE: 
 * Initial extraction and normalization of Internal Audits. 
 * This script consolidates Member First (M1) Soft Skills and 
 * Legal/Compliance questions into a structured format before unpivoting.
 * * MAINTENANCE NOTE: 
 * Source headers from Google Sheets are sensitive. If headers change 
 * in the source Form, this mapping must be updated.
 ********************************************************************************/

SELECT DISTINCT
    -- Primary Keys & Dimensional Linking
    CASE 
        WHEN ros.[roster_empdaterange_key] IS NULL THEN '-1' 
        ELSE ros.[roster_empdaterange_key]
    END AS roster_key,
    
    -- Standardized Date Key for Time Intelligence
    CREATEDATE(GETYEAR(ce.[Timestamp]), GETMONTH(ce.[Timestamp]), GETDAY(ce.[Timestamp])) AS date_key,

    -- Operational Metrics: Audit Volume Counter
    CASE 
        WHEN ce.[workday_id] IS NOT NULL THEN 1
        ELSE 0
    END AS audit_counter,

    -- Source Record Tracking
    ce.[Row Number M1] AS m1_questions_key,
    ce.[Row Number Comp] AS comp_questions_key,

    -- Interaction Metadata
    ce.[Evaluation Category],
    ce.[Timestamp] AS interaction_timestamp,
    ce.[Booking Type],
    ce.[Evaluation Type],
    ce.[Transaction Type],
    ce.[Evaluator Full Name] AS auditor_name,
    ce.[Travel Counselor] AS agent_name,
    ce.[Date of the Interaction],
    
    -- ID Normalization (Ensuring string consistency for joins)
    TOSTRING(TOINT(ce.[workday_id])) AS workday_id,
    TOSTRING(TOINT(ce.[workday_id_key])) AS workday_id_key,

    /* * SECTION: Members First (M1) - Soft Skills 
     * Focus: Customer Connection and STEER Methodology
     */
    ce.[Greeted CM with an upbeat and welcoming tone],
    ce.[Recognized CM tone and pace and responded appropriately],
    ce.[Used tools to uncover information such as intent and preferences],
    ce.[Did not speak over CM or interrupt; allowed CM to complete sentences],
    ce.[Captured details of conversation and CM did not need to repeat themselves],
    ce.[Paraphrased to gain a clear understanding of CMs needs],
    ce.[Asked door opening questions followed by validating questions to fully understand CM needs],
    ce.[Used STEER to uncover and anticipate relevant CM needs, when applicable],
    ce.[Provided accurate and relevant recommendations],
    ce.[Provided relevant benefits],
    ce.[Used confident, excited, and/or empathetic tone while providing recommendations],
    ce.[Offered assistance early and appropriately resolved all discovered needs],
    ce.[When hold is necessary, used proper hold courtesies],
    ce.[Kept conversation flowing with minimal dead air and hold time],
    ce.[Correctly executed all steps to deliver on all the Card Members requests],
    ce.[Resolved issue (achieved FCR) during the interaction or set plan to follow up],
    ce.[Used positive language and tone when speaking about Amex/Partners],
    ce.[Recapped and clearly defined next steps with specific timelines],
    ce.[Ended interaction with personalization],
    ce.[M1 SCORE],

    /* * SECTION: Internal Compliance & Legal Audits
     * Focus: Regulatory requirements, PII protection, and Fare Disclosures.
     * WARNING: These fields depend on Google Form header consistency.
     */
    ce.[Did the TC correctly establish who is on the call via the approved greeting?],
    ce.[Did the TC correctly verify the account?],
    ce.[Did the TC refrain from releasing privileged information before ID?],
    ce.[Did the TC refrain from releasing any Personally Identifiable Information (PII)?],
    ce.[Did the TC provide the call recording notification at the start of the call?],
    ce.[Did the TC provide the call recording notification when 3rd party joins call],
    ce.[Did the TC provide the call recording notification when call is passed to a 3rd party?],
    ce.[Column 35] AS generic_compliance_placeholder, 
    ce.[Did the TC provide the total amount to be paid for all tickets],
    ce.[Did the TC disclose correct fare rules for ticket(s)],
    ce.[IF CODE SHARE: Did the TC provide correct airline name & flight number],
    ce.[IF DOMESTIC - Did the TC verify the correct name on government ID],
    ce.[IF DOMESTIC - Did the TC verify the correct date of birth (DOB) / gender],
    ce.[IF INTERNATIONAL - Did the TC verify correct name on passport],
    ce.[IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?],
    ce.[Additional Elements Part 1],
    ce.[Did the TC advise "optional fees may apply?" (verbatim)],
    ce.[Did the TC advise special requests are based on availability?],
    ce.[If TC provides the Average Nightly Rate, did the TC state -average nightly rate-],
    ce.[Did the TC provide the total amount for the reservation ($X)?],
    ce.[If the Lodging and/or Billing Address is in California...],
    ce.[Did the TC provide the correct cancellation policy, including penalty?],
    ce.[CALIFORNIA 24HR CANCEL DISCLOSURE],
    ce.[IF DEPOSIT / PREPAYMENT REQUIRED: Did the TC provide the correct amount being billed?],
    ce.[IF DEPOSIT / PREPAYMENT REQUIRED: Amount refundable or non-refundable?],
    ce.[Additional Elements Part 2],
    ce.[Did the TC provide the correct amount for reservation including base rate],
    ce.[IF PREPAID - Did the TC correctly advise refundable / non refundable?],
    ce.[IF PREPAID - Did the TC correctly advise fee for changes / cancellations?],
    ce.[Additional Elements Part 3],
    ce.[Did the TC update OPUS accurately?],
    ce.[COMPLAINT: Response to caller complaint],
    ce.[COMPLAINT: Resolution of complaint],
    ce.[What Vibes score would you give this call],
    ce.[CALIFORNIA RESTITUTION FUND DISCLOSURE],
    
    -- Audit Scoring Totals
    TOINT(ce.[Column 74]) AS hoc_total_met,
    TOINT(ce.[Column 5]) AS hoc_total_opportunities,
    ce.[Internal P&P]

FROM internal_audits_compiled AS ce
    -- Join to Operations Master Roster for ID mapping
    LEFT JOIN operations_master_roster AS roster
        ON TOSTRING(TOINT(roster.[workday_id])) = TOSTRING(TOINT(ce.[workday_id]))
    
    -- Join to Historical Roster to ensure Date-Effective alignment
    LEFT JOIN ods_daterange_roster AS ros
        ON TOSTRING(TOINT(roster.[workday_id])) = ros.[employee_id]
        AND CREATEDATE(GETYEAR(ce.[Timestamp]), GETMONTH(ce.[Timestamp]), GETDAY(ce.[Timestamp]))
        BETWEEN ros.[effective_from] AND CASE WHEN ros.[effective_to] IS NULL THEN CREATEDATE(2099,01,01) ELSE ros.[effective_to] END

/* WHERE ce.[Evaluation Category] IN ('Training Audit', 'Regular Evaluation') */
