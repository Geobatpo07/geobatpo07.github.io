---
lang: en
ref: project-chlordecone
title: "Mathematical Modelling of Chlordecone Contamination"
excerpt: "A compartmental ODE model of seasonal chlordecone exposure in Guadeloupe, published as a research preprint and deployed as a live decision-support simulation tool."
permalink: /en/projects/chlordecone/
status: "Active Research"
status_key: "Active"
domain: "Environmental Modelling"
research_theme: "Environmental Modelling"
technologies: ["R", "Shiny", "ODE Systems", "Compartmental Modelling"]
github: "https://github.com/Geobatpo07/simulation-chlordecone"
docs: "https://doi.org/10.13140/RG.2.2.36238.01607"
docs_label: "View DOI Record"
demo: "https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/"
demo_label: "Launch Simulation App"
last_updated: 2026-03-06
date: 2026-03-06
---

## Overview

A non-autonomous compartmental ODE model of chronic chlordecone contamination in tropical soils and food chains, paired with an interactive Shiny tool for exploring seasonal exposure scenarios. The work is published as a research preprint, [Modélisation de l'exposition humaine au chlordécone](https://doi.org/10.13140/RG.2.2.36238.01607), and deployed publicly as a [live simulation app](https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/) so the model can be explored directly rather than taken on faith.

## Scientific Context

Chlordecone is a persistent organochlorine pesticide used in Guadeloupe's banana plantations until the early 1990s. Decades later, it remains present in soils and moves through the food chain into water and locally grown produce, making chronic low-level exposure an ongoing public-health concern rather than a historical one. Understanding how contamination moves through the environment over time (not just how much of it exists at a single moment) is what motivated a modelling approach.

## Problem Statement

Existing risk assessments tend to treat contamination as roughly constant, which understates how much exposure varies with rainfall and season. The problem this project addresses: can a mathematical model capture that seasonal variability precisely enough to be useful for setting or questioning public-health thresholds, without becoming so complex that its assumptions are impossible to communicate or scrutinize?

## Objectives

- Represent the environmental transfer pathways (soil &rarr; water &rarr; food chain &rarr; human exposure) as a coupled compartmental system.
- Introduce seasonal, rainfall-driven forcing into the model rather than assuming static transfer rates.
- Make the model's assumptions and sensitivity visible and explorable, not just its output.
- Make the model available to explore directly, not only describable in a paper.

## Methodology

The system is formulated as a non-autonomous system of ordinary differential equations, with time-dependent coefficients representing rainfall-driven transfer between compartments. Numerical solutions are computed for a range of seasonal scenarios, and the resulting exposure trajectories are compared against qualitative expectations from the environmental literature as a sanity check on the model's behavior.

## Architecture

The simulation core is implemented in R, structured as a set of compartment definitions and transfer-rate functions that a numerical ODE solver integrates over time. An R Shiny application sits on top of that core, exposing the model's parameters (rainfall intensity, seasonal timing, transfer rates) as interactive controls, so a scenario can be adjusted and re-simulated without touching code. That Shiny application is deployed publicly on shinyapps.io, so the tool doubles as both a research instrument and a decision-support interface anyone can open directly.

## Implementation

Keeping the simulation core and the interactive layer separate was a deliberate choice: the Shiny app calls the same modelling functions a command-line script would, so the interactive tool can never silently diverge from the underlying model. Seasonal forcing is implemented as smooth periodic functions rather than step changes, which better reflects how rainfall-driven transfer actually varies and avoids introducing artificial discontinuities into the numerical solution. Packaging the app for public deployment meant drawing a clean line between what only needed to run on a local machine and what had to run reliably on a hosted server, without weakening the guarantee that the deployed app and the underlying model stay in sync.

## Challenges Encountered

The main technical challenge was numerical: non-autonomous systems with periodic forcing are more sensitive to solver choice and step size than their autonomous counterparts, and an unstable configuration can produce trajectories that look plausible but don't actually reflect the underlying dynamics. A second, less technical challenge was scope: it is easy for an environmental model like this to expand indefinitely (more compartments, more pathways), and part of the work was deciding which simplifications were honest and which would have quietly changed the question being answered.

## Results

The model produces exposure trajectories that track rainfall-driven seasonal variation, rather than the flat estimates a static model would give, which was the central point of building it. The Shiny interface has made it possible to explore how sensitive exposure estimates are to specific seasonal assumptions, which is itself a useful output: it shows where the model's conclusions are robust and where they depend heavily on a specific parameter choice.

Two concrete outputs came out of this work. The modelling approach and its results are written up as a preprint, [Modélisation de l'exposition humaine au chlordécone](https://doi.org/10.13140/RG.2.2.36238.01607), for anyone who wants the full mathematical account. The model itself is deployed as a [public simulation app](https://fsu5hs-geovany0batista0polo-laguerre.shinyapps.io/chlordecone-simulation-app/), so the seasonal exposure scenarios it produces can be explored interactively rather than read about secondhand.

## Lessons Learned

A model doesn't have to be more complex to be more honest: introducing seasonal forcing added real explanatory value, while several other extensions considered would have added complexity without changing the model's conclusions. Building the interactive layer alongside the core model, rather than after it, also made it much easier to notice when a "reasonable-looking" parameter choice produced an implausible result. Publishing the preprint and deploying the app as two separate outputs, rather than treating the paper as the only real deliverable, also changed how the model was tested: an interface anyone can open invites scrutiny a static document doesn't.

## Future Improvements

Extending the model to incorporate uncertainty quantification (treating key transfer rates as distributions rather than point estimates) is the most valuable next step, since it would let the model report a range of plausible exposure levels rather than a single trajectory. Validating the model's qualitative behavior against any available field measurement data, where accessible, is the other priority.
