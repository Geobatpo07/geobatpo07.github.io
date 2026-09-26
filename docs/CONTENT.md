# Contenu du site : format des données

Tout le contenu des pages d'accueil et de parcours (`/`, `/software/`, `/data/`, `/research/` et leurs versions `/fr/`) est décrit **une seule fois** dans `_data/`. Les pages ne contiennent pas de texte : elles filtrent ces fichiers au build via Liquid.

Pour ajouter un projet, une expérience ou une compétence, on modifie un fichier YAML. Aucun template n'est à toucher.

| Fichier | Contenu |
|---|---|
| `_data/tracks.yml` | Les trois parcours : titre, accroche, icône, CV, métadonnées SEO |
| `_data/experience.yml` | Postes, avec des puces différentes selon le parcours |
| `_data/projects.yml` | Projets, priorité par parcours, projets mis en avant sur l'accueil |
| `_data/skills.yml` | Compétences par catégorie (badges) |
| `_data/education.yml` | Formation (affichée sur tous les parcours) |
| `_data/certifications.yml` | Certifications |
| `_data/i18n.yml` | Libellés de l'interface (boutons, titres de sections, mois) |

## Conventions

**Textes bilingues.** Tout texte affiché est une paire `{ fr, en }` :

```yaml
role:
  fr: "Développeur Full-Stack & Data Analyst"
  en: "Full-Stack Developer & Data Analyst"
```

Les noms propres qui ne se traduisent pas (organisation, nom de projet, technologies) sont de simples chaînes. Le français doit être rédigé, pas traduit mot à mot.

**Parcours et priorité.** Le champ `tracks` est une table `parcours: rang` :

```yaml
tracks: { data: 1, software: 6 }
```

- l'élément apparaît sur `/data/` en première position, et sur `/software/` en sixième ;
- il n'apparaît pas sur `/research/` ;
- les clés valides sont celles de `tracks.yml` : `software`, `data`, `research`.

**Dates.** Au format `"YYYY-MM"` (expériences) ou `"YYYY"` (formation). Sans `end`, le poste est affiché « – aujourd'hui ».

## Ajouter un projet

Ajoutez une entrée à `_data/projects.yml` :

```yaml
- id: mon-projet                      # identifiant unique, en minuscules
  name: "Mon projet"
  github: "https://github.com/Geobatpo07/mon-projet"   # facultatif
  # private: true                     # à la place de github pour un dépôt privé
  case_study: /projects/mon-projet/   # facultatif : page détaillée existante
  stack: ["Python", "DuckDB", { fr: "Séries temporelles", en: "Time series" }]
  status: active                      # active | prototype | completed | presented
  featured: false                     # true = affiché sur l'accueil (en garder trois)
  tracks: { data: 2, research: 6 }
  description:
    fr: "Une ou deux phrases factuelles : ce que fait le projet, avec quoi."
    en: "One or two factual sentences: what the project does, with what."
  links:                              # facultatif : démo, DOI, etc.
    - label: { fr: "Démo", en: "Demo" }
      url: "https://…"
  research:                           # facultatif : affiché sur /research/ seulement
    question: { fr: "…", en: "…" }
    motivation: { fr: "…", en: "…" }
    methodology: { fr: "…", en: "…" }
    contribution: { fr: "…", en: "…" }
```

Si deux projets ont la même priorité sur un parcours, ils gardent l'ordre du fichier. Pensez à décaler les rangs des projets suivants si vous insérez un projet au milieu.

## Ajouter une expérience

Ajoutez une entrée à `_data/experience.yml`. Chaque parcours a sa propre liste de puces : le même poste se raconte différemment à un recruteur software ou data.

```yaml
- id: acme
  role:
    fr: "Data Engineer"
    en: "Data Engineer"
  org: "Acme"
  start: "2026-10"
  # end: "2027-06"                    # omis = poste en cours
  location: { fr: "Paris", en: "Paris" }   # facultatif
  sector: { fr: "Énergie", en: "Energy" }   # facultatif
  tracks: { data: 1, software: 3 }
  bullets:
    data:
      - fr: "Conception des pipelines d'ingestion…"
        en: "Designed the ingestion pipelines…"
    software:
      - fr: "Développement d'une API…"
        en: "Built an API…"
```

Un parcours listé dans `tracks` doit avoir ses puces dans `bullets`. Sinon, le poste s'affiche sans détail.

## Compétences, formation, certifications

- `skills.yml` : une catégorie porte `tracks: { parcours: rang }`. Un élément est une chaîne, ou `{ name, tracks: [..] }` pour le limiter à certains parcours, ou `{ name: { fr, en } }` s'il se traduit.
- `education.yml` : sans `tracks`, une formation s'affiche partout (cas actuel).
- `certifications.yml` : la section n'apparaît que sur les parcours qui ont au moins une certification.

## Parcours et pages

Chaque parcours existe en deux pages de quelques lignes, par exemple `_pages/software.md` et `_pages/fr/software.md` :

```yaml
---
layout: track
track: software      # clé de tracks.yml
lang: fr
ref: software        # identifiant commun aux deux langues (sélecteur FR | EN)
permalink: /fr/software/
---
```

Le titre, la description SEO et le fichier CV viennent de `tracks.yml`. Le contenu écrit sous le front matter est ajouté après les sections générées (c'est le cas de `/research/`).

Une nouvelle page bilingue suit le même principe : deux fichiers avec le même `ref` et des `lang` différents. Une page sans équivalent (par exemple `/teaching/`) renvoie le sélecteur de langue vers l'accueil de l'autre langue.

## CV

Les boutons pointent vers `files/` :

| Fichier | Page |
|---|---|
| `files/CV_Laguerre.pdf` | accueil (CV généraliste) |
| `files/CV_Laguerre_Software.pdf` | `/software/` |
| `files/CV_Laguerre_Data.pdf` | `/data/` |
| `files/CV_Laguerre_Research.pdf` | `/research/` |

`files/Profile.pdf` reste généré par la CI à partir de `/resume-print/` pour la page `/cv/`.

## Vérifier

```bash
docker compose up --build        # http://localhost:4001
```

Contrôlez la page du parcours concerné, en français et en anglais.
