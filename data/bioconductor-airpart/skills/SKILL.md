---
name: bioconductor-airpart
description: This tool analyzes single-cell allelic imbalance and differential allelic imbalance using generalized fused lasso or nonparametric methods. Use when user asks to partition cell types by allelic ratio, cluster genes with similar imbalance profiles, perform quality control on allelic counts, or estimate posterior mean allelic ratios.
homepage: https://bioconductor.org/packages/release/bioc/html/airpart.html
---

# bioconductor-airpart

name: bioconductor-airpart
description: Analyze single-cell allelic imbalance (AI) and differential allelic imbalance (DAI) using the airpart R package. Use this skill to partition cell types by allelic ratio, cluster genes with similar imbalance profiles, and perform quality control on allelic counts.

## Overview

The `airpart` package identifies sets of genes displaying differential cell-type-specific allelic imbalance across cell types or states using single-cell RNA-seq data. It utilizes a generalized fused lasso with binomial observations or nonparametric methods to partition cell types by their allelic imbalance.

## Core Workflow

### 1. Data Preparation
`airpart` requires a `SingleCellExperiment` (SCE) object with:
- `colData(sce)$x`: A factor representing discrete cell types.
- `assays(sce)[["a1"]]`: Counts for the effect allele.
- `assays(sce)[["a2"]]`: Counts for the non-effect allele.

```r
library(airpart)
library(SingleCellExperiment)

# Preprocess to add pseudo-counts for clustering/visualization
sce <- preprocess(sce)
```

### 2. Quality Control
Perform QC on both cells and genes to ensure robust allelic ratio estimates.

```r
# Cell QC
cellQCmetrics <- cellQC(sce, mad_detected = 4)
sce <- sce[, cellQCmetrics$filter_sum | cellQCmetrics$filter_detected]

# Gene QC (filter for expression in >25% of cells and high variation)
featureQCmetric <- featureQC(sce)
sce <- sce[featureQCmetric$filter_celltype & featureQCmetric$filter_sd, ]
```

### 3. Gene Clustering
Cluster genes by their allelic imbalance profile to increase power and speed.

```r
# Gaussian Mixture Modeling (Default)
sce <- geneCluster(sce, G = 1:4)

# View cluster sizes
table(mcols(sce)$cluster)
```

### 4. Cell Type Partitioning
Identify which cell types share similar allelic ratios for a specific gene cluster.

**Option A: Fused Lasso (Binomial Likelihood)**
Best for data following a binomial distribution.
```r
sce_sub <- fusedLasso(sce, model = "binomial", genecluster = 1)
# If niter > 1, use consensusPart
sce_sub <- consensusPart(sce_sub)
```

**Option B: Mann-Whitney-Wilcoxon Extension**
Best for data with high over-dispersion (small `theta`).
```r
thrs <- 10^seq(-2, -0.4, by = 0.2)
sce_sub <- wilcoxExt(sce, genecluster = 1, threshold = thrs)
```

### 5. Allelic Ratio Estimation
Calculate posterior mean allelic ratios and credible intervals using a beta-binomial model.

```r
# Estimate ratios and test for Dynamic Allelic Imbalance (DAI)
sce_sub <- allelicRatio(sce_sub, DAItest = TRUE)

# Extract results (ar, svalue, lower, upper)
results <- extractResult(sce_sub)
```

## Visualization

- **Heatmap**: `makeHeatmap(sce_sub)` - Shows allelic ratios across cells and genes, optionally ordered by partition.
- **Forest Plot**: `makeForest(sce_sub)` - Displays posterior means and credible intervals per cell type.
- **Violin Plot**: `makeViolin(sce_sub)` - Shows distribution of posterior mean allelic ratios.
- **Step Plot**: `makeStep(sce_sub[genes,])` - Visualizes allelic ratio changes across cell types for specific genes.

## Statistical Inference

- **Allelic Imbalance (AI)**: Look for `svalue < 0.005` or credible intervals not overlapping 0.5.
- **Dynamic Allelic Imbalance (DAI)**: Check `mcols(sce_sub)$adj.p.value < 0.05` for significant differences across the cell type partition.

## Reference documentation

- [Differential cell-type-specific allelic imbalance with airpart](./references/airpart.md)
- [airpart Vignette Source](./references/airpart.Rmd)