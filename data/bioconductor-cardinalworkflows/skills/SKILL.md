---
name: bioconductor-cardinalworkflows
description: This package provides example datasets and standardized workflows for mass spectrometry imaging analysis using the Cardinal framework. Use when user asks to perform supervised classification, unsupervised spatial segmentation, or class comparison to find differentially abundant peaks.
homepage: https://bioconductor.org/packages/release/data/experiment/html/CardinalWorkflows.html
---


# bioconductor-cardinalworkflows

## Overview
The `CardinalWorkflows` package provides example datasets and standardized workflows for the `Cardinal` MSI analysis framework. This skill guides the execution of three primary MSI analysis types: supervised classification (predicting tissue types), unsupervised segmentation (discovering chemical regions), and class comparison (finding differentially abundant peaks).

## Typical Workflows

### 1. Data Loading and Pre-processing
Most workflows begin by loading example data and performing peak processing to reduce the high-dimensional spectral data into a manageable set of features.

```r
library(Cardinal)
library(CardinalWorkflows)

# Load example data (e.g., "rcc", "pig206", or "cardinal")
mse <- CardinalWorkflows::exampleMSIData("rcc")

# Standard Pre-processing Pipeline
mse_peaks <- mse |>
    normalize(method="tic") |>
    peakProcess(SNR=3, sampleSize=0.1, tolerance=0.5, units="mz")
```

### 2. Unsupervised Segmentation (SSC)
Use Spatial Shrunken Centroids (SSC) to find regions with distinct chemical profiles without prior labeling.

- **Key Parameters**: `r` (neighborhood radius), `k` (max clusters), `s` (shrinkage/sparsity).
- **Selection**: Higher `s` values result in sparser models (fewer peaks used). Choose the highest `s` that still preserves known morphology.

```r
# Run segmentation
set.seed(1)
ssc_results <- spatialShrunkenCentroids(mse_peaks, r=2, k=8, s=2^(1:6))

# Visualize results
image(ssc_results, i=5) # Plot a specific model from the ResultsList
image(ssc_results[[5]], type="class") # Plot cluster assignments
```

### 3. Supervised Classification
Used when you have labeled training data (e.g., "Normal" vs "Cancer") and want to build a predictive model.

- **Cross-Validation**: Use `crossValidate` to ensure the model generalizes. Folds should typically be based on independent biological replicates (runs/samples), not individual pixels.
- **Evaluation**: Check `MacroRecall` and `MacroPrecision` in the CV results.

```r
# Cross-validation using 'run' as the fold
cv_results <- crossValidate(spatialShrunkenCentroids,
    x=mse_peaks, y=mse_peaks$diagnosis, r=1, s=2^(1:5),
    folds=run(mse_peaks))

# Plot predicted classes
image(cv_results, i=4)
```

### 4. Class Comparison (Testing)
Find peaks differentially abundant between conditions using biological replicates.

- **Spatial-DGMM**: Use `spatialDGMM` to summarize spatial segments independently for each sample before testing to avoid pixel-level autocorrelation bias.
- **Filtering**: Non-specific filtering (e.g., by variance) is often used to reduce the number of tests.

```r
# Segment peaks independently per sample
dgmm_fit <- spatialDGMM(mse_peaks, r=1, k=3, groups=mse_peaks$samples)

# Test for differences between conditions
# (Requires means-based or segmentation-based testing functions in Cardinal)
```

## Interpreting Results
- **t-statistics**: In SSC, positive t-statistics indicate a peak is higher in that segment/class relative to the global mean; negative indicates it is lower.
- **Top Features**: Use `topFeatures()` to extract the most important *m/z* values for a specific class or segment.

```r
# Get top peaks for a specific model
top_peaks <- topFeatures(ssc_results[[5]])
subset(top_peaks, class == "cancer" & statistic > 0)
```

## Reference documentation
- [Classification of MS imaging experiments with Cardinal](./references/MSI-classification.md)
- [Segmentation of MS imaging experiments with Cardinal](./references/MSI-segmentation.md)
- [Class comparison for MSI experiments with Cardinal](./references/MSI-testing.md)