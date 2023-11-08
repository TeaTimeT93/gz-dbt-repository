
{% macro margin_percent(x,y) %}
    ROUND(SAFE_DIVIDE({{ x }}, {{y}}),2)
{% endmacro %}
