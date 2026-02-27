---
name: bioconductor-trendy
description: Bioconductor-trendy performs segmented regression analysis to characterize expression dynamics in ordered high-throughput profiling experiments. Use when user asks to fit breakpoint models to gene expression data, identify top dynamic genes, visualize expression trends, or extract specific temporal patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/Trendy.html
---


# bioconductor-trendy

name: bioconductor-trendy
description: Segmented regression analysis of expression dynamics in high-throughput ordered profiling experiments (e.g., time-course or spatial-course data). Use this skill to fit breakpoint models to gene expression data, identify top dynamic genes, visualize expression trends, and extract specific patterns (e.g., "up-down" peaks).

## Overview

Trendy is designed to analyze gene expression data from ordered conditions. It fits segmented regression models (0 to K breakpoints) to each gene and selects the optimal model using the Bayesian Information Criterion (BIC). This allows for the identification of "breakpoints" where expression trends change significantly.

## Core Workflow

### 1. Data Preparation
Input data must be a normalized expression matrix (Genes x Samples) where columns are sorted by the ordered condition (e.g., time).

```r
library(Trendy)
# Load example data
data("trendyExampleData") 

# Define a time vector matching the columns
# It can be equally spaced or represent true time/sampling intervals
time.vector <- 1:40 
```

### 2. Running the Analysis
The `trendy` function fits the models. Use `results()` to extract the list of fitted models and `topTrendy()` to filter for genes with high adjusted R-squared values.

```r
# Run segmented regression (maxK is max breakpoints allowed)
res <- trendy(Data = trendyExampleData, tVectIn = time.vector, maxK = 2)
res <- results(res)

# Extract top dynamic genes (default adjR2Cut = 0.5)
res.top <- topTrendy(res, adjR2Cut = 0.5)
```

### 3. Visualizing Results
Trendy provides functions for global trend heatmaps and individual gene plots.

```r
# Generate a list of genes categorized by their first trend (up/down/no change)
res.trend <- trendHeatmap(res.top)

# Plot specific genes with fitted lines and breakpoints
plotFeature(Data = trendyExampleData, tVectIn = time.vector, 
            featureNames = c("g1", "g2"), trendyOutData = res)
```

### 4. Extracting Specific Patterns
You can search for genes following specific multi-segment patterns.

```r
# Find genes that go up then down (peaking)
peaking_genes <- extractPattern(res, Pattern = c("up", "down"))

# Find genes that are stable then increase
delayed_up <- extractPattern(res, Pattern = c("no change", "up"))
```

## Key Parameters

- `maxK`: Maximum number of breakpoints to fit (default is 3).
- `minNumInSeg`: Minimum number of samples required in a segment to avoid overfitting (default is 5).
- `pvalCut`: P-value threshold for determining if a segment slope is significantly different from zero (default is 0.1).
- `adjR2Cut`: Adjusted R-squared threshold for defining "top" dynamic genes.

## Advanced Features

- **Breakpoint Distribution**: Use `breakpointDist(res.top)` to see where global shifts occur in the time course.
- **Non-uniform Sampling**: Always use the actual time/spatial values in `tVectIn` rather than simple indices if sampling was not uniform.
- **Replicates**: If replicates exist, the `tVectIn` should contain repeated values (e.g., `c(1,1,2,2,3,3)`). Trendy handles these automatically.
- **Formatting**: Use `formatResults(res.top)` to create a summary table of slopes, p-values, and breakpoints for export.

## Reference documentation

- [Trendy: segmented regression analysis of expression dynamics in high-throughput ordered profiling experiments](./references/Trendy_vignette.md)