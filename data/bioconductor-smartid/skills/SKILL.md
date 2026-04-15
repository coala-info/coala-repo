---
name: bioconductor-smartid
description: The smartid package identifies group-specific signature genes and calculates gene-set scores using modified TF-IDF methods for single-cell and bulk expression data. Use when user asks to identify marker genes for specific cell populations, calculate gene-set scores for labeled or unlabeled datasets, transform gene expression data using TF-IDF metrics, or visualize marker distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/smartid.html
---

# bioconductor-smartid

name: bioconductor-smartid
description: Comprehensive guide for using the smartid R package to identify group-specific signature genes and perform gene-set scoring using modified TF-IDF methods. Use when the user needs to: (1) Identify marker genes for specific cell populations (especially rare ones) in scRNA-seq or bulk data, (2) Calculate gene-set scores for labeled or unlabeled datasets, (3) Transform gene expression data using TF-IDF, IDF, and IAE metrics, or (4) Visualize marker distributions and scoring results.

# bioconductor-smartid

## Overview

The `smartid` package provides tools for automated selection of group-specific signature genes and gene-set scoring. It adapts the **Term Frequency-Inverse Document Frequency (TF-IDF)** approach from text mining to biological data, incorporating an **Inverse Average Expression (IAE)** term. It is particularly effective at identifying markers for rare cell populations where traditional differential expression methods may struggle.

## Installation

Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("smartid")
```

## Core Workflow: Labeled Data (Marker Identification)

Use this workflow when you have group labels (e.g., cell types, clusters) and want to find specific markers.

### 1. Calculate Scores
Compute the TF-IDF-IAE scores. For labeled data, the "prob" (probability) method for IDF and IAE is recommended.

```r
# data can be a SingleCellExperiment or matrix
data <- cal_score(
  data,
  tf = "logtf",
  idf = "prob",
  iae = "prob",
  par.idf = list(label = "GroupColumn"),
  par.iae = list(label = "GroupColumn")
)
```

### 2. Rank Top Features
Extract and rank the features for each group.

```r
top_m <- top_markers(
  data = data,
  label = "GroupColumn",
  n = Inf # Use Inf to process all features for EM selection
)
```

### 3. Automated Marker Selection
Use Expectation Maximization (EM) to identify the "break point" between real markers and background noise.

*   **Option A: Mixture Model (Faster)**
    ```r
    marker_ls <- markers_mixmdl(top_m, column = ".dot", dist = "norm", plot = TRUE)
    ```
*   **Option B: Mclust (More Robust)**
    ```r
    marker_ls <- markers_mclust(top_m, column = ".dot", method = "max.one", plot = TRUE)
    ```

## Core Workflow: Unlabeled Data (Gene-set Scoring)

Use this workflow to score cells based on a predefined gene list without using group labels.

### 1. Calculate Unlabeled Scores
Use the "sd" (standard deviation) method for IDF and IAE.

```r
data <- cal_score(
  data,
  tf = "logtf",
  idf = "sd",
  iae = "sd",
  new.slot = "score_unlabel"
)
```

### 2. Compute Gene-set Scores
Calculate an aggregate score for specific gene sets per cell.

```r
data <- gs_score(
  data = data,
  features = list(MyMarkers = c("GeneA", "GeneB")),
  slot = "score_unlabel",
  suffix = "score"
)
```

## Visualization

*   **Score Barplot**: Compare top feature scores against known DEGs.
    ```r
    score_barplot(top_markers = top_m, column = ".dot", f_list = known_markers, n = 20)
    ```
*   **Single Gene Boxplot**: Check the relative expression/score of a specific gene across groups.
    ```r
    sin_score_boxplot(metadata(data)$tf, features = "GeneName", ref.group = "TargetGroup", label = data$GroupColumn)
    ```

## Key Functions and Parameters

*   `idf_iae_methods()`: Lists available methods for IDF and IAE terms (e.g., "prob", "sd", "igm", "hdb").
*   `cal_score()`: The primary transformation function. It can handle raw counts directly.
*   `tf`: Term Frequency. Options include "logtf", "tf", or "null".
*   `idf`: Inverse Document Frequency. Measures how unique a gene is to specific cells.
*   `iae`: Inverse Average Expression. Measures the magnitude of expression.

## Reference documentation

- [A quick start guide to smartid](./references/smartid_Demo.md)