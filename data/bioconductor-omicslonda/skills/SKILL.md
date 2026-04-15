---
name: bioconductor-omicslonda
description: OmicsLonDA identifies significant time intervals in longitudinal omics data by performing spline fitting and permutation-based inference. Use when user asks to analyze longitudinal omics datasets, identify windows of significance between groups, or visualize temporal differences in feature abundance.
homepage: https://bioconductor.org/packages/3.9/bioc/html/OmicsLonDA.html
---

# bioconductor-omicslonda

## Overview
OmicsLonDA is designed to handle the challenges of longitudinal omics data, such as irregular sampling and high dimensionality. It identifies "windows of significance" rather than just global differences. The workflow typically involves data preparation using `SummarizedExperiment`, baseline normalization, spline fitting, and permutation-based inference.

## Core Workflow

### 1. Data Preparation
Data must be formatted into a `SummarizedExperiment` object. The `colData` must contain three specific columns:
*   `Subject`: Unique identifier for each individual.
*   `Group`: Categorical variable (e.g., Case vs. Control).
*   `Time`: Numeric value representing the collection time point.

```r
library(OmicsLonDA)
library(SummarizedExperiment)

# Create SE object
se_ome_matrix = as.matrix(count_matrix)
se_metadata = DataFrame(sample_metadata)
omicslonda_se = SummarizedExperiment(assays=list(se_ome_matrix), colData = se_metadata)
```

### 2. Baseline Adjustment
Use `adjustBaseline` to normalize measurements relative to each subject's initial time point using Centered Log-Ratio (CLR) transformation. This helps account for inter-individual variation at the start of the study.

```r
omicslonda_se_adj = adjustBaseline(se_object = omicslonda_se)
```

### 3. Running the Analysis
The `omicslonda` function is the primary interface. It performs the spline fitting and permutation testing.

```r
# Define the time points to evaluate (the grid)
points = seq(min_time, max_time, length.out = 100)

res = omicslonda(
  se_object = omicslonda_se_adj[1, ], # Analyze one feature at a time or loop
  n.perm = 100,                       # Number of permutations (higher is better)
  fit.method = "ssgaussian",          # Smoothing spline method
  points = points,
  text = "Feature_Name",
  parall = FALSE,                     # Set TRUE for multi-core processing
  pvalue.threshold = 0.05,
  adjust.method = "BH",
  time.unit = "days"
)
```

### 4. Visualization
OmicsLonDA provides several specialized plotting functions to interpret the results:
*   `visualizeFeature()`: Raw data points over time colored by group.
*   `visualizeFeatureSpline()`: Shows the fitted splines for both groups.
*   `visualizeArea()`: Highlights the specific time intervals where the difference is statistically significant.
*   `visualizeTestStatHistogram()`: Displays the empirical null distribution from permutations.

```r
visualizeArea(omicslonda_object = res, fit.method = "ssgaussian",
              text = "Feature_1", unit = "days", 
              ylabel = "Normalized Count", col = c("blue", "red"))
```

## Key Parameters
*   `fit.method`: Options include `ssgaussian` (Smoothing Spline Gaussian) for continuous data.
*   `n.perm`: For publication-quality results, use at least 500-1000 permutations.
*   `points`: The density of this sequence determines the resolution of the identified significant intervals.

## Interpreting Results
The output object contains a `details` list. You can convert this to a dataframe to see the start and end times of significant intervals, along with associated p-values.

```r
feature_summary = as.data.frame(do.call(cbind, res$details))
```

## Reference documentation
- [An Introduction to the OmicsLonDA Package](./references/OmicsLonDA.Rmd)
- [OmicsLonDA Vignette](./references/OmicsLonDA.md)