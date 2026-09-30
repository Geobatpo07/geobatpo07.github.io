{% comment %}
  Long-form research content in English, shown on /en/research/ after the
  generated track sections. The French version is details-fr.md.
{% endcomment %}
<div class="page-prose" markdown="1" lang="en">

I am interested in understanding complex systems through mathematical models, computational methods, and intelligent algorithms. Whether the application concerns environmental dynamics, healthcare, or scientific data infrastructure, the underlying scientific challenge stays the same: constructing models that are mathematically rigorous, computationally reliable, and useful for decision making. Everything below follows from that one challenge.

---

<span class="hero__section-label">The Centerpiece</span>

## Research Questions

I don't organize my work around projects first. Projects exist because of these questions.

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">How can mathematical models better represent complex environmental systems?</h3>
    <p class="research-card__desc">Seasonal forcing, delayed effects, and incomplete measurements make environmental systems resistant to simple models. I'm interested in how much structure a compartmental approach can capture before it needs to become something more complex.</p>
    <p class="research-card__project">Related: <span>Mathematical Modelling · Environmental Modelling</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">How can scientific computing improve the reliability of numerical simulations?</h3>
    <p class="research-card__desc">A simulation is only as trustworthy as the stability of the scheme producing it. I look at how discretization choices (finite differences, operator splitting) decide whether a result reflects the physics or just numerical artifacts.</p>
    <p class="research-card__project">Related: <span>Scientific Computing · Numerical Analysis</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">How can artificial intelligence support scientific discovery while remaining transparent and reproducible?</h3>
    <p class="research-card__desc">Machine learning can find structure I wouldn't specify by hand, but only if it stays interpretable enough to validate. I'm interested in architectures that combine symbolic reasoning with learned components without losing that transparency.</p>
    <p class="research-card__project">Related: <span>Artificial Intelligence · Machine Learning</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">How can data infrastructures improve reproducibility in computational research?</h3>
    <p class="research-card__desc">Most data platforms are built for business scale. I'm interested in what changes when reproducibility, not throughput, is the primary design constraint.</p>
    <p class="research-card__project">Related: <span>Scientific Data Infrastructure</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">How can mathematical modelling contribute to healthcare decision support?</h3>
    <p class="research-card__desc">A model that informs a health decision carries a different burden of proof than one that doesn't. I'm interested in decision-support tools precise enough to be useful and honest enough to be questioned.</p>
    <p class="research-card__project">Related: <span>Healthcare Analytics · Biostatistics</span></p>
  </li>
</ul>

---

<span class="hero__section-label">The Vocabulary</span>

## Research Themes

Ten perspectives on the same underlying problem, not a checklist of skills.

<ul class="research-grid">
  {% for theme in site.data.researchThemes %}
  <li class="research-card">
    <h3 class="research-card__title">{{ theme.title.en }}</h3>
    <p class="research-card__desc"><strong>Why it matters.</strong> {{ theme.why.en }}</p>
    <p class="research-card__desc"><strong>Scientific challenge.</strong> {{ theme.challenge.en }}</p>
    <p class="research-card__desc"><strong>Current application.</strong> {{ theme.application.en }}</p>
    <p class="research-card__project">{{ theme.connection.en }}</p>
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Interdisciplinary Balance</span>

## Scientific Profile

Read this less as a skills inventory and more as a map of balance. Each axis depends on the others: mathematical modelling means little without the computing to test it, and computing means little without the statistical grounding to trust its output.

{% include chart.html id="radarChart" height="480px" data=site.data.radar.en %}

---

<span class="hero__section-label">Methodology</span>

## Research Framework

How a question here typically becomes an answer.

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Scientific Question</span></li>
  <li><span class="scientific-timeline__label">Mathematical Model</span></li>
  <li><span class="scientific-timeline__label">Numerical Method</span></li>
  <li><span class="scientific-timeline__label">Scientific Computing</span></li>
  <li><span class="scientific-timeline__label">Data</span></li>
  <li><span class="scientific-timeline__label">Machine Learning</span></li>
  <li><span class="scientific-timeline__label">Validation</span></li>
  <li><span class="scientific-timeline__label">Decision Support</span></li>
</ol>

---

<span class="hero__section-label">Evidence</span>

## Research Outputs

Publications are one research output among several, alongside software, technical notes, and the projects above.

{% if site.author.googlescholar %}
<p>You can also find my articles on <a href="{{ site.author.googlescholar }}" target="_blank" rel="noopener noreferrer">my Google Scholar profile</a>.</p>
{% endif %}

{% include base_path %}
{% assign publications_sorted = site.publications | where: "lang", "en" | sort: 'date' | reverse %}

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
      {% include archive-single.html %}
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
      {% include archive-single.html %}
    {% endfor %}
  {% endfor %}
{% endif %}

---

<span class="hero__section-label">Commitments</span>

## Open Science

None of this work is credible to me if it can't be checked. That means code that runs for someone other than me, methods documented well enough to be challenged, and results that don't depend on a specific machine to reproduce. GitHub hosts the code and technical notes; <a href="https://stories.geovanylaguerre.net" target="_blank" rel="noopener noreferrer">Geo's Stories</a> hosts the less formal record of how the ideas actually developed.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Version Control</li>
  <li class="hero__chip">Open Source</li>
  <li class="hero__chip">Reproducible Pipelines</li>
  <li class="hero__chip">Documented Methods</li>
  <li class="hero__chip">Public Technical Notes</li>
</ul>

---

<span class="hero__section-label">Directions, Not Promises</span>

## Future Research

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">AI for Science</li>
  <li class="hero__chip">Scientific Machine Learning</li>
  <li class="hero__chip">Environmental Mathematics</li>
  <li class="hero__chip">Healthcare Analytics</li>
  <li class="hero__chip">Computational Biology</li>
  <li class="hero__chip">Decision Support Systems</li>
  <li class="hero__chip">Digital Health</li>
  <li class="hero__chip">Mathematical Epidemiology</li>
</ul>

These are directions I want to grow into, not results I'm claiming. The throughline that got me here (read on the [Scientific Journey](/en/about/) page) is the same one pointing toward them.

</div>
