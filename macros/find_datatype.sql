{% macro find_datatypes(models) %}
    {% set cols=adapter.get_columns_in_relation(models) %}
    {%- for col in cols %}
      - name: {{ col.name | lower }}
        data_type: {{ col.dtype | lower }}
    {%- endfor %}
{% endmacro %}
