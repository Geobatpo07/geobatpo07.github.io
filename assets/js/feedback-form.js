---
layout: null
---
// Feedback form (_includes/feedback-form.html): opens the mail client with
// the message pre-filled. The texts of the mail come from the form's data-*
// attributes, set from _data/i18n.yml in the page language.
(function () {
  var FEEDBACK_EMAIL = "{{ site.author.email }}";
  var form = document.getElementById("feedback-form");
  if (!form || !FEEDBACK_EMAIL) return;

  var text = form.dataset;

  form.addEventListener("submit", function (e) {
    e.preventDefault();

    var name = form.name.value.trim();
    var email = form.email.value.trim();
    var message = form.message.value.trim();

    var subject = text.subject + " " + (name || text.visitor);
    var bodyLines = [message, "", text.from + " " + (name || text.anonymous)];
    if (email) {
      bodyLines.push(text.replyTo + " " + email);
    }

    var mailto = "mailto:" + FEEDBACK_EMAIL
      + "?subject=" + encodeURIComponent(subject)
      + "&body=" + encodeURIComponent(bodyLines.join("\n"));

    window.location.href = mailto;
  });
})();
