---
name: bioconductor-featseekr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/FeatSeekR.html
---

# bioconductor-featseekr

name: bioconductor-featseekr
description: Feature selection and dimension reduction using the FeatSeekR algorithm. Use this skill to select non-redundant, reproducible features from high-dimensional data with replicates. It is particularly useful for ranking features based on their consistency across replicates and minimizing redundancy through an iterative selection process.

## Overview

FeatSeekR is a Bioconductor package designed for feature selection in high-dimensional datasets where replicated measurements are available. Unlike standard dimension reduction techniques like PCA, FeatSeekR maintains interpretability by selecting a subset of the original features. The algorithm ranks features based on two primary criteria:
1. **Reproducibility**: Consistency of the signal across replicates (measured via F-statistics).
2. **Non-redundancy**: Selecting features that provide unique information not already captured by previously selected features.

The package works with `SummarizedExperiment` objects and is suitable for various omics data types where experimental replicates exist.

## Typical Workflow

### 1. Data Preparation
FeatSeekR requires a `SummarizedExperiment` object. The data should contain multiple conditions and multiple replicates per condition.

```r
library(FeatSeekR)
library(SummarizedExperiment)

# Example: Using simulated data
# conditions: number of experimental groups
# n_latent_factors: number of underlying biological signals
# replicates: number of replicates per condition
sim <- simData(conditions = 500, n_latent_factors = 5, replicates = 3)

# The assay should be a matrix of (features x samples)
# Samples are typically ordered such that replicates are grouped or identifiable
```

### 2. Feature Selection
The core function is `FeatSeek()`. It performs an iterative ranking procedure.

```r
# Perform feature selection
# max_features: The maximum number of features to select/rank
res <- FeatSeek(sim, max_features = 10)

# The output 'res' is a SummarizedExperiment object containing:
# - The selected features in the assay
# - Ranking information and statistics in the metadata
```

### 3. Visualizing Results
FeatSeekR provides a dedicated plotting function to visualize the correlation structure of the selected features.

```r
# Plot a heatmap of the correlation matrix for selected features
# This helps verify that selected features are indeed non-redundant (low correlation)
plotSelectedFeatures(res)
```

## Key Functions

- `FeatSeek(se, max_features, ...)`: Main entry point for feature selection. Requires a `SummarizedExperiment`.
- `simData(conditions, n_latent_factors, replicates)`: Utility to generate synthetic datasets with known latent structures and redundancy for testing.
- `plotSelectedFeatures(se)`: Generates a heatmap of the correlation matrix for the features stored in the provided `SummarizedExperiment` (usually the output of `FeatSeek`).

## Tips for Success

- **Replicate Structure**: Ensure your input `SummarizedExperiment` correctly represents the replicate structure. The algorithm relies on the F-statistic, which compares variance between conditions to variance between replicates.
- **Interpreting Output**: The features in the resulting object are ordered by their selection rank. The first feature selected is the most reproducible one; subsequent features are chosen based on their ability to add new information (residual signal) while maintaining reproducibility.
- **Scaling**: While FeatSeekR handles various data scales, ensure your data is appropriately normalized (e.g., log-transformed for sequencing data) before running the selection.

## Reference documentation

- [FeatSeekR user guide](./references/FeatSeekR-vignette.md)
- [FeatSeekR R-Markdown Source](./references/FeatSeekR-vignette.Rmd)