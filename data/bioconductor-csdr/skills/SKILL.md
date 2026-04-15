---
name: bioconductor-csdr
description: This tool performs differential co-expression analysis using the CSD algorithm to compare gene expression networks between two conditions. Use when user asks to identify conserved, specific, or differentiated gene co-expression patterns, compare gene networks between biological states, or run the CSD algorithm on expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/csdR.html
---

# bioconductor-csdr

name: bioconductor-csdr
description: Perform differential co-expression analysis using the CSD (Conserved, Specific, Differentiated) algorithm. Use this skill to compare gene expression networks between two conditions (e.g., disease vs. healthy) to identify gene pairs that maintain, lose, or reverse their co-expression patterns.

# bioconductor-csdr

## Overview

The `csdR` package implements the CSD algorithm to compare gene co-expression between two conditions. It uses Spearman correlation and bootstrapping to calculate three distinct scores for every gene pair: Conserved (C), Specific (S), and Differentiated (D). This allows for the identification of functional modules that change behavior across biological states.

## Installation

Install the package via Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("csdR")
library(csdR)
```

## Data Preparation

Ensure input data meets these criteria before analysis:
- **Two Matrices**: Input `x_1` and `x_2` must be expression matrices (genes as rows, samples as columns).
- **No Missing Values**: Fill NAs with average or pseudo-values.
- **Matching Labels**: Gene names/IDs must be identical and in the same order in both matrices.
- **Continuous Values**: Data should be continuous numerical values (Spearman correlation uses ranks).

## Core Workflow

### 1. Run CSD Analysis
Use `run_csd` to compute the differential co-expression scores.

```r
# n_it: bootstrap iterations (100+ recommended for production)
# nThreads: parallel processing (diminishing returns > 10)
csd_results <- run_csd(
    x_1 = normal_expression, 
    x_2 = sick_expression,
    n_it = 100, 
    nThreads = 4, 
    verbose = TRUE
)
```

### 2. Interpret Scores
The output dataframe contains the following metrics for each gene pair:
- **cVal (Conserved)**: High if the pair has strong co-expression in both conditions.
- **sVal (Specific)**: High if the pair is strongly co-expressed in one condition but not the other.
- **dVal (Differentiated)**: High if the pair is strongly co-expressed in both, but with opposite signs (positive vs. negative correlation).

### 3. Filter Top Results
Because CSD evaluates all possible gene pairs, use `partial_argsort` to extract the most significant edges without overloading memory.

```r
# Extract top 100 edges for each category
n_top <- 100L
c_indices <- partial_argsort(csd_results$cVal, n_top)
s_indices <- partial_argsort(csd_results$sVal, n_top)
d_indices <- partial_argsort(csd_results$dVal, n_top)

# Create filtered dataframes
c_top <- csd_results[c_indices, ]
s_top <- csd_results[s_indices, ]
d_top <- csd_results[d_indices, ]
```

## Downstream Network Analysis

Convert results to `igraph` objects for visualization or topological analysis.

```r
library(igraph)
# Create a specific network
s_net <- graph_from_data_frame(s_top, directed = FALSE)

# Combine networks and assign types
E(s_net)$type <- "Specific"
# ... repeat for C and D, then union
```

## Technical Considerations

- **Memory**: For large datasets (20k+ genes), CSD is memory-intensive. Use a high-RAM compute server rather than a standard laptop.
- **Bootstrapping**: Results depend on `n_it`. If results are not reproducible across different seeds, increase the number of iterations.
- **Parallelization**: Parallelism happens within iterations. Increasing `nThreads` increases memory consumption proportionally.

## Reference documentation

- [Analyzing differential co-expression with csdR](./references/csdR.md)
- [csdR Vignette Source](./references/csdR.Rmd)