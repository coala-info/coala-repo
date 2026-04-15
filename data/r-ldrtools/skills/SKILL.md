---
name: r-ldrtools
description: This tool provides functions for working with linear dimension reduction subspaces by representing them as orthogonal projection matrices. Use when user asks to compute distances between subspaces, convert orthogonal matrices to projection matrices, or calculate average subspaces from multiple results.
homepage: https://cran.r-project.org/web/packages/ldrtools/index.html
---

# r-ldrtools

name: r-ldrtools
description: Tools for linear dimension reduction (LDR) subspaces. Use this skill to compute distances between subspaces, work with orthogonal projection matrices, and calculate average subspaces from multiple LDR results.

## Overview

The `LDRTools` package provides a framework for handling linear dimension reduction subspaces by representing them as orthogonal projection matrices. This approach allows for the comparison of different LDR methods (like SIR, SAVE, or DR) and the computation of a "mean" subspace when multiple estimates are available.

## Installation

```R
install.packages("LDRTools")
```

## Core Functions

### Subspace Representation
LDR subspaces are uniquely defined by their orthogonal projection matrices.
- `O2P(U)`: Converts an orthogonal matrix `U` (where columns span the subspace) into a projection matrix $P = UU^T$.

### Distance Measures
Compute the distance between two subspaces of the same or different dimensions:
- `distance(P1, P2, type = "canonical")`: Calculates the distance between two projection matrices.
  - `type = "canonical"`: The default distance based on principal angles.
  - `type = "procrustes"`: The Procrustes distance.

### Averaging Subspaces
When you have multiple LDR results (e.g., from bootstrapping or different algorithms), you can find a consensus subspace:
- `Averaging(P_list)`: Computes the average projection matrix from a list or array of projection matrices.
- `P_avg`: The result is a projection matrix representing the "mean" subspace.

## Workflow: Comparing Two LDR Results

1. **Extract Basis**: Obtain the basis matrices $B_1$ and $B_2$ from two different LDR models.
2. **Convert to Projection**:
   ```R
   library(LDRTools)
   P1 <- O2P(B1)
   P2 <- O2P(B2)
   ```
3. **Compute Distance**:
   ```R
   d <- distance(P1, P2)
   ```

## Workflow: Computing an Average Subspace

1. **Collect Projections**: Create a list of projection matrices.
   ```R
   # Assuming B_list is a list of basis matrices
   P_list <- lapply(B_list, O2P)
   ```
2. **Calculate Average**:
   ```R
   P_mean <- Averaging(P_list)
   ```
3. **Recover Basis**: To get an orthogonal basis for the average subspace, perform an eigen-decomposition on `P_mean` and select the eigenvectors corresponding to the largest eigenvalues.

## Tips
- Ensure that the input matrices to `O2P` have orthonormal columns.
- The `distance` function is particularly useful for stability selection and comparing the performance of different dimension reduction techniques on the same dataset.

## Reference documentation
- [LDRTools: Tools for Linear Dimension Reduction](./references/home_page.md)