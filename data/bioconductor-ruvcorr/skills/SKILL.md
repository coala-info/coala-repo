---
name: bioconductor-ruvcorr
description: The RUVcorr package removes systematic noise and batch effects from gene expression data to recover true gene-gene correlation structures for co-expression analysis. Use when user asks to remove unwanted variation from expression data, identify empirical negative control genes, or prioritize genes based on co-expression patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/RUVcorr.html
---


# bioconductor-ruvcorr

## Overview
The `RUVcorr` package implements the Global Removal of Unwanted Variation (RUV) framework specifically optimized for gene co-expression analysis. Unlike standard RUV methods that focus on differential expression, `RUVcorr` (specifically the `RUVNaiveRidge` algorithm) aims to recover the true underlying gene-gene correlation structure by removing systematic noise (batch effects, unobserved covariates) at the expense of absolute expression values.

## Core Workflow

### 1. Data Preparation
Input data must be a matrix where columns are genes and rows are samples.
```r
library(RUVcorr)
# Ensure genes are columns
expr_matrix <- t(raw_expression_data) 
```

### 2. Selecting Negative Control Genes
Negative controls (genes unrelated to the biological factor of interest) are critical. If a priori controls are unavailable, use empirical selection:
```r
# Exclude genes of interest (e.g., your positive controls or candidates)
nc_index <- empNegativeControls(expr_matrix, exclude = interest_indices, nc = 3000)

# Visualize selection
genePlot(expr_matrix, index = nc_index, title = "Empirical NC Selection")
```

### 3. Applying RUVNaiveRidge
The method requires two parameters: `k` (dimensionality of unwanted variation) and `nu` (ridge penalty). It is best practice to test a grid of parameters.
```r
# Single run
cleaned_data <- RUVNaiveRidge(Y = expr_matrix, center = TRUE, nc_index = nc_index, nu = 500, k = 2)
```

### 4. Parameter Evaluation
Use plotting functions to determine the optimal `k` and `nu`.
*   **`histogramPlot`**: Compare correlation densities of known positive/negative controls against raw data.
*   **`RLEPlot`**: Check Relative Log Expression to ensure data isn't over-corrected (variance shouldn't be too low).
*   **`PCAPlot`**: Verify if batch effects or known noise clusters are removed.
*   **`eigenvaluePlot`**: Assist in choosing the dimension `k`.

### 5. Gene Prioritisation
Identify candidate genes co-expressed with a known set of genes:
```r
# 1. Calculate significance threshold
Prop <- calculateThreshold(cleaned_data, exclude = c(nc_index, cand_index), 
                           index.ref = ref_index, set.size = length(cand_index))
threshold <- predict(Prop$loess.estimate, 0.3)

# 2. Prioritise
results <- prioritise(cleaned_data, ref_index, cand_index, threshold = threshold)
```

## Simulation of Expression Data
`RUVcorr` can generate realistic datasets to test co-expression algorithms:
```r
# Independent signal and noise
Yind <- simulateGEdata(n=3000, m=1000, k=10, corr.strength=5, nc=2000, ne=1000)

# Dependent signal and noise (more realistic)
# g = dimension of shared subspace between signal X and noise W
Ydep <- simulateGEdata(n=3000, m=1000, k=10, g=2, corr.strength=5, nc=2000, ne=1000)
```

## Tips for Success
*   **Sample Size**: Co-expression analysis typically requires >100 samples for robust results.
*   **Parallelization**: Use `snowfall` or `BiocParallel` when testing large grids of `k` and `nu` parameters to save time.
*   **RNA-seq**: While designed for microarrays, it works for RNA-seq if data is properly transformed (e.g., log-transformed VST or CPM counts).
*   **Negative Controls**: The choice of `nc_index` is the most influential factor. If results look poor, re-evaluate the empirical selection or increase the number of controls.

## Reference documentation
- [Simulating and cleaning gene expression data using RUVcorr](./references/Vignette.md)