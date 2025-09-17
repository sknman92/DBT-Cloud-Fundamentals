{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema=target.schema %}
    {%- set env = env_var('DBT_ENV_NAME') -%}
    {% if custom_schema_name is none or env == 'dev' %}

        {{default_schema}}

    {% elif target.name in ['prod']%}

        {{default_schema | trim}}

    {% else %}

        {{custom_schema_name | trim}}
        
    {% endif %}
    
{% endmacro %}