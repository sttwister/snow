{% for resort in resorts %}
  <h2>{{ resort.name }}</h2>
  {% for webcam in resort.webcams %}
    {{ webcam.src }}
  {% endfor %}
{% endfor %}

<h3>Contributing</h3>
<a href="https://github.com/sttwister/snow">https://github.com/sttwister/snow</a>
