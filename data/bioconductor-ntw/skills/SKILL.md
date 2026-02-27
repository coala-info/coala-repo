---
name: bioconductor-ntw
description: The NTW package infers gene interaction networks from steady-state gene expression data by solving a linearized system of ordinary differential equations. Use when user asks to estimate gene interaction matrices, identify perturbation targets from expression rankings, or refine prior network structures using regression methods.
homepage: https://bioconductor.org/packages/release/bioc/html/NTW.html
---


# bioconductor-ntw

## Overview

The `NTW` (Network of Transcripts Wirings) package is designed to infer gene interaction networks from steady-state gene expression data. It solves the linearized ODE system $AX = -P$, where $A$ is the $n \times n$ interaction network, $X$ is the $n \times m$ expression matrix, and $P$ is the $n \times m$ perturbation matrix. 

A key feature of `NTW` is its ability to estimate the network even when the perturbation matrix $P$ is unknown, by identifying potential targets based on expression rankings. It also allows for "forward" or "backward" refinement of a prior network (e.g., from literature).

## Core Workflow

### 1. Data Preparation
Input data `X` should be a matrix where rows are genes and columns are experiments/samples.

```r
library(NTW)
data(sos.data)
X <- as.matrix(sos.data)
```

### 2. Parameter Setting
Several parameters control the search space and computation time:
- `restK`: Vector of maximum connections per gene (suggested: 20-30% of total genes).
- `topD`: Number of branches kept in the grid search tree (suggested: 20-30% of total genes).
- `topK`: Number of potential target genes per perturbation (suggested: 10-20% of total genes).
- `numP`: Maximum number of times a gene can be perturbed across all experiments.

```r
restK <- rep(ncol(X)-1, nrow(X))
topD <- round(0.6 * nrow(X))
topK <- round(0.5 * nrow(X))
numP <- round(0.25 * nrow(X))
```

### 3. Network Estimation (Main Function)
Use the `NTW` function to estimate both $A$ and $P$.

**Without Prior Knowledge:**
```r
result <- NTW(X, restK, topD, topK, P.known=NULL, cFlag="sse", 
              pred.net=NULL, sup.drop=-1, numP, noiseLevel=0.1)
# Access results
est_A <- result$est.A
est_P <- result$est.P
```

**With Prior Knowledge:**
`pred.net` is a Boolean matrix of the same dimensions as $A$. `sup.drop` determines the mode: `1` for forward (adding edges) and `-1` for backward (pruning edges).

```r
result <- NTW(X, restK, topD, topK, P.known=NULL, cFlag="geo", 
              pred.net=my_prior_matrix, sup.drop=1, numP)
```

### 4. Regression Methods (`cFlag`)
- `sse`: Ordinary linear regression (Standard).
- `geo`: Error-in-variable model (Geometric mean).
- `ml`: Maximum likelihood method (requires `noiseLevel`).

## Parallel Processing and Row-wise Estimation
For large networks, estimate rows independently to distribute the workload:

**When P is unknown:**
```r
# Pre-estimate potential perturbation targets
IX <- P.preestimation(X, topK = round(0.2 * nrow(X)))
# Estimate row 1
row1 <- AP.estimation.Srow(r=1, cMM.corrected=1, pred.net=NULL, X, IX, 
                           topD, restK, cFlag="sse", sup.drop=-1, numP)
```

**When P is known:**
```r
row1 <- A.estimation.Srow(r=1, cMM.corrected=1, pred.net=NULL, X, 
                          P.known, topD, restK, cFlag="ml")
```

## Tips for Success
- **Sparsity:** The algorithm assumes the gene interaction matrix is sparse. Setting `restK` too high significantly increases computation time.
- **Prior Knowledge:** If using `pred.net`, ensure `cMM.corrected` is set to 1 in the sub-functions.
- **Data Scaling:** Ensure expression data `X` is properly normalized (e.g., log-transformed or standardized) before input.

## Reference documentation
- [NTW](./references/NTW.md)