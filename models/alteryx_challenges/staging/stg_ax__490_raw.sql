select *
from {{ source('ax_source', 'AX_490') }}