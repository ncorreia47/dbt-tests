{% test is_a_valid_gender(model, column_name) %}

    select *
    from {{ model }}
    where 1=1
    and {{ column_name }} not in ('M', 'F') 

{% endtest %}