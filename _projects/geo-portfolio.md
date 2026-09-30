---
lang: fr
ref: project-geo-portfolio
title: "Geo Portfolio"
excerpt: "Un site Next.js et TypeScript pour présenter des projets de data engineering, d'apprentissage automatique et de calcul scientifique."
permalink: /projects/geo-portfolio/
redirect_from:
  - /portfolio/geo-portfolio/
status: "Terminé"
status_key: "Completed"
domain: "Infrastructure de données scientifiques"
research_theme: "Infrastructure de données scientifiques"
technologies: ["Next.js", "TypeScript"]
github: "https://github.com/Geobatpo07/geo-portfolio"
last_updated: 2026-03-02
date: 2026-03-02
---

## Présentation

Un site Next.js et TypeScript conçu pour présenter des projets de data engineering, d'apprentissage automatique et de calcul scientifique dans une interface moderne et lisible : dans l'esprit, l'ancêtre de la bibliothèque de projets que vous lisez.

## Contexte scientifique

Bien présenter un travail technique fait partie du travail lui-même : un projet qu'on ne sait pas expliquer clairement à quelqu'un d'extérieur n'est pas vraiment terminé. Ce projet portait précisément sur cette couche de communication : à partir de vrais projets techniques, comment les présenter pour que leur fond reste lisible, sans l'enfouir sous le jargon ni, tout aussi mal, le simplifier en discours marketing ?

## Problématique

Comment construire une couche de présentation de projets techniques qui reste fidèle à leur complexité réelle, sans exiger du lecteur qu'il connaisse déjà le domaine ?

## Objectifs

- Présenter des projets de data engineering, d'apprentissage automatique et de calcul scientifique selon une structure cohérente et lisible.
- Utiliser une pile front-end moderne (Next.js, TypeScript) pour garder le site maintenable, et pas seulement comme vitrine technologique.
- Construire quelque chose d'assez réutilisable pour accueillir de nouveaux projets.

## Méthodologie

Le site a été construit à partir des composants : une structure commune de carte projet et de page de détail dans laquelle tout nouveau projet peut s'insérer, plutôt qu'une page sur mesure par projet. TypeScript a été utilisé partout pour garder le modèle de contenu (les champs dont un projet a besoin) explicite et vérifié, plutôt qu'implicite et facile à mal remplir.

## Architecture

Une application Next.js avec des modèles de contenu typés pour chaque projet, générée statiquement pour la performance, et une bibliothèque de composants partagée entre la liste des projets et les pages de chaque projet.

## Mise en œuvre

Un modèle de contenu typé signifiait qu'ajouter un projet faisait apparaître les champs manquants au moment du build, plutôt qu'une page silencieusement cassée en production : une petite discipline qui a payé à chaque nouveau projet.

## Difficultés rencontrées

La principale difficulté était de tenir le périmètre : un site personnel de ce type peut se peaufiner visuellement à l'infini sans jamais être fini, et le plus dur a été de décider quand la présentation était assez bonne pour arrêter d'itérer et commencer à s'en servir.

## Résultats

Le site a servi de support fonctionnel et maintenable pour présenter des projets techniques, et les enseignements de sa construction (en particulier sur les modèles de contenu typés et les gabarits réutilisables) se retrouvent directement dans la structure de la bibliothèque de projets et des études de cas du site actuel.

## Enseignements

Un modèle de contenu typé vaut son coût initial, même pour un petit site personnel, parce qu'il transforme « j'ai oublié un champ » en erreur de build plutôt qu'en bug silencieux. Concevoir pour la réutilisation dès le premier projet, et non au troisième, a accéléré chaque ajout suivant.

## Perspectives

Le rôle de ce projet est aujourd'hui repris par la bibliothèque de projets du site actuel : son principal intérêt restant est de servir de référence pour les modèles de composants qui l'ont façonné.
