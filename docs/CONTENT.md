# Contenu du site : format des données

Tout le contenu du portail et des espaces (`/`, `/software/`, `/data/`, `/research/`, leurs pages contact et leurs versions anglaises `/en/…`) est décrit **une seule fois** dans `_data/`. Les pages ne contiennent pas de texte : elles filtrent ces fichiers au build via Liquid.

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
  org: "Acme"                         # ou { fr: "Indépendant", en: "Self-employed" }
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

Pour garder une puce sur le site mais l'écarter du CV généré, ajoutez-lui `cv: false` :

```yaml
      - fr: "…"
        en: "…"
        cv: false
```

## Compétences, formation, certifications

- `skills.yml` : une catégorie porte `tracks: { parcours: rang }`. Un élément est une chaîne, ou `{ name, tracks: [..] }` pour le limiter à certains parcours, ou `{ name: { fr, en } }` s'il se traduit.
- `education.yml` : sans `tracks`, une formation s'affiche partout (cas actuel).
- `certifications.yml` : la section n'apparaît que sur les parcours qui ont au moins une certification.

## Portail, espaces et pages partagées

Le site est un portail et trois espaces cloisonnés. Le layout `default` choisit l'en-tête et le pied de page selon `space` (ou `track`), et l'écrit dans `<html data-space="…">` :

| `data-space` | Pages | En-tête | Pied de page |
|---|---|---|---|
| `portal` | `/`, `/en/` | nom, FR \| EN, thème | e-mail, LinkedIn, GitHub |
| `software`, `data`, `research` | racine, page contact et pages rattachées de l'espace | nom (vers la racine de l'espace), menu de l'espace, FR \| EN dans l'espace, thème | contact de l'espace, e-mail avec objet, LinkedIn, GitHub |
| `neutral` | études de cas `/projects/*/`, fiches publication et enseignement, 404, `/terms/`, `/cv-json/`, `/resume-print/` | nom sans lien, bouton « Retour », thème | copyright |

**Règle d'isolement.** Une page d'espace ne contient aucun lien vers le portail ni vers un autre espace (en-tête, pied de page et contenu). Seul le portail liste les trois espaces.

