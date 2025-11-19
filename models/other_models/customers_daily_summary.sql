select
    {{dbt_utils.generate_surrogate_key(['customer_id', 'order_placed_at'])}} as id
    , customer_id
    , order_placed_at
    , count(*) as count

from {{ref('stg_jaffle_shop__orders')}}
group by 1, 2, 3