---
space: research
permalink: /about/
title: "My Scientific Journey"
description: "How one question, how can mathematics help us understand complex systems well enough to make better decisions, led from pure mathematics through scientific computing, data, and AI, with healthcare and environmental science as specialization domains."
full_width: true
author_profile: false
redirect_from:
  - /about.html
---

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <span class="hero__section-label">My Scientific Journey</span>

    <p class="hero__statement">
      Every researcher begins with a question. Mine has always been remarkably simple:
    </p>

    <p class="hero__name" style="font-size: clamp(1.7rem, 3.8vw, 2.85rem); max-width: 34ch; margin-left: auto; margin-right: auto;">
      How can mathematics help us understand complex systems well enough to make better decisions?
    </p>
  </div>
</section>

<div class="page-prose" markdown="1" style="max-width: 880px; margin: 0 auto; padding: 0 1.5rem 2rem;">

<span class="hero__section-label">Chapter One</span>

## Foundations

Before I had a research question, I had a habit: distrust anything that isn't precise. That habit didn't come from a classroom: it came from working with systems where a wrong assumption doesn't just look bad on paper, it fails in the real world. Mathematics became the language that let me be precise on purpose. Group theory, functional analysis, differential equations, not as subjects to master, but as a discipline of thought: define your terms, state your assumptions, follow the logic wherever it leads, and never mistake an intuition for a proof.

That discipline is still the first filter everything else in this story has to pass through.

<p class="hero__why">Rigor isn't a constraint on creativity. It's what makes an idea trustworthy enough to build on.</p>

---

<span class="hero__section-label">Chapter Two</span>

## From Theory to Computation

A theorem is true in general. Reality is a specific case, and specific cases rarely have closed-form answers. That gap is where mathematical modelling lives, and scientific computing is what makes a model something more than an equation on paper. I started translating continuous equations (wave propagation, atmospheric flow) into discrete schemes a computer could actually run: finite differences, operator splitting, stability conditions that quietly decide whether a simulation reflects physics or just accumulates numerical noise.

That taught me something the pure theory hadn't: an elegant model that is numerically unstable is not a working model. Computation isn't separate from mathematics: it's mathematics forced to be honest about what it can actually compute.

<p class="hero__why">An unstable numerical scheme is just as wrong as an incorrect proof. It just fails later, and more expensively.</p>

---

<span class="hero__section-label">Chapter Three</span>

## From Models to Data

Simulated systems are clean. Real ones are not. The moment a model has to face actual measurements, uncertainty stops being a footnote and becomes the main problem: noisy inputs, missing values, distributions that don't behave the way the theory assumed. Statistics gave me a formal way to reason about that uncertainty instead of gesturing at it, and once the data in question was about human health rather than an abstract system, that same statistical grounding became biostatistics.

Data has a second, quieter problem: it has to be trustworthy before it is ever analyzed. That is what pulled me into data science and data engineering: pipelines, validation, reproducibility. I don't think of that as software work bolted onto research. It's scientific methodology: the part that decides whether a conclusion survives someone else re-running the analysis.

<p class="hero__why">A result that can't be reproduced isn't a finding yet. It's a claim waiting for verification.</p>

---

<span class="hero__section-label">Chapter Four</span>

## Learning Systems

Machine learning entered this story late, and on purpose. I didn't want a black box that outperforms interpretation; I wanted another modelling framework, one that can find structure I didn't specify by hand, but that still has to earn trust the same way every other model does: through validation, transparency, and reproducibility.

In practice that means combining approaches rather than replacing one with another: symbolic reasoning for what can be stated precisely, statistical learning for what can only be estimated, and enough documentation that someone else can see exactly how a system reached its answer. Intelligence, in this context, isn't the goal. Accountable inference is.

<p class="hero__why">A model that can't explain itself isn't intelligent. It's just confident.</p>

---

<span class="hero__section-label">Chapter Five</span>

## Where the Methods Specialize

All four of these threads (rigor, computation, data, learning) only matter to me insofar as they can be trusted with something that matters. Healthcare and environmental science are the two specializations where that stake is highest for me: a model of contamination exposure, or a triage recommendation, isn't an academic exercise. It's an input into someone's decision, sometimes about someone's health. That is not a comfortable place to be careless.

