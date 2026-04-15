---
name: bioconductor-dcanr
description: This tool performs differential co-expression analysis to identify gene-gene associations that change across binary conditions. Use when user asks to perform differential co-expression analysis, benchmark DCA methods using simulated datasets, or generate gene association networks.
homepage: https://bioconductor.org/packages/release/bioc/html/dcanr.html
---

# bioconductor-dcanr

name: bioconductor-dcanr
description: Comprehensive differential co-expression analysis (DCA) and benchmarking. Use when identifying gene-gene associations that change across binary conditions or evaluating DCA methods using simulated datasets. Supports 10 methods including z-score, entropy, and LDGM.

# bioconductor-dcanr

## Overview
The `dcanr` package provides a suite of methods to perform differential co-expression analysis (DCA). It identifies gene-gene associations that change across binary conditions. The package includes 10 inference methods and a robust evaluation framework using simulated data to benchmark performance against known gold standards.

## Core Workflow: Differential Co-expression Analysis
A standard DCA pipeline follows four sequential steps.

### 1. Compute Scores
Use `dcScore` to generate statistics for each pair of genes.
```R
library(dcanr)
# emat: expression matrix (genes x samples)
# condition: binary vector (1s and 2s)
z_scores <- dcScore(emat, condition, dc.method = 'zscore', cor.method = 'spearman')
```
Available methods via `dcMethods()`: `dicer`, `diffcoex`, `ebcoexpress`, `entropy`, `ftgi`, `ggm-based`, `ldgm`, `magic`, `mindy`, `zscore`.

### 2. Statistical Testing
Apply `dcTest` to assess the significance of the scores. The appropriate test (e.g., z-test or permutation) is selected automatically based on the method.
```R
raw_p <- dcTest(z_scores, emat, condition)
```
*Note: For permutation-based methods like MINDy, use the `B` parameter to set the number of permutations.*

### 3. Multiple Testing Correction
Adjust p-values using `dcAdjust`.
```R
adj_p <- dcAdjust(raw_p, f = p.adjust, method = 'fdr')
```

### 4. Generate the Network
Threshold the results to create an `igraph` object using `dcNetwork`.
```R
dcnet <- dcNetwork(z_scores, adj_p, thresh = 0.1)
plot(dcnet, vertex.label = '')
```

## Evaluation and Benchmarking
`dcanr` includes 812 precomputed simulations for benchmarking.

### Using dcPipeline
The `dcPipeline` function wraps the entire workflow. It can run standard methods, retrieve precomputed results, or execute custom functions.
```R
data(sim102)
# Run standard pipeline
dcnets <- dcPipeline(sim102, dc.func = 'zscore')
# Retrieve precomputed results for comparison
precomp_nets <- dcPipeline(sim102, dc.func = 'zscore', precomputed = TRUE)
```

### Performance Metrics
Evaluate inferred networks against the simulation truth using `dcEvaluate`.
```R
# truth.type can be 'direct', 'influence', or 'association' (recommended)
f1_score <- dcEvaluate(sim102, dcnets, truth.type = 'association', perf.method = 'f.measure')
```
Available metrics via `perfMethods()`: `AC`, `MCC`, `accuracy`, `f.measure`, `precision`, `recall`.

## Implementation Tips
- **Condition Encoding**: Ensure the condition vector is a factor or numeric vector consisting of 1s and 2s.
- **Correlation Method**: Spearman correlation is recommended for `dcScore` as it is robust to outliers common in RNA-seq data.
- **Method Exceptions**: 
    - `EBcoexpress` and `DiffCoEx` do not require `dcTest` or `dcAdjust`.
    - `FTGI` uses p-values as scores, skipping the explicit testing step.
- **Visualization**: Use `plotSimNetwork(sim102, what = 'association')` to visualize the true differential network from a simulation.

## Reference documentation
- [Evaluating differential co-expression methods using dcanr](./references/dcanr_evaluation_vignette.md)
- [Performing differential co-expression analysis using dcanr](./references/dcanr_vignette.md)