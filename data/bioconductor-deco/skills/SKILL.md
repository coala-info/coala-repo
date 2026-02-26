---
name: bioconductor-deco
description: The deco package decomposes heterogeneity in large omic datasets to identify sample subclasses and feature outliers using recurrent-sampling differential analysis and non-symmetrical correspondence analysis. Use when user asks to identify sample subclasses, find features marking specific categories, perform recurrent-sampling differential analysis, or calculate h-statistics to rank features in omic data.
homepage: https://bioconductor.org/packages/3.9/bioc/html/deco.html
---


# bioconductor-deco

## Overview

The `deco` package provides a computational framework to explore and decompose heterogeneity in large omic datasets. It is particularly effective for identifying sample subclasses and features that mark specific categories or outliers within a cohort. The workflow consists of two primary steps:
1.  **RDA (Recurrent-sampling Differential Analysis):** A subsampling strategy that uses `limma` to identify differential events across many combinations of samples.
2.  **NSCA (Non-Symmetrical Correspondence Analysis):** A multivariate technique that integrates differential events into a common relational space, producing an **h-statistic** used for ranking features and stratifying samples.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("deco")
```

## Typical Workflow

### 1. Data Preparation
Input data should be a normalized expression matrix (features as rows, samples as columns).
- **Microarrays:** Use RMA or `normalizeBetweenArrays`.
- **RNA-seq:** Use `voom` (logCPMs) or log-scaled RPKM/FPKM/TPM.

```r
library(deco)
data(ALCLdata)
# Extract matrix from SummarizedExperiment
exp_matrix <- assay(ALCL)
# Define classes for supervised analysis
classes <- colData(ALCL)$Alk.positivity
```

### 2. Recurrent-sampling Differential Analysis (RDA)
Use `decoRDA` to generate an incidence matrix of differential events.

```r
# Supervised (Binary) Analysis
sub_binary <- decoRDA(data = exp_matrix, 
                      classes = classes, 
                      q.val = 0.01, 
                      iterations = 1000, 
                      control = "pos")

# Unsupervised Analysis (no classes provided)
sub_uns <- decoRDA(data = exp_matrix, 
                   q.val = 0.05, 
                   iterations = 1000)
```

### 3. Non-Symmetrical Correspondence Analysis (NSCA)
Use `decoNSCA` to calculate the h-statistic and identify subclasses.

```r
# Parallel processing setup (optional)
library(BiocParallel)
bpparam <- MulticoreParam()

deco_results <- decoNSCA(sub = sub_binary, 
                         v = 80, 
                         method = "ward.D", 
                         bpparam = bpparam)
```

### 4. Interpreting Results
Extract statistics and subclass memberships from the `deco` object.

```r
# Get feature rankings and h-statistics
res_table <- featureTable(deco_results)

# Get sample subclass assignments
# For supervised, check Control and Case slots
subclasses <- NSCAcluster(deco_results)$Case$samplesSubclass

# Summary of the analysis
summary(deco_results)
```

## Visualization and Reporting

- **Full Report:** `decoReport(deco_results, sub_binary, pdf.file = "Report.pdf")` generates a comprehensive PDF.
- **H-statistic Heatmap:** `plotHeatmapH(deco_results)` visualizes the biclustering of features and samples.
- **Feature Profiles:** `plotDECOProfile(deco_results, id = "GENE_ID", data = exp_matrix)` shows raw expression vs. h-statistic for specific features.
- **Gaining H:** `plotGainingH(deco_results, data = exp_matrix, ids = "GENE_ID")` compares original data dispersion against h-statistic stratification.

## Tips for Success
- **Parallelization:** RDA is computationally intensive. Always use `BiocParallel` parameters (`bpparam`) for large datasets.
- **Annotation:** Set `annot = TRUE` and provide `id.type` (e.g., "ENSEMBL", "SYMBOL") if you want the package to handle feature mapping via `Homo.sapiens`.
- **Sex Chromosomes:** If your cohort has a gender imbalance, use `rm.xy = TRUE` in `decoRDA` to prevent sex-linked genes from driving the stratification.
- **Subsampling Size (r):** If `r` is NULL, the package calculates an optimal size. For very small cohorts, you may need to manually adjust this.

## Reference documentation
- [DECO: DEcomposing heterogeneous Cohorts using Omic profiling data](./references/DECO.Rmd)
- [DECO Vignette](./references/DECO.md)