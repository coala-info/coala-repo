---
name: bioconductor-microstasis
description: This tool quantifies the temporal stability of microbial communities using an iterative clustering framework to calculate mS scores. Use when user asks to calculate microbiota stability scores, analyze longitudinal microbiome data, perform cross-validation of stability metrics, or visualize temporal dynamics in microbial communities.
homepage: https://bioconductor.org/packages/release/bioc/html/microSTASIS.html
---

# bioconductor-microstasis

name: bioconductor-microstasis
description: Expert guidance for the microSTASIS R package to assess microbiota stability over time using iterative clustering. Use this skill when analyzing longitudinal microbiome data (ASV/OTU tables or TreeSummarizedExperiment objects) to calculate mS stability scores, perform cross-validation, and visualize temporal dynamics.

# bioconductor-microstasis

## Overview

The `microSTASIS` package provides a framework for quantifying the stability of microbial communities over time. It addresses the challenges of high-dimensional, compositional microbiome data by using an iterative clustering algorithm (Hartigan-Wong k-means) to determine if paired samples from the same individual consistently cluster together across varying cluster numbers. The primary output is the **mS score**, a metric ranging from 0 to 1, where higher values indicate greater temporal stability.

## Core Workflow

### 1. Data Preparation
Input data can be a matrix (rows: samples, columns: features) or a `TreeSummarizedExperiment` (TSE) object. Sample names should typically follow a pattern like `ID_Common_Time`.

```r
library(microSTASIS)
data(clr) # Example CLR-transformed data

# For TSE objects:
# ID and time info should be in colData
```

### 2. Subsetting Paired Times
Use `pairedTimes()` to organize data into pairs (e.g., T1 vs T2).

```r
# Sequential pairing (T1-T2, T2-T3)
times <- pairedTimes(data = clr, sequential = TRUE, common = "_0_")

# Specific non-sequential pairing
times_spec <- pairedTimes(data = clr, sequential = FALSE, 
                          specifiedTimePoints = c("1", "3"), common = "_0_")
```

### 3. Calculating Stability (mS Score)
The `iterativeClustering()` function applies the core algorithm to the list of paired times.

```r
mS <- iterativeClustering(pairedTimes = times, common = "_")
```

### 4. Visualization
Prepare results using `mSpreviz()` before plotting.

```r
results <- mSpreviz(results = mS, times = times)

# Scatter plot with marginal boxplots
plotmSscatter(results = results, times = c("t1_t2", "t2_t3"), order = "median")

# Heatmap of stability scores
plotmSheatmap(results = results, order = "mean", label = TRUE)
```

## Advanced Analysis

### Cross-Validation
Validate the robustness of the mS score using Leave-K-Out Cross-Validation (LKOCV).

```r
# Run CV (can be parallelized)
cv_results <- iterativeClusteringCV(pairedTime = times$t1_t2, 
                                    results = mS, 
                                    k = 1L, # 1 for LOOCV
                                    common = "_0_")

# Calculate Mean Absolute Error (MAE)
mae <- mSerrorCV(pairedTime = times$t1_t2, CVklist = cv_results, k = 1L)

# Visualize CV stability lines
plotmSlinesCV(pairedTime = times$t1_t2, CVklist = cv_results, k = 1L)
```

### Metadata Integration
Compare stability across different groups (e.g., Age, Treatment).

```r
# Map metadata to results
group <- mSmetadataGroups(metadata = my_metadata, 
                          samples = my_metadata$SampleID, 
                          individuals = results$individual, 
                          variable = "GroupColumn")

# Plot dynamics by group
plotmSdynamics(results, groups = group, points = TRUE)
```

## Tips for Success
- **Common Pattern**: The `common` argument in `pairedTimes` and `iterativeClustering` is crucial for correctly parsing sample IDs. Ensure it matches your naming convention (e.g., `_` or `_0_`).
- **Parallelization**: For large datasets, use `BiocParallel` parameters in `iterativeClustering` to speed up the iterative process.
- **Interpretation**: An mS score of 1 means the individual's samples always clustered together regardless of the number of clusters $k$, indicating high stability.

## Reference documentation
- [Introduction to microSTASIS](./references/microSTASIS.Rmd)