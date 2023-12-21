<html>
  <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  </head>
  <body>
    <!-- Resorts -->
    <div class="row">
      {% for resort in resorts %}
        <div class="col-12 col-lg-6 border">
          <div class="d-flex">
            <div class="flex-fill pt-3" style="width: 325px;">
              <!-- Resort - Header -->
              <h2>{{ resort.name }}</h2>
              <a target="_blank" href="https://www.windy.com/{{ resort.lat }}/{{ resort.lng }}/meteogram">meteogram</a>
              {% if resort.snow_forecast %}
                <a target="_blank" href="https://www.snow-forecast.com/resorts/{{ resort.snow_forecast }}/6day/top">snow-forecast</a>
              {% endif %}
              <br><br>
              <!-- Resort - Weather -->
              <iframe src="https://www.meteoblue.com/en/weather/widget/daily/{{ resort.lat }}N{{ resort.lng }}E?geoloc=fixed&days=7&tempunit=CELSIUS&windunit=KILOMETER_PER_HOUR&precipunit=MILLIMETER&coloured=coloured&pictoicon=0&pictoicon=1&maxtemperature=0&maxtemperature=1&mintemperature=0&mintemperature=1&windspeed=0&windspeed=1&windgust=0&windgust=1&winddirection=0&winddirection=1&uv=0&humidity=0&precipitation=0&precipitation=1&precipitationprobability=0&precipitationprobability=1&spot=0&spot=1&pressure=0&layout=light"
                      sandbox="allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox" 
                      frameborder="0" scrolling="NO" allowtransparency="true" 
                      class="w-100" style="height: 420px;"></iframe>
            </div>
            <!-- Resort - Webcams -->
            <div class="flex-fill">
              {% for webcam in resort.webcams %}
                <div class="ratio ratio-16x9">
                  {{ webcam.src }}
                </div>
              {% endfor %}
            </div>
          </div>
        </div>
      {% endfor %}
    </div>

    <!-- Snow Maps -->
    <div class="d-flex flex-wrap mt-3">
      {% for map in snow_forecast.maps %}
        <div class="overflow-hidden col-6 col-lg-3">
          <p>{{ map.title }}</p>
          <a target="_blank" href="{{ snow_forecast.link }}"><img src="{{ map.url }}" /></a>
        </div>
      {% endfor %}
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col">
          <div class="alert alert-primary my-3" role="alert">
            <h3>Contributing</h3>
            <a href="https://github.com/sttwister/snow">https://github.com/sttwister/snow</a>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
