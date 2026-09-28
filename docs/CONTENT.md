# Contenu du site : format des données

Tout le contenu du portail et des espaces (`/`, `/software/`, `/data/`, `/research/`, leurs pages contact et leurs versions `/fr/`) est décrit **une seule fois** dans `_data/`. Les pages ne contiennent pas de texte : elles filtrent ces fichiers au build via Liquid.

Pour ajouter un projet, une expérience ou une compétence, on modifie un fichier YAML. Aucun template n'est à toucher.

| Fichier | Contenu |
|---|---|
| `_data/tracks.yml` | Les trois espaces : titre, accroche, icône, CV, menu, textes de la page contact, métadonnées SEO |
| `_data/experience.yml` | Postes, avec des puces différentes selon le parcours |
| `_data/projects.yml` | Projets et priorité par espace |
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
  case_study: /projects/mon-projet/   # facultatif : étude de cas (layout neutral)
  stack: ["Python", "DuckDB", { fr: "Séries temporelles", en: "Time series" }]
  status: active                      # active | prototype | completed | presented
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

## Portail, espaces et pages partagées

Le site est un portail et trois espaces cloisonnés. Le layout `default` choisit l'en-tête et le pied de page selon `space` (ou `track`), et l'écrit dans `<html data-space="…">` :

| `data-space` | Pages | En-tête | Pied de page |
|---|---|---|---|
| `portal` | `/`, `/fr/`, 404 | nom, FR \| EN, thème | e-mail, LinkedIn, GitHub |
| `software`, `data`, `research` | racine, page contact et pages rattachées de l'espace | nom (vers la racine de l'espace), menu de l'espace, FR \| EN dans l'espace, thème | contact de l'espace, e-mail avec objet, LinkedIn, GitHub |
| `neutral` | études de cas `/projects/*/`, fiches publication et enseignement, `/terms/`, `/cv-json/`, `/resume-print/` | nom sans lien, bouton « Retour », thème | copyright |

**Règle d'isolement.** Une page d'espace ne contient aucun lien vers le portail ni vers un autre espace (en-tête, pied de page et contenu). Seul le portail liste les trois espaces.

**Espaces.** Chaque espace existe en deux pages de quelques lignes, par exemple `_pages/software.md` et `_pages/fr/software.md` :

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

Le menu de l'espace pointe vers les ancres de la racine (Expérience, Projets, Compétences), le CV (`cv_url`, sinon le PDF `cv`), les entrées `extra_nav`, Stories si `stories: true`, et la page contact.

**Pages contact.** `_pages/<espace>-contact.md` et `_pages/fr/<espace>-contact.md` (layout `contact`, `space: <espace>`) ; tous les textes viennent du bloc `contact` de `tracks.yml` : titre, introduction, objet du mail, `calendly` (réservation intégrée) et `profiles` (liens supplémentaires, clés de `site.author`).

**Pages rattachées.** Une page qui appartient à un espace déclare `space: research` (c'est le cas de `/about/`, `/cv/`, `/teaching/`, `/feedback/`). Une page sans équivalent dans l'autre langue renvoie le sélecteur FR | EN vers la racine de l'espace dans l'autre langue.

**Pages partagées.** Les études de cas utilisent le layout `case-study`, qui passe par `neutral` ; les fiches publication et enseignement reçoivent `space: neutral` par défaut (`_config.yml`). Depuis un espace, un lien vers une page partagée ajoute `?from=<espace>` (et `&lang=fr` en français) : le bouton « Retour » fait `history.back()`, sinon renvoie à la racine indiquée par `from`, sinon reste masqué.

## CV

Les boutons pointent vers `files/` :

| Fichier | Page |
|---|---|
| `files/CV_Laguerre_Software.pdf` | `/software/` et sa page contact |
| `files/CV_Laguerre_Data.pdf` | `/data/` et sa page contact |
| `files/CV_Laguerre_Research.pdf` | `/research/` et sa page contact |

`files/Profile.pdf` reste généré par la CI à partir de `/resume-print/` pour la page `/cv/`. Tant que les trois PDF d'espace ne sont pas déposés, `scripts/check-isolation.rb` ignore leurs liens (`IGNORED_URLS`).

## Vérifier

```bash
docker compose up --build        # http://localhost:4001
```

Contrôlez la page de l'espace concerné, en français et en anglais.

La CI lance ensuite html-proofer avec le contrôle d'isolement ; un échec bloque le déploiement. En local, après `bundle exec jekyll build` puis `node scripts/generate-cv-pdf.mjs` :

```bash
bundle exec ruby scripts/check-isolation.rb   # liens internes, images, scripts, isolement des espaces
```

Le contrôle échoue si une page d'espace pointe vers le portail ou vers un autre espace (redirections suivies), si une page n'a pas de `data-space`, ou si l'ancien en-tête global (`.masthead`, `.site-header`) réapparaît.
