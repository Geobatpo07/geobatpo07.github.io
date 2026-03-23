/* ==========================================================================
   Various functions that we want to use within the template
   ========================================================================== */

// Determine the expected state of the theme toggle, which can be "dark", "light", or
// "system". Default is "system".
let determineThemeSetting = () => {
  let themeSetting = localStorage.getItem("theme");
  return (themeSetting != "dark" && themeSetting != "light" && themeSetting != "system") ? "system" : themeSetting;
};

// Determine the computed theme, which can be "dark" or "light". If the theme setting is
// "system", the computed theme is determined based on the user's system preference.
let determineComputedTheme = () => {
  let themeSetting = determineThemeSetting();
  if (themeSetting != "system") {
    return themeSetting;
  }
  return (userPref && userPref("(prefers-color-scheme: dark)").matches) ? "dark" : "light";
};

// detect OS/browser preference
const browserPref = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';

// Set the theme on page load or when explicitly called
let setTheme = (theme) => {
  const use_theme =
    theme ||
    localStorage.getItem("theme") ||
    $("html").attr("data-theme") ||
    browserPref;

  if (use_theme === "dark") {
    $("html").attr("data-theme", "dark");
    $("#theme-icon").removeClass("fa-sun").addClass("fa-moon");
  } else if (use_theme === "light") {
    $("html").removeAttr("data-theme");
    $("#theme-icon").removeClass("fa-moon").addClass("fa-sun");
  }
};

// Toggle the theme manually
var toggleTheme = () => {
  const current_theme = $("html").attr("data-theme");
  const new_theme = current_theme === "dark" ? "light" : "dark";
  localStorage.setItem("theme", new_theme);
  setTheme(new_theme);
};

/* ==========================================================================
   Chart.js integration for Markdown codeblocks
   ========================================================================== */

let chartCodeElements = document.querySelectorAll("pre>code.language-chartjs");

const chartScriptId = '__chartjs-markdown-script';

function ensureChartJsLoaded(onReady) {
  if (typeof Chart !== 'undefined') {
    onReady();
    return;
  }

  let existing = document.getElementById(chartScriptId);
  if (!existing) {
    let script = document.createElement('script');
    script.id = chartScriptId;
    script.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js';
    script.async = true;
    script.onload = onReady;
    document.head.appendChild(script);
  } else {
    existing.addEventListener('load', onReady, { once: true });
  }
}

function toChartConfigFromCodePayload(payload) {
  if (payload && payload.type && payload.data) {
    return payload;
  }

  return {
    type: 'radar',
    data: {
      labels: [],
      datasets: []
    },
    options: {
      responsive: true,
      maintainAspectRatio: false
    }
  };
}

function renderMarkdownCharts() {
  if (chartCodeElements.length === 0) {
    return;
  }

  ensureChartJsLoaded(() => {
    chartCodeElements.forEach((elem, index) => {
      let payload;
      try {
        payload = JSON.parse(elem.textContent);
      } catch (error) {
        return;
      }

      elem.parentElement.classList.add('hidden');

      const chartContainer = document.createElement('div');
      chartContainer.style.width = '100%';
      chartContainer.style.height = '460px';

      const chartCanvas = document.createElement('canvas');
      chartCanvas.id = 'md-chart-' + index;
      chartContainer.appendChild(chartCanvas);

      elem.parentElement.after(chartContainer);

      const chartConfig = toChartConfigFromCodePayload(payload);
      new Chart(chartCanvas, chartConfig);
    });
  });
}

if (chartCodeElements.length > 0) {
  document.addEventListener('readystatechange', () => {
    if (document.readyState === 'complete') {
      renderMarkdownCharts();
    }
  });
}

/* ==========================================================================
   Actions that should occur when the page has been fully loaded
   ========================================================================== */

$(document).ready(function () {
  // SCSS SETTINGS - These should be the same as the settings in the relevant files 
  const scssLarge = 925;          // pixels, from /_sass/_themes.scss
  const scssMastheadHeight = 70;  // pixels, from the current theme (e.g., /_sass/theme/_default.scss)

  // If the user hasn't chosen a theme, follow the OS preference
  setTheme();
  window.matchMedia('(prefers-color-scheme: dark)')
        .addEventListener("change", (e) => {
          if (!localStorage.getItem("theme")) {
            setTheme(e.matches ? "dark" : "light");
          }
        });

  // Enable the theme toggle
  $('#theme-toggle').on('click', toggleTheme);

  // Enable the sticky footer
  var bumpIt = function () {
    $("body").css("padding-bottom", "0");
    $("body").css("margin-bottom", $(".page__footer").outerHeight(true));
  }
  $(window).resize(function () {
    didResize = true;
  });
  setInterval(function () {
    if (didResize) {
      didResize = false;
      bumpIt();
    }}, 250);
  var didResize = false;
  bumpIt();

  // FitVids init
  fitvids();

  // Follow menu drop down
  $(".author__urls-wrapper button").on("click", function () {
    $(".author__urls").fadeToggle("fast", function () { });
    $(".author__urls-wrapper button").toggleClass("open");
  });

  // Restore the follow menu if toggled on a window resize
  jQuery(window).on('resize', function () {
    if ($('.author__urls.social-icons').css('display') == 'none' && $(window).width() >= scssLarge) {
      $(".author__urls").css('display', 'block')
    }
  });

  // Init smooth scroll, this needs to be slightly more than then fixed masthead height
  $("a").smoothScroll({
    offset: -scssMastheadHeight,
    preventDefault: false,
  });

});
