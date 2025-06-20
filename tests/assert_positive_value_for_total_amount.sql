-- total amount should always be >= 0

WITH sum_amount as (SELECT order_id
    , SUM(payment_amount) AS sum_amount
FROM {{ ref('stg_stripe__payments') }}
GROUP BY order_id)

SELECT order_id
FROM sum_amount
WHERE sum_amount < 0