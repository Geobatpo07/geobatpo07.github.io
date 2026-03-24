---
layout: single
title: "Blog"
permalink: /blog/
author_profile: true
---

<section class="blog-shell">
  <div class="blog-hero">
    <h2>Independent Blog Space</h2>
    <p>This is the dedicated home of my blog, focused on data science, applied mathematics, machine learning, and scientific modeling.</p>
    <div class="blog-inline-links">
      <a class="blog-link-chip" href="/about/">Qui suis-je ?</a>
      <a class="blog-link-chip" href="/year-archive/">Open year archive</a>
    </div>
  </div>

## Latest Articles

  <p class="blog-note">All posts follow a consistent format: context, objective, method, implementation, results, limitations, and references.</p>

  {% assign posts_count = site.posts | size %}
  {% if posts_count > 0 %}
  <div class="blog-feed">
    {% for post in site.posts limit: 8 %}
    <article class="blog-card">
      <h3 class="blog-card-title"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <p class="blog-card-meta">{{ post.date | date: "%B %-d, %Y" }}</p>
      {% if post.excerpt %}
      <p class="blog-card-excerpt">{{ post.excerpt | strip_html | truncate: 220 }}</p>
      {% endif %}
    </article>
    {% endfor %}
  </div>
  {% else %}
  <p class="blog-empty">No posts yet. New articles will be published here soon.</p>
  {% endif %}

## Explore By Theme

  <ul class="blog-pill-list">
    <li><a class="blog-pill" href="/tags/#demography">Demography</a></li>
    <li><a class="blog-pill" href="/tags/#compartmental-modeling">Compartmental modeling</a></li>
    <li><a class="blog-pill" href="/tags/#python">Python</a></li>
    <li><a class="blog-pill" href="/categories/#data-science">Data Science</a></li>
  </ul>

## Publication Rhythm

  <p>I publish practical and research-oriented posts regularly, including:</p>

  <ul>
    <li>methodological tutorials</li>
    <li>real case-study walkthroughs</li>
    <li>reproducible code-first analyses</li>
  </ul>
</section>
