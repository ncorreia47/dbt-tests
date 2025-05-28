SELECT 
    gender,
    AVG(age_of_death) AS mean_age_of_death
FROM {{ ref('case_statement') }}
GROUP BY gender