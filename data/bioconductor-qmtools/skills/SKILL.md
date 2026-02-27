---
name: bioconductor-qmtools
description: The qmtools package provides a suite of tools for the post-processing and quality control of quantitative metabolomics data. Use when user asks to filter features, impute missing values, normalize intensities, or perform dimension reduction on metabolomics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/qmtools.html
---


# bioconductor-qmtools

## Overview

The `qmtools` package provides a suite of tools for the post-processing of quantitative metabolomics data. It is built upon the `SummarizedExperiment` class, ensuring compatibility with the broader Bioconductor ecosystem. The package streamlines the transition from raw feature tables to statistically analyzed results by providing standardized methods for data cleaning, imputation, normalization, and feature grouping.

## Core Workflow

### 1. Data Preparation
Load your data into a `SummarizedExperiment` object. Assays should contain feature intensities, `rowData` should contain feature metadata (like retention time), and `colData` should contain sample metadata.

```r
library(qmtools)
library(SummarizedExperiment)
data(faahko_se)
```

### 2. Feature Filtering
Use `removeFeatures` to eliminate uninformative features. This is critical for reducing noise and the multiple testing burden.

*   **Missing Values:** Filter based on the proportion of non-missing values per group.
*   **QC Metrics:** Filter using Relative Standard Deviation (RSD) or Intraclass Correlation Coefficient (ICC) if QC samples are available.

```r
# Retain features with >= 80% non-missing values in at least one group
se_filtered <- removeFeatures(faahko_se, i = "raw", 
                              group = colData(faahko_se)$sample_group, 
                              cut = 0.80)
```

### 3. Imputation and Visualization
Handle missing values using `imputeIntensity`. Use `plotMiss` to diagnose whether missingness is random or related to experimental conditions.

*   **Methods:** `knn` (default, uses Gower distance), `rf` (Random Forest), `bpca` (Bayesian PCA).
*   **Note:** `knn` in `qmtools` works on original scales due to the Gower distance, but scaling is generally recommended for other distance-based methods.

```r
# Visualize missingness
plotMiss(se_filtered, i = "raw", group = colData(se_filtered)$sample_group)

# Perform kNN imputation
se_imputed <- imputeIntensity(se_filtered, i = "raw", name = "knn", method = "knn")
```

### 4. Normalization
Reduce non-biological variance using `normalizeIntensity`.

*   **Methods:** `vsn` (Variance-Stabilizing Normalization), `pqn` (Probabilistic Quotient Normalization), `cyclicloess`.
*   **Visualization:** Use `plotBox` to compare distributions before and after.

```r
se_norm <- normalizeIntensity(se_imputed, i = "knn", name = "vsn", method = "vsn")
plotBox(se_norm, i = "vsn", group = colData(se_norm)$sample_group)
```

### 5. Dimension Reduction
Explore data structure and group separation using `reduceFeatures`.

*   **Unsupervised:** `method = "pca"` or `method = "tsne"`.
*   **Supervised:** `method = "plsda"` (requires group labels `y`).
*   **Visualization:** Use `plotReduced` to plot the results.

```r
pca_res <- reduceFeatures(se_norm, i = "vsn", method = "pca", ncomp = 2)
plotReduced(pca_res, group = colData(se_norm)$sample_group)
```

### 6. Feature Clustering
Identify features likely derived from the same parent compound (e.g., adducts, isotopes) using `clusterFeatures`.

1.  **Retention Time Grouping:** Groups features with similar RTs.
2.  **Correlation Grouping:** Sub-clusters RT groups based on intensity correlation across samples.

```r
se_clustered <- clusterFeatures(se_norm, i = "vsn", rtime_var = "rtmed", 
                                rt_cut = 10, cor_cut = 0.7)

# Visualize a specific feature group
plotRTgroup(se_clustered, i = "vsn", group = "FG.01")
```

### 7. Statistical Comparison
Perform differential abundance analysis using `compareSamples`, which provides a wrapper for `limma`.

```r
# Contrast: KO - WT
stats <- compareSamples(se_clustered, i = "vsn", group = "sample_group", 
                        class1 = "WT", class2 = "KO")
head(stats)
```

## Reference documentation

- [Processing quantitative metabolomics data with the qmtools package](./references/qmtools.Rmd)
- [Processing quantitative metabolomics data with the qmtools package](./references/qmtools.md)