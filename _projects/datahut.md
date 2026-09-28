---
lang: fr
ref: project-datahut
title: "DataHut-DuckHouse"
excerpt: "Une plateforme analytique modulaire et multi-tenant, pensée d'abord pour la reproductibilité : l'infrastructure de données sur laquelle repose le reste de ces travaux."
permalink: /projects/datahut/
redirect_from:
  - /portfolio/datahut-duckhouse/
status: "En cours · Open source"
status_key: "Active"
domain: "Infrastructure de données scientifiques"
research_theme: "Infrastructure de données scientifiques"
technologies: ["DuckDB", "Apache Iceberg", "Arrow Flight", "dbt", "Trino"]
github: "https://github.com/Geobatpo07/datahut-duckhouse"
last_updated: 2026-03-05
date: 2026-03-05
---

## Présentation

Une plateforme analytique modulaire qui associe DuckDB, Apache Iceberg, Arrow Flight, dbt et Trino, conçue pour que la reproductibilité, et non le passage à l'échelle, soit la contrainte principale de l'architecture.

## Contexte scientifique

La plupart des plateformes analytiques sont conçues pour le débit métier : plus d'utilisateurs, plus de requêtes simultanées, plus de tableaux de bord. La recherche bute sur autre chose : la même analyse, relancée par quelqu'un d'autre, avec les mêmes données et le même résultat. C'est autour de cet écart entre « ça marche chez moi » et « c'est reproductible par tous » que DataHut-DuckHouse est construit.

## Problématique

Monter une chaîne de données qui permette l'analyse exploratoire, la transformation et le reporting revient en général à assembler des outils qui n'ont pas été pensés pour fonctionner ensemble, la reproductibilité venant en dernier. La question posée ici : à quoi ressemble une plateforme de données quand la reproductibilité est une contrainte de conception dès le départ, et non un ajout après coup ?

## Objectifs

- Proposer une pile analytique légère, auto-hébergeable, qui ne demande pas d'infrastructure lourde.
- Garder des transformations déclaratives et versionnées, plutôt que dispersées dans des scripts ponctuels.
- Permettre un usage multi-tenant sans déploiement séparé pour chaque tenant.

## Méthodologie

La plateforme combine DuckDB comme moteur analytique embarqué, Apache Iceberg comme format de table pour des jeux de données versionnés dont le schéma évolue, Arrow Flight pour un transport de données efficace, dbt pour des transformations déclaratives et testables, et Trino pour interroger plusieurs sources de façon fédérée. Chaque composant a été choisi parce qu'il fait bien une seule chose, pas parce qu'il appartient à l'écosystème d'un même éditeur.

## Architecture

Les données arrivent dans des tables Iceberg, qui apportent l'isolation par snapshots et l'évolution de schéma sans service de métadonnées séparé. DuckDB exécute des requêtes analytiques locales rapides directement sur ces tables ; Trino prend le relais quand une requête doit couvrir plusieurs sources. dbt constitue la couche de transformation, si bien que chaque table dérivée a une définition versionnée plutôt qu'un script ponctuel. Arrow Flight déplace les données entre composants sans le coût de sérialisation des formats orientés lignes.

## Mise en œuvre

Le multi-tenant est géré au niveau des tables et du catalogue, et non par une infrastructure séparée pour chaque tenant, ce qui garde une empreinte opérationnelle réduite. Chaque transformation est un modèle dbt accompagné de ses propres tests : une hypothèse fausse échoue bruyamment en CI plutôt que silencieusement dans un rapport en aval.

## Difficultés rencontrées

Obtenir une évolution de schéma Iceberg prévisible à la fois dans DuckDB et dans Trino a demandé de vrais tâtonnements : les deux moteurs n'interprètent pas toujours le format de table de la même façon, et les réconcilier relevait davantage d'une configuration soignée que d'un défaut de l'un ou de l'autre. L'autre difficulté récurrente a été de résister à l'élargissement du périmètre : il est tentant d'ajouter sans cesse connecteurs et fonctionnalités, et la vraie discipline a consisté à décider ce qui relevait du cœur centré sur la reproductibilité et ce qui devait rester une couche séparée et facultative.

## Résultats

La plateforme permet aujourd'hui un flux analytique local fonctionnel (ingestion dans Iceberg, transformation avec dbt, requêtes avec DuckDB ou Trino selon la portée de la requête) et suscite un intérêt open source (une douzaine d'étoiles sur GitHub en septembre 2026). Elle sert de couche de données aux autres travaux de calcul de ce portfolio, dont le travail exploratoire qui a précédé la modélisation du chlordécone.

## Enseignements

Choisir des outils composables à usage unique plutôt qu'une plateforme tout-en-un a rendu le système plus facile à comprendre, au prix d'un travail d'intégration plus important au départ. Écrire les tests dbt en même temps que les transformations, et non après, a révélé plus de vrais problèmes de qualité des données qu'aucune relecture manuelle ne l'aurait fait.

## Perspectives

Formaliser le contrôle d'accès multi-tenant (au lieu de s'appuyer seulement sur la séparation au niveau du catalogue) et ajouter un vrai suivi du lignage des données sont les deux prochaines étapes les plus utiles, avec un même but : rendre la plateforme assez fiable pour qu'une personne extérieure au projet puisse l'adopter en confiance.
