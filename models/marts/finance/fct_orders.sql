{{
    config(
        materialized='incremental',
        unique_key = 'order_id',
        incremental_strategy = 'merge',
        on_schema_change = 'fail'
        
    )
}}


WITH payments as (SELECT order_id, payment_amount
                  FROM {{ ref('stg_stripe__payments') }} ),

orders as (SELECT order_id, customer_id, order_placed_at
           FROM {{ ref('stg_jaffle_shop__orders') }} )

SELECT o.order_id, o.order_placed_at, customer_id, payment_amount
FROM orders as o
JOIN payments as p
ON o.order_id = p.order_id


{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where  order_placed_at >= (select max(order_placed_at) from {{ this }}) 
{% endif %}






