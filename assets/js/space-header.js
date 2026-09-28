// Page header behaviour (_includes/chrome/header.html).
(function () {
  // Mobile menu of a space header.
  var toggle = document.querySelector('.space-header__toggle');
  var menu = document.getElementById('space-menu');
  if (toggle && menu) {
    var setOpen = function (open) {
      toggle.setAttribute('aria-expanded', String(open));
      menu.classList.toggle('is-open', open);
    };

    toggle.addEventListener('click', function () {
      setOpen(toggle.getAttribute('aria-expanded') !== 'true');
    });

    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && menu.classList.contains('is-open')) {
        setOpen(false);
        toggle.focus();
      }
    });
  }

  // "Back" button of the neutral header: history.back() when there is a
  // page to return to, else the space root given by ?from=<space>
  // (&lang=en for the English root). Without either, the button stays hidden,
  // so a neutral page never carries a link to a space in its markup.
  var back = document.querySelector('[data-back]');
  if (!back) return;

  var roots = { software: '/software/', data: '/data/', research: '/research/' };
  var params = new URLSearchParams(window.location.search);
  var from = params.get('from');
  var fallback = null;
  if (from && Object.prototype.hasOwnProperty.call(roots, from)) {
    fallback = (params.get('lang') === 'en' ? '/en' : '') + roots[from];
  }
  var hasHistory = window.history.length > 1 && document.referrer !== '';

  if (!hasHistory && !fallback) return;

  back.hidden = false;
  back.addEventListener('click', function () {
    if (hasHistory) {
      window.history.back();
    } else {
      window.location.assign(fallback);
    }
  });
})();
