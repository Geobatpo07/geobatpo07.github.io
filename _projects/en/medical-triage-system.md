---
lang: en
ref: project-medical-triage-system
title: "Medical Triage System"
excerpt: "A C++ decision-support tool using a Random Forest model to support pre-triage prioritization in emergency contexts."
permalink: /en/projects/medical-triage-system/
status: "Prototype Complete"
status_key: "Prototype"
domain: "Healthcare Analytics"
research_theme: "Healthcare Analytics"
technologies: ["C++", "Random Forest", "Python"]
github: "https://github.com/Geobatpo07/MedicalTriageSystem"
last_updated: 2026-03-03
date: 2026-03-03
---

## Overview

A C++ application that uses a Random Forest model, trained in Python, to support pre-triage prioritization of patients in emergency contexts, a decision-support tool, not a diagnostic one.

## Scientific Context

In emergency and resource-constrained settings, the order in which patients are seen matters as much as the care itself. Triage decisions are usually made quickly and under pressure, which is exactly the situation where a fast, interpretable second opinion can help, provided it's transparent enough that clinical staff can trust or override it, rather than a black box they have to blindly follow.

## Problem Statement

Can a lightweight model give a useful pre-triage risk signal fast enough to be practical in an emergency setting, while staying interpretable enough that a clinician can see why it produced that signal and disagree with it when appropriate?

## Objectives

- Produce a risk-prioritization score from patient data quickly enough to be usable at intake.
- Keep the model interpretable rather than treating accuracy as the only metric that matters.
- Separate the model-training step (Python) from the deployed decision-support application (C++) so the runtime tool stays fast and dependency-light.

## Methodology

A Random Forest classifier was trained in Python on patient intake features to produce a prioritization score. Random Forest was chosen specifically because its decision structure (an ensemble of relatively shallow trees) is easier to inspect and explain than deeper or less structured models, which matters more here than squeezing out marginal accuracy gains.

## Architecture

The trained model is exported and embedded into a C++ application that handles the runtime decision-support logic, keeping the deployed tool free of a Python runtime dependency. The C++ layer handles input validation and score presentation; the model itself remains a separate, versioned artifact that can be retrained and swapped without changing the application code around it.

## Implementation

Separating training from deployment this way meant the runtime application could stay small and fast, while the model itself could be iterated on independently using the full Python data-science toolchain. Input validation was treated as seriously as the model itself: a fast, wrong answer is worse than a fast, honest "insufficient data" response.

## Challenges Encountered

The main tension was between model complexity and interpretability: more complex models offered marginal accuracy improvements but made it harder to explain why a specific patient received a specific score, which mattered more for this use case than the accuracy gain justified. Porting a Python-trained model into a C++ runtime cleanly, without silently changing its behavior in the process, also required careful attention to how the model's decision logic was serialized and reproduced.

## Results

The prototype produces prioritization scores with an inspectable decision path, consistent with the goal of a tool clinicians can question rather than one they have to trust blindly. As a prototype, it has not been deployed or validated in a live clinical setting.

## Lessons Learned

For decision-support tools in high-stakes contexts, interpretability is not a nice-to-have secondary property: it's close to the primary requirement, and it's worth choosing a model architecture around it rather than optimizing for accuracy first and explaining the result after. Keeping the model and the application as separate, independently versioned artifacts made iteration substantially easier.

## Future Improvements

Any path toward real clinical use would require formal validation against real-world outcomes and a much more rigorous approach to bias and fairness in the training data than a prototype needs: that validation work, not new features, is the actual next step.
