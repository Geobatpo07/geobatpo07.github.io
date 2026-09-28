---
lang: en
layout: resume-print
permalink: /resume-print/
title: "Resume"
noindex: true
sitemap: false
---

{% assign r = site.data.resume %}

<div class="resume">

  <header class="resume__header">
    <p class="resume__name">{{ r.name }}</p>
    <p class="resume__title">{{ r.title }}</p>
    <p class="resume__contact">
      {% if r.location %}<span>{{ r.location }}</span>{% endif %}
      {% if r.email %}<span><a href="{{ r.email }}">{{ r.email | remove: "mailto:" }}</a></span>{% endif %}
      {% if site.url %}<span><a href="{{ site.url }}">{{ site.url | remove: "https://" | remove: "http://" }}</a></span>{% endif %}
      {% if r.github %}<span><a href="{{ r.github }}" target="_blank" rel="noopener noreferrer">{{ r.github | remove: "https://" }}</a></span>{% endif %}
      {% if r.linkedin %}<span><a href="{{ r.linkedin }}" target="_blank" rel="noopener noreferrer">{{ r.linkedin | remove: "https://www." | remove: "https://" }}</a></span>{% endif %}
      {% if site.author.orcid %}<span><a href="{{ site.author.orcid }}" target="_blank" rel="noopener noreferrer">{{ site.author.orcid | remove: "https://" }}</a></span>{% endif %}
    </p>
  </header>

  {% capture newline %}
{% endcapture %}
  {% assign summary_intro = r.summary | split: newline | first %}
  <section class="section">
    <h2 class="section__title">Summary</h2>
    <p class="section__summary">{{ summary_intro | strip }}</p>
  </section>

  <section class="section">
    <h2 class="section__title">Education</h2>
    {% for edu in r.education %}
    <div class="entry">
      <div class="entry__row">
        <span class="entry__title">{{ edu.degree }}</span>
        <span class="entry__dates">{{ edu.dates }}</span>
      </div>
      <p class="entry__subtitle">{{ edu.institution }}</p>
      {% if edu.track %}<p class="entry__meta">{{ edu.track }}</p>{% endif %}
      {% if edu.supervisor %}<p class="entry__meta">Supervisor: {{ edu.supervisor }}</p>{% endif %}
    </div>
    {% endfor %}
  </section>

  <section class="section">
    <h2 class="section__title">Professional Experience</h2>
    {% for job in r.experience %}
    <div class="entry">
      <div class="entry__row">
        <span class="entry__title">{{ job.title }}</span>
        <span class="entry__dates">{{ job.dates }}</span>
      </div>
      <p class="entry__subtitle">{{ job.venue }}</p>
      <ul class="entry__bullets">
        <li>{{ job.responsibilities }}</li>
        {% if job.contributions %}<li>{{ job.contributions }}</li>{% endif %}
        {% if job.impact %}<li>{{ job.impact }}</li>{% endif %}
      </ul>
    </div>
    {% endfor %}
  </section>

  <section class="section">
    <h2 class="section__title">Research Experience</h2>
    {% for exp in r.research_experience %}
      {% unless exp.title == "Master's Research" %}
      <div class="entry">
        <div class="entry__row">
          <span class="entry__title">{{ exp.title }}</span>
          <span class="entry__dates">{{ exp.dates }}</span>
        </div>
        <p class="entry__subtitle">{{ exp.venue }}</p>
        <ul class="entry__bullets">
          {% if exp.context %}<li>{{ exp.context }}</li>{% endif %}
          {% if exp.objectives %}<li>{{ exp.objectives }}</li>{% endif %}
          {% if exp.methods %}<li>{{ exp.methods }}</li>{% endif %}
          {% if exp.contribution %}<li>{{ exp.contribution }}</li>{% endif %}
        </ul>
      </div>
      {% endunless %}
    {% endfor %}
  </section>

  <section class="section">
    <h2 class="section__title">Selected Projects</h2>
    {% assign projects_selected = site.projects | sort: 'date' | reverse | slice: 0, 4 %}
    {% for project in projects_selected %}
    <div class="entry">
      <div class="entry__row">
        <span class="entry__title">{{ project.title }}</span>
      </div>
      <p class="entry__desc">{{ project.excerpt }}</p>
      {% if project.technologies %}<p class="entry__meta">{{ project.technologies | join: ", " }}</p>{% endif %}
      {% if project.github %}<p class="entry__meta">{{ project.github | remove: "https://" }}</p>{% endif %}
    </div>
    {% endfor %}
  </section>

  <section class="section">
    <h2 class="section__title">Publications</h2>
    {% assign pubs_sorted = site.publications | sort: 'date' | reverse %}
    <ul class="compact-list">
      {% for pub in pubs_sorted %}
        {% assign venue_down = pub.venue | default: '' | downcase %}
        {% unless venue_down contains 'in preparation' or venue_down contains 'en preparation' or venue_down contains 'en préparation' %}
        <li>{{ pub.citation }}</li>
        {% endunless %}
      {% endfor %}
    </ul>
  </section>

  <section class="section">
    <h2 class="section__title">Technical Skills</h2>
    <ul class="compact-list">
      {% for skill in r.skills %}
      <li><span class="label">{{ skill.category }}:</span> {{ skill.items | join: ", " }}</li>
      {% endfor %}
    </ul>
  </section>

  <section class="section">
    <h2 class="section__title">Certifications</h2>
    <ul class="compact-list">
      {% for cert in r.certifications %}
      <li>{{ cert.name }}{% if cert.issuer %}, {{ cert.issuer }}{% endif %}</li>
      {% endfor %}
    </ul>
  </section>

  <section class="section">
    <h2 class="section__title">Languages</h2>
    <p class="lang-line">
      {% for lang in r.languages %}{{ lang.language }} ({{ lang.level }}){% unless forloop.last %} &middot; {% endunless %}{% endfor %}
    </p>
  </section>

</div>