It's exactly why the earlier chapters exist: because decision support in healthcare, public health, and environmental systems deserves mathematics rigorous enough to be right, and transparent enough to be questioned. That is the direction this is heading: not artificial intelligence for its own sake, not modelling for its own sake, but scientific tools built carefully enough to be trusted with real consequences, wherever I choose to specialize next.

<p class="hero__why">The question I started with hasn't changed. Only the tools I have to answer it with.</p>

---

<span class="hero__section-label">The Shape of the Idea</span>

## An Intellectual Timeline

Not a résumé. A record of how one question kept finding new tools to answer it.

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Applied Mathematics</span></li>
  <li><span class="scientific-timeline__label">Mathematical Modelling</span></li>
  <li><span class="scientific-timeline__label">Scientific Computing</span></li>
  <li><span class="scientific-timeline__label">Statistics &amp; Biostatistics</span></li>
  <li><span class="scientific-timeline__label">Data Science</span></li>
  <li><span class="scientific-timeline__label">Artificial Intelligence</span></li>
  <li><span class="scientific-timeline__label">Decision Support Systems</span></li>
</ol>

---

<span class="hero__section-label">How I Work</span>

## Research Philosophy

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">Mathematical Rigor</h3>
    <p class="research-card__desc">Every model starts with explicit assumptions and ends with an honest account of its limits. If I can't state what a result assumes, I don't trust it yet.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Computational Reproducibility</h3>
    <p class="research-card__desc">A result that only exists on my machine isn't a result. Code, data, and methods should be transparent enough for someone else to verify (or challenge) what I found.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Interdisciplinary Thinking</h3>
    <p class="research-card__desc">The most interesting problems don't respect department boundaries. Mathematics, computation, and domain expertise have to work together, not in sequence.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Practical Impact</h3>
    <p class="research-card__desc">An elegant model that never touches a real decision is unfinished. I care about work that eventually has to survive contact with reality.</p>
  </li>
</ul>

---

<span class="hero__section-label">Extensions, Not Separate Activities</span>

## Beyond Research

None of the following are a break from research. They are what happens when the same question gets asked out loud, in front of other people.

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">Teaching</h3>
    <p class="research-card__desc">Explaining a model well is often what reveals whether I actually understand it. <a href="/teaching/">Teaching</a> is where that gets tested in real time.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Open Source</h3>
    <p class="research-card__desc">Publishing code is a form of intellectual honesty: it means the methodology has to be complete enough for someone else to run.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Scientific Writing</h3>
    <p class="research-card__desc">Writing forces the same rigor as the mathematics itself: state it clearly enough that being wrong would be obvious.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Knowledge Sharing</h3>
    <p class="research-card__desc">Research that stays in one head doesn't compound. Conversations, reviews, and mentoring are part of how ideas actually get better.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Geo's Stories</h3>
    <p class="research-card__desc">The unpolished side of the same work (ideas, failures, and unexpected turns) lives on <a href="https://stories.geovanylaguerre.net" target="_blank" rel="noopener noreferrer">Geo's Stories</a>.</p>
  </li>
</ul>

For the concrete version of this story (dates, publications, technical skills), the [CV](/cv/) has that.

---

<span class="hero__section-label">Looking Forward</span>

## Where This Is Headed

This is not a finished trajectory. The next chapter is a PhD, and the questions I want to spend it on haven't changed; only the scale has. I'm looking for interdisciplinary collaboration at the intersection of scientific computing, artificial intelligence for science, healthcare analytics, environmental modelling, and decision support systems: places where rigorous mathematics has to meet a real, consequential decision.

I don't think of this as ambition for its own sake. I think of it as the natural next size of the same question I started with.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">PhD</li>
  <li class="hero__chip">Scientific Computing</li>
  <li class="hero__chip">AI for Science</li>
  <li class="hero__chip">Healthcare Analytics</li>
  <li class="hero__chip">Environmental Modelling</li>
  <li class="hero__chip">Decision Support</li>
</ul>

</div>

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(1.6rem, 3.4vw, 2.4rem); max-width: 34ch; margin-left: auto; margin-right: auto;">
      Science advances through collaboration.
    </p>
    <p class="hero__statement">
      If our research interests intersect, I would be delighted to exchange ideas.
    </p>
    <div class="hero__actions">
      <a href="/research/" class="btn btn--large">Research</a>
      <a href="/teaching/" class="btn btn--large btn--outline">Teaching</a>
      <a href="/research/contact/" class="btn btn--large btn--outline">Contact</a>
    </div>
  </div>
</section>
