{%- set companies = ['Microsoft', 'Apple', 'Nokia'] -%}

{% for company in companies %}
    {% if company != 'Nokia' %}
    
        {{ company }}

    {% else %}
        {{ company }} is not a good company

    {% endif %}
{% endfor %}