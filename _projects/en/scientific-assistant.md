---
lang: en
ref: project-scientific-assistant
title: "Scientific Assistant"
excerpt: "A local-first, multi-agent framework combining symbolic mathematics, numerical methods, and document intelligence for reproducible research."
permalink: /en/projects/scientific-assistant/
status: "Active Development"
status_key: "Active"
domain: "Artificial Intelligence"
research_theme: "Artificial Intelligence"
technologies: ["Python", "Multi-agent Systems", "RAG", "Symbolic Computation"]
github: "https://github.com/Geobatpo07/scientific-assistant"
last_updated: 2026-03-04
date: 2026-03-04
---

## Overview

A local-first, multi-agent AI framework that combines symbolic mathematics, numerical methods, and retrieval-augmented document intelligence to support reproducible scientific research workflows.

## Scientific Context

General-purpose AI assistants are convenient but opaque: it's often unclear how they reached an answer, and reproducing that answer later isn't guaranteed. Scientific work needs something different: a system that can help with derivations, numerical experiments, and literature review, but whose reasoning stays inspectable and whose results can be reproduced independently of the specific run.

## Problem Statement

Can a multi-agent system combine symbolic reasoning, numerical computation, and literature retrieval into a single workflow without collapsing into the same opacity that makes general-purpose AI tools unsuitable for rigorous research?

## Objectives

- Keep symbolic and numerical reasoning separate from language-model-based components, so each does what it's actually reliable at.
- Make every agent's intermediate steps inspectable rather than hidden inside a single opaque response.
- Run entirely locally, so reproducibility doesn't depend on a third-party API's availability or version.

## Methodology

The framework is structured as a set of cooperating agents with distinct responsibilities: a symbolic-computation agent for exact derivations, a numerical-methods agent for simulation and computation, and a retrieval-augmented-generation agent for grounding responses in actual source documents rather than model memory alone. A coordinating layer routes a given task to the appropriate agent (or sequence of agents) based on what kind of reasoning it requires.

## Architecture

Each agent wraps a specific tool or library appropriate to its task (symbolic computation libraries for exact mathematics, numerical solvers for simulation, and a document index for retrieval) behind a common interface the coordinator can call. Because the agents are modular, a given task's execution trace shows which agent handled which step, rather than a single undifferentiated response.

## Implementation

Running everything locally was a deliberate constraint, not just a convenience: it means an experiment run today produces the same result when re-run later, independent of an external API's model version changing underneath it. Document retrieval is grounded against a locally indexed set of sources rather than an open-ended web search, which keeps the provenance of any retrieved claim traceable.

## Challenges Encountered

The hardest part was deciding where to draw the line between agents: too fine-grained, and the coordination overhead outweighs the benefit; too coarse, and you're back to one opaque system that happens to be organized differently. Getting the symbolic and numerical agents to hand off cleanly to each other, so a symbolic result could be evaluated numerically without a manual translation step, took several iterations to get right.

## Results

The framework currently supports end-to-end workflows that combine a symbolic derivation, a numerical evaluation of that derivation, and a retrieval step to check it against source material, all with an inspectable trace of which agent did what. It is still under active development rather than a finished tool.

## Lessons Learned

Modularity that makes a system's reasoning inspectable is worth more, for scientific use, than raw capability that hides its steps. Building the retrieval agent to cite specific source passages, rather than summarizing freely, made it much easier to catch when a response was subtly unsupported by its sources.

## Future Improvements

Expanding the symbolic-numerical handoff to cover a wider range of problem types, and adding a persistent record of past runs so results can be directly compared over time, are the next priorities.
