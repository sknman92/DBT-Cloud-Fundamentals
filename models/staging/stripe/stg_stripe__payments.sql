with 

source as (

    select * from {{ source('STRIPE', 'PAYMENT') }}

),

transformed as (

  select

    id as payment_id,
    orderid as order_id,
    created as payment_created_at,
    paymentmethod as payment_method,
    status as payment_status,
    -- amount is stored in cents, convert to dollars
    {{ cents_to_dollars('amount', 2) }} as payment_amount

  from source

)

select * from transformed