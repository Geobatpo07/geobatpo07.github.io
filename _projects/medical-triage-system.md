---
lang: fr
ref: project-medical-triage-system
title: "Medical Triage System"
excerpt: "Un outil d'aide à la décision en C++ qui s'appuie sur un modèle Random Forest pour aider à prioriser les patients au pré-triage en contexte d'urgence."
permalink: /projects/medical-triage-system/
redirect_from:
  - /portfolio/medical-triage-system/
status: "Prototype terminé"
status_key: "Prototype"
domain: "Analytique de santé"
research_theme: "Analytique de santé"
technologies: ["C++", "Random Forest", "Python"]
github: "https://github.com/Geobatpo07/MedicalTriageSystem"
last_updated: 2026-03-03
date: 2026-03-03
---

## Présentation

Une application C++ qui utilise un modèle Random Forest, entraîné en Python, pour aider à prioriser les patients au pré-triage en contexte d'urgence : un outil d'aide à la décision, pas un outil de diagnostic.

## Contexte scientifique

Dans les services d'urgence et les contextes aux ressources limitées, l'ordre dans lequel les patients sont vus compte autant que les soins eux-mêmes. Les décisions de triage se prennent en général vite et sous pression : c'est précisément là qu'un second avis rapide et interprétable peut aider, à condition d'être assez transparent pour que le personnel soignant puisse s'y fier ou passer outre, plutôt qu'une boîte noire à suivre aveuglément.

## Problématique

Un modèle léger peut-il fournir un signal de risque utile au pré-triage, assez vite pour servir en contexte d'urgence, tout en restant assez interprétable pour qu'un clinicien voie pourquoi il l'a produit et puisse le contredire quand c'est justifié ?

## Objectifs

- Produire un score de priorisation à partir des données du patient assez vite pour servir à l'accueil.
- Garder un modèle interprétable, sans faire de la précision la seule mesure qui compte.
- Séparer l'entraînement du modèle (Python) de l'application d'aide à la décision déployée (C++), pour que l'outil reste rapide et léger en dépendances.

## Méthodologie

Un classifieur Random Forest a été entraîné en Python sur les données d'accueil des patients pour produire un score de priorisation. Ce choix tient à sa structure de décision (un ensemble d'arbres relativement peu profonds), plus facile à inspecter et à expliquer que des modèles plus profonds ou moins structurés : c'est ici plus important que de gagner quelques points de précision.

## Architecture

Le modèle entraîné est exporté puis intégré dans une application C++ qui gère la logique d'aide à la décision à l'exécution, sans dépendre d'un environnement Python. La couche C++ gère la validation des entrées et la présentation du score ; le modèle reste un artefact séparé et versionné, qu'on peut réentraîner et remplacer sans toucher au code de l'application.

## Mise en œuvre

Séparer ainsi l'entraînement du déploiement a permis de garder une application petite et rapide, tout en faisant évoluer le modèle de façon indépendante avec toute la chaîne d'outils data science de Python. La validation des entrées a été traitée avec autant de sérieux que le modèle : une réponse rapide et fausse est pire qu'une réponse rapide et honnête du type « données insuffisantes ».

## Difficultés rencontrées

La principale tension opposait complexité du modèle et interprétabilité : des modèles plus complexes offraient des gains de précision marginaux, mais rendaient plus difficile d'expliquer pourquoi un patient recevait tel score, ce qui comptait davantage ici que le gain de précision. Porter proprement un modèle entraîné en Python dans un environnement C++, sans modifier silencieusement son comportement, a aussi demandé une grande attention à la façon dont sa logique de décision était sérialisée et reproduite.

## Résultats

Le prototype produit des scores de priorisation avec un chemin de décision inspectable, conformément à l'objectif d'un outil que les cliniciens peuvent questionner plutôt que suivre aveuglément. En tant que prototype, il n'a été ni déployé ni validé en situation clinique réelle.

## Enseignements

Pour les outils d'aide à la décision dans des contextes à fort enjeu, l'interprétabilité n'est pas une qualité secondaire : c'est presque l'exigence principale, et il vaut la peine de choisir l'architecture du modèle en fonction d'elle plutôt que d'optimiser d'abord la précision et d'expliquer le résultat ensuite. Garder le modèle et l'application comme deux artefacts séparés et versionnés indépendamment a nettement facilité les itérations.

## Perspectives

Toute évolution vers un usage clinique réel exigerait une validation formelle sur des résultats réels et une approche bien plus rigoureuse des biais et de l'équité dans les données d'entraînement qu'un prototype n'en demande : c'est ce travail de validation, et non de nouvelles fonctionnalités, qui constitue la vraie prochaine étape.
