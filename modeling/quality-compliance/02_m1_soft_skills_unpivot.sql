/********************************************************************************
 * PROJECT: AMEX Operational Intelligence Suite
 * LAYER: Transformation / Refinement
 * PURPOSE: 
 * Normalizing M1 Soft Skills audit attributes. This transformation unpivots 
 * survey responses into a long-format fact table to enable granular 
 * performance analytics and coaching trend identification.
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
        /* M1 Attributes Normalization */
        
        SELECT 
            [m1_questions_key],  
            'Greeting & Tone' AS Question, 
            [Greeted CM with an upbeat and welcoming tone] AS Response,
            CASE WHEN [Greeted CM with an upbeat and welcoming tone] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Greeted CM with an upbeat and welcoming tone] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce
        
        UNION ALL 
        
        SELECT 
            [m1_questions_key],  
            'Tone & Pace Recognition' AS Question, 
            [Recognized CM tone and pace and responded appropriately] AS Response,
            CASE WHEN [Recognized CM tone and pace and responded appropriately] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Recognized CM tone and pace and responded appropriately] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Tool Usage for Discovery' AS Question, 
            [Used tools to uncover information such as intent and preferences] AS Response,
            CASE WHEN [Used tools to uncover information such as intent and preferences] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used tools to uncover information such as intent and preferences] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Active Listening (Non-Interruption)' AS Question, 
            [Did not speak over CM or interrupt; allowed CM to complete sentences] AS Response,
            CASE WHEN [Did not speak over CM or interrupt; allowed CM to complete sentences] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Did not speak over CM or interrupt; allowed CM to complete sentences] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Data Capture Accuracy' AS Question, 
            [Captured details of conversation and CM did not need to repeat themselves] AS Response,
            CASE WHEN [Captured details of conversation and CM did not need to repeat themselves] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Captured details of conversation and CM did not need to repeat themselves] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL

        SELECT 
            [m1_questions_key],  
            'Needs Identification (Door Opening Questions)' AS Question, 
            [Asked door opening questions followed by validating questions to fully understand CM needs] AS Response,
            CASE WHEN [Asked door opening questions followed by validating questions to fully understand CM needs] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Asked door opening questions followed by validating questions to fully understand CM needs] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'STEER Methodology Application' AS Question, 
            [Used STEER to uncover and anticipate relevant CM needs, when applicable] AS Response,
            CASE WHEN [Used STEER to uncover and anticipate relevant CM needs, when applicable] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used STEER to uncover and anticipate relevant CM needs, when applicable] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Accurate Recommendations' AS Question, 
            [Provided accurate and relevant recommendations] AS Response,
            CASE WHEN [Provided accurate and relevant recommendations] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Provided accurate and relevant recommendations] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Hold Courtesies & Expectations' AS Question, 
            [When hold is necessary, used proper hold courtesies; asked permission prior, set appropriate expectations, checked back frequently, and thanked the customer for holding] AS Response,
            CASE WHEN [When hold is necessary, used proper hold courtesies; asked permission prior, set appropriate expectations, checked back frequently, and thanked the customer for holding] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [When hold is necessary, used proper hold courtesies; asked permission prior, set appropriate expectations, checked back frequently, and thanked the customer for holding] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'FCR (First Contact Resolution)' AS Question, 
            [Resolved issue (achieved FCR) during the interaction or set plan to follow up] AS Response,
            CASE WHEN [Resolved issue (achieved FCR) during the interaction or set plan to follow up] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Resolved issue (achieved FCR) during the interaction or set plan to follow up] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Brand Language & Positive Tone' AS Question, 
            [Used positive language and tone when speaking about American Express, our partners, our suppliers, and our systems/tools; avoided negative word choices] AS Response,
            CASE WHEN [Used positive language and tone when speaking about American Express, our partners, our suppliers, and our systems/tools; avoided negative word choices] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Used positive language and tone when speaking about American Express, our partners, our suppliers, and our systems/tools; avoided negative word choices] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

        UNION ALL 

        SELECT 
            [m1_questions_key],  
            'Personalized Closing' AS Question, 
            [Ended interaction with personalization] AS Response,
            CASE WHEN [Ended interaction with personalization] = 'Yes' THEN 1 ELSE 0 END AS Yes_Response,
            CASE WHEN [Ended interaction with personalization] = 'No' THEN 1 ELSE 0 END AS No_Response
        FROM m1_comp_str_ce

    ) AS combineddata_m1
) AS filterdata_m1
WHERE Response IN('Yes', 'No')
