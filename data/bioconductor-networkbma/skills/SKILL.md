---
name: bioconductor-networkbma
description: This tool infers gene regulatory networks from time-series expression data using Bayesian Model Averaging. Use when user asks to infer gene regulatory networks, apply ScanBMA or fastBMA algorithms, integrate prior biological knowledge into network models, or evaluate network predictions using ROC and Precision-Recall curves.
homepage: https://bioconductor.org/packages/3.6/bioc/html/networkBMA.html
---


# bioconductor-networkbma

name: bioconductor-networkbma
description: Expert assistance for the networkBMA R package to infer gene regulatory networks from time-series expression data using Bayesian Model Averaging. Use this skill to perform network modeling with ScanBMA, fastBMA, or iBMA algorithms, integrate prior biological knowledge, and assess network predictions using contingency tables, ROC, and Precision-Recall curves.

# bioconductor-networkbma

## Overview

The `networkBMA` package provides a suite of Bayesian Model Averaging (BMA) methods specifically designed for uncovering regulatory relationships from time-series gene expression data. It models the expression of a gene at time $t$ as a linear combination of the expression levels of other genes at time $t-1$. The package supports the integration of prior probabilities and known regulatory edges to improve inference accuracy.

## Core Workflow

### 1. Data Preparation
The package expects expression data where rows represent observations (time points/replicates) and columns represent genes.

```R
library(networkBMA)
data(vignette)

# timeSeries: first two columns are 'replicate' and 'time'
# Genes start from column 3
gene_data <- timeSeries[, -(1:2)]
n_time_points <- length(unique(timeSeries$time))
```

### 2. Network Inference
There are three primary algorithms available via the `networkBMA` function:

*   **ScanBMA**: The preferred algorithm for most cases; uses an Occam's window approach to search the model space.
*   **fastBMA**: A high-performance C++ implementation optimized for speed.
*   **iBMA**: Iterative BMA, useful when hard-coding known regulatory relationships.

```R
# Inference using ScanBMA with prior probabilities
edges.ScanBMA <- networkBMA(data = gene_data,
                            nTimePoints = n_time_points,
                            prior.prob = reg.prob,
                            nvar = 50,
                            ordering = "bic1+prior")

# Inference using fastBMA for large datasets
edges.fastBMA <- networkBMA(data = gene_data,
                            nTimePoints = n_time_points,
                            prior.prob = reg.prob,
                            control = fastBMAcontrol(edgeMin = 0.01))
```

### 3. Integrating Prior Knowledge
*   **prior.prob**: Can be a single fraction (expected density) or a matrix of probabilities where entry $(i, j)$ is the probability that gene $i$ regulates gene $j$.
*   **known**: A data frame of confirmed regulator-target pairs to be forced into the model (requires `iBMA`).

### 4. Assessment and Validation
Compare inferred edges against a reference network (e.g., YEASTRACT or literature-curated sets).

```R
# Generate contingency tables at specific posterior probability thresholds
ctables <- contabs.netwBMA(edges.ScanBMA, 
                           referencePairs, 
                           reg.known, 
                           thresh = c(0.5, 0.75, 0.9))

# Calculate Sensitivity, Specificity, Precision, and Recall
stats <- scores(ctables, what = c("FDR", "precision", "recall"))

# Plot ROC and Precision-Recall Curves
roc_obj <- roc(contabs.netwBMA(edges.ScanBMA, referencePairs), plotit = TRUE)
prc_obj <- prc(contabs.netwBMA(edges.ScanBMA, referencePairs), plotit = TRUE)
```

## Key Parameters
*   `nvar`: Number of top-ranked variables to consider as potential regulators for each target gene.
*   `ordering`: Method to rank variables (e.g., "bic1", "prior", or "bic1+prior").
*   `diff100` / `diff0`: Logical flags to differentiate edges with 100% or 0% posterior probability.

## Tips for Success
*   **Time Series Structure**: Ensure `nTimePoints` is correctly specified. The algorithm assumes equal intervals between time points unless otherwise handled.
*   **Memory Management**: For very large networks, use `fastBMA` and adjust the `edgeMin` threshold in `fastBMAcontrol` to prune low-confidence edges early.
*   **Prior Matrix**: If using a prior matrix, ensure the row and column names match the gene names in your expression data.

## Reference documentation
- [Uncovering gene regulatory relationships from time-series expression data using networkBMA](./references/networkBMA.md)