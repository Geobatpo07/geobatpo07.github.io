---
lang: en
space: research
layout: single
permalink: /teaching/
title: "Teaching"
description: "Teaching philosophy and approach to mathematics, scientific computing, AI, and data science education, from undergraduate foundations to graduate research mentoring."
full_width: true
author_profile: false
---

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(2rem, 4.5vw, 3.4rem); margin-bottom: 0.75rem;">Teaching</p>
    <p class="hero__statement">
      Helping students and professionals build strong foundations in mathematics, scientific computing, artificial intelligence, and data science.
    </p>
    <p class="hero__why">
      I believe understanding always comes before implementation: a method you can't explain is a method you don't yet own.
    </p>
  </div>
</section>

<div class="page-prose" markdown="1" style="max-width: 1100px; margin: 0 auto; padding: 0 1.5rem 3rem;">

<span class="hero__section-label">How I Think About It</span>

## Teaching Philosophy

I don't think of teaching and research as separate activities: explaining a method well is often what reveals whether I actually understand it. A few convictions I try not to compromise on:

**Understanding before implementation.** I would rather a student spend an extra session understanding *why* a method works than memorize the steps to use it. Syntax and formulas fade; reasoning transfers.

**Curiosity is the actual prerequisite.** Not talent, not prior background: the willingness to ask "why does this work" instead of accepting a rule. I try to protect that curiosity rather than train it out of students with rote procedure.

**Progressive complexity.** Every subject I teach follows the same arc: build intuition first, formalize it second, and only then layer on technical complexity. Starting with the formalism is efficient for me and confusing for almost everyone else.

**Critical thinking over correct answers.** A student who can explain why a wrong answer is wrong has learned more than one who guessed the right one. I'd rather grade reasoning than outcomes.

---

<span class="hero__section-label">How Every Subject Is Taught</span>

## Learning Framework

Every subject I teach follows the same progression, regardless of topic:

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Understand</span></li>
  <li><span class="scientific-timeline__label">Model</span></li>
  <li><span class="scientific-timeline__label">Implement</span></li>
  <li><span class="scientific-timeline__label">Experiment</span></li>
  <li><span class="scientific-timeline__label">Interpret</span></li>
  <li><span class="scientific-timeline__label">Communicate</span></li>
</ol>

The goal at each stage is to build intuition before technical complexity, not to skip the complexity, but to earn it.

---

<span class="hero__section-label">What I Teach</span>

## Subjects I Teach

Grouped into coherent units rather than isolated topics, each grounded in real teaching or professional experience.

<ul class="research-grid">
  {% for subject in site.data.teachingSubjects %}
  <li class="research-card">
    <h3 class="research-card__title">{{ subject.title }}</h3>
    <p class="research-card__desc">{{ subject.description }}</p>
    <p class="case-study__meta-item">{{ subject.level }} &middot; {{ subject.audience }}</p>
    <p class="research-card__project">Applications: <span>{{ subject.applications }}</span></p>
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Adapted, Not Uniform</span>

## Who I Teach

Teaching is adapted to each learner's objectives and background, not delivered the same way regardless of audience.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Undergraduate Students</li>
  <li class="hero__chip">Master's Students</li>
  <li class="hero__chip">PhD Applicants</li>
  <li class="hero__chip">Researchers</li>
  <li class="hero__chip">Professionals</li>
  <li class="hero__chip">Career Changers</li>
  <li class="hero__chip">High-School Students</li>
</ul>

---

<span class="hero__section-label">Not a Passive Lecture</span>

## Learning Experience

