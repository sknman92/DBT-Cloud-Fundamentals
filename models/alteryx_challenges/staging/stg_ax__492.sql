-- setting variables
{% set relation =  source('ax_source', 'AX_492') %}
--{% set columns = dbt_utils.get_filtered_columns_in_relation(from=relation)%}
{% set columns=["Diagnosis Category"] %}

with source as (
    select *
    from {{ relation }}
),

-- removing nulls
wrangled as (
    select *
    from source
    {{ remove_null_cols(columns) }}
)

-- final cte
select *
from wrangled