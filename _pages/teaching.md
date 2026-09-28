---
lang: fr
ref: teaching
space: research
layout: single
permalink: /teaching/
title: "Enseignement"
description: "Philosophie et approche de l'enseignement des mathématiques, du calcul scientifique, de l'IA et de la data science, des bases de licence à l'encadrement de recherche en master."
full_width: true
author_profile: false
---

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(2rem, 4.5vw, 3.4rem); margin-bottom: 0.75rem;">Enseignement</p>
    <p class="hero__statement">
      Aider étudiants et professionnels à acquérir des bases solides en mathématiques, en calcul scientifique, en intelligence artificielle et en data science.
    </p>
    <p class="hero__why">
      Je crois que la compréhension passe toujours avant la mise en œuvre : une méthode qu'on ne sait pas expliquer est une méthode qu'on ne maîtrise pas encore.
    </p>
  </div>
</section>

<div class="page-prose" markdown="1" style="max-width: 1100px; margin: 0 auto; padding: 0 1.5rem 3rem;">

<span class="hero__section-label">Ma façon de voir</span>

## Philosophie d'enseignement

Je ne sépare pas l'enseignement de la recherche : bien expliquer une méthode révèle souvent si je la comprends vraiment. Quelques convictions sur lesquelles j'essaie de ne pas transiger :

**Comprendre avant d'appliquer.** Je préfère qu'un étudiant passe une séance de plus à comprendre *pourquoi* une méthode fonctionne plutôt qu'il en mémorise les étapes. La syntaxe et les formules s'oublient ; le raisonnement se transpose.

**La curiosité est le vrai prérequis.** Ni le talent ni le bagage préalable : la volonté de demander « pourquoi ça marche » plutôt que d'accepter une règle. J'essaie de protéger cette curiosité plutôt que de l'éteindre à coups de procédures apprises par cœur.

**Une complexité progressive.** Chaque matière que j'enseigne suit le même arc : d'abord construire l'intuition, ensuite la formaliser, et seulement après ajouter la complexité technique. Commencer par le formalisme est efficace pour moi et déroutant pour presque tout le monde.

**L'esprit critique avant la bonne réponse.** Un étudiant capable d'expliquer pourquoi une réponse fausse est fausse a appris davantage qu'un étudiant qui a deviné la bonne. Je préfère évaluer le raisonnement plutôt que le résultat.

---

<span class="hero__section-label">Comment chaque matière est enseignée</span>

## Cadre d'apprentissage

Chaque matière que j'enseigne suit la même progression, quel que soit le sujet :

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Comprendre</span></li>
  <li><span class="scientific-timeline__label">Modéliser</span></li>
  <li><span class="scientific-timeline__label">Implémenter</span></li>
  <li><span class="scientific-timeline__label">Expérimenter</span></li>
  <li><span class="scientific-timeline__label">Interpréter</span></li>
  <li><span class="scientific-timeline__label">Communiquer</span></li>
</ol>

À chaque étape, l'objectif est de construire l'intuition avant la complexité technique : non pas éviter la complexité, mais la mériter.

---

<span class="hero__section-label">Ce que j'enseigne</span>

## Matières enseignées

Regroupées en ensembles cohérents plutôt qu'en sujets isolés, chacune ancrée dans une vraie expérience d'enseignement ou professionnelle.

<ul class="research-grid">
  {% for subject in site.data.teachingSubjects %}
  <li class="research-card">
    <h3 class="research-card__title">{{ subject.title[page.lang] }}</h3>
    <p class="research-card__desc">{{ subject.description[page.lang] }}</p>
    <p class="case-study__meta-item">{{ subject.level[page.lang] }} &middot; {{ subject.audience[page.lang] }}</p>
    <p class="research-card__project">Applications : <span>{{ subject.applications[page.lang] }}</span></p>
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Adapté, pas uniforme</span>

## À qui j'enseigne

L'enseignement s'adapte aux objectifs et au parcours de chacun, au lieu d'être délivré de la même façon quel que soit le public.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Étudiants de licence</li>
  <li class="hero__chip">Étudiants de master</li>
  <li class="hero__chip">Candidats au doctorat</li>
  <li class="hero__chip">Chercheurs</li>
  <li class="hero__chip">Professionnels</li>
  <li class="hero__chip">Personnes en reconversion</li>
  <li class="hero__chip">Lycéens</li>
</ul>

---

<span class="hero__section-label">Pas un cours magistral passif</span>

## Déroulé des séances

