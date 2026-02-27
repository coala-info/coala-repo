---
name: bioconductor-perturbatr
description: This package analyzes high-throughput genetic perturbation screens using hierarchical models and network diffusion to identify gene hits. Use when user asks to integrate multiple genetic screens, estimate gene effect sizes across conditions, or apply network propagation to smooth results using biological networks.
homepage: https://bioconductor.org/packages/3.8/bioc/html/perturbatr.html
---


# bioconductor-perturbatr

name: bioconductor-perturbatr
description: Analysis of high-throughput genetic perturbation screens (RNAi, CRISPR) using hierarchical models and network diffusion. Use when integrating multiple screens, estimating gene effect sizes across conditions, or smoothing results using biological networks to identify hits.

# bioconductor-perturbatr

## Overview

The `perturbatr` package provides a framework for the stage-wise analysis of large-scale genetic perturbation screens. It is specifically designed for integrated datasets consisting of multiple screens (e.g., different viruses, cell lines, or infection stages). It uses hierarchical linear mixed-effects models to estimate gene effect sizes while accounting for variance between biological conditions and applies network propagation (diffusion) to correct for false negatives by leveraging known gene-gene interactions.

## Data Preparation

### Creating PerturbationData Objects
The core data structure is the `PerturbationData` S4 object. Convert a `data.frame` or `tibble` using the `as` method.

```r
library(perturbatr)
# Convert data.frame to PerturbationData
pd <- methods::as(your_dataframe, "PerturbationData")
```

### Required Column Schema
The input data must contain the following columns:
- **Condition**: Unique identifier for the screen (e.g., "SARS", "HCV").
- **Replicate**: Integer representing the replicate number.
- **GeneSymbol**: Character vector of gene identifiers (e.g., HUGO, Entrez).
- **Perturbation**: Identifier for the specific reagent (e.g., siRNA ID, gRNA ID).
- **Readout**: Normalized numeric value (e.g., log-fold change, Z-score).
- **Control**: Integer vector: `-1` (negative control), `1` (positive control), `0` (sample).

### Data Manipulation
- **Access data**: Use `dataSet(pd)` to retrieve the underlying tibble.
- **Filter**: Use `perturbatr::filter(pd, ...)` to subset data based on predicates.
- **Combine**: Use `rbind(pd1, pd2)` to merge multiple `PerturbationData` objects.

## Hierarchical Modeling

Use the `hm()` function to fit a hierarchical model. This ranks genes by estimating effect sizes across different conditions.

### Model Specification
Define the model using an R formula. Typically, `Readout` is the response, and `Condition` is a fixed effect, while `GeneSymbol` and its interaction with `Condition` are random effects.

```r
# Example formula for pan-condition analysis
frm <- Readout ~ Condition + 
                 (1|GeneSymbol) + 
                 (1|Condition:GeneSymbol)

# Fit the model
res.hm <- hm(pd, formula = frm)
```

### Interpreting Results
- **Global Effects**: Use `geneEffects(res.hm)` to get the ranking of genes across all conditions.
- **Condition-Specific Effects**: Use `nestedGeneEffects(res.hm)` to see effects for specific conditions.
- **Visualization**: `plot(res.hm)` generates plots for the top 25 strongest gene effects (pan-viral and nested).

## Network Diffusion

To reduce false negatives, "smooth" the hierarchical model results using a gene interaction network.

### Running Diffusion
Supply a graph (as a data.frame of edges) to the `diffuse()` function.

```r
# Load a network (edge list)
graph <- readRDS("path/to/graph.rds")

# Apply network propagation
res.diff <- diffuse(res.hm, 
                    graph = graph, 
                    r = 0.35, 
                    delete.nodes.on.degree = 1)
```

### Parameters
- **r**: Restart probability for the Markov random walk (typically 0.3 to 0.5).
- **correct.for.hubs**: Boolean to normalize for high-degree nodes.
- **take.largest.component**: Boolean to restrict analysis to the largest connected subgraph.

## Workflow Summary

1.  **Format**: Ensure data has required columns and convert to `PerturbationData`.
2.  **Explore**: Use `plot(pd)` to check replicate consistency and gene coverage.
3.  **Model**: Fit a hierarchical model with `hm()` to identify primary hits.
4.  **Diffuse**: Use `diffuse()` with a protein-protein interaction (PPI) network to refine the hit list.
5.  **Rank**: Extract final rankings using `geneEffects()` or `plot()`.

## Reference documentation
- [perturbatr tutorial](./references/perturbatr.Rmd)
- [perturbatr cookbook](./references/perturbatr.md)