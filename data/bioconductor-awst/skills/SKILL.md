---
name: bioconductor-awst
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/awst.html
---

# bioconductor-awst

name: bioconductor-awst
description: Regularize RNA-seq read counts using per-sample standardization and asymmetric winsorization to reduce noise and improve sample clustering. Use when processing gene expression data (especially from degraded or low-input material like tumor samples or single cells) to minimize the impact of background noise in lowly expressed genes and amplification bias in highly expressed genes.

# bioconductor-awst

## Overview

The `awst` package (Asymmetric Winsorization and Standardization Transformation) provides a robust method to regularize gene expression count data. It is specifically designed to mitigate the influence of noise in both lowly expressed genes (background noise) and highly expressed genes (amplification bias). The transformation consists of two main steps:
1.  **Standardization**: Centering and scaling counts using a log-normal distribution (z-counts).
2.  **Smoothing**: Applying a skewed transformation (asymmetric winsorization) to decrease noise while preserving biological signals necessary for clustering and subtype identification.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("awst")
```

## Core Workflow

The package is designed to work seamlessly with `SummarizedExperiment` objects.

### 1. Data Preparation and Initial Filtering
Before applying `awst`, it is recommended to remove genes with very low expression across all samples.

```r
library(awst)
library(SummarizedExperiment)

# Example: Filter genes with mean counts < 10
keep <- rowMeans(assay(se)) >= 10
se <- se[keep, ]
```

### 2. Applying the AWST Transformation
The `awst()` function computes the transformation and, by default, adds a new assay named "awst" to the `SummarizedExperiment` object.

```r
# Apply transformation to the 'counts' assay
se <- awst(se)

# Access the transformed data
awst_counts <- assay(se, "awst")
```

### 3. Filtering Uninformative Genes
The `gene_filter()` function uses an entropy-based measure to remove genes that contribute little to the distance between samples, further refining the dataset for clustering.

```r
# Filter for informative genes
se_filtered <- gene_filter(se)
```

### 4. Downstream Analysis (PCA/Clustering)
The transformed values are suitable for distance-based methods like Principal Component Analysis (PCA) or hierarchical clustering.

```r
# Run PCA on transformed data
res_pca <- prcomp(t(assay(se_filtered, "awst")))
plot(res_pca$x[,1:2])
```

## Role of Normalization

While `awst` can be applied to raw counts, prior normalization often improves results. Full-quantile normalization is specifically recommended as it allows `awst` to estimate parameters once for all samples, increasing computational efficiency.

```r
library(EDASeq)

# Perform full-quantile normalization
assay(se, "fq") <- betweenLaneNormalization(assay(se), which="full")

# Apply awst to the normalized assay
se <- awst(se, expr_values = "fq")
```

## Key Tips
- **Input Format**: `awst` accepts `SummarizedExperiment` objects or matrix-like objects.
- **Assay Selection**: Use the `expr_values` argument in `awst()` to specify which assay to transform if your object contains multiple (e.g., "counts", "fq", "tpm").
- **Noise Reduction**: The transformation typically shrinks the majority of low-expression values toward a common baseline (around -2) and winsorizes high-expression outliers (around 4).

## Reference documentation
- [Introduction to awst](./references/awst_intro.Rmd)
- [Introduction to awst (Markdown)](./references/awst_intro.md)