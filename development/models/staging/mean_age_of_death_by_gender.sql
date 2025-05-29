{{ config(
    materialized='incremental',
    on_schema_change='sync_all_columns',
    tags=['development', 'staging']
    ) 
}}

SELECT 
      gender
    , AVG(age_of_death) AS mean_age_of_death
FROM {{ source('development', 'case_statement') }}
GROUP BY gender