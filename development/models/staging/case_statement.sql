{{ config(
    materialized='incremental',
    on_schema_change='sync_all_columns',
    unique_key='Id',
    tags=['development', 'staging'],
    partition_by={'field': 'Birth year', 'data_type': 'integer'}
    ) 
}}

with example_data as (

    select
        distinct
          "Id"           as id
        , "Name"         as name
        , "Gender"       as gender
        , "Age of death" as age_of_death
    
    from {{ source('development', 'people_dataset') }}
    limit 100
)

select
      id
    , name
    , case 
        when gender = 'Male' then 'M' else 'F'
      end as gender
    , age_of_death
    , case
        when age_of_death between 0 and 45 then '< 45 year old'
        when age_of_death between 46 and 60 then '> 45 and <= 60 years old'
        when age_of_death between 61 and 89 then '> 61 and <= 89 years old'
        else '> 90 year old'
      end as age_range_of_death 
from example_data 