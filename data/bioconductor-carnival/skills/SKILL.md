---
name: bioconductor-carnival
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CARNIVAL.html
---

# bioconductor-carnival

name: bioconductor-carnival
description: Causal network contextualization using Integer Linear Programming (ILP) to derive signaling architectures from gene expression footprints. Use when Claude needs to integrate prior knowledge networks (PKN) with transcription factor (TF) or pathway activities to infer upstream signaling paths. Supports standard (known perturbation targets) and inverse (unknown targets) causal reasoning.

# bioconductor-carnival

## Overview

CARNIVAL (CAusal Reasoning pipeline for Network identification using Integer VALue programming) is an R package used to identify the most likely signaling network topology that explains observed downstream changes (e.g., gene expression footprints). It transforms the network inference problem into an ILP optimization task, finding a family of highest-scoring networks that best explain inferred TF activities.

## Core Workflows

### 1. Standard CARNIVAL (Vanilla)
Use `runVanillaCarnival` when the experimental perturbations (e.g., drug targets, knockouts) are known.

```r
library(CARNIVAL)

# Define options (lpSolve is default for small examples)
options <- defaultLpSolveCarnivalOptions()
options$outputFolder <- "results_vanilla"

# Run pipeline
results <- runVanillaCarnival(
  perturbations = my_perturbations,      # Named vector: 1 (act), -1 (inh)
  measurements = my_measurements,        # Named vector of TF activities
  priorKnowledgeNetwork = my_pkn,        # Data frame: source, interaction, target
  carnivalOptions = options
)
```

### 2. Inverse CARNIVAL
Use `runInverseCarnival` when the upstream perturbation targets are unknown. The algorithm will infer potential entry points into the network.

```r
options <- defaultLpSolveCarnivalOptions()
options$outputFolder <- "results_inverse"

results <- runInverseCarnival(
  measurements = my_measurements,
  priorKnowledgeNetwork = my_pkn,
  carnivalOptions = options
)
```

### 3. Two-Step Execution
For complex setups or when using external solvers, generate the LP file first.

```r
# Step 1: Generate LP file
generateLpFileCarnival(
  perturbations = my_perturbations,
  measurements = my_measurements,
  priorKnowledgeNetwork = my_pkn,
  carnivalOptions = options
)

# Step 2: Run from generated files
results <- runFromLpCarnival(
  lpFile = "path/to/file.lp",
  parsedDataFile = "path/to/data.RData",
  carnivalOptions = options
)
```

## Solver Selection

CARNIVAL requires an ILP solver. Specify the solver in the options object.

*   **lpSolve**: Use `defaultLpSolveCarnivalOptions()`. Best for small toy examples; included with the R package.
*   **Cbc / CPLEX / Gurobi**: Required for large-scale real-world networks. Users must provide the path to the executable in the options.

```r
# Example for CPLEX
options <- defaultCplexCarnivalOptions()
options$solverPath <- "/path/to/cplex_executable"
```

## Interpreting Results

The output is a list containing:
*   `weightedSIF`: A data frame of edges with weights (frequency of appearance in the optimal network family).
*   `nodesAttributes`: Activity states for nodes (Up-regulated, Down-regulated, or Zero).
*   `sifAll`: A list of individual network solutions.
*   `attributesAll`: Activity states for each individual solution.

## Tips for Success
*   **Data Format**: Ensure the Prior Knowledge Network (PKN) has columns named `source`, `interaction` (1 or -1), and `target`.
*   **TF Activities**: Measurements should be discretized or continuous TF activities (often derived via DoRothEA).
*   **Visualization**: Use `graphviz` or export the `weightedSIF` to Cytoscape for network visualization.

## Reference documentation

- [Contextualizing large scale signalling networks from expression footprints with CARNIVAL](./references/CARNIVAL.md)
- [CARNIVAL Vignette Source](./references/CARNIVAL.Rmd)