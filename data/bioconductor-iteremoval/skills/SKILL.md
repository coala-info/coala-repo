---
name: bioconductor-iteremoval
description: This tool implements an iterative removal algorithm for feature selection and screening to identify robust subsets of features that distinguish between two groups. Use when user asks to perform feature selection for binary classification, screen methylation loci or gene expression data, or identify stable feature subsets while minimizing overfitting.
homepage: https://bioconductor.org/packages/3.8/bioc/html/iteremoval.html
---


# bioconductor-iteremoval

name: bioconductor-iteremoval
description: Feature selection and screening using the iterative removal algorithm. Use this skill when you need to identify a robust subset of features (e.g., methylation loci, gene expression) that distinguish two groups while minimizing overfitting. It is particularly useful for NGS data where features should have high values in one group and low values in another.

# bioconductor-iteremoval

## Overview

The `iteremoval` package implements a flexible, iterative algorithm for feature selection between two distinct groups. It was originally designed for screening methylation loci in Next-Generation Sequencing (NGS) data but serves as a general-purpose method for binary classification feature selection. The core logic involves iteratively removing features that contribute least to the separation of groups, considering overall performance and overfitting.

## Core Workflow

### 1. Data Preparation
The package accepts two primary input formats:
- **Two Data Frames/Matrices**: `data1` (e.g., malignant) and `data0` (e.g., normal), where rows are features and columns are samples.
- **SummarizedExperiment**: A single object accompanied by a logical vector to identify the control group.

### 2. Feature Removal
The `feature_removal` function is the engine of the package. It performs the iterative screening.

```r
library(iteremoval)

# Using two datasets
# cutoff1/cutoff0: Percentiles to define 'high' and 'low' values (default 0.95)
# offset: A vector of values to test different stringency levels
removal.stat <- feature_removal(SWRG1, SWRG0, 
                                cutoff1 = 0.95, 
                                cutoff0 = 0.95, 
                                offset = c(0.25, 0.5, 2, 4))
```

### 3. Visualizing Iteration Trace
To determine where to stop the removal process, plot the scores of removed features.

```r
# Returns a ggplot2 object
ggiteration_trace(removal.stat) + theme_bw()
```
**Tip**: Look for the iteration index where scores begin to fluctuate drastically; this usually indicates that the remaining features are the most stable and informative.

### 4. Calculating Feature Prevalence
Because multiple `offset` values are typically used, the package calculates "prevalence"—how many times a feature remained across different offset runs at a specific iteration index.

```r
# index: The iteration step chosen from the trace plot
features <- feature_prevalence(removal.stat, index = 255, hist.plot = TRUE)
```

### 5. Final Screening
Filter the features based on a prevalence threshold to get the final robust feature set.

```r
# prevalence: Minimum number of offsets the feature must appear in
final_list <- feature_screen(features, prevalence = 4)
```

## Key Parameters and Tuning
- **cutoff1 & cutoff0**: Adjust these to control sensitivity to outliers. Increasing `cutoff1` and decreasing `cutoff0` can help reduce overfitting by being more stringent about what constitutes a "high" or "low" value.
- **offset**: This parameter adjusts the scoring calculation. Using a vector of offsets (e.g., `c(0.5, 1, 2)`) allows for a consensus approach via the prevalence functions.
- **Customization**: Users can provide their own functions to `feature_removal` to replace the default scoring or removal logic if specific statistical requirements exist.

## Reference documentation
- [An introduction to iteremoval](./references/iteremoval.md)
- [iteremoval RMarkdown Source](./references/iteremoval.Rmd)