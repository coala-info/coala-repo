---
name: bioconductor-a4core
description: The a4Core package provides the foundational infrastructure and data simulation tools for the Automated Affymetrix Array Analysis suite. Use when user asks to simulate ExpressionSet objects with controlled biological effects, generate synthetic microarray datasets, or extract top tables from classification models.
homepage: https://bioconductor.org/packages/release/bioc/html/a4Core.html
---


# bioconductor-a4core

## Overview

The `a4Core` package serves as the foundational infrastructure for the "Automated Affymetrix Array Analysis" (a4) suite of Bioconductor packages. Its primary practical utility for users is providing a robust data simulation engine (`simulateData`) that generates `ExpressionSet` objects with controlled experimental effects, which is essential for testing differential expression and classification pipelines. It also provides internal utility functions that support top-table generation for classification models (like LASSO and Elastic Net) used in higher-level a4 packages.

## Data Simulation

The `simulateData` function is the primary tool for creating synthetic microarray datasets. It allows for fine-grained control over the number of features, samples, and the magnitude of the biological effect.

### Basic Simulation
Generate a standard `ExpressionSet` with 1000 features and 40 samples:

```r
library(a4Core)

eSet <- simulateData(
  nCols = 40,               # Number of samples
  nRows = 1000,             # Number of features (genes)
  nEffectRows = 5,          # Number of features with a true biological effect
  nNoEffectCols = 5,        # Number of samples without the effect (within a class)
  betweenClassDifference = 1, # Magnitude of difference between groups
  withinClassSd = 0.5       # Standard deviation within groups
)

# Inspect the generated object
print(eSet)
exprs(eSet)[1:5, 1:5] # View first few expression values
pData(eSet)           # View sample metadata (contains 'type' column)
```

## Integration with a4 Suite

While `a4Core` provides the underlying structure, it is typically used in conjunction with:
- **a4Classif**: Uses `a4Core` utilities to format results from `glmnet`, `lognet`, and `elnet` models.
- **a4Base**: Uses the core structures for visualization and basic statistical filtering.

When working with classification models from `a4Classif` (e.g., `lassoClass`), `a4Core` provides the logic to extract "top tables" of the most important features based on model coefficients.

## Workflow Tips

- **Testing Pipelines**: Use `simulateData` to verify that your downstream analysis code (e.g., `limma` or `a4Base` plots) handles `ExpressionSet` objects correctly before applying it to real experimental data.
- **Reproducibility**: Always set a seed (`set.seed()`) before running `simulateData` to ensure the synthetic dataset remains consistent across different R sessions.
- **Class Labels**: The simulated data automatically creates a binary classification factor in the phenoData slot named `type`, which is compatible with most Bioconductor supervised learning workflows.

## Reference documentation

- [Vignette of the a4Core package](./references/a4Core-vignette.md)