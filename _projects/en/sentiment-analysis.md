---
lang: en
ref: project-sentiment-analysis
title: "Sentiment Analysis Pipeline"
excerpt: "An NLP pipeline for automated sentiment classification, built as a testbed for text-preprocessing and evaluation methodology."
permalink: /en/projects/sentiment-analysis/
status: "Completed"
status_key: "Completed"
domain: "Artificial Intelligence"
research_theme: "Machine Learning"
technologies: ["Python", "NLP", "Scikit-learn"]
github: "https://github.com/Geobatpo07/sentiment-analysis"
last_updated: 2026-03-01
date: 2026-03-01
---

## Overview

An NLP pipeline for automated sentiment classification of text into positive, neutral, and negative categories, built as a focused exercise in text preprocessing, feature representation, and evaluation methodology.

## Scientific Context

Sentiment classification is a well-studied problem, which is exactly what makes it useful as a testbed: with the modelling question mostly settled, it becomes a place to be rigorous about the parts that are easy to shortcut: data cleaning, evaluation design, and honestly characterizing where a model fails, rather than just reporting an aggregate accuracy number.

## Problem Statement

How much of a sentiment classifier's performance comes from the model versus from the quality of preprocessing and feature representation upstream of it? And where, specifically, does a reasonably simple pipeline still get things wrong?

## Objectives

- Build a complete pipeline from raw text to classified sentiment, treating each stage as something to evaluate independently.
- Compare feature representations rather than assuming one is obviously correct.
- Characterize failure modes, not just aggregate accuracy.

## Methodology

The pipeline follows a standard structure (preprocessing, vectorization, training, evaluation) with deliberate attention at each stage: text normalization choices were tested for their effect on downstream accuracy rather than applied by default, and multiple vectorization approaches were compared before settling on one.

## Architecture

Raw text moves through a preprocessing stage (normalization, tokenization, noise removal), a vectorization stage that converts cleaned text into numerical features, and a classification stage that assigns a sentiment label. Each stage is a separate, swappable component, which made it straightforward to isolate how much a given preprocessing choice actually mattered.

## Implementation

Evaluation was built around more than a single accuracy number: confusion matrices and per-class performance were used throughout to catch cases where a model looked good in aggregate but was systematically weak on, for instance, neutral-sentiment text, which is typically the hardest class to classify correctly.

## Challenges Encountered

Neutral sentiment was consistently the hardest category, both for the model and for defining ground truth in the first place: human-labeled "neutral" text is often genuinely ambiguous, which puts a ceiling on any model's achievable accuracy that has nothing to do with the model itself. Balancing preprocessing aggressiveness was another tension: more aggressive text cleaning simplified the input but occasionally removed signal that mattered for sentiment.

## Results

The pipeline achieves solid separation between clearly positive and clearly negative text, with the expected drop in reliability for neutral and ambiguous cases. Its main value has been as a methodology exercise: a clean, well-evaluated reference pipeline rather than a novel modelling contribution.

## Lessons Learned

Comparing preprocessing and feature-representation choices explicitly, instead of defaulting to whatever's conventional, surfaced real differences in downstream performance that would have otherwise gone unnoticed. Evaluating per-class performance rather than only aggregate accuracy is what actually revealed where the pipeline was weak.

## Future Improvements

Extending the evaluation to out-of-domain text (text stylistically different from the training data) would be the most informative next step, since that is where preprocessing and feature choices tend to matter most.
