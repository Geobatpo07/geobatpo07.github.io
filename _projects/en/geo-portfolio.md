---
lang: en
ref: project-geo-portfolio
title: "Geo Portfolio"
excerpt: "A Next.js and TypeScript site for presenting data engineering, machine learning, and scientific computing projects."
permalink: /en/projects/geo-portfolio/
status: "Completed"
status_key: "Completed"
domain: "Scientific Data Infrastructure"
research_theme: "Scientific Data Infrastructure"
technologies: ["Next.js", "TypeScript"]
github: "https://github.com/Geobatpo07/geo-portfolio"
last_updated: 2026-03-02
date: 2026-03-02
---

## Overview

A Next.js and TypeScript site built to present data engineering, machine learning, and scientific computing projects through a modern, readable interface, the predecessor, in spirit, to the project library you're reading now.

## Scientific Context

Communicating technical work well is part of doing it well: a project that can't be explained clearly to someone outside it hasn't really been finished. This project was an exercise in that communication layer specifically: given a set of real technical projects, how do you present them so their substance is legible rather than buried in jargon or, just as bad, oversimplified into marketing language?

## Problem Statement

How do you build a presentation layer for technical projects that stays accurate to their actual complexity without requiring the reader to already understand the domain?

## Objectives

- Present data engineering, ML, and scientific computing projects through a consistent, readable structure.
- Use a modern frontend stack (Next.js, TypeScript) as a way to keep the site itself maintainable, not just as a technology showcase.
- Build something reusable enough to extend as new projects were added.

## Methodology

The site was built component-first: a consistent project-card and detail-page structure that any new project could be dropped into, rather than one-off pages per project. TypeScript was used throughout to keep the content model (what fields a project needs) explicit and checked, rather than implicit and easy to get wrong.

## Architecture

A Next.js application with typed content models for each project, statically generated for performance, with a component library shared across the project listing and individual project pages.

## Implementation

Keeping the content model typed meant that adding a new project surfaced missing fields at build time rather than as a silently broken page in production, a small discipline that paid off every time a new project was added.

## Challenges Encountered

The main challenge was scope discipline: a personal site like this can expand indefinitely in visual polish without ever finishing, and the harder work was deciding when the presentation was good enough to stop iterating on and start actually using.

## Results

The site served as a working, maintainable home for presenting technical projects, and the lessons from building it (particularly around typed content models and reusable templates) carried directly into how this current site's project library and case-study system are structured.

## Lessons Learned

A typed content model is worth the upfront cost even for a small personal site, because it turns "I forgot to add a field" from a silent bug into a build error. Building for reuse from the first project, rather than the third, made every subsequent addition faster.

## Future Improvements

This project's role has effectively been succeeded by the current site's own project library: its main remaining value is as a reference for the component patterns that shaped it.
