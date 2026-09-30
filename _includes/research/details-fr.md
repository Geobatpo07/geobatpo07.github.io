{% comment %}
  Long-form research content in French, shown on /research/ after the
  generated track sections. The English version is details-en.md.
{% endcomment %}
{% assign t = site.data.i18n.fr %}
<div class="page-prose" markdown="1">

Je cherche à comprendre des systèmes complexes au moyen de modèles mathématiques, de méthodes de calcul et d'algorithmes intelligents. Que l'application porte sur la dynamique de l'environnement, la santé ou l'infrastructure de données scientifiques, le défi scientifique reste le même : construire des modèles mathématiquement rigoureux, fiables sur le plan numérique et utiles à la décision. Tout ce qui suit découle de ce défi.

---

<span class="hero__section-label">Le cœur</span>

## Questions de recherche

Je n'organise pas mon travail d'abord autour de projets. Les projets existent à cause de ces questions.

<ul class="research-grid">
  <li class="research-card">
    <h3 class="research-card__title">Comment les modèles mathématiques peuvent-ils mieux représenter des systèmes environnementaux complexes ?</h3>
    <p class="research-card__desc">Forçage saisonnier, effets différés et mesures incomplètes rendent les systèmes environnementaux rétifs aux modèles simples. Je m'intéresse à la part de structure qu'une approche compartimentale peut capter avant de devoir se complexifier.</p>
    <p class="research-card__project">Liens : <span>Modélisation mathématique · Modélisation environnementale</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Comment le calcul scientifique peut-il rendre les simulations numériques plus fiables ?</h3>
    <p class="research-card__desc">Une simulation n'est fiable que si le schéma qui la produit est stable. J'étudie comment les choix de discrétisation (différences finies, splitting d'opérateurs) décident si un résultat reflète la physique ou seulement des artefacts numériques.</p>
    <p class="research-card__project">Liens : <span>Calcul scientifique · Analyse numérique</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Comment l'intelligence artificielle peut-elle soutenir la découverte scientifique tout en restant transparente et reproductible ?</h3>
    <p class="research-card__desc">L'apprentissage automatique peut trouver des structures que je ne spécifierais pas à la main, mais seulement s'il reste assez interprétable pour être validé. Je m'intéresse aux architectures qui associent raisonnement symbolique et composants appris sans perdre cette transparence.</p>
    <p class="research-card__project">Liens : <span>Intelligence artificielle · Apprentissage automatique</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Comment les infrastructures de données peuvent-elles améliorer la reproductibilité de la recherche numérique ?</h3>
    <p class="research-card__desc">La plupart des plateformes de données sont conçues pour l'échelle d'une entreprise. Je m'intéresse à ce qui change quand la reproductibilité, et non le débit, devient la contrainte de conception principale.</p>
    <p class="research-card__project">Liens : <span>Infrastructure de données scientifiques</span></p>
  </li>
  <li class="research-card">
    <h3 class="research-card__title">Comment la modélisation mathématique peut-elle contribuer à l'aide à la décision en santé ?</h3>
    <p class="research-card__desc">Un modèle qui éclaire une décision de santé porte une charge de la preuve différente de celle d'un modèle qui n'en éclaire aucune. Je m'intéresse à des outils d'aide à la décision assez précis pour être utiles et assez honnêtes pour être discutés.</p>
    <p class="research-card__project">Liens : <span>Analytique de santé · Biostatistique</span></p>
  </li>
</ul>

---

<span class="hero__section-label">Le vocabulaire</span>

## Thèmes de recherche

Dix points de vue sur un même problème, et non une liste de compétences.

<ul class="research-grid">
  {% for theme in site.data.researchThemes %}
  <li class="research-card">
    <h3 class="research-card__title">{{ theme.title.fr }}</h3>
    <p class="research-card__desc"><strong>Pourquoi c'est important.</strong> {{ theme.why.fr }}</p>
    <p class="research-card__desc"><strong>Défi scientifique.</strong> {{ theme.challenge.fr }}</p>
    <p class="research-card__desc"><strong>Application actuelle.</strong> {{ theme.application.fr }}</p>
    <p class="research-card__project">{{ theme.connection.fr }}</p>
  </li>
  {% endfor %}
</ul>

---

<span class="hero__section-label">Équilibre interdisciplinaire</span>

## Profil scientifique

À lire moins comme un inventaire de compétences que comme une carte d'équilibre. Chaque axe dépend des autres : la modélisation mathématique vaut peu sans le calcul pour la mettre à l'épreuve, et le calcul vaut peu sans le socle statistique qui permet de se fier à ses résultats.

{% include chart.html id="radarChart" height="480px" data=site.data.radar.fr %}

---

<span class="hero__section-label">Méthode</span>

## Cadre de recherche

Comment une question devient, en général, une réponse.

<ol class="scientific-timeline">
  <li><span class="scientific-timeline__label">Question scientifique</span></li>
  <li><span class="scientific-timeline__label">Modèle mathématique</span></li>
  <li><span class="scientific-timeline__label">Méthode numérique</span></li>
  <li><span class="scientific-timeline__label">Calcul scientifique</span></li>
  <li><span class="scientific-timeline__label">Données</span></li>
  <li><span class="scientific-timeline__label">Apprentissage automatique</span></li>
  <li><span class="scientific-timeline__label">Validation</span></li>
  <li><span class="scientific-timeline__label">Aide à la décision</span></li>
</ol>

---

<span class="hero__section-label">Les preuves</span>

## Travaux de recherche

Les publications sont un résultat de recherche parmi d'autres, aux côtés des logiciels, des notes techniques et des projets ci-dessus.

{% if site.author.googlescholar %}
<p>Mes articles sont aussi référencés sur <a href="{{ site.author.googlescholar }}" target="_blank" rel="noopener noreferrer">mon profil Google Scholar</a>.</p>
{% endif %}

{% include base_path %}
{% assign publications_sorted = site.publications | where: "lang", "fr" | sort: 'date' | reverse %}

{% if site.publication_category %}
  {% for category in site.publication_category %}
    {% assign title_shown = false %}
    {% assign category_title = t.publication_categories[category[0]] | default: category[1].title %}

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
<h3>{{ category_title }}</h3>
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
<h3>{{ category_title }}</h3>
        {% assign title_shown = true %}
      {% endunless %}
      {% include archive-single.html %}
    {% endfor %}
  {% endfor %}
{% endif %}

---

<span class="hero__section-label">Engagements</span>

## Science ouverte

Aucun de ces travaux n'est crédible à mes yeux s'il ne peut pas être vérifié. Cela veut dire du code qui tourne chez d'autres que moi, des méthodes assez documentées pour être contestées, et des résultats qui ne dépendent pas d'une machine particulière pour être reproduits. GitHub héberge le code et les notes techniques ; <a href="https://stories.geovanylaguerre.net" target="_blank" rel="noopener noreferrer">Geo's Stories</a> garde la trace, moins formelle, de la façon dont les idées se sont réellement construites.

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">Gestion de versions</li>
  <li class="hero__chip">Open source</li>
  <li class="hero__chip">Pipelines reproductibles</li>
  <li class="hero__chip">Méthodes documentées</li>
  <li class="hero__chip">Notes techniques publiques</li>
</ul>

---

<span class="hero__section-label">Des directions, pas des promesses</span>

## Recherches à venir

<ul class="hero__eyebrow" style="margin: 1.5rem 0;">
  <li class="hero__chip">IA pour la science</li>
  <li class="hero__chip">Apprentissage automatique scientifique</li>
  <li class="hero__chip">Mathématiques de l'environnement</li>
  <li class="hero__chip">Analytique de santé</li>
  <li class="hero__chip">Biologie computationnelle</li>
  <li class="hero__chip">Systèmes d'aide à la décision</li>
  <li class="hero__chip">Santé numérique</li>
  <li class="hero__chip">Épidémiologie mathématique</li>
</ul>

Ce sont des directions dans lesquelles je veux grandir, pas des résultats que je revendique. Le fil qui m'a mené jusqu'ici (à lire sur la page [Mon parcours scientifique](/about/)) est le même qui pointe vers elles.

</div>
