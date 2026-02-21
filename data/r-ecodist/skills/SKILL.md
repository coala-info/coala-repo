---
name: r-ecodist
description: Dissimilarity-based analysis functions including ordination and Mantel test functions, intended for use with spatial and community ecological data.
homepage: https://cloud.r-project.org/web/packages/ecodist/index.html
---

# r-ecodist

name: r-ecodist
description: Dissimilarity-based ecological analysis using the ecodist R package. Use this skill for Mantel tests, Mantel correlograms, Multiple Regression on Distance Matrices (MRM), and ordination (NMDS, PCoA) of community and spatial data.

# r-ecodist

## Overview
The `ecodist` package provides a suite of functions for dissimilarity-based analysis, specifically designed for ecological data where spatial structure and community composition are primary concerns. It is the standard tool for Mantel-based tests and distance-based regression.

## Installation
```R
install.packages("ecodist")
library(ecodist)
```

## Core Workflows

### 1. Calculating Dissimilarity
Ecological data often requires specific distance metrics like Bray-Curtis.
- `bcdist(x)`: Calculates Bray-Curtis dissimilarity.
- `distance(x, method = "euclidean")`: General distance function supporting multiple metrics (e.g., "bray", "euclidean", "mahalanobis").
- `xdistance(x, y)`: Calculates cross-dissimilarity between two matrices (e.g., same sites at different times).

### 2. Mantel Tests
Used to test the correlation between two distance matrices.
- **Simple Mantel**: `mantel(D1 ~ D2)`
- **Partial Mantel**: `mantel(D1 ~ D2 + D3)` (Relationship between D1 and D2, controlling for D3).
- **Cross-Mantel**: `xmantel(D12 ~ D34)` for cross-dissimilarity matrices.

### 3. Spatial Structure (Correlograms)
Analyze how dissimilarity changes with spatial distance classes.
- **Mantel Correlogram**: `mgram(D1, space_dist)`
- **Piecewise Multivariate Correlogram**: `pmgram(D1, space_dist)`
- **Cross-Mantel Correlogram**: `xmgram(D12, space_dist)`

### 4. Multiple Regression on Distance Matrices (MRM)
Extension of the Mantel test to multiple predictors.
- `MRM(D1 ~ D2 + D3 + D4, nperm = 1000)`
- Returns coefficients, R-squared, and p-values based on permutation.

### 5. Ordination
- **NMDS**: `nmds(dist_matrix, mindim = 1, maxdim = 2)`
- **PCoA (Principal Coordinates Analysis)**: `pco(dist_matrix)`
- **NMDS Rotation**: `nmdsrotate(nmds_results, secondary_data)` to align ordination axes with environmental variables.

## Usage Tips
- **Permutations**: Most functions use `nperm` for significance testing. Increase `nperm` (e.g., 1000 or 10000) for publication-quality p-values.
- **Data Format**: Ensure input matrices are either `dist` objects or symmetric matrices. Use `lower()` to extract the lower triangle if manual manipulation is needed.
- **Residuals**: For partial analyses not directly supported by a function, you can often use `residuals(lm(D1 ~ D2))` and then run the analysis on the residuals.

## Reference documentation
- [Dissimilarity Cheat Sheet](./references/dissimilarity.Rmd)