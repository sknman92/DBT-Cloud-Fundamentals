with source as (
    select *
    from {{ source('ax_source', 'AX_487a') }})

select *
     ,"Group Leaders" + "Members" as total_members
from source