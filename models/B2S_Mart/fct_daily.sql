with source_cte as 
(select *
from {{ ref('successful_payments') }}), 

agg_cte as (
    select payment_created_at
    , sum(payment_amount) as daily_payment
    from source_cte
    group by 1
    order by 1
)

select *
from agg_cte