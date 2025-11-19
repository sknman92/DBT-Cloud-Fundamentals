with source as (
    select *
    from {{ source('ax_source', 'AX_490') }}
)

select  "Sender_Account_ID" as origin
    , "Sender_Account_ID" as current_
    , "Receiver_Account_ID" as next
    , "Amount_of_Transaction" as amount
    , "Transaction_Date" as date
    , "Transaction_ID" as id_path
from source