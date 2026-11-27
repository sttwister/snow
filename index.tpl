<!doctype html>
<html lang="en">
  <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      /* Image webcams (e.g. <a><img></a>) must fill the 16:9 box like iframes do */
      .ratio > a > img, .ratio > img { width: 100%; height: 100%; object-fit: cover; }
      /* Webcams off: weather takes the whole resort width */
      .cams-off .cams-col { display: none; }
      .cams-off .weather-col { flex: 0 0 100%; max-width: 100%; }
      /* Resorts with webcams hidden are just a weather widget: fit more per row (2 / 3 / 4) */
      /* ...and a resort opened individually takes two of those slots, so rows stay full */
      @media (min-width: 768px) { .resort.cams-off { width: 50%; } .resort.cams-opened { width: 100%; } }
      @media (min-width: 992px) { .resort.cams-off { width: 33.3333%; } .resort.cams-opened { width: 66.6667%; } }
      @media (min-width: 1800px) { .resort.cams-off { width: 25%; } .resort.cams-opened { width: 50%; } }
      /* "open webcams" only on resorts whose webcams are hidden, "close webcams" only on ones opened individually */
      .open-cams, .close-cams { display: none; }
      .cams-off .open-cams { display: inline; }
      .cams-opened .close-cams { display: inline-block; }
      /* Enough room below so "Jump to snow maps" can put the maps at the top of the screen */
      #snow-maps { min-height: 100vh; }
      .controls label { min-height: 32px; display: inline-flex; align-items: center; gap: 4px; }
    </style>
  </head>
  <body>
    <!-- Controls -->
    <div class="controls bg-dark text-white px-2 py-1 d-flex flex-wrap align-items-center gap-2" data-bs-theme="dark">
      <a href="#snow-maps">Jump to snow maps</a>
      <label class="ms-auto"><input type="checkbox" id="show-webcams"> Show all webcams</label>
    </div>

    <!-- Resorts -->
    <div class="row g-0">
      {% for resort in resorts %}
        <div class="col-12 col-lg-6 border resort" data-resort="{{ resort.name }}">
          <div class="row g-0">
            <div class="col-md-6 col-xl-5 col-xxl-4 p-1 weather-col">
              <!-- Resort - Header -->
              <h2>{{ resort.name }}</h2>
              <a target="_blank" href="https://www.windy.com/{{ resort.lat }}/{{ resort.lng }}/meteogram">meteogram</a>
              {% if resort.snow_forecast %}
                <a target="_blank" href="https://www.snow-forecast.com/resorts/{{ resort.snow_forecast }}/6day/top">snow-forecast</a>
              {% endif %}
              {% if resort.webcams %}
                <a href="#" class="open-cams">open webcams</a>
              {% endif %}
              <br><br>
              <!-- Resort - Weather -->
              <iframe src="https://www.meteoblue.com/en/weather/widget/daily/{{ resort.lat }}N{{ resort.lng }}E?geoloc=fixed&days=7&tempunit=CELSIUS&windunit=KILOMETER_PER_HOUR&precipunit=MILLIMETER&coloured=coloured&pictoicon=0&pictoicon=1&maxtemperature=0&maxtemperature=1&mintemperature=0&mintemperature=1&windspeed=0&windspeed=1&windgust=0&windgust=1&winddirection=0&winddirection=1&uv=0&humidity=0&precipitation=0&precipitation=1&precipitationprobability=0&precipitationprobability=1&spot=0&spot=1&pressure=0&layout=light"
                      sandbox="allow-same-origin allow-scripts allow-popups allow-popups-to-escape-sandbox" 
                      frameborder="0" scrolling="NO" allowtransparency="true" 
                      class="w-100" style="height: 400px;"></iframe>
            </div>
            <!-- Resort - Webcams -->
            <div class="col-md-6 col-xl-7 col-xxl-8 cams-col">
              <div class="row row-cols-1 row-cols-xxl-2 g-0">
                {% for webcam in resort.webcams %}
                  <div class="col">
                    <div class="ratio ratio-16x9" data-cam>
                      <template>{{ webcam.src }}</template>
                    </div>
                  </div>
                {% endfor %}
              </div>
              <a href="#" class="close-cams p-1">close webcams</a>
            </div>
          </div>
        </div>
      {% endfor %}
    </div>

    <!-- Snow Maps -->
    <div id="snow-maps">
    <div class="d-flex flex-wrap">
      {% for map in snow_forecast.maps %}
        <div class="overflow-hidden col-6 col-lg-3">
          <p class="m-0 py-1 text-center text-white bg-dark">{{ map.title }}</p>
          <a target="_blank" href="{{ snow_forecast.link }}"><img src="{{ map.url }}" class="d-block w-100 h-auto" width="601" height="776" alt="{{ map.title }}" /></a>
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
    </div>

    <script>
      // Webcam embeds live in <template>s and are only inserted when shown, so hidden ones
      // don't load at all. "Show all webcams" and individually opened resorts are remembered
      // in localStorage (if available).
      (function () {
        var box = document.getElementById('show-webcams');
        var all = true, opened = [];
        try {
          all = localStorage.getItem('snow:showWebcams') !== '0';
          opened = JSON.parse(localStorage.getItem('snow:openedWebcams')) || [];
        } catch (e) {}
        function save() {
          try {
            localStorage.setItem('snow:showWebcams', all ? '1' : '0');
            localStorage.setItem('snow:openedWebcams', JSON.stringify(opened));
          } catch (e) {}
        }

        function render() {
          box.checked = all;
          document.querySelectorAll('[data-resort]').forEach(function (resort) {
            var isOpened = !all && opened.indexOf(resort.dataset.resort) !== -1;
            var show = all || isOpened;
            resort.classList.toggle('cams-off', !show);
            resort.classList.toggle('cams-opened', isOpened);
            resort.querySelectorAll('[data-cam]').forEach(function (cam) {
              var media = cam.querySelector(':scope > :not(template)');
              if (show && !media) {
                var frag = cam.querySelector('template').content.cloneNode(true);
                frag.querySelectorAll('iframe, img').forEach(function (el) { el.setAttribute('loading', 'lazy'); });
                cam.appendChild(frag);
              } else if (!show && media) {
                media.remove();
              }
            });
          });
        }

        box.addEventListener('change', function () {
          all = box.checked;
          opened = [];
          save(); render();
        });
        document.addEventListener('click', function (e) {
          var link = e.target.closest('.open-cams, .close-cams');
          if (!link) return;
          e.preventDefault();
          var resort = link.closest('[data-resort]');
          var name = resort.dataset.resort;
          opened = opened.filter(function (n) { return n !== name; });
          if (link.classList.contains('open-cams')) opened.push(name);
          save(); render();
          // After closing, bring the resort back into view if it scrolled away
          if (resort.getBoundingClientRect().top < 0) resort.scrollIntoView();
        });
        render();
      })();
    </script>
  </body>
</html>
