---
lang: fr
ref: project-sentiment-analysis
title: "Pipeline d'analyse de sentiment"
excerpt: "Un pipeline de traitement automatique du langage pour classer automatiquement le sentiment de textes, conçu comme banc d'essai pour le prétraitement et la méthode d'évaluation."
permalink: /projects/sentiment-analysis/
redirect_from:
  - /portfolio/sentiment-analysis/
status: "Terminé"
status_key: "Completed"
domain: "Intelligence artificielle"
research_theme: "Apprentissage automatique"
technologies: ["Python", "TAL", "Scikit-learn"]
github: "https://github.com/Geobatpo07/sentiment-analysis"
last_updated: 2026-03-01
date: 2026-03-01
---

## Présentation

Un pipeline de traitement automatique du langage (TAL) qui classe des textes en sentiment positif, neutre ou négatif, conçu comme un exercice ciblé sur le prétraitement des textes, la représentation des caractéristiques et la méthode d'évaluation.

## Contexte scientifique

La classification de sentiment est un problème bien étudié, et c'est justement ce qui en fait un bon banc d'essai : la question de modélisation étant en grande partie réglée, on peut se montrer rigoureux sur ce qu'il est facile de bâcler (nettoyage des données, conception de l'évaluation, description honnête des cas où un modèle échoue) au lieu de ne publier qu'une précision globale.

## Problématique

Quelle part de la performance d'un classifieur de sentiment vient du modèle, et quelle part de la qualité du prétraitement et de la représentation des caractéristiques en amont ? Et où, précisément, un pipeline assez simple se trompe-t-il encore ?

## Objectifs

- Construire un pipeline complet, du texte brut au sentiment classé, en évaluant chaque étape séparément.
- Comparer plusieurs représentations des caractéristiques plutôt que d'en supposer une évidemment meilleure.
- Décrire les modes d'échec, et pas seulement la précision globale.

## Méthodologie

Le pipeline suit une structure classique (prétraitement, vectorisation, entraînement, évaluation), avec une attention particulière à chaque étape : les choix de normalisation du texte ont été testés pour leur effet sur la précision en aval plutôt qu'appliqués par défaut, et plusieurs méthodes de vectorisation ont été comparées avant d'en retenir une.

## Architecture

Le texte brut passe par une étape de prétraitement (normalisation, tokenisation, suppression du bruit), une étape de vectorisation qui convertit le texte nettoyé en caractéristiques numériques, puis une étape de classification qui attribue une étiquette de sentiment. Chaque étape est un composant séparé et interchangeable, ce qui a permis d'isoler simplement l'effet réel de chaque choix de prétraitement.

## Mise en œuvre

L'évaluation ne se résume pas à un seul chiffre de précision : matrices de confusion et performances par classe ont été utilisées tout au long du travail pour repérer les cas où un modèle semblait bon globalement mais restait systématiquement faible, par exemple sur les textes au sentiment neutre, en général la classe la plus difficile à bien classer.

## Difficultés rencontrées

Le sentiment neutre a toujours été la catégorie la plus difficile, à la fois pour le modèle et pour définir la vérité de référence : un texte étiqueté « neutre » par un humain est souvent réellement ambigu, ce qui plafonne la précision atteignable par n'importe quel modèle, indépendamment du modèle lui-même. Doser l'intensité du prétraitement a été une autre source de tension : un nettoyage plus agressif simplifiait l'entrée, mais supprimait parfois des indices utiles au sentiment.

## Résultats

Le pipeline sépare nettement les textes clairement positifs des textes clairement négatifs, avec la baisse de fiabilité attendue sur les cas neutres et ambigus. Son principal intérêt a été méthodologique : un pipeline de référence propre et bien évalué, plutôt qu'une contribution de modélisation nouvelle.

## Enseignements

Comparer explicitement les choix de prétraitement et de représentation, au lieu de s'en tenir aux habitudes, a fait apparaître de vraies différences de performance en aval qui seraient sinon passées inaperçues. C'est l'évaluation par classe, et non la seule précision globale, qui a réellement montré où le pipeline était faible.

## Perspectives

Étendre l'évaluation à des textes hors domaine (stylistiquement différents des données d'entraînement) serait l'étape la plus instructive, car c'est là que les choix de prétraitement et de caractéristiques pèsent le plus.
