---
lang: en
space: research
layout: single
permalink: /cv/
title: "Curriculum Vitae"
description: "Academic and professional background: education, research experience, teaching, technical skills, certifications, and publications in applied mathematics and data science."
full_width: true
author_profile: false
redirect_from:
  - /resume
---

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(1.9rem, 4vw, 2.9rem); margin-bottom: 0.75rem;">Curriculum Vitae</p>
    <p class="hero__statement">
      A concise overview of my academic journey, research experience, professional activities, and technical expertise.
    </p>
    <div class="hero__actions">
      <a href="/files/Profile.pdf" class="btn btn--large">Download PDF CV</a>
    </div>
  </div>
</section>

<div class="page-prose" markdown="1" style="max-width: 1100px; margin: 0 auto; padding: 0 1.5rem 3rem;">

<span class="hero__section-label">Summary</span>

## Academic Profile

{{ site.data.resume.summary | markdownify }}

The [Research](/en/research/) and [Scientific Journey](/about/) pages develop this further; what follows here is the evidence.

---

<span class="hero__section-label">Progression</span>

## Timeline

<ol class="cv-timeline">
  {% for item in site.data.resume.timeline %}
  <li class="cv-timeline__item">
    <span class="cv-timeline__date">{{ item.date }}</span>
    <span class="status-badge">{{ item.category }}</span>
    <h3 class="cv-timeline__title">{{ item.title }}</h3>
    <p class="cv-timeline__desc">{{ item.description }}</p>
  </li>
  {% endfor %}
</ol>

---

<span class="hero__section-label">Academic Background</span>

## Education

<ul class="research-grid">
  {% for edu in site.data.resume.education %}
  <li class="research-card">
    <h3 class="research-card__title">{{ edu.degree }}</h3>
    <p class="case-study__meta-item">{{ edu.institution }} &middot; {{ edu.dates }}</p>
    {% if edu.track %}<p class="research-card__desc">{{ edu.track }}</p>{% endif %}
    {% if edu.research_topics %}<p class="research-card__desc"><strong>Research focus.</strong> {{ edu.research_topics }}</p>{% endif %}
    {% if edu.supervisor %}<p class="research-card__desc"><strong>Supervisor.</strong> {{ edu.supervisor }}</p>{% endif %}
    {% if edu.related_link %}<a href="{{ edu.related_link }}{% if edu.related_link contains '/projects/' %}?from=research{% endif %}" class="project-teaser__link">{{ edu.related_link_label }} &rarr;</a>{% endif %}
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Where the Research Happened</span>

## Research Experience

<div class="project-teasers reveal">
  {% for exp in site.data.resume.research_experience %}
  <div class="project-teaser">
    <h3>{{ exp.title }}</h3>
    <p class="case-study__meta-item" style="margin-bottom: 0.9rem;">{{ exp.venue }} &middot; {{ exp.dates }}</p>
    <p><strong>Context.</strong> {{ exp.context }}</p>
    <p><strong>Objectives.</strong> {{ exp.objectives }}</p>
    <p><strong>Methods.</strong> {{ exp.methods }}</p>
    <p><strong>Contribution.</strong> {{ exp.contribution }}</p>
    {% if exp.related_link %}<a href="{{ exp.related_link }}{% if exp.related_link contains '/projects/' %}?from=research{% endif %}" class="project-teaser__link">{{ exp.related_link_label }} &rarr;</a>{% endif %}
  </div>
  {% endfor %}
</div>

---

<span class="hero__section-label">Applied Work</span>

## Professional Experience

<div class="project-teasers reveal">
  {% for job in site.data.resume.experience %}
  <div class="project-teaser">
    <h3>{{ job.title }}</h3>
    <p class="case-study__meta-item" style="margin-bottom: 0.9rem;">{{ job.venue }} &middot; {{ job.dates }}</p>
    <p><strong>Responsibilities.</strong> {{ job.responsibilities }}</p>
    {% if job.contributions %}<p><strong>Contributions.</strong> {{ job.contributions }}</p>{% endif %}
    {% if job.impact %}<p><strong>Impact.</strong> {{ job.impact }}</p>{% endif %}
    {% if job.technologies %}
    <ul class="research-card__tech">
      {% for tech in job.technologies %}<li>{{ tech }}</li>{% endfor %}
    </ul>
    {% endif %}
  </div>
  {% endfor %}
</div>

Teaching roles (Lecturer, Teaching Assistant, and Mathematics Tutor) are covered in full on the [Teaching](/teaching/) page rather than duplicated here.

---

<span class="hero__section-label">Evidence</span>

## Research Outputs

{% if site.author.googlescholar %}
<p>You can also find my articles on <a href="{{ site.author.googlescholar }}" target="_blank" rel="noopener noreferrer">my Google Scholar profile</a>.</p>
{% endif %}

{% include base_path %}
{% assign publications_sorted = site.publications | sort: 'date' | reverse %}

{% if site.publication_category %}
  {% for category in site.publication_category %}
    {% assign title_shown = false %}
    {% for post in publications_sorted %}
      {% if post.category != category[0] %}
        {% continue %}
      {% endif %}
      {% assign venue_down = post.venue | default: '' | downcase %}
      {% assign title_down = post.title | default: '' | downcase %}
      {% assign is_preparation = false %}
      {% if venue_down contains 'in preparation' or venue_down contains 'en preparation' or venue_down contains 'en préparation' or title_down contains 'in preparation' or title_down contains 'en preparation' or title_down contains 'en préparation' %}
        {% assign is_preparation = true %}
      {% endif %}
      {% if is_preparation %}
        {% continue %}
      {% endif %}
      {% unless title_shown %}