Une séance repose sur une participation active :

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">Explication des concepts</h3>
    <p class="research-card__desc">Construire l'intuition avant le formalisme.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Exemples commentés</h3>
    <p class="research-card__desc">Voir la méthode appliquée avant de l'appliquer soi-même.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Mise en pratique</h3>
    <p class="research-card__desc">Écrire le code ou dérouler la preuve, pas seulement regarder.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Exercices</h3>
    <p class="research-card__desc">Un entraînement délibéré sur des problèmes choisis pour révéler les lacunes, pas pour confirmer la maîtrise.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Discussion</h3>
    <p class="research-card__desc">Expliquer son raisonnement à voix haute, là où apparaissent les vraies lacunes.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Révision</h3>
    <p class="research-card__desc">Revenir honnêtement sur ce qui n'a pas été retenu la première fois.</p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Applications concrètes</h3>
    <p class="research-card__desc">Relier la méthode à un problème qui mérite d'être résolu.</p>
  </li>
</ul>

---

<span class="hero__section-label">Au-delà de la séance</span>

## Ressources pédagogiques

Des supports que je conçois et partage pour prolonger l'apprentissage au-delà de la séance : une collection qui s'enrichit, pas un ensemble figé.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Notes de cours</li>
  <li class="hero__chip">Notebooks de programmation</li>
  <li class="hero__chip">Démonstrations interactives</li>
  <li class="hero__chip">Diaporamas</li>
  <li class="hero__chip">Dépôts GitHub</li>
  <li class="hero__chip">Articles scientifiques</li>
  <li class="hero__chip">Tutoriels</li>
  <li class="hero__chip">Exercices</li>
  <li class="hero__chip">Suggestions de lecture</li>
  <li class="hero__chip">Cours en vidéo (prévus)</li>
</ul>

---

<span class="hero__section-label">Au-delà de la salle de classe</span>

## Encadrement

L'encadrement est la part la plus personnelle de l'enseignement : il porte moins sur une matière que sur la prochaine étape d'une personne précise. L'objectif reste toujours l'autonomie scientifique : aider quelqu'un à atteindre le point où il n'a plus besoin de moi pour vérifier son raisonnement.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Méthodologie de recherche</li>
  <li class="hero__chip">Écriture scientifique</li>
  <li class="hero__chip">Projets de data science</li>
  <li class="hero__chip">Programmation</li>
  <li class="hero__chip">Modélisation mathématique</li>
  <li class="hero__chip">Apprentissage automatique</li>
  <li class="hero__chip">Orientation professionnelle</li>
  <li class="hero__chip">Préparation aux études doctorales</li>
  <li class="hero__chip">Stages de recherche</li>
</ul>

---

<span class="hero__section-label">Un cycle, pas une suite</span>

## Enseignement et recherche

La recherche produit de nouvelles connaissances. Les projets transforment les idées en solutions concrètes. L'enseignement rend les deux accessibles, et bien enseigner une notion fait régulièrement surgir la prochaine question qui mérite d'être étudiée.

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Recherche</span></li>
  <li><span class="scientific-timeline__label">Projets</span></li>
  <li><span class="scientific-timeline__label">Enseignement</span></li>
  <li><span class="scientific-timeline__label">Nouvelles questions</span></li>
</ol>

---

<span class="hero__section-label">Les faits</span>

## Où j'ai enseigné

{% include base_path %}
{% assign teaching_items = site.teaching | where: "lang", page.lang %}
{% for post in teaching_items reversed %}
  {% include archive-single.html %}
{% endfor %}

---

<span class="hero__section-label">Leurs mots</span>

## Témoignages

{% if site.data.testimonials.size > 0 %}
<ul class="research-grid">
  {% for t in site.data.testimonials %}
  <li class="research-card">
    <p class="research-card__desc">&laquo;&nbsp;{{ t.quote }}&nbsp;&raquo;</p>
    <p class="research-card__project">{{ t.name }}<span> &middot; {{ t.role }}</span></p>
  </li>
  {% endfor %}
</ul>
{% else %}
<div class="rdv-panel">
  <p class="rdv-subtitle">Les témoignages d'étudiants et de collaborateurs apparaîtront ici au fil de cette pratique d'enseignement. Si nous avons travaillé ensemble, votre retour me fera plaisir.</p>
  <p><a href="/feedback/" class="btn btn--outline">Donner mon avis</a></p>
</div>
{% endif %}

</div>

<section class="hero hero--centered reveal">
  <div class="hero__content">
    <p class="hero__name" style="font-size: clamp(1.8rem, 3.8vw, 2.6rem); margin-bottom: 0.75rem;">Réserver une séance</p>
    <p class="hero__statement">
      Cours particuliers, encadrement de recherche, accompagnement académique, mentorat en data science, orientation professionnelle ou préparation aux entretiens.
    </p>
    <div class="hero__actions">
      <a href="/research/contact/" class="btn btn--large">Réserver via Calendly</a>
      <a href="https://www.linkedin.com/in/geobatpo07" target="_blank" rel="noopener noreferrer" class="btn btn--large btn--outline">Écrire sur LinkedIn</a>
    </div>
  </div>
</section>
