---
name: bioconductor-spem
description: This tool reconstructs gene regulatory networks from time-series expression data by estimating parameters for an S-system model. Use when user asks to estimate S-system parameters, calculate slopes from time-series data, or perform network inference using power-law formalism.
homepage: https://bioconductor.org/packages/release/bioc/html/SPEM.html
---


# bioconductor-spem

name: bioconductor-spem
description: S-system Parameter Estimation Method (SPEM) for reconstructing gene regulatory networks from time-series data. Use this skill to estimate parameters (alpha, beta, G, and H) of an S-system model, calculate slopes from expression data, and perform row-wise or global optimization for network inference.

# bioconductor-spem

## Overview

The `SPEM` package implements the S-system Parameter Estimation Method to reconstruct gene networks from time-series expression data. It uses a power-law formalism (S-systems) to capture non-linear interactions between genes. The model identifies two types of parameters: scale parameters ($\alpha, \beta$) and kinetic orders ($G, H$). The $G$ and $H$ matrices represent activation and inhibition interactions, respectively, which are used to build directed, signed regulatory networks.

## Core Workflow

### 1. Data Preparation
SPEM requires data in an `ExpressionSet` format. The `phenoData` must contain a column named `"time"` indicating the exact time points of the samples.

```r
library(SPEM)
library(Biobase)

# Example: Creating a compatible ExpressionSet
data_matrix <- matrix(runif(12), nrow=3, ncol=4)
rownames(data_matrix) <- c("G1", "G2", "G3")
time_info <- data.frame(time = c(0, 2, 4, 6), row.names = colnames(data_matrix))
metadata <- data.frame(labelDescription = "Time points", row.names = "time")
phenoData <- new("AnnotatedDataFrame", data = time_info, varMetadata = metadata)
eset <- new("ExpressionSet", exprs = data_matrix, phenoData = phenoData)
```

### 2. Global Parameter Estimation
Use the `SPEM` function to estimate all parameters for the entire network simultaneously.

```r
# Parameters
n <- 10            # Number of times to guess initial beta (higher = more stable)
sparsity <- 0.1    # Threshold to set small interactions to zero
lbH <- -3; ubH <- 3 # Bounds for kinetic orders (H)
lbB <- 0; ubB <- 10 # Bounds for beta

results <- SPEM(eset, n, sparsity, lbH, ubH, lbB, ubB)

# Accessing results
# results$alpha, results$g, results$beta, results$h
```

### 3. Row-wise Optimization
If you prefer to estimate parameters for a single gene or need more control over the optimization, use `row_optimize`. This requires pre-calculating the slope.

```r
# 1. Calculate slopes for all genes
slopes <- s_diff(eset)

# 2. Optimize for the first gene (row 1)
S_row1 <- slopes[1, ]
initial_beta <- runif(1, 0, 10)
row_res <- row_optimize(eset, S_row1, initial_beta, sparsity, lbH, ubH, lbB, ubB)
```

### 4. Network Reconstruction
The interaction matrix $A$ is derived from the $G$ and $H$ matrices. An element $A_{ij}$ represents the influence of gene $j$ on gene $i$.

```r
# Combine G and H to find the dominant interaction
# A_ij = max(g_ij, h_ij)
interaction_matrix <- pmax(results$g, results$h)
```

## Key Functions

- `SPEM()`: The primary function for full-network parameter estimation.
- `s_diff()`: Calculates the slope matrix from time-series data using curve-fitting to reduce noise.
- `row_optimize()`: Performs optimization for a single gene (row) at a time.

## Tips for Success

- **Stability**: Because initial $\beta$ values are generated randomly, run the optimization multiple times (set `n` to 10 or higher) to ensure the solution is reliable.
- **Sparsity**: Biological networks are typically sparse. Adjust the `sparsity` parameter to filter out low-confidence interactions and produce a cleaner topology.
- **Noise**: `s_diff` uses a curve-fitting algorithm to handle noise in experimental data before calculating slopes. Always use this or a similar smoothing method for real biological datasets.

## Reference documentation

- [SPEM (S-system Parameter Estimation Method)](./references/SPEM-package.md)