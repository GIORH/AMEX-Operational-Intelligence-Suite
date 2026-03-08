/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Transformation / Modeling
 * PURPOSE: 
 * Manually unpivoting Regulatory & Compliance (Comp) questions.
 * This script normalizes legal requirements, PII handling, and mandatory 
 * disclosures into a long-format table for risk assessment reporting.
 * * STRATEGY: Manual Unpivot via UNION ALL.
 ********************************************************************************/

SELECT 
    [comp_questions_key],
    Question, 
    Response,
    Yes_Response,
    No_Response
FROM (
    SELECT 
        [comp_questions_key],
        Question, 
        Response,
        Yes_Response,
        No_Response
    FROM (
        
        /* CATEGORY: Identification & Verification (ID&V) */
        
        SELECT [comp_questions_key], 'Approved Greeting & TC Identification' AS Question, [Did the TC correctly establish who is on the call via the approved greeting?] AS Response,
            CASE WHEN [Did the TC correctly establish who is on the call via the approved greeting?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC correctly establish who is on the call via the approved greeting?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Account Verification Compliance' AS Question, [Did the TC correctly verify the account?] AS Response,
            CASE WHEN [Did the TC correctly verify the account?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC correctly verify the account?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'PII Protection - Pre-ID Disclosure' AS Question, [Did the TC refrain from releasing privileged information before ID?] AS Response,
            CASE WHEN [Did the TC refrain from releasing privileged information before ID?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC refrain from releasing privileged information before ID?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'PII Protection - General' AS Question, [Did the TC refrain from releasing any Personally Identifiable Information (PII)?] AS Response,
            CASE WHEN [Did the TC refrain from releasing any Personally Identifiable Information (PII)?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC refrain from releasing any Personally Identifiable Information (PII)?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        /* CATEGORY: Mandatory Legal Notifications (Call Recording) */

        SELECT [comp_questions_key], 'Recording Notification - Start of Call' AS Question, [Did the TC provide the call recording notification at the start of the call?] AS Response,
            CASE WHEN [Did the TC provide the call recording notification at the start of the call?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC provide the call recording notification at the start of the call?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Recording Notification - 3rd Party/Speakerphone' AS Question, [Did the TC provide the call recording notification when 3rd party joins call & when call transferred to speakerphone (whether or not there is a 3rd party)?] AS Response,
            CASE WHEN [Did the TC provide the call recording notification when 3rd party joins call & when call transferred to speakerphone (whether or not there is a 3rd party)?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC provide the call recording notification when 3rd party joins call & when call transferred to speakerphone (whether or not there is a 3rd party)?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Recording Notification - Transfer to 3rd Party' AS Question, [Did the TC provide the call recording notification when call is passed to a 3rd party?] AS Response,
            CASE WHEN [Did the TC provide the call recording notification when call is passed to a 3rd party?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC provide the call recording notification when call is passed to a 3rd party?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        /* CATEGORY: Financial Disclosures & Fare Rules */

        SELECT [comp_questions_key], 'Total Fare Disclosure (Taxes & Fees included)' AS Question, [Did the TC provide the total amount to be paid for all tickets which encompass complete taxes and fees?] AS Response,
            CASE WHEN [Did the TC provide the total amount to be paid for all tickets which encompass complete taxes and fees?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC provide the total amount to be paid for all tickets which encompass complete taxes and fees?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Fare Rules - Refundability & Penalties' AS Question, [Did the TC disclose correct fare rules for ticket(s) - refundability & changes/cancellation policies?] AS Response,
            CASE WHEN [Did the TC disclose correct fare rules for ticket(s) - refundability & changes/cancellation policies?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC disclose correct fare rules for ticket(s) - refundability & changes/cancellation policies?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Code Share Disclosure' AS Question, [IF CODE SHARE: Did the TC provide correct airline name & flight number, operated by code-share airline name & DBA?] AS Response,
            CASE WHEN [IF CODE SHARE: Did the TC provide correct airline name & flight number, operated by code-share airline name & DBA?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [IF CODE SHARE: Did the TC provide correct airline name & flight number, operated by code-share airline name & DBA?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        /* CATEGORY: Travel Documentation (Domestic & International) */

        SELECT [comp_questions_key], 'Domestic ID - Name Spelling' AS Question, [IF DOMESTIC - Did the TC verify the correct name on government ID and confirm spelling?] AS Response,
            CASE WHEN [IF DOMESTIC - Did the TC verify the correct name on government ID and confirm spelling?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [IF DOMESTIC - Did the TC verify the correct name on government ID and confirm spelling?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Domestic ID - DOB & Gender' AS Question, [IF DOMESTIC - Did the TC verify the correct date of birth (DOB) / gender for each traveler?] AS Response,
            CASE WHEN [IF DOMESTIC - Did the TC verify the correct date of birth (DOB) / gender for each traveler?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [IF DOMESTIC - Did the TC verify the correct date of birth (DOB) / gender for each traveler?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'International ID - Passport & Spelling' AS Question, [IF INTERNATIONAL - Did the TC verify correct name on passport and confirm spelling?] AS Response,
            CASE WHEN [IF INTERNATIONAL - Did the TC verify correct name on passport and confirm spelling?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [IF INTERNATIONAL - Did the TC verify correct name on passport and confirm spelling?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'International ID - Citizenship' AS Question, [IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?] AS Response,
            CASE WHEN [IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [IF INTERNATIONAL - Did the TC verify correct citizenship for all passengers?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        /* CATEGORY: Hotel & Lodging Specifics */

        SELECT [comp_questions_key], 'Optional Fees Verbatim' AS Question, [Did the TC advise "optional fees may apply?" (verbatim)] AS Response,
            CASE WHEN [Did the TC advise "optional fees may apply?" (verbatim)] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC advise "optional fees may apply?" (verbatim)] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Hotel - Average Nightly Rate Disclosure' AS Question, [If TC provides the Average Nightly Rate, from the Property / Hotel Search Page, did the TC state -average nightly rate- and -start at- before providing cost? -must say it for all quotes-.] AS Response,
            CASE WHEN [If TC provides the Average Nightly Rate, from the Property / Hotel Search Page, did the TC state -average nightly rate- and -start at- before providing cost? -must say it for all quotes-.] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [If TC provides the Average Nightly Rate, from the Property / Hotel Search Page, did the TC state -average nightly rate- and -start at- before providing cost? -must say it for all quotes-.] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'California Mandatory Disclosures' AS Question, [If the Lodging and/or Billing Address is in California, did the TC provide the total amount for the reservation which includes all taxes and mandatory fees?] AS Response,
            CASE WHEN [If the Lodging and/or Billing Address is in California, did the TC provide the total amount for the reservation which includes all taxes and mandatory fees?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [If the Lodging and/or Billing Address is in California, did the TC provide the total amount for the reservation which includes all taxes and mandatory fees?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        /* CATEGORY: Systems & Complaints */

        SELECT [comp_questions_key], 'OPUS System Accuracy' AS Question, [Did the TC update OPUS accurately?] AS Response,
            CASE WHEN [Did the TC update OPUS accurately?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did the TC update OPUS accurately?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Complaint Recognition' AS Question, [COMPLAINT: If the caller expressed a complaint, did the TC recognize and respond to the callers complaint?] AS Response,
            CASE WHEN [COMPLAINT: If the caller expressed a complaint, did the TC recognize and respond to the callers complaint?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [COMPLAINT: If the caller expressed a complaint, did the TC recognize and respond to the callers complaint?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        UNION ALL
        SELECT [comp_questions_key], 'Complaint Resolution/Next Steps' AS Question, [COMPLAINT: If the caller expressed a complaint; did the TC resolve the complaint or convey next steps to the caller?] AS Response,
            CASE WHEN [COMPLAINT: If the caller expressed a complaint; did the TC resolve the complaint or convey next steps to the caller?] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [COMPLAINT: If the caller expressed a complaint; did the TC resolve the complaint or convey next steps to the caller?] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

    ) AS combineddata_comp
) AS filterdata_comp
WHERE Response IN ('Yes', 'No')
