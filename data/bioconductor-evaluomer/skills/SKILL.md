---
name: bioconductor-evaluomer
description: This tool evaluates the reliability of bioinformatics metrics by analyzing their correlations, clustering stability, and classification quality. Use when user asks to evaluate metric reliability, calculate correlations between metrics, assess clustering stability, measure classification quality, find the optimal number of clusters, or visualize metric distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/evaluomeR.html
---


# bioconductor-evaluomer

## Overview

The `evaluomeR` package provides a framework for evaluating the reliability of bioinformatics metrics. It focuses on three analytical pillars:
1.  **Correlations**: Quantifying interrelationships between metrics.
2.  **Stability**: Assessing how k-means clustering is affected by small sample variations using bootstrap replicates and Jaccard coefficients.
3.  **Goodness of Classification**: Measuring the quality of clusters using Silhouette width scores.

The package is designed to work with `SummarizedExperiment` objects where rows represent instances (e.g., ontologies, pathways) and columns represent the metrics being evaluated.

## Core Workflow

### 1. Data Preparation
Input data must be a `SummarizedExperiment`. The assay should have IDs in the first column and metric measurements in subsequent columns.

```r
library(evaluomeR)
library(SummarizedExperiment)

# Load example data
data("rnaMetrics") # Contains RIN and DegFact metrics
```

### 2. Correlation Analysis
Quantify the Pearson correlation between pairs of metrics.

```r
# Calculate and plot correlations
correlationSE <- metricsCorrelations(rnaMetrics, margins = c(4,4,12,10))

# Access the correlation matrix
assay(correlationSE, 1)
```

### 3. Stability Analysis
Estimate clustering stability. Stability scores > 0.75 indicate stable clustering; > 0.85 is highly stable.

```r
# Single K stability (k must be between 2 and 15)
stabilityData <- stability(rnaMetrics, k = 2, bs = 100)
assay(stabilityData, "stability_mean")

# Stability over a range of K values
stabilityRangeData <- stabilityRange(rnaMetrics, k.range = c(2, 4), bs = 100)
```

### 4. Goodness of Classification (Quality)
Evaluate cluster quality using Silhouette width. Scores > 0.5 indicate reasonable structure; > 0.7 indicate strong structure.

```r
# Quality for a specific K
qualityData <- quality(rnaMetrics, k = 4)
assay(qualityData, 1)

# Quality over a range of K values
qualityRangeData <- qualityRange(rnaMetrics, k.range = c(4, 6))

# Access specific K results from a range
k5Data <- getDataQualityRange(qualityRangeData, 5)
```

### 5. Finding Optimal K
The `getOptimalKValue` function automates the selection of the best `k` for each metric by balancing stability and quality.

```r
# 1. Run ranges (disable images for speed)
stabRange <- stabilityRange(ontMetrics, k.range = c(2, 4), bs = 20, getImages = FALSE)
qualRange <- qualityRange(ontMetrics, k.range = c(2, 4), getImages = FALSE)

# 2. Get optimal table
kOptTable <- getOptimalKValue(stabRange, qualRange)
```

## Metric Visualization
Use these functions for exploratory data analysis of the metrics:

*   `plotMetricsMinMax(data)`: Plots min, max, and standard deviation.
*   `plotMetricsBoxplot(data)`: Standard boxplot of metric values.
*   `plotMetricsViolin(data)`: Violin plots for distribution density.
*   `plotMetricsCluster(data)`: Dendrogram using Euclidean distance and Ward.D2.

## Tips and Best Practices
*   **Disable Plotting**: For large-scale computations or when only data is needed, set `getImages = FALSE` in analysis functions.
*   **K Range**: The k-means algorithm in this package is optimized for `k` values between 2 and 15.
*   **Interpretation**: 
    *   **Stability**: [0.75, 0.85] is Stable; > 0.85 is Highly Stable.
    *   **Quality**: [0.5, 0.7] is Reasonable; > 0.7 is Strong.
*   **Data Access**: Analysis functions often return `ExperimentList` or `SummarizedExperiment` objects. Use `assay(obj, i)` to extract the numerical results.

## Reference documentation
- [Evaluation of Bioinformatics Metrics with evaluomeR](./references/manual.md)
- [evaluomeR Rmd Manual](./references/manual.Rmd)