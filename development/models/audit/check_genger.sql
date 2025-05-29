{{ config(
    materialized='incremental',
    on_schema_change='sync_all_columns',
    tags=['development', 'audit'],
    partition_by={'field': 'updated_at', 'data_type': 'string'}

    ) 
}}

select 
      a.*
    , to_char(current_timestamp at time zone 'America/Sao_Paulo', 'YYYYMMDDHH24MISS') as updated_at
from {{ source('development', 'case_statement') }} a
where 1=1
and a.gender not in ('M', 'F')