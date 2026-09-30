---
lang: fr
ref: project-scientific-assistant
title: "Scientific Assistant"
excerpt: "Un cadre multi-agents qui fonctionne en local et associe mathématiques symboliques, méthodes numériques et analyse documentaire au service d'une recherche reproductible."
permalink: /projects/scientific-assistant/
redirect_from:
  - /portfolio/scientific-assistant/
status: "Développement en cours"
status_key: "Active"
domain: "Intelligence artificielle"
research_theme: "Intelligence artificielle"
technologies: ["Python", "Systèmes multi-agents", "RAG", "Calcul symbolique"]
github: "https://github.com/Geobatpo07/scientific-assistant"
last_updated: 2026-03-04
date: 2026-03-04
---

## Présentation

Un cadre d'IA multi-agents qui fonctionne en local et associe mathématiques symboliques, méthodes numériques et analyse documentaire augmentée par la recherche (RAG), pour soutenir des flux de travail de recherche scientifique reproductibles.

## Contexte scientifique

Les assistants d'IA généralistes sont pratiques mais opaques : on ne sait souvent pas comment ils sont parvenus à une réponse, et rien ne garantit qu'on pourra la reproduire plus tard. Le travail scientifique demande autre chose : un système qui aide aux calculs, aux expériences numériques et à la revue de littérature, mais dont le raisonnement reste inspectable et dont les résultats se reproduisent indépendamment d'une exécution particulière.

## Problématique

Un système multi-agents peut-il réunir raisonnement symbolique, calcul numérique et recherche bibliographique dans un même flux de travail, sans retomber dans l'opacité qui rend les outils d'IA généralistes inadaptés à une recherche rigoureuse ?

## Objectifs

- Séparer le raisonnement symbolique et numérique des composants fondés sur un modèle de langage, pour que chacun fasse ce qu'il fait de façon fiable.
- Rendre inspectables les étapes intermédiaires de chaque agent, au lieu de les cacher dans une réponse unique et opaque.
- Tout exécuter en local, pour que la reproductibilité ne dépende ni de la disponibilité ni de la version d'une API tierce.

## Méthodologie

Le cadre est organisé en agents coopérants aux responsabilités distinctes : un agent de calcul symbolique pour les dérivations exactes, un agent de méthodes numériques pour la simulation et le calcul, et un agent de génération augmentée par la recherche qui ancre les réponses dans de vrais documents sources plutôt que dans la seule mémoire du modèle. Une couche de coordination oriente chaque tâche vers l'agent (ou la suite d'agents) adapté au type de raisonnement qu'elle demande.

## Architecture

Chaque agent encapsule l'outil ou la bibliothèque adaptés à sa tâche (bibliothèques de calcul symbolique pour les mathématiques exactes, solveurs numériques pour la simulation, index documentaire pour la recherche) derrière une interface commune que le coordinateur peut appeler. Comme les agents sont modulaires, la trace d'exécution d'une tâche montre quel agent a traité quelle étape, au lieu d'une réponse unique et indifférenciée.

## Mise en œuvre

Tout exécuter en local était une contrainte délibérée, pas une simple commodité : une expérience lancée aujourd'hui donne le même résultat quand on la relance plus tard, même si la version du modèle d'une API externe change entre-temps. La recherche documentaire s'appuie sur un ensemble de sources indexées localement plutôt que sur une recherche web ouverte, ce qui garde traçable l'origine de toute affirmation retrouvée.

## Difficultés rencontrées

Le plus difficile a été de décider où tracer la frontière entre les agents : trop fine, et le coût de coordination dépasse le bénéfice ; trop grossière, et l'on revient à un système opaque unique, simplement organisé autrement. Obtenir un passage de relais propre entre les agents symbolique et numérique, pour qu'un résultat symbolique puisse être évalué numériquement sans étape de traduction manuelle, a demandé plusieurs itérations.

## Résultats

Le cadre permet aujourd'hui des flux de travail complets qui enchaînent une dérivation symbolique, l'évaluation numérique de cette dérivation et une étape de recherche pour la confronter aux sources, avec une trace inspectable de ce que chaque agent a fait. Il reste en développement actif et n'est pas un outil terminé.

## Enseignements

Pour un usage scientifique, une modularité qui rend le raisonnement d'un système inspectable vaut davantage qu'une capacité brute qui cache ses étapes. Concevoir l'agent de recherche pour qu'il cite des passages précis des sources, plutôt que de résumer librement, a rendu bien plus facile le repérage des réponses que les sources ne soutenaient qu'à moitié.

## Perspectives

Étendre le passage de relais entre symbolique et numérique à davantage de types de problèmes, et conserver un historique des exécutions passées pour comparer directement les résultats dans le temps, sont les prochaines priorités.
