with 

source as (

    select * from {{ source('B2S_JAFFLE_SHOP', 'CUSTOMERS') }}

),

renamed as (

    select
        id,
        first_name,
        last_name

    from source

)

select * from renamed