**Langues.** Le français est la langue par défaut : les pages françaises sont à la racine (`/`, `/data/`, `/data/contact/`…), les pages anglaises sous `/en/` (`/en/`, `/en/data/`…). `_config.yml` donne `lang: fr` à toutes les pages ; une page anglaise déclare `lang: en`. Chaque paire FR/EN partage un `ref` : le `<head>` liste les deux versions en `hreflang`, avec `x-default` sur la version française, et le sélecteur FR | EN passe de l'une à l'autre sans quitter l'espace. Il n'existe plus de préfixe `/fr/` (et aucune redirection depuis `/fr/`, qui n'a jamais été en ligne).

**Exception : pages research en anglais seulement.** `/cv/`, `/teaching/`, `/about/`, `/feedback/`, les études de cas et les fiches publication et enseignement restent en anglais, à leur URL actuelle, sans préfixe `/en/` (`lang: en`, sans version française). Leur sélecteur FR | EN renvoie vers la racine de l'espace dans l'autre langue, et leurs liens internes visent les pages anglaises de l'espace (`/en/research/…`).

**Espaces.** Chaque espace existe en deux pages de quelques lignes, par exemple `_pages/software.md` (français, `/software/`) et `_pages/en/software.md` (anglais, `/en/software/`) :

```yaml
---
layout: track
track: software      # clé de tracks.yml
lang: en
ref: software        # identifiant commun aux deux langues (sélecteur FR | EN)
permalink: /en/software/
---
```

Le titre, la description SEO et le fichier CV viennent de `tracks.yml`. Le contenu écrit sous le front matter est ajouté après les sections générées (c'est le cas de `/research/`).

Le menu de l'espace pointe vers les ancres de la racine (Expérience, Projets, Compétences), le CV PDF de la langue affichée (voir « CV »), les entrées `extra_nav`, Stories si `stories: true`, et la page contact.

**Pages contact.** `_pages/<espace>-contact.md` et `_pages/en/<espace>-contact.md` (layout `contact`, `space: <espace>`) ; tous les textes viennent du bloc `contact` de `tracks.yml` : titre, introduction, objet du mail, `calendly` (réservation intégrée) et `profiles` (liens supplémentaires, clés de `site.author`).

**Pages rattachées.** Une page qui appartient à un espace déclare `space: research` (c'est le cas de `/about/`, `/cv/`, `/teaching/`, `/feedback/`). Une page sans équivalent dans l'autre langue renvoie le sélecteur FR | EN vers la racine de l'espace dans l'autre langue.

**Pages partagées.** Les études de cas utilisent le layout `case-study`, qui passe par `neutral` ; les fiches publication et enseignement reçoivent `space: neutral` par défaut (`_config.yml`). Depuis un espace, un lien vers une page partagée ajoute `?from=<espace>` (et `&lang=en` en anglais) : le bouton « Retour » fait `history.back()`, sinon renvoie à la racine indiquée par `from`, sinon reste masqué.

## CV

Les CV d'espace ne sont pas déposés à la main : la CI les génère à chaque déploiement, uniquement à partir de `_data/` (et de `_publications/` pour Research).

| Page d'impression | PDF généré | Limite |
|---|---|---|
| `/software/print/`, `/en/software/print/` | `files/CV_Laguerre_Software_FR.pdf`, `_EN.pdf` | 1 page |
| `/data/print/`, `/en/data/print/` | `files/CV_Laguerre_Data_FR.pdf`, `_EN.pdf` | 1 page |
| `/research/print/`, `/en/research/print/` | `files/CV_Laguerre_Research_FR.pdf`, `_EN.pdf` | 2 pages |

Le lien « CV » de l'en-tête, le bouton de la racine et celui de la page contact pointent vers le PDF de la langue affichée (une page anglaise hors `/en/`, comme `/cv/`, pointe vers le PDF anglais).

**Contenu : bloc `cv` de `tracks.yml`.**

```yaml
data:
  cv_file: CV_Laguerre_Data     # nom de base des PDF : <cv_file>_FR.pdf et <cv_file>_EN.pdf
  cv:
    max_pages: 1                # contrôlé en CI
    headline: { fr: "…", en: "…" }
    summary:  { fr: "…", en: "…" }
    experience: [solutions-sa, ayitistats]    # id de experience.yml, dans cet ordre
    projects: [datahut-duckhouse, nyansa]     # id de projects.yml, dans cet ordre
    certifications: block       # block : section dédiée ; line : une ligne compacte en fin de page
    publications: true          # facultatif : liste la collection _publications (Research)
```

- Puces : celles de l'espace dans `experience.yml`, sauf celles marquées `cv: false`.
- Compétences, formation et certifications : toutes les entrées de l'espace (mêmes règles que le site).
- Projets : description, technologies, lien GitHub (ou « Dépôt privé, démo sur demande ») et liens `links`.
- Publications : les entrées publiées, puis celles « en préparation » (lieu contenant « preparation »).
- En-tête : nom, `headline`, e-mail, LinkedIn, GitHub (`_config.yml`, `author`) et `cv_location` d'`i18n.yml` (« Île-de-France »). Ni téléphone ni adresse.
- Libellés des sections : `i18n.yml`.

Mise en page (`_layouts/cv-print.html`, `assets/css/cv-print.scss`) : lisible par les ATS, une colonne, texte réel, sans police d'icônes, A4, corps 10 pt, police Arial (Liberation Sans, métriquement identique, sur le runner Ubuntu).

- Un CV limité à 1 page (Software, Data) est compact : dates sur la ligne du poste, technologies à la suite de la description, un diplôme par ligne. Un CV autorisé à plus d'une page (Research) prend la mise en page aérée : marges plus larges, dates, technologies et liens sur leur propre ligne, formation avec son détail.
- Les mots à trait d'union (« Scikit-learn », « Lax-Friedrichs », « DP-700 ») ne sont jamais coupés en fin de ligne : le filtre `nowrap_hyphens` (`_plugins/nowrap_hyphens.rb`) les entoure d'un `<span class="nowrap">` (`white-space: nowrap`), avec un trait d'union normal ; les URL affichées sont aussi en `nowrap`. L'extraction de texte du PDF les restitue entiers.
- Si un CV dépasse sa limite, on retire un élément du bloc `cv` (projet, poste) ou une puce (`cv: false`) ; la mise en page ne se resserre pas pour compenser.

**Génération et contrôle.** `scripts/generate-cv-pdf.mjs` (Playwright) produit `Profile.pdf` depuis `/resume-print/`, puis un PDF par page d'impression, nommé par sa balise `<meta name="cv-file">`. L'étape échoue et bloque le déploiement si un CV dépasse `max_pages`, ou si un id du bloc `cv` ne correspond à rien dans `_data/`.

`files/Profile.pdf` reste généré depuis `/resume-print/` (données de `resume.yml`) pour la page `/cv/`.

## Vérifier

```bash
docker compose up --build        # http://localhost:4001
```

Contrôlez la page de l'espace concerné, en français et en anglais.

La CI génère les PDF puis lance html-proofer avec le contrôle d'isolement ; un échec bloque le déploiement. En local, après `bundle exec jekyll build` puis `node scripts/generate-cv-pdf.mjs` (qui affiche le nombre de pages de chaque CV) :

```bash
bundle exec ruby scripts/check-isolation.rb   # liens internes, images, scripts, isolement des espaces
```

Le contrôle échoue si une page d'espace pointe vers le portail ou vers un autre espace (redirections suivies), si une page n'a pas de `data-space`, si l'ancien en-tête global (`.masthead`, `.site-header`) réapparaît, si une page sous `/en/` n'est pas en anglais, si une page anglaise qui a une version française n'est pas sous `/en/`, si le `x-default` d'une paire ne vise pas la version française, ou si un lien utilise le préfixe `/fr/`.
