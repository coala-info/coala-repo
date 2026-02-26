---
name: r-propr
description: The r-propr tool performs proportionality analysis to measure associations in compositional data such as RNA-seq or microbiome counts. Use when user asks to calculate proportionality coefficients like rho or phi, perform differential proportionality analysis between groups, or visualize compositional associations in R.
homepage: https://cran.r-project.org/web/packages/propr/index.html
---


# r-propr

name: r-propr
description: Proportionality analysis for compositional data (e.g., RNA-seq, microbiome). Use this skill when you need to calculate proportionality coefficients (phi, rho) as an alternative to correlation for constrained data, perform differential proportionality analysis, or visualize compositional associations in R.

# r-propr

## Overview
The `propr` package implements proportionality, a measure of association specifically designed for compositional data. Unlike correlation, which can be spurious when applied to relative abundance data (where variables sum to a constant), proportionality is sub-compositionally dominant. It is widely used in genomics and metagenomics to identify co-clustered or differentially associated features.

## Installation
```R
install.packages("propr")
# Or for the development version:
# devtools::install_github("tpq/propr")
```

## Core Workflow

### 1. Data Preparation
Data should be a matrix or data frame with samples as rows and features (e.g., genes, OTUs) as columns. Proportionality requires non-zero values.
```R
library(propr)
# Handle zeros (e.g., using a simple pseudocount)
data_nonzero <- data + 1
```

### 2. Calculating Proportionality
The primary function is `propr()`, which calculates the proportionality matrix.
- **Metric `rho`**: Ranges from -1 to 1 (similar to correlation).
- **Metric `phi`**: A "disproportionality" measure (0 is perfect proportionality).

```R
# Calculate rho proportionality
pd <- propr(data_nonzero, metric = "rho")

# Calculate phi proportionality
pd <- propr(data_nonzero, metric = "phi")
```

### 3. Permutation and FDR
To determine a significance threshold for the proportionality coefficient:
```R
# Run permutations to estimate FDR
pd <- updateCutoffs(pd, cutoff = seq(0.9, 0.99, 0.01), ncores = 1)
# View FDR table
print(pd@fdr)
```

### 4. Filtering and Subsetting
Once a threshold is chosen, filter the results:
```R
# Keep only pairs with rho > 0.95
pd_filtered <- pd[pd@matrix > 0.95]
```

## Differential Proportionality
Use `propd()` to compare proportionality between two groups (e.g., Case vs. Control).
```R
# group is a vector of group labels
pd_diff <- propd(data_nonzero, group, alpha = NA)

# Calculate significance
pd_diff <- updateCutoffs(pd_diff, ncores = 1)
```

## Visualization
`propr` provides built-in methods for visualizing associations:
```R
# Heatmap of the proportionality matrix
snapshot(pd)

# Dendrogram/Cluster plot
plot(pd)

# For differential proportionality
plot(pd_diff)
```

## Key Functions
- `propr()`: Main constructor for proportionality objects.
- `propd()`: Constructor for differential proportionality.
- `getResults()`: Extract a long-format table of pairs and their scores.
- `updateCutoffs()`: Perform permutations to find significant thresholds.
- `permutate()`: Underlying function for permutation testing.

## Tips
- **Log-ratio Transformation**: `propr` internally applies a Centered Log-Ratio (CLR) transformation by default.
- **Memory Management**: For very large datasets (e.g., >20,000 genes), the proportionality matrix can be massive. Consider pre-filtering low-abundance features.
- **Alpha Transformation**: Use the `alpha` argument in `propr()` or `propd()` to apply a Box-Cox transformation if zeros are a significant concern (Power Transformation).

## Reference documentation
- [propr: An R-package for Likelihood-based Proportionality Analysis](https://cran.r-project.org/web/packages/propr/index.html)