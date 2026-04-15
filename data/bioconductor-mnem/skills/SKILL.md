---
name: bioconductor-mnem
description: The mnem package implements Mixture Nested Effects Models to perform soft clustering and causal network inference on single-cell RNA-seq data from pooled CRISPR screens. Use when user asks to reconstruct signaling networks from single-cell perturbation data, cluster cells based on response patterns, or infer causal relationships between genes.
homepage: https://bioconductor.org/packages/release/bioc/html/mnem.html
---

# bioconductor-mnem

## Overview
The `mnem` package implements Mixture Nested Effects Models (M&NEM), an extension of Nested Effects Models (NEM) designed for single-cell RNA-seq data from pooled CRISPR screens. It simultaneously performs two tasks:
1. **Soft Clustering**: Assigns cells to subpopulations (components) based on their response patterns.
2. **Network Inference**: Reconstructs a causal signaling network (S-genes) for each subpopulation.

The model handles both log odds (continuous) and binary (discrete) data and supports samples with multiple perturbations.

## Core Workflow

### 1. Data Preparation
Input data should be an $m \times n$ matrix where $m$ is the number of E-genes (features) and $n$ is the number of cells.
- **Log Odds**: Values representing the evidence of an effect (e.g., from `limma`).
- **Discrete**: Binary values (1 for effect, 0 for no effect).
- **Column Names**: Must indicate the perturbed S-gene. For multiple perturbations, use an underscore separator (e.g., `"Sgene1_Sgene2"`).

### 2. Network Inference
Use `mnem` for a fixed number of components $k$, or `mnemk` to search for the optimal $k$.

```r
library(mnem)

# Inference for a specific k
# search: "greedy", "exhaustive", or "mcmc"
result <- mnem(data, k = 2, search = "greedy", starts = 10)

# Inference across a range of k to find the best model
best_k_result <- mnemk(data, ks = 1:5, search = "greedy", starts = 5)
```

### 3. Working with Discrete Data
If using binary data, specify `method = "disc"` and provide false positive/negative rates.

```r
result_disc <- mnem(datadisc, k = 2, method = "disc", fpfn = c(0.1, 0.1))
```

### 4. Interpreting Results
- **Model Selection**: Compare `best_k_result$lls` (raw log-likelihood) and `best_k_result$ics` (penalized log-likelihood/BIC). Lower IC values indicate better models.
- **Cell Assignments**: Use `getAffinity` to extract the "responsibilities" (probability of a cell belonging to a component).
- **Visualization**: The `plot()` function visualizes the inferred networks, mixture weights, and E-gene attachments.

```r
# Get soft clustering probabilities
post_probs <- getAffinity(result$probs, mw = result$mw)

# Plot the mixture model
plot(result)

# Check EM convergence
plotConvergence(result)
```

## Key Functions
- `mnem()`: Main EM algorithm for a fixed number of components.
- `mnemk()`: Wrapper to run `mnem` for multiple $k$ values and perform model selection.
- `simData()`: Simulates single-cell perturbation data for testing.
- `getAffinity()`: Calculates the posterior probabilities (responsibilities) for each cell.
- `getIC()`: Calculates the penalized log-likelihood (Information Criterion) for a model.

## Tips
- **Parallelization**: Use the `parallel` parameter in `mnem` or `mnemk` to speed up computation on multi-core systems.
- **Starts**: The EM algorithm is sensitive to initial conditions. Increase the `starts` parameter (e.g., 10-50) for more robust results on real data.
- **Large Data**: For data sets with many E-genes, `mnem` automatically uses a specialized calculation to prevent numerical overflow when computing expectations.

## Reference documentation
- [Mixture Nested Effects Models Vignette](./references/mnem.Rmd)
- [mnem: Simultaneous inference of causal networks and subpopulations](./references/mnem.md)