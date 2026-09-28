// Click-to-load embeds (_layouts/contact.html): a third-party iframe is
// created only when the visitor clicks the button, so no request reaches the
// third party (and no cookie is set) before that action.
//   <div data-click-to-load data-src="https://…" data-title="…">
//     <p>What will load, link to the privacy policy.</p>
//     <button type="button" hidden>Show</button>
//   </div>
// Without JavaScript the button stays hidden; pages keep a direct link.
(function () {
  document.querySelectorAll('[data-click-to-load]').forEach(function (shell) {
    var button = shell.querySelector('button');
    if (!button || !shell.dataset.src) return;
    button.hidden = false;
    button.addEventListener('click', function () {
      var iframe = document.createElement('iframe');
      iframe.className = 'rdv-embed';
      iframe.src = shell.dataset.src;
      iframe.title = shell.dataset.title || '';
      iframe.referrerPolicy = 'no-referrer-when-downgrade';
      shell.classList.remove('rdv-embed-shell--consent');
      shell.replaceChildren(iframe);
      iframe.focus();
    });
  });
})();
