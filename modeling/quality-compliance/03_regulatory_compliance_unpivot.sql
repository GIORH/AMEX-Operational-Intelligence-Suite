/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Transformation / Risk & Compliance
 * PURPOSE: 
 * This script performs a manual unpivot of regulatory audit questions. 
 * It categorizes binary responses (Yes/No) to monitor adherence to PII, 
 * California disclosures, and identity verification protocols.
 ********************************************************************************/

SELECT 
    [comp_questions_key],
    Question, 
    Response,
    CASE WHEN Response = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
    CASE WHEN Response = 'No' THEN 1 ELSE 0 END AS No_Response
FROM (
    /* Identity & Access Management */
    SELECT [comp_questions_key], 'Greeting & Identification' AS Question, [Did the TC correctly establish who is on the call via the approved greeting?] AS Response FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'Account Verification', [Did the TC correctly verify the account?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'Privileged Info Protection', [Did the TC refrain from releasing privileged information before ID?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'PII Protection', [Did the TC refrain from releasing any Personally Identifiable Information (PII)?] FROM m1_comp_str_ce
    
    /* Disclosures & Recordings */
    UNION ALL
    SELECT [comp_questions_key], 'Call Recording (Start)', [Did the TC provide the call recording notification at the start of the call?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'Call Recording (3rd Party)', [Did the TC provide the call recording notification when 3rd party joins call & when call transferred to speakerphone (whether or not there is a 3rd party)?] FROM m1_comp_str_ce
    
    /* Regulatory Pricing & Fees */
    UNION ALL
    SELECT [comp_questions_key], 'Total Fare Disclosure', [Did the TC provide the total amount to be paid for all tickets which encompass complete taxes and fees?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'Fare Rules Disclosure', [Did the TC disclose correct fare rules for ticket(s) - refundability & changes/cancellation policies?] FROM m1_comp_str_ce
    
    /* Travel Documents Verification */
    UNION ALL
    SELECT [comp_questions_key], 'ID/Passport Verification', [IF DOMESTIC - Did the TC verify the correct name on government ID and confirm spelling?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'International Citizenship', [IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?] FROM m1_comp_str_ce
    
    /* California Specific Regulations */
    UNION ALL
    SELECT [comp_questions_key], 'CA 24hr Cancellation Disclosure', [CALIFORNIA 24HR CANCEL DISCLOSURE: If propertys address (hotel or house rental) is in California, did the TC provide the verbatim disclosure, prior to booking?] FROM m1_comp_str_ce
    
    /* Complaint Management */
    UNION ALL
    SELECT [comp_questions_key], 'Complaint Recognition', [COMPLAINT: If the caller expressed a complaint, did the TC recognize and respond to the callers complaint?] FROM m1_comp_str_ce
    UNION ALL
    SELECT [comp_questions_key], 'Complaint Resolution', [COMPLAINT: If the caller expressed a complaint; did the TC resolve the complaint or convey next steps to the caller?] FROM m1_comp_str_ce

) AS compliance_combined
WHERE Response IN ('Yes', 'No');
