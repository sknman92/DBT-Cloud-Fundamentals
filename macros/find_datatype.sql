<<<<<<< HEAD
{% macro find_datatypes(model) %}
    {% set cols=adapter.get_columns_in_relation(model) %}
=======
{% macro find_datatypes(models) %}
    {% set cols=adapter.get_columns_in_relation(models) %}
>>>>>>> cbf720430c638c45b6b21ee09199d188ccca50e8
    {%- for col in cols %}
      - name: {{ col.name | lower }}
        data_type: {{ col.dtype | lower }}
    {%- endfor %}
<<<<<<< HEAD
{% endmacro %}
=======
{% endmacro %}
>>>>>>> cbf720430c638c45b6b21ee09199d188ccca50e8