A session is built around active participation:

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">Conceptual Explanation</h3>
    <p class="research-card__desc">Building the intuition before the formalism.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Worked Examples</h3>
    <p class="research-card__desc">Seeing the method applied before applying it yourself.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Hands-on Implementation</h3>
    <p class="research-card__desc">Writing the code or working the proof, not watching it.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Exercises</h3>
    <p class="research-card__desc">Deliberate practice on problems chosen to expose gaps, not confirm mastery.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Discussion</h3>
    <p class="research-card__desc">Explaining your reasoning out loud, where the actual gaps in understanding surface.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Review</h3>
    <p class="research-card__desc">Revisiting what didn't stick the first time, honestly.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Real-World Applications</h3>
    <p class="research-card__desc">Connecting the method back to a problem worth solving.</p>
  </li>
</ul>

---

<span class="hero__section-label">Beyond the Session</span>

## Educational Resources

Materials I develop and share to support learning beyond the session itself, an ongoing collection, not a fixed set:

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Lecture Notes</li>
  <li class="hero__chip">Programming Notebooks</li>
  <li class="hero__chip">Interactive Demonstrations</li>
  <li class="hero__chip">Slides</li>
  <li class="hero__chip">GitHub Repositories</li>
  <li class="hero__chip">Scientific Articles</li>
  <li class="hero__chip">Tutorials</li>
  <li class="hero__chip">Exercises</li>
  <li class="hero__chip">Reading Recommendations</li>
  <li class="hero__chip">Video Lectures (Planned)</li>
</ul>

---

<span class="hero__section-label">Beyond the Classroom</span>

## Mentoring

Mentoring is where teaching gets personal: less about a subject, more about a specific person's next step. The focus is always on building scientific autonomy: helping someone reach the point where they no longer need me to check their reasoning.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Research Methodology</li>
  <li class="hero__chip">Scientific Writing</li>
  <li class="hero__chip">Data Science Projects</li>
  <li class="hero__chip">Programming</li>
  <li class="hero__chip">Mathematical Modelling</li>
  <li class="hero__chip">Machine Learning</li>
  <li class="hero__chip">Career Guidance</li>
  <li class="hero__chip">Graduate School Preparation</li>
  <li class="hero__chip">Research Internships</li>
</ul>

---

<span class="hero__section-label">A Cycle, Not a Sequence</span>

## Teaching & Research

Research generates new knowledge. Projects transform ideas into practical solutions. Teaching makes both accessible, and teaching a concept well routinely surfaces the next question worth researching.

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Research</span></li>
  <li><span class="scientific-timeline__label">Projects</span></li>
  <li><span class="scientific-timeline__label">Teaching</span></li>
  <li><span class="scientific-timeline__label">New Questions</span></li>
</ol>

---

<span class="hero__section-label">The Concrete Record</span>

## Where I've Taught

{% include base_path %}
{% for post in site.teaching reversed %}
  {% include archive-single.html %}
{% endfor %}

---

<span class="hero__section-label">In Their Words</span>

## Testimonials

{% if site.data.testimonials.size > 0 %}
<ul class="research-grid">
  {% for t in site.data.testimonials %}
  <li class="research-card">
    <p class="research-card__desc">&ldquo;{{ t.quote }}&rdquo;</p>
    <p class="research-card__project">{{ t.name }}<span> &middot; {{ t.role }}</span></p>
  </li>
  {% endfor %}
</ul>
{% else %}
<div class="rdv-panel">
  <p class="rdv-subtitle">Testimonials from students and collaborators will appear here as this teaching practice grows. If we've worked together, I'd welcome hearing from you.</p>
  <p><a href="/feedback/" class="btn btn--outline">Share Feedback</a></p>
</div>
{% endif %}

</div>

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(1.8rem, 3.8vw, 2.6rem); margin-bottom: 0.75rem;">Book a Session</p>
    <p class="hero__statement">
      Private tutoring, research mentoring, academic coaching, data science mentoring, career guidance, or interview preparation.
    </p>
    <div class="hero__actions">
      <a href="/en/research/contact/" class="btn btn--large">Schedule via Calendly</a>
      <a href="https://www.linkedin.com/in/geobatpo07" target="_blank" rel="noopener noreferrer" class="btn btn--large btn--outline">Message on LinkedIn</a>
    </div>
  </div>
</section>
