// Hidden links to the three spaces in the home page footer (_includes/chrome/footer.html).
// They are shown only in a browser where the owner switched them on:
//   open /?owner=1 once to show them from then on, /?owner=0 to hide them again.
// This is a convenience, not access control: the spaces stay reachable by their URL.
(function () {
  var KEY = 'owner-links';
  var nav = document.querySelector('[data-owner-links]');
  if (!nav) return;
  try {
    var flag = new URLSearchParams(window.location.search).get('owner');
    if (flag === '1') {
      window.localStorage.setItem(KEY, '1');
    } else if (flag === '0') {
      window.localStorage.removeItem(KEY);
    }
    if (window.localStorage.getItem(KEY) === '1') {
      nav.hidden = false;
    }
  } catch (e) {
    // Storage unavailable (private mode, blocked): the links simply stay hidden.
  }
})();
