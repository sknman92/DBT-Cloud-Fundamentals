{% macro limit_data_in_dev(column_name, days_to_limit = 3) %}
{% if target.name == 'Dev' %}
where {{ column_name }} >= dateadd('day', -{{ days_to_limit }}, current_timestamp)
{% endif %}
{% endmacro %}