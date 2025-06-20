with source_cte as (
    select *
    from {{ source('B2S_JAFFLE_SHOP', 'ORDERS') }}
),

final_cte as (select id as order_id
    , user_id
    , order_date
    , status
    , _etl_loaded_at as etl_loaded_at
from source_cte)

select *
from final_cte