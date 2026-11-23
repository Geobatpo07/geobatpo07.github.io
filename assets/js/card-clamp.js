// "Read more" on project cards whose description exceeds 4 lines.
// shortcut: measured once at load, not on resize; add a ResizeObserver if cards must re-evaluate.
(function () {
  document.querySelectorAll('.tracks-card__desc').forEach(function (p) {
    p.classList.add('is-clamped');
    if (p.scrollHeight <= p.clientHeight + 1) { p.classList.remove('is-clamped'); return; }
    var b = document.createElement('button');
    b.type = 'button';
    b.className = 'tracks-card__more';
    b.textContent = p.dataset.more;
    b.setAttribute('aria-expanded', 'false');
    b.addEventListener('click', function () {
      var open = b.getAttribute('aria-expanded') !== 'true';
      p.classList.toggle('is-clamped', !open);
      b.setAttribute('aria-expanded', open ? 'true' : 'false');
      b.textContent = open ? p.dataset.less : p.dataset.more;
    });
    p.insertAdjacentElement('afterend', b);
  });
})();
