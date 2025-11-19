{% macro remove_null_cols(cols) %}
    
    where

    {% for col in cols %}
        
        "{{ col }}" is not null 
        
        {%- if not loop.last %} 
        AND
        {% endif %}

    {% endfor %}

{% endmacro %}