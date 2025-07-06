{{
    config(
        materialized='ephemeral'
    )
}}

with source_cte as(select *
from {{ ref('stg_stripe__payments') }}),


transformed_cte as (select *
from source_cte
where payment_status = 'success')

select *
from transformed_cte
