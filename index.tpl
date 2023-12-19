{% for title, url in snow_forecast.maps.items() %}
  {{ title }}
  <a target="_blank" href="{{ snow_forecast.link }}"><img src="{{ url }}" /></a>
{% endfor %}
{% for resort in resorts %}
  <h2>
    {{ resort.name }}
    <a href="https://www.windy.com/{{ resort.lat }}/{{ resort.lng }}/windy">meteogram</a>
    {% if resort.snow_forecast %}
      <a href="https://www.snow-forecast.com/resorts/{{ resort.snow_forecast }}/6day/top">snow-forecast</a>
    {% endif %}
  </h2>
    <iframe src="https://www.meteoblue.com/en/weather/widget/daily/{{ resort.lat }}N{{ resort.lng }}E?geoloc=fixed&days=7&tempunit=CELSIUS&windunit=KILOMETER_PER_HOUR&precipunit=MILLIMETER&coloured=coloured&pictoicon=0&pictoicon=1&maxtemperature=0&maxtemperature=1&mintemperature=0&mintemperature=1&windspeed=0&windspeed=1&windgust=0&windgust=1&winddirection=0&winddirection=1&uv=0&humidity=0&precipitation=0&precipitation=1&precipitationprobability=0&precipitationprobability=1&spot=0&spot=1&pressure=0&layout=light"  frameborder="0" scrolling="NO" allowtransparency="true" sandbox="allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox" style="width: 378px; height: 420px"></iframe>
  {% for webcam in resort.webcams %}
    {{ webcam.src }}
  {% endfor %}
{% endfor %}

<h3>Contributing</h3>
<a href="https://github.com/sttwister/snow">https://github.com/sttwister/snow</a>
