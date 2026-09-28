---
lang: en
ref: project-datahut
title: "DataHut-DuckHouse"
excerpt: "A modular, multi-tenant analytics platform built for reproducibility first: the data infrastructure underneath the rest of this research."
permalink: /en/projects/datahut/
status: "Active · Open Source"
status_key: "Active"
domain: "Scientific Data Infrastructure"
research_theme: "Scientific Data Infrastructure"
technologies: ["DuckDB", "Apache Iceberg", "Arrow Flight", "dbt", "Trino"]
github: "https://github.com/Geobatpo07/datahut-duckhouse"
last_updated: 2026-03-05
date: 2026-03-05
---

## Overview

A modular analytics platform integrating DuckDB, Apache Iceberg, Arrow Flight, dbt, and Trino, designed so that reproducibility, not scale, is the primary constraint the architecture optimizes for.

## Scientific Context

Most analytics platforms are built for business throughput: more users, more concurrent queries, more dashboards. Research work has a different bottleneck: the same analysis, run again by someone else, with the same data and the same result. That gap between "works for me" and "reproducible for anyone" is what DataHut-DuckHouse is built around.

## Problem Statement

Assembling a data stack that supports exploratory analysis, transformation, and reporting usually means gluing together tools that weren't designed to work together, with reproducibility as an afterthought. The question here: what does a data platform look like if reproducibility is a first-class design constraint from the start, rather than something bolted on later?

## Objectives

- Provide a lightweight, self-hostable analytics stack that doesn't require heavyweight infrastructure to run.
- Keep transformations declarative and version-controlled rather than embedded in ad hoc scripts.
- Support multi-tenant use without each tenant needing a separate deployment.

## Methodology

The platform combines DuckDB as an embedded analytical engine, Apache Iceberg as a table format for versioned, schema-evolving datasets, Arrow Flight for efficient data transport, dbt for declarative, testable transformations, and Trino for federated querying across sources. Each component was chosen for doing one job well rather than for being part of a single vendor's ecosystem.

## Architecture

Data lands in Iceberg tables, which give the platform snapshot isolation and schema evolution without a separate metadata service. DuckDB provides fast local analytical queries directly against those tables; Trino is used when a query needs to span multiple data sources. dbt sits on top as the transformation layer, so every derived table has a version-controlled definition rather than a one-off script. Arrow Flight handles data movement between components without the serialization overhead of row-based formats.

## Implementation

Multi-tenancy is handled at the table and catalog level rather than through separate infrastructure per tenant, which keeps the operational footprint small. Every transformation is expressed as a dbt model with its own tests, so a broken assumption fails loudly in CI rather than quietly in a downstream report.

## Challenges Encountered

Getting Iceberg's schema evolution to behave predictably across DuckDB and Trino simultaneously took real trial and error: the two engines don't always interpret the table format identically, and reconciling that was more about careful configuration than about either tool being wrong. The other recurring challenge was resisting scope creep: it's tempting to keep adding connectors and features, and the harder discipline was deciding what belonged in the reproducibility-first core versus what should stay a separate, optional layer.

## Results

The platform currently supports a working local-first analytics workflow (ingestion into Iceberg, transformation via dbt, and querying through either DuckDB or Trino depending on the scope of the query) and has attracted open-source interest reflected in its 12+ GitHub stars. It functions as the data layer behind the other computational research in this portfolio, including the exploratory work behind the chlordecone modelling.

## Lessons Learned

Choosing composable, single-purpose tools over an all-in-one platform made the system easier to reason about, even though it meant more integration work up front. Writing dbt tests alongside transformations, not after them, caught more real data-quality issues than any amount of manual review would have.

## Future Improvements

Formalizing multi-tenant access control (rather than relying on catalog-level separation alone) and adding first-class data lineage tracking are the two most valuable next steps, both aimed at making the platform trustworthy enough for someone outside the project to adopt with confidence.
