/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Modeling / Integration
 * PURPOSE: 
 * Integration of Internal Audits with Master Roster.
 * This script joins raw survey data with employee metadata (Workday ID) 
 * and handles effective date ranges for historical reporting.
 ********************************************************************************/

SELECT DISTINCT
    -- Primary Keys & Roster Linkage
    CASE 
        WHEN ros.[roster_empdaterange_key] IS NULL THEN '-1' 
        ELSE ros.[roster_empdaterange_key]
    END AS roster_key,
    
    CREATEDATE(GETYEAR(ce.[Timestamp]), GETMONTH(ce.[Timestamp]), GETDAY(ce.[Timestamp])) AS date_key,

    -- Audit Metrics
    CASE 
        WHEN ce.[workday_id] IS NOT NULL THEN 1
        ELSE 0
    END AS audit_counter,

    -- Technical Identifiers
    ce.[Row Number M1] AS m1_questions_key,
    ce.[Row Number Comp] AS comp_questions_key,
    TOSTRING(TOINT(ce.[workday_id])) AS workday_id,
    TOSTRING(TOINT(ce.[workday_id_key])) AS workday_id_key,

    -- Metadata & Dimensions
    ce.[Evaluation Category],
    ce.[Timestamp],
    ce.[Booking Type],
    ce.[Evaluation Type],
    ce.[Transaction Type],
    ce.[Evaluator Full Name],
    ce.[Travel Counselor],
    ce.[Date of the Interaction],

    -- M1 PERFORMANCE QUESTIONS (Soft Skills)
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
    ce.[Correctly executed all steps to deliver on all the Card Members requests & followed up the way promised],
    ce.[Resolved issue (achieved FCR) during the interaction or set plan to follow up],
    ce.[Used positive language and tone when speaking about American Express],
    ce.[Recapped and clearly defined next steps with specific timelines],
    ce.[Ended interaction with personalization],
    ce.[M1 SCORE],

    -- COMPLIANCE & REGULATORY QUESTIONS
    ce.[Did the TC correctly establish who is on the call via the approved greeting?],
    ce.[Did the TC correctly verify the account?],
    ce.[Did the TC refrain from releasing privileged information before ID?],
    ce.[Did the TC refrain from releasing any Personally Identifiable Information (PII)?],
    ce.[Did the TC provide the call recording notification at the start of the call?],
    ce.[Did the TC provide the call recording notification when 3rd party joins call],
    ce.[Did the TC provide the call recording notification when call is passed to a 3rd party?],
    ce.[Did the TC provide the total amount to be paid for all tickets which encompass complete taxes and fees?],
    ce.[Did the TC disclose correct fare rules for ticket(s) - refundability & changes/cancellation policies?],
    ce.[IF CODE SHARE: Did the TC provide correct airline name & flight number],
    ce.[IF DOMESTIC - Did the TC verify the correct name on government ID and confirm spelling?],
    ce.[IF DOMESTIC - Did the TC verify the correct date of birth (DOB) / gender for each traveler?],
    ce.[IF INTERNATIONAL - Did the TC verify correct name on passport and confirm spelling?],
    ce.[IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?],
    ce.[Did the TC advise "optional fees may apply?" (verbatim)],
    ce.[Did the TC advise special requests are based on availability?],
    ce.[Did the TC provide the total amount for the reservation ($X)?],
    ce.[If the Lodging and/or Billing Address is in California...],
    ce.[Did the TC update OPUS accurately?],
    ce.[COMPLAINT: If the caller expressed a complaint, did the TC recognize and respond?],
    ce.[COMPLAINT: If the caller expressed a complaint; did the TC resolve or convey next steps?],
    
    -- High Order Concern (HOC) Metrics
    TOINT(ce.[Column 74]) AS hoc_total_met,
    TOINT(ce.[Column 5]) AS hoc_total_opportunities,
    ce.[Internal P&P]

FROM internal_audits_compiled AS ce
    -- Logic to link with Master Roster based on Workday ID
    LEFT JOIN operations_master_roster AS roster
        ON TOSTRING(TOINT(roster.[workday_id])) = TOSTRING(TOINT(ce.[workday_id]))
   
    -- SCD Type 2 logic for employee data at the time of the audit
    LEFT JOIN ods_daterange_roster AS ros
        ON TOSTRING(TOINT(roster.[workday_id])) = ros.[employee_id]
        AND CREATEDATE(GETYEAR(ce.[Timestamp]), GETMONTH(ce.[Timestamp]), GETDAY(ce.[Timestamp]))
        BETWEEN ros.[effective_from] AND CASE WHEN ros.[effective_to] IS NULL THEN CREATEDATE(2099,01,01) ELSE ros.[effective_to] END
