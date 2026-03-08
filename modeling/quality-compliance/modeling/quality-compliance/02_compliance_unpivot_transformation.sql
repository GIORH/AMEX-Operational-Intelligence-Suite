/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Transformation / Modeling
 * PURPOSE: 
 * Manually unpivoting Soft Skills (Member First - M1) questions.
 * This transformation converts wide-row survey data into a normalized 
 * long-format table to enable granular question-level KPI analysis.
 * * STRATEGY: Manual Unpivot via UNION ALL (Optimized for Sisense SQL Engine).
 ********************************************************************************/

SELECT 
    [m1_questions_key],
    Question, 
    Response,
    Yes_Response,
    No_Response
FROM (
    SELECT 
        [m1_questions_key],
        Question, 
        Response,
        Yes_Response,
        No_Response
    FROM (
        /* 1. Welcoming Tone */
        SELECT 
            [m1_questions_key],  
            'Greeted CM with an upbeat and welcoming tone' AS Question,  
            [Greeted CM with an upbeat and welcoming tone] AS Response,
            CASE WHEN [Greeted CM with an upbeat and welcoming tone] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Greeted CM with an upbeat and welcoming tone] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 
        
        /* 2. Tone & Pace Recognition */
        SELECT 
            [m1_questions_key],  
            'Recognized CM tone and pace and responded appropriately' AS Question,  
            [Recognized CM tone and pace and responded appropriately] AS Response,
            CASE WHEN [Recognized CM tone and pace and responded appropriately] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Recognized CM tone and pace and responded appropriately] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL
        
        /* 3. Intent Discovery Tools */
        SELECT 
            [m1_questions_key],  
            'Used tools to uncover information such as intent and preferences' AS Question,  
            [Used tools to uncover information such as intent and preferences] AS Response,
            CASE WHEN [Used tools to uncover information such as intent and preferences] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used tools to uncover information such as intent and preferences] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL
        
        /* 4. Active Listening (Non-Interrupt) */
        SELECT 
            [m1_questions_key],  
            'Did not speak over CM or interrupt; allowed CM to complete sentences' AS Question,  
            [Did not speak over CM or interrupt; allowed CM to complete sentences] AS Response,
            CASE WHEN [Did not speak over CM or interrupt; allowed CM to complete sentences] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did not speak over CM or interrupt; allowed CM to complete sentences] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 

        /* 5. Information Capture */
        SELECT 
            [m1_questions_key],  
            'Captured details of conversation and CM did not need to repeat themselves' AS Question,  
            [Captured details of conversation and CM did not need to repeat themselves] AS Response,
            CASE WHEN [Captured details of conversation and CM did not need to repeat themselves] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Captured details of conversation and CM did not need to repeat themselves] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 6. Paraphrasing */
        SELECT 
            [m1_questions_key],  
            'Paraphrased to gain a clear understanding of CMs needs' AS Question,  
            [Paraphrased to gain a clear understanding of CMs needs] AS Response,
            CASE WHEN [Paraphrased to gain a clear understanding of CMs needs] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Paraphrased to gain a clear understanding of CMs needs] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 

        /* 7. Validating Questions */
        SELECT 
            [m1_questions_key],  
            'Asked door opening questions followed by validating questions to fully understand CM needs' AS Question,  
            [Asked door opening questions followed by validating questions to fully understand CM needs] AS Response,
            CASE WHEN [Asked door opening questions followed by validating questions to fully understand CM needs] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Asked door opening questions followed by validating questions to fully understand CM needs] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 
        
        /* 8. STEER Methodology */
        SELECT 
            [m1_questions_key],  
            'Used STEER to uncover and anticipate relevant CM needs, when applicable' AS Question,  
            [Used STEER to uncover and anticipate relevant CM needs, when applicable] AS Response,
            CASE WHEN [Used STEER to uncover and anticipate relevant CM needs, when applicable] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used STEER to uncover and anticipate relevant CM needs, when applicable] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 9. Accurate Recommendations */
        SELECT 
            [m1_questions_key],  
            'Provided accurate and relevant recommendations' AS Question,  
            [Provided accurate and relevant recommendations] AS Response,
            CASE WHEN [Provided accurate and relevant recommendations] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Provided accurate and relevant recommendations] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 10. Relevant Benefits */
        SELECT 
            [m1_questions_key],  
            'Provided relevant benefits' AS Question,  
            [Provided relevant benefits] AS Response,
            CASE WHEN [Provided relevant benefits] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Provided relevant benefits] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 11. Tone & Empathy */
        SELECT 
            [m1_questions_key],  
            'Used confident, excited, and/or empathetic tone while providing recommendations' AS Question,  
            [Used confident, excited, and/or empathetic tone while providing recommendations] AS Response,
            CASE WHEN [Used confident, excited, and/or empathetic tone while providing recommendations] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used confident, excited, and/or empathetic tone while providing recommendations] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 
        
        /* 12. Assistance Offering */
        SELECT 
            [m1_questions_key],  
            'Offered assistance early and appropriately resolved all discovered needs' AS Question,  
            [Offered assistance early and appropriately resolved all discovered needs] AS Response,
            CASE WHEN [Offered assistance early and appropriately resolved all discovered needs] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Offered assistance early and appropriately resolved all discovered needs] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 13. Hold Courtesies */
        SELECT 
            [m1_questions_key],  
            'When hold is necessary, used proper hold courtesies' AS Question,  
            [When hold is necessary, used proper hold courtesies] AS Response,
            CASE WHEN [When hold is necessary, used proper hold courtesies] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [When hold is necessary, used proper hold courtesies] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 

        /* 14. Conversation Flow */
        SELECT 
            [m1_questions_key],  
            'Kept conversation flowing with minimal dead air and hold time' AS Question,  
            [Kept conversation flowing with minimal dead air and hold time] AS Response,
            CASE WHEN [Kept conversation flowing with minimal dead air and hold time] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Kept conversation flowing with minimal dead air and hold time] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 15. Execution & Promises */
        SELECT 
            [m1_questions_key],  
            'Correctly executed all steps to deliver on all the Card Members requests' AS Question,  
            [Correctly executed all steps to deliver on all the Card Members requests] AS Response,
            CASE WHEN [Correctly executed all steps to deliver on all the Card Members requests] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Correctly executed all steps to deliver on all the Card Members requests] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 16. First Call Resolution (FCR) */
        SELECT 
            [m1_questions_key],  
            'Resolved issue (achieved FCR) during the interaction or set plan to follow up' AS Question,  
            [Resolved issue (achieved FCR) during the interaction or set plan to follow up] AS Response,
            CASE WHEN [Resolved issue (achieved FCR) during the interaction or set plan to follow up] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Resolved issue (achieved FCR) during the interaction or set plan to follow up] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 17. Positive Language */
        SELECT 
            [m1_questions_key],  
            'Used positive language and tone when speaking about Amex and partners' AS Question,  
            [Used positive language and tone when speaking about Amex and partners] AS Response,
            CASE WHEN [Used positive language and tone when speaking about Amex and partners] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used positive language and tone when speaking about Amex and partners] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 18. Recap & Next Steps */
        SELECT 
            [m1_questions_key],  
            'Recapped and clearly defined next steps with specific timelines' AS Question,  
            [Recapped and clearly defined next steps with specific timelines] AS Response,
            CASE WHEN [Recapped and clearly defined next steps with specific timelines] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Recapped and clearly defined next steps with specific timelines] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL

        /* 19. Personalization */
        SELECT 
            [m1_questions_key],  
            'Ended interaction with personalization' AS Question,  
            [Ended interaction with personalization] AS Response,
            CASE WHEN [Ended interaction with personalization] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Ended interaction with personalization] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

    ) AS combineddata_m1
) AS filterdata_m1
WHERE Response IN ('Yes', 'No')
