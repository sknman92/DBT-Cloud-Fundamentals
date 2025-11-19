with usergrouphistory as (
    select *
    from stg_ax__487a
),

change_history as (
    select *
    from {{ source('ax_source', 'AX_487b') }}
),

joined as (
    select u.*
        , c."New"
    from usergrouphistory as u
    left join change_history as c
    on u."URL_detail" = c."Old"
)

select *
    , {{coalesce(cols = ['"URL_detail"', '"New"' ])}}
from joined




