---
lang: fr
ref: project-chlordecone
title: "Modélisation mathématique de la contamination au chlordécone"
excerpt: "Un modèle compartimental d'EDO de l'exposition saisonnière au chlordécone en Guadeloupe, publié en prépublication et déployé comme outil de simulation en ligne d'aide à la décision."
permalink: /projects/chlordecone/
redirect_from:
  - /portfolio/simulation-chlordecone/
status: "Recherche en cours"
status_key: "Active"
domain: "Modélisation environnementale"
research_theme: "Modélisation environnementale"
technologies: ["R", "Shiny", "Systèmes d'EDO", "Modélisation compartimentale"]
github: "https://github.com/Geobatpo07/simulation-chlordecone"
docs: "https://doi.org/10.13140/RG.2.2.36238.01607"
docs_label: "Voir la notice DOI"
demo: "https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/"
demo_label: "Lancer l'application de simulation"
last_updated: 2026-03-06
date: 2026-03-06
---

## Présentation

Un modèle compartimental d'EDO non autonome de la contamination chronique au chlordécone dans les sols et les chaînes alimentaires tropicales, associé à un outil Shiny interactif pour explorer des scénarios d'exposition saisonnière. Le travail est publié en prépublication, [Modélisation de l'exposition humaine au chlordécone](https://doi.org/10.13140/RG.2.2.36238.01607), et déployé publiquement sous la forme d'une [application de simulation en ligne](https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/), pour que le modèle puisse être exploré directement plutôt que cru sur parole.

## Contexte scientifique

Le chlordécone est un pesticide organochloré persistant utilisé dans les bananeraies de Guadeloupe jusqu'au début des années 1990. Des décennies plus tard, il reste présent dans les sols et passe par la chaîne alimentaire dans l'eau et les produits cultivés localement : l'exposition chronique à faible dose est un enjeu de santé publique actuel, pas seulement historique. Comprendre comment la contamination circule dans l'environnement au fil du temps (et pas seulement sa quantité à un instant donné) est ce qui a motivé une approche par la modélisation.

## Problématique

Les évaluations de risque existantes traitent souvent la contamination comme à peu près constante, ce qui sous-estime la variation de l'exposition selon les pluies et les saisons. La question traitée ici : un modèle mathématique peut-il capter cette variabilité saisonnière avec assez de précision pour aider à fixer ou à discuter des seuils de santé publique, sans devenir si complexe que ses hypothèses soient impossibles à expliquer ou à examiner ?

## Objectifs

- Représenter les voies de transfert dans l'environnement (sol &rarr; eau &rarr; chaîne alimentaire &rarr; exposition humaine) sous la forme d'un système compartimental couplé.
- Introduire dans le modèle un forçage saisonnier piloté par les pluies, au lieu de taux de transfert fixes.
- Rendre visibles et explorables les hypothèses et la sensibilité du modèle, et pas seulement ses résultats.
- Permettre d'explorer le modèle directement, et pas seulement de le décrire dans un article.

## Méthodologie

Le système est formulé comme un système non autonome d'équations différentielles ordinaires, dont les coefficients dépendant du temps représentent les transferts entre compartiments pilotés par les pluies. Des solutions numériques sont calculées pour une série de scénarios saisonniers, et les trajectoires d'exposition obtenues sont comparées aux attentes qualitatives de la littérature environnementale, pour vérifier la cohérence du comportement du modèle.

## Architecture

Le cœur de simulation est écrit en R : un ensemble de définitions de compartiments et de fonctions de taux de transfert qu'un solveur numérique d'EDO intègre dans le temps. Une application R Shiny s'appuie sur ce cœur et expose les paramètres du modèle (intensité des pluies, calendrier saisonnier, taux de transfert) sous forme de commandes interactives : un scénario peut être ajusté et relancé sans toucher au code. Cette application Shiny est déployée publiquement sur shinyapps.io, si bien que l'outil sert à la fois d'instrument de recherche et d'interface d'aide à la décision que chacun peut ouvrir.

## Mise en œuvre

Séparer le cœur de simulation de la couche interactive était un choix délibéré : l'application Shiny appelle les mêmes fonctions de modélisation qu'un script en ligne de commande, si bien que l'outil interactif ne peut jamais s'écarter silencieusement du modèle. Le forçage saisonnier est implémenté par des fonctions périodiques continues plutôt que par des paliers, ce qui reflète mieux la variation réelle des transferts liés aux pluies et évite d'introduire des discontinuités artificielles dans la solution numérique. Préparer l'application pour un déploiement public a demandé de distinguer nettement ce qui ne devait tourner qu'en local de ce qui devait tourner de façon fiable sur un serveur hébergé, sans affaiblir la garantie que l'application déployée et le modèle restent synchronisés.

## Difficultés rencontrées

La principale difficulté technique était numérique : les systèmes non autonomes à forçage périodique sont plus sensibles au choix du solveur et du pas de temps que les systèmes autonomes, et une configuration instable peut produire des trajectoires plausibles en apparence mais qui ne reflètent pas la dynamique réelle. Une seconde difficulté, moins technique, tenait au périmètre : un modèle environnemental de ce type peut s'étendre indéfiniment (plus de compartiments, plus de voies de transfert), et une partie du travail a consisté à décider quelles simplifications étaient honnêtes et lesquelles auraient changé en silence la question posée.

## Résultats

Le modèle produit des trajectoires d'exposition qui suivent la variation saisonnière liée aux pluies, au lieu des estimations plates qu'un modèle statique donnerait : c'était l'objet même du travail. L'interface Shiny permet d'explorer la sensibilité des estimations d'exposition à chaque hypothèse saisonnière, ce qui est en soi un résultat utile : on voit où les conclusions du modèle sont robustes et où elles dépendent fortement d'un paramètre précis.

Ce travail a donné deux résultats concrets. L'approche de modélisation et ses résultats sont décrits dans une prépublication, [Modélisation de l'exposition humaine au chlordécone](https://doi.org/10.13140/RG.2.2.36238.01607), pour qui veut le développement mathématique complet. Le modèle lui-même est déployé sous la forme d'une [application de simulation publique](https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/), pour explorer les scénarios d'exposition saisonnière de façon interactive plutôt que d'en lire le compte rendu.

## Enseignements

Un modèle n'a pas besoin d'être plus complexe pour être plus honnête : le forçage saisonnier a apporté une vraie valeur explicative, alors que plusieurs autres extensions envisagées auraient ajouté de la complexité sans changer les conclusions. Construire la couche interactive en même temps que le cœur du modèle, et non après, a aussi permis de repérer bien plus facilement un paramètre « raisonnable en apparence » qui produisait un résultat invraisemblable. Publier la prépublication et déployer l'application comme deux résultats distincts, plutôt que de considérer l'article comme le seul vrai livrable, a également changé la façon dont le modèle a été mis à l'épreuve : une interface que chacun peut ouvrir appelle un examen qu'un document statique n'appelle pas.

## Perspectives

Étendre le modèle à la quantification de l'incertitude (en traitant les principaux taux de transfert comme des distributions plutôt que comme des valeurs ponctuelles) est la prochaine étape la plus utile : le modèle pourrait alors donner une fourchette de niveaux d'exposition plausibles plutôt qu'une trajectoire unique. Valider le comportement qualitatif du modèle sur les données de mesure de terrain disponibles, quand elles sont accessibles, est l'autre priorité.
