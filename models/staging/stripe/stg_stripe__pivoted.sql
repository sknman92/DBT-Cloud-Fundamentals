with payments as 
(
    select * from {{ ref('stg_stripe__payments') }}
)

, pivoted as 
(
    select order_id,
    {%- set payment_methods=['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

    {%- for p in payment_methods -%}

        {%- if not loop.last -%}
            sum(case when payment_method = '{{p}}' then amount else 0 end) as {{p}}_amount,

        {%- else -%}
            sum(case when payment_method = '{{p}}' then amount else 0 end) as {{p}}_amount
            
        {% endif %}

    {% endfor %}

    from payments