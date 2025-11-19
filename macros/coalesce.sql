{% macro coalesce(cols) %}

    coalesce({{ cols | join(', ')}}, 'Unknown') as coalesced_column
    
{% endmacro %}