<h3>{{ category[1].title }}</h3>
        {% assign title_shown = true %}
      {% endunless %}
      {% include archive-single-cv.html from="?from=research" %}
    {% endfor %}
    {% for post in publications_sorted %}
      {% if post.category != category[0] %}
        {% continue %}
      {% endif %}
      {% assign venue_down = post.venue | default: '' | downcase %}
      {% assign title_down = post.title | default: '' | downcase %}
      {% assign is_preparation = false %}
      {% if venue_down contains 'in preparation' or venue_down contains 'en preparation' or venue_down contains 'en préparation' or title_down contains 'in preparation' or title_down contains 'en preparation' or title_down contains 'en préparation' %}
        {% assign is_preparation = true %}
      {% endif %}
      {% unless is_preparation %}
        {% continue %}
      {% endunless %}
      {% unless title_shown %}
<h3>{{ category[1].title }}</h3>
        {% assign title_shown = true %}
      {% endunless %}
      {% include archive-single-cv.html from="?from=research" %}
    {% endfor %}
  {% endfor %}
{% endif %}

Research software and open-source contributions (DataHut-DuckHouse, Scientific Assistant, and others) are documented as full case studies on the <a href="/en/research/#projects">Research</a> page. My Master's thesis has been completed and will be linked here soon.

---

<span class="hero__section-label">Toolkit</span>

## Technical Expertise

<ul class="research-grid">
  {% for skill in site.data.resume.skills %}
  <li class="research-card">
    <h3 class="research-card__title">{{ skill.category }}</h3>
    <ul class="research-card__tech">
      {% for item in skill.items %}<li>{{ item }}</li>{% endfor %}
    </ul>
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Credentials</span>

## Certifications

{% if site.author.credly %}
<p>Verified digital badges for these credentials are available on <a href="{{ site.author.credly }}" target="_blank" rel="noopener noreferrer">Credly</a>.</p>
{% endif %}

<ul class="research-grid">
  {% for cert in site.data.resume.certifications %}
  <li class="research-card">
    <h3 class="research-card__title">{{ cert.name }}</h3>
    {% if cert.issuer %}<p class="case-study__meta-item">{{ cert.issuer }}</p>{% endif %}
    <p class="research-card__desc">{{ cert.description }}</p>
    {% if cert.link %}<a href="{{ cert.link }}" target="_blank" rel="noopener noreferrer" class="project-teaser__link">View credential &rarr;</a>{% endif %}
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Recognition</span>

## Awards & Recognition

{% if site.data.resume.awards.size > 0 %}
<ul class="research-grid">
  {% for award in site.data.resume.awards %}
  <li class="research-card">
    <h3 class="research-card__title">{{ award.title }}</h3>
    <p class="case-study__meta-item">{{ award.issuer }} &middot; {{ award.date }}</p>
    <p class="research-card__desc">{{ award.description }}</p>
  </li>
  {% endfor %}
</ul>
{% else %}
<div class="rdv-panel">
  <p class="rdv-subtitle">No formal awards to list yet at this stage of my research career. This section is ready to grow as that changes.</p>
</div>
{% endif %}

---

<span class="hero__section-label">Communication</span>

## Languages

<div>
  {% for lang in site.data.resume.languages %}
  <span class="language-card"><strong>{{ lang.language }}</strong> <span class="case-study__meta-item">{{ lang.level }}</span></span>
  {% endfor %}
</div>

---

<span class="hero__section-label">Beyond the Core Work</span>

## Professional Activities

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Teaching</li>
  <li class="hero__chip">Mentoring</li>
  <li class="hero__chip">Open-Source Contributions</li>
  <li class="hero__chip">Scientific Communication</li>
</ul>

Teaching and mentoring are detailed on the [Teaching](/teaching/) page. Open-source work is documented in the [Research projects](/en/research/#projects) and on <a href="https://github.com/Geobatpo07" target="_blank" rel="noopener noreferrer">GitHub</a> (125+ repositories, 198+ contributions). Scientific communication beyond formal publications continues on <a href="https://stories.geovanylaguerre.net" target="_blank" rel="noopener noreferrer">Geo's Stories</a>. No conference presentations to date, noted here rather than omitted.

---

<span class="hero__section-label">Get the Full Picture</span>

## Downloads

<div class="hero__actions">
  <a href="/files/Profile.pdf" class="btn">Download PDF CV</a>
  <a href="/about/" class="btn btn--outline">Scientific Journey</a>
  <span class="btn btn--outline" style="opacity: 0.55; cursor: not-allowed;" aria-disabled="true">Research Statement (Coming Soon)</span>
  <span class="btn btn--outline" style="opacity: 0.55; cursor: not-allowed;" aria-disabled="true">Teaching Statement (Coming Soon)</span>
</div>

</div>

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(1.6rem, 3.4vw, 2.2rem); margin-bottom: 0.75rem;">Continue Exploring</p>
    <div class="hero__actions">
      <a href="/en/research/" class="btn btn--large">Research</a>
      <a href="/teaching/" class="btn btn--large btn--outline">Teaching</a>
      <a href="https://stories.geovanylaguerre.net" target="_blank" rel="noopener noreferrer" class="btn btn--large btn--outline">Stories</a>
      <a href="/en/research/contact/" class="btn btn--large btn--outline">Contact</a>
    </div>
  </div>
</section>
