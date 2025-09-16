{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema=target.schema %}
    {%- set env = env_var('DBT_ENV_NAME') -%}
    {% if custom_schema_name is none or env == 'prod' %}

        {{default_schema}}

    {% elif target.name in ['prod']%}

        {{custom_schema_name | trim}}

    {% else %}

        {{default_schema}}_{{custom_schema_name | trim}}
        
    {% endif %}
    
{% endmacro %}