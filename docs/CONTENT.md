# Contenu du site : format des données

Tout le contenu structuré du site (portail, trois espaces, CV) est décrit **une seule fois** dans `_data/`. Les pages ne contiennent pas ce texte : elles le filtrent au build via Liquid.

| Fichier | Contenu |
|---|---|
| `_data/resume.yml` | **Source unique des CV et des espaces** : titres et résumés des CV, expériences, formation, compétences, certifications, langues |
| `_data/projects.yml` | Projets, rang par espace, CV qui les listent |
| `_data/tracks.yml` | Les trois espaces : titre, accroche, icône, menu, page contact, SEO, mise en page du CV |
| `_data/teachingSubjects.yml` | Matières enseignées (`/teaching/`) |
| `_data/i18n.yml` | Libellés de l'interface (boutons, titres de sections, mois) |

`resume.yml` est préparé par le moteur `_plugins/resume_engine.rb` (libellés de dates, références de puces, frise, années d'expérience) et vérifié en CI par `scripts/validate_resume.rb`, avant le build.

## Conventions

**Textes bilingues.** Tout texte affiché est un groupe `{ fr, en }` :

```yaml
title:
  fr: "Développeur Full-Stack & Data Analyst"
  en: "Full-Stack Developer & Data Analyst"
```

Les noms propres qui ne se traduisent pas (organisation, nom de projet, technologies) sont de simples chaînes. Le français doit être rédigé, pas traduit mot à mot.

**Préfixes de `resume.yml`.** Un préfixe par CV :

| Préfixe | Où |
|---|---|
| `profile_` | CV complet : `/cv/`, `/en/cv/`, `files/Profile.pdf`, `files/Profile_EN.pdf` |
| `software_`, `data_`, `research_` | La page de l'espace (`/<espace>/`) et son CV (`files/CV_Laguerre_<Espace>_<FR\|EN>.pdf`) |

**Ordre.** L'ordre du fichier est l'ordre d'affichage partout (sauf compétences : voir `<préfixe>_rank`).

**Dates.** Au format `"YYYY-MM"`. Sans `end_date`, le poste est affiché « – aujourd'hui ». Le moteur calcule les libellés (`dates`, par exemple « juil. 2023 – août 2026 ») dans les deux langues.

## Titre et résumé des CV

```yaml
profile_headline: { fr: "…", en: "…" }
profile_summary:  { fr: "…", en: "…" }    # plusieurs paragraphes possibles (|)
software_headline: { fr: "…", en: "…" }
software_summary:  { fr: "…", en: "…" }
# idem data_ et research_
```

## Ajouter une expérience

```yaml
experience:
  - id: acme
    category: professional        # professional | research | teaching (frise du CV complet)
    title: { fr: "Data Engineer", en: "Data Engineer" }
    org: "Acme"                   # ou { fr: "Indépendant", en: "Self-employed" }
    start_date: "2026-10"
    # end_date: "2027-06"         # omis = poste en cours
    location: { fr: "Paris", en: "Paris" }   # facultatif
    sector: { fr: "Énergie", en: "Energy" }   # facultatif
    data_bullets:                 # le poste apparaît sur /data/ et sur le CV Data
      - fr: "Conception des pipelines d'ingestion…"
        en: "Designed the ingestion pipelines…"
    software_bullets: []          # sur /software/, sans puce
    profile_bullets: [data, software]   # CV complet : reprend les puces data puis software
```

- Un poste apparaît sur une page ou un CV s'il porte la clé `<préfixe>_bullets`.
- Une valeur de `<préfixe>_bullets` est une liste de `{ fr, en }`, ou le nom d'un autre préfixe (`profile_bullets: research`), ou une liste de noms : le moteur remplace la référence par les puces correspondantes. Une puce n'est ainsi écrite qu'une fois.
- `<espace>_cv: false` : le poste reste sur la page de l'espace mais sort du CV de l'espace.
- `cv: false` sur une puce : elle reste sur le site mais sort des CV.
- `link` et `link_label` (facultatifs) : lien affiché sur le CV complet ; `link` est le chemin français, `/en` est ajouté sur la version anglaise.
- `include_in_timeline: false` : hors de la frise du CV complet.

## Formation, compétences, certifications, langues

```yaml
education:                        # affichée partout, dans l'ordre du fichier
  - degree: { fr: "…", en: "…" }
    detail: { fr: "…", en: "…" }  # facultatif
    institution: "Université des Antilles"
    start_date: "2024-09"
    end_date: "2026-06"
    research_focus: { fr: "…", en: "…" }   # facultatif, CV complet seulement
    supervisor: { fr: "Pr …", en: "Prof. …" }   # facultatif, CV complet seulement

skills:
  - category: { fr: "Langages", en: "Languages" }
    software_rank: 1              # présente sur /software/ et son CV, au rang 1
    data_rank: 1
    profile_rank: 1
    # software_cv: false          # sur /software/ mais pas sur le CV Software
    items:
      - "Python"
      - { name: "C#", spaces: [software] }       # limité à certains espaces (le CV complet liste tout)
      - { name: { fr: "API REST", en: "REST APIs" } }

certifications:                   # toutes sur le CV complet
  - name: "Microsoft Certified: Fabric Data Engineer Associate (DP-700)"
    issuer: "Microsoft"
    spaces: [data, software]      # espaces (page et CV) où elle apparaît
    detail: { fr: "…", en: "…" }       # facultatif, affiché partout
    description: { fr: "…", en: "…" }  # facultatif, CV complet seulement

languages:                        # CV complet seulement
  - language: { fr: "Français", en: "French" }
    level: { fr: "Courant", en: "Fluent" }
```

Sur les pages d'espace et les CV d'espace, la formation affiche les années seules (« 2024 – 2026 ») ; le CV complet affiche les mois.

## Ajouter un projet

Ajoutez une entrée à `_data/projects.yml` :

```yaml
- id: mon-projet                      # identifiant unique, en minuscules
  name: "Mon projet"
  github: "https://github.com/Geobatpo07/mon-projet"   # facultatif
  # private: true                     # à la place de github pour un dépôt privé
  case_study: /projects/mon-projet/   # facultatif : étude de cas (page neutre)
  stack: ["Python", "DuckDB", { fr: "Séries temporelles", en: "Time series" }]
  status: active                      # active | prototype | completed | presented
  tracks: { data: 2, research: 6 }    # espaces et rang (1 = première carte)
  cv: [data, research, profile]       # CV qui listent le projet, dans l'ordre de l'espace
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

Si deux projets ont la même priorité sur un espace, ils gardent l'ordre du fichier.

## Portail, espaces et pages partagées

Le site est un portail et trois espaces cloisonnés. Le layout `default` choisit l'en-tête et le pied de page selon `space` (ou `track`), et l'écrit dans `<html data-space="…">` :

| `data-space` | Pages | En-tête | Pied de page |
|---|---|---|---|
| `portal` | `/`, `/en/` | nom, FR \| EN, thème | e-mail, LinkedIn, GitHub |
| `software`, `data`, `research` | racine, page contact, pages d'impression du CV et pages rattachées de l'espace ; pour research : `/about/`, `/cv/`, `/teaching/`, `/feedback/` et les études de cas | nom (vers la racine de l'espace), menu de l'espace, FR \| EN dans l'espace, thème | contact de l'espace, e-mail avec objet, LinkedIn, GitHub |
| `neutral` | fiches publication et enseignement, 404, `/terms/`, `/resume-print/` | nom sans lien, bouton « Retour », thème | copyright |

**Règle d'isolement.** Une page d'espace ne contient aucun lien vers le portail ni vers un autre espace (en-tête, pied de page et contenu). Seul le portail liste les trois espaces. Le seul lien que les trois espaces partagent est celui du blog Stories, dans leur menu.

**Études de cas.** Ce sont des pages neutres (`space: neutral` par défaut dans `_config.yml`, layout `case-study`) : en-tête sans menu avec un bouton Retour, pied de page neutre, aucun lien vers un espace. La carte d'un projet mène à son étude de cas dans chaque espace où elle apparaît, avec `?from=<espace>` (et `&lang=en` en anglais) : le bouton Retour revient à la page précédente, ou à défaut à la racine de cet espace.

**Langues.** Le français est la langue par défaut : toute page française est à la racine, toute page anglaise sous `/en/`, et **toute page anglaise a sa version française**. `_config.yml` donne `lang: fr` à toutes les pages et à tous les documents des collections ; une page anglaise déclare `lang: en`. Chaque paire partage un `ref` : le `<head>` liste les deux versions en `hreflang`, avec `x-default` sur la version française, et le sélecteur FR | EN passe de l'une à l'autre sans quitter l'espace. Il n'existe pas de préfixe `/fr/`.

- Pages : `_pages/x.md` (français) et `_pages/en/x.md` (anglais).
- Collections : `_projects/x.md` et `_projects/en/x.md` (idem `_publications`, `_teaching`), avec un `permalink` explicite (`/projects/x/` et `/en/projects/x/`).
- Liens écrits à la main dans une page : chemin français pour la page française, `/en/…` pour l'anglaise, ou l'include `localized-url.html` (`{% raw %}{% include localized-url.html path="/teaching/" %}{% endraw %}`), qui ajoute `/en` sur une page anglaise.
- Publications : l'article garde son titre original ; la fiche française traduit le résumé et le lieu et donne le titre traduit dans son texte.

**Espaces.** Chaque espace existe en deux pages de quelques lignes, par exemple `_pages/software.md` (`/software/`) et `_pages/en/software.md` (`/en/software/`) :

```yaml
---
layout: track
track: software      # clé de tracks.yml
lang: en
ref: software        # identifiant commun aux deux langues (sélecteur FR | EN)
permalink: /en/software/
---
```

Le menu de l'espace pointe vers les ancres de la racine (Expérience, Projets, Compétences), les entrées `extra_nav`, le CV PDF de la langue affichée, le blog Stories et la page contact.

**Pages contact.** `_pages/<espace>-contact.md` et `_pages/en/<espace>-contact.md` (layout `contact`, `space: <espace>`) ; tous les textes viennent du bloc `contact` de `tracks.yml`.

**Pages neutres.** Les fiches publication et enseignement reçoivent `space: neutral` par défaut. Depuis un espace, un lien vers une fiche ajoute `?from=<espace>` (et `&lang=en` en anglais) : le bouton « Retour » fait `history.back()`, sinon renvoie à la racine indiquée par `from`, sinon reste masqué.

## CV

Aucun CV n'est déposé à la main : la CI les génère à chaque déploiement, à partir de `_data/` (et de `_publications/` pour Research et le CV complet).

| Page d'impression | PDF généré | Limite |
|---|---|---|
| `/software/print/`, `/en/software/print/` | `files/CV_Laguerre_Software_FR.pdf`, `_EN.pdf` | 1 page |
| `/data/print/`, `/en/data/print/` | `files/CV_Laguerre_Data_FR.pdf`, `_EN.pdf` | 1 page |
| `/research/print/`, `/en/research/print/` | `files/CV_Laguerre_Research_FR.pdf`, `_EN.pdf` | 2 pages |
| `/resume-print/`, `/en/resume-print/` (CV complet) | `files/Profile.pdf`, `files/Profile_EN.pdf` | — |

Le lien « CV » de l'en-tête, le bouton de la racine et celui de la page contact pointent vers le PDF de l'espace dans la langue affichée. La page `/cv/` (et `/en/cv/`) affiche le CV complet et propose `Profile.pdf` (ou `Profile_EN.pdf`).

**Contenu d'un CV d'espace** (`_layouts/cv-print.html`) : `<espace>_headline` et `<espace>_summary`, les postes avec `<espace>_bullets` (sauf `<espace>_cv: false`), les projets dont `cv` contient l'espace, les compétences avec `<espace>_rank` (sauf `<espace>_cv: false`), la formation, les certifications de l'espace et, si `publications: true`, les publications de la langue.

**Mise en page d'un CV d'espace : bloc `cv` de `tracks.yml`.**

```yaml
data:
  cv_file: CV_Laguerre_Data     # nom de base des PDF : <cv_file>_FR.pdf et <cv_file>_EN.pdf
  cv:
    max_pages: 1                # contrôlé à chaque build
    certifications: block       # block : section dédiée ; line : une ligne compacte en fin de page
    publications: true          # facultatif : liste la collection _publications (Research)
```

- En-tête : nom, titre, e-mail, LinkedIn, GitHub (`_config.yml`, `author`) et `cv_location` d'`i18n.yml` (« Île-de-France »). Ni téléphone ni adresse.
- Lisible par les ATS : une colonne, texte réel, sans police d'icônes, A4, corps 10 pt, police Arial (Liberation Sans, métriquement identique, installée dans l'image Docker et sur le runner) ; `assets/css/cv-print.scss`.
- Un CV limité à 1 page est compact ; un CV autorisé à plus d'une page (Research) prend une mise en page aérée.
- Les mots à trait d'union (« Scikit-learn », « DP-700 ») ne sont jamais coupés en fin de ligne (filtre `nowrap_hyphens`, `_plugins/nowrap_hyphens.rb`).
- Si un CV dépasse sa limite, on retire un projet de `cv`, un poste (`<espace>_cv: false`), une puce (`cv: false`) ou une catégorie de compétences (`<espace>_cv: false`) ; la mise en page ne se resserre pas pour compenser.

**Génération et contrôle.** Jekyll génère lui-même les huit PDF, à la fin de chaque build : le plugin `_plugins/cv_pdf.rb` (hook `:site, :post_write`) ouvre les pages d'impression dans Chrome headless, piloté par la gem Ferrum, et écrit dans `_site/files/` :

| Page d'impression | PDF |
|---|---|
| `/resume-print/`, `/en/resume-print/` | `Profile.pdf`, `Profile_EN.pdf` |
| `/<espace>/print/`, `/en/<espace>/print/` | `<cv_file>_FR.pdf`, `<cv_file>_EN.pdf` (`cv_file` dans `tracks.yml`) |

Les marges et le format viennent de la règle `@page` de chaque feuille d'impression. Le build échoue, avec un message qui nomme le fichier, si :

- un CV d'espace dépasse `cv.max_pages` de `tracks.yml` (pages comptées par la gem pdf-reader) : le message donne le fichier, le nombre de pages obtenu et la limite. Raccourcissez alors le CV comme indiqué ci-dessus, puis relancez le build ;
- Chrome ou Chromium est introuvable : installez-le, ou indiquez son exécutable dans la variable `BROWSER_PATH` ;
- une des huit pages d'impression manque, ou un bloc `cv` de `tracks.yml` cite un identifiant inconnu.

**Sauter la génération en local.** Pendant `jekyll serve`, `CV_PDF=0 bundle exec jekyll serve`, ou `cv_pdf: false` dans un fichier de configuration local (`--config _config.yml,_config_local.yml`). Ce réglage est ignoré en production (`JEKYLL_ENV=production`) et en CI (`CI=true`) : les PDF y sont toujours générés. L'image Docker contient Chromium et les polices Liberation, donc `docker compose up --build` génère aussi les PDF.

## Conformité : ce que le site charge et collecte

- **Pages légales** (neutres, FR et EN, liées depuis le pied de page de toutes les pages) : mentions légales (`/mentions-legales/`, `/en/legal-notice/`) et politique de confidentialité (`/confidentialite/`, `/en/privacy/`, qui remplace `/terms/`). Toute modification de ce que le site charge ou collecte doit y être reportée.
- **Aucun traceur avant action volontaire**, donc aucun bandeau de cookies. Le seul script tiers chargé d'office est GoatCounter (mesure d'audience sans cookie, builds de production seulement, pas sur les pages d'impression des CV ; `analytics` dans `_config.yml`).
- **Tout le reste est hébergé avec le site** : polices Inter et Fraunces (`assets/fonts/`, `_sass/_fonts.scss`, licences OFL), Font Awesome, Academicons, Chart.js (`assets/js/chart.umd.min.js`). Ne pas réintroduire de ressource chargée depuis Google Fonts ou un CDN.
- **Calendly** n'est chargé qu'après un clic (`data-click-to-load`, `assets/js/click-to-load.js`) ; le même mécanisme sert pour tout futur contenu tiers intégré.
- **Accessibilité** : contrastes WCAG AA dans les deux thèmes (couleurs dans `_sass/theme/_default_*.scss`), un `h1` visible par page.
- **Agents IA** : `/llms.txt` est généré depuis les données ; `robots.txt` autorise tous les robots.

## Vérifier

```bash
docker compose up --build        # http://localhost:4001
```

Contrôlez la page concernée, en français et en anglais.

La CI (`.github/workflows/jekyll.yml`) valide `resume.yml`, construit le site (ce qui génère et contrôle les PDF), puis lance html-proofer avec le contrôle d'isolement, qui vérifie aussi que les liens vers les huit PDF aboutissent. Sur une pull request, tout est exécuté sauf le déploiement, réservé aux push sur master ; un échec bloque le déploiement. En local, après `ruby scripts/validate_resume.rb` puis `JEKYLL_ENV=production bundle exec jekyll build` (qui affiche le nombre de pages de chaque CV) :

```bash
bundle exec ruby scripts/check-isolation.rb   # liens internes, images, scripts, isolement, langues
```

Le contrôle échoue si une page d'espace pointe vers le portail ou vers un autre espace (redirections suivies), si une page n'a pas de `data-space`, si l'ancien en-tête global (`.masthead`, `.site-header`) réapparaît, si une page anglaise n'est pas sous `/en/` ou n'a pas de version française existante, si une page sous `/en/` n'est pas en anglais, si le `x-default` d'une paire ne vise pas la version française, ou si un lien utilise le préfixe `/fr/`.
