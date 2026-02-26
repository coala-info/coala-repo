---
name: bioconductor-liquidassociation
description: This tool analyzes three-way gene interactions to determine if the correlation between two variables is modulated by a third controller variable. Use when user asks to calculate liquid association estimators, fit conditional normal models, or visualize changes in co-expression across different levels of a modulator.
homepage: https://bioconductor.org/packages/release/bioc/html/LiquidAssociation.html
---


# bioconductor-liquidassociation

name: bioconductor-liquidassociation
description: Analysis of three-way gene interactions using Liquid Association (LA) and Generalized Liquid Association (GLA). Use this skill to calculate direct and model-based estimators (CNM) to determine if the correlation between two variables (e.g., genes) is modulated by a third variable.

## Overview

Liquid Association (LA) describes a phenomenon where the co-expression/correlation of two variables changes depending on the value of a third "controller" variable. This package provides tools to:
1.  **Visualize** these interactions via conditional scatter plots.
2.  **Estimate** the magnitude of LA using direct (LA, GLA) or model-based (Conditional Normal Model - CNM) approaches.
3.  **Test** for statistical significance using bootstrap and permutation methods.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or `ExpressionSet`. Variables must be standardized (mean 0, variance 1) and the controller variable should be normally distributed. The package functions often perform these steps internally, but manual preparation is common for custom pipelines.

```R
library(LiquidAssociation)
# data: matrix with 3 columns (X1, X2, X3)
# X3 is typically the controller/modulator variable
```

### 2. Visualization
Use `plotGLA` to see how the correlation of (X1, X2) changes across different levels of X3.

```R
# cut: number of grid points/bins for the controller variable
# dim: index of the column acting as the controller (X3)
plotGLA(data, cut=3, dim=3)
```

### 3. Direct Estimation (LA and GLA)
*   **LA**: The original three-product-moment estimator.
*   **GLA**: A more robust version that handles cases where marginal mean/variance depend on the third variable.

```R
# Calculate LA
la_val <- LA(data)

# Calculate GLA (requires specifying the controller dimension)
gla_val <- GLA(data, cut=4, dim=3)
```

### 4. Model-Based Estimation (CNM)
The Conditional Normal Model (CNM) uses Generalized Estimating Equations (GEE). The parameter `b5` represents the liquid association effect.

```R
fit <- CNM.full(data)
# Look for the 'b5' row in the output
# The Wald statistic and p-value for b5 indicate LA significance
```

### 5. Hypothesis Testing
Use `getsGLA` or `getsLA` to obtain significance values via bootstrapping and permutations.

```R
# sGLA test
# boots: bootstrap iterations for SE
# perm: iterations for permuted p-value
results <- getsGLA(data, boots=100, perm=100, cut=4, dim=3)
```

## Key Functions Reference

| Function | Description |
| :--- | :--- |
| `LA(data)` | Calculates the three-product-moment LA estimator. |
| `GLA(data, cut, dim)` | Calculates the Generalized Liquid Association estimator. |
| `plotGLA(data, cut, dim)` | Generates conditional scatter plots. |
| `CNM.full(data)` | Fits the full Conditional Normal Model via GEE. |
| `getsGLA(...)` | Performs hypothesis testing for GLA. |
| `getsLA(...)` | Performs hypothesis testing for LA. |

## Usage Tips
*   **Standardization**: While functions like `GLA` and `CNM.full` handle standardization internally, ensure your data doesn't have excessive missing values (NAs) before processing.
*   **Controller Selection**: In a triplet (A, B, C), any gene can be the controller. It is common to iterate through all three positions (`dim=1`, `dim=2`, `dim=3`) to find the strongest interaction.
*   **Robustness**: Prefer `GLA` and `sGLA` over `LA` and `sLA` if you suspect the marginal distributions are not constant relative to the controller.

## Reference documentation
- [The LiquidAssociation Package](./references/LiquidAssociation.md)