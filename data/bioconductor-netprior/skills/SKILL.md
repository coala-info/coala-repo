---
name: bioconductor-netprior
description: This package implements a probabilistic framework to prioritize genes by integrating network data, phenotypes, and prior knowledge using an Expectation-Maximization algorithm. Use when user asks to rank genes for biological processes, integrate multiple gene-gene similarity networks, or perform network-based gene prioritization.
homepage: https://bioconductor.org/packages/release/bioc/html/netprioR.html
---

# bioconductor-netprior

## Overview

The `netprioR` package implements a probabilistic framework for gene prioritisation. It is designed to integrate three distinct types of information:
1. **Network Data**: Gene-gene similarity matrices (e.g., protein-protein interactions).
2. **Phenotypes**: Quantitative measures of gene function or effect (e.g., GWAS scores, RNAi screens).
3. **Prior Knowledge**: Known true positive (TP) and true negative (TN) labels for the specific biological process of interest.

The model uses an Expectation-Maximization (EM) algorithm to learn the optimal weights for different networks and impute missing labels, resulting in a robustly ranked list of genes.

## Typical Workflow

### 1. Data Preparation
The package requires three inputs:
- **Networks**: A list of adjacency matrices (can be sparse `Matrix` objects).
- **Phenotypes**: A matrix or data frame where rows are genes and columns are features.
- **Labels**: A factor vector of labels ("Positive", "Negative", or `NA` for unknown).

```r
library(netprioR)

# Example: List of adjacency matrices
# networks <- list(PPI = adj_matrix_1, CoExp = adj_matrix_2)

# Example: Phenotype matrix
# phenotypes <- matrix(rnorm(1000), ncol = 1)

# Example: Labels (use NA for genes to be prioritised)
# labels <- factor(c("Positive", "Negative", NA, ...))
```

### 2. Model Fitting
The main function is `netprioR()`. It performs parameter inference and prioritisation.

```r
# Fit the model
fit <- netprioR(networks = networks, 
                phenotypes = phenotypes, 
                labels = labels,
                nrestarts = 5,      # Use multiple restarts to avoid local minima
                thresh = 1e-6,      # Convergence threshold
                a = 0.1, b = 0.1,   # Hyperparameters for Gamma prior (sparsifying)
                fit.model = TRUE)

# View summary of weights and likelihood
summary(fit)
```

### 3. Interpreting Results
The model assigns weights to each input network, indicating their informativeness for the task.

- **Network Weights**: Accessible via `summary(fit)`. High weights indicate the network aligns well with the labels and phenotypes.
- **Ranks**: The prioritised list of genes.
- **Visualization**: Use `plot(fit, which = "all")` to see log-likelihood convergence, network weights, and rank distributions.

### 4. Performance Evaluation
If you have a set of "true" labels for validation, use the `ROC` function.

```r
# Compute and plot ROC curve
perf <- ROC(fit, true.labels = validation_labels, plot = TRUE)
```

## Tips and Best Practices
- **Network Sparsity**: The model handles sparse matrices efficiently. Use the `Matrix` package to save memory.
- **Hyperparameters**: The parameters `a` and `b` control the Gamma prior on network weights. Small values (e.g., 0.01 or 0.1) act as a sparsifying prior, effectively performing network selection.
- **Restarts**: Always use `nrestarts > 1` in real-world applications to ensure the EM algorithm finds a global maximum.
- **Phenotype Scaling**: Ensure phenotypes are appropriately scaled (e.g., z-scores) before inputting them into the model.

## Reference documentation
- [netprioR Vignette](./references/netprioR.md)