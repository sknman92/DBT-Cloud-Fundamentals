with 

customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

order_payments as (

    select 
        order_id
        , sum(case when payment_status = 'success' then payment_amount end) as amount
    from {{ ref('stg_stripe__payments')}}
    group by order_id
),

final as (

    select
        orders.order_id
        , orders.customer_id
        , orders.order_placed_at
        , coalesce(order_payments.amount, 0) as amount

    from orders

    left join order_payments on orders.order_id = order_payments.order_id
    
)

select * from final