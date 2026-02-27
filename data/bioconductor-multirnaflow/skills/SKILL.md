---
name: bioconductor-multirnaflow
description: MultiRNAflow performs integrated analysis of temporal RNA-seq data across multiple biological conditions. Use when user asks to normalize counts, perform exploratory PCA or temporal clustering, identify differentially expressed genes across time points, or conduct functional enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MultiRNAflow.html
---


# bioconductor-multirnaflow

name: bioconductor-multirnaflow
description: Expert guidance for the MultiRNAflow R package to perform integrated analysis of temporal RNA-seq data across multiple biological conditions. Use this skill when analyzing complex RNA-seq experimental designs involving time-series data, multiple groups, or both. It supports normalization, exploratory data analysis (PCA, clustering, Mfuzz), differential expression (DE) analysis using DESeq2, and functional enrichment preprocessing.

## Overview

MultiRNAflow is a unified framework for the analysis of temporal RNA-seq data. It is specifically designed for experimental designs that include a reference time point ($t_0$) and subsequent time points ($t_1 \dots t_n$) across one or more biological conditions. The package automates the transition from raw counts to biological insights by integrating normalization, unsupervised exploratory analysis, and supervised statistical testing.

## Typical Workflow

### 1. Data Preparation
The package uses the `SummarizedExperiment` class. Data must be a data frame of raw counts where column names contain metadata (Condition, Time, Replicate) separated by underscores.

```r
library(MultiRNAflow)

# Example: Condition_Time_Replicate (e.g., "wt_t0_r1")
resSE <- DATAprepSE(RawCounts = your_data_frame,
                    Column.gene = 1,
                    Group.position = 1,
                    Time.position = 2,
                    Individual.position = 3)
```

### 2. Unsupervised Analysis (Exploratory)
Perform normalization and visualize data structure before statistical testing.

*   **Normalization:** Use `DATAnormalization()` (supports "vst", "rlog", or "rle").
*   **PCA & Clustering:** Use `PCAanalysis()` for 2D/3D visualization and `HCPCanalysis()` for hierarchical clustering.
*   **Temporal Clustering:** Use `MFUZZanalysis()` to find genes with similar temporal profiles across conditions.

```r
# Normalization
resSE <- DATAnormalization(resSE, Normalization = "vst")

# PCA
resSE <- PCAanalysis(resSE, Plot.PCA = TRUE)

# Plot specific gene profiles
DATAplotExpressionGenes(resSE, Vector.row.gene = c(1, 10, 100))
```

### 3. Supervised Analysis (Differential Expression)
The `DEanalysisGlobal()` function performs a comprehensive suite of tests depending on the experimental design:
*   **Case 1 (Conditions only):** DE between all pairs of conditions.
*   **Case 2 (Time only):** DE between each $t_i$ and $t_0$.
*   **Case 3/4 (Time + Conditions):** Combines both, identifying "specific" genes (DE in one condition vs others at a specific time) and "signature" genes (specific AND DE over time).

```r
resSE <- DEanalysisGlobal(resSE, pval.min = 0.05, log.FC.min = 1)

# Visualization
DEplotVolcanoMA(resSE)
DEplotHeatmaps(resSE)
```

### 4. Functional Analysis
MultiRNAflow facilitates Gene Ontology (GO) and Gene Set Enrichment Analysis (GSEA).

*   **Quick Analysis:** `GSEAQuickAnalysis()` uses `gprofiler2`.
*   **External Tools:** `GSEApreprocessing()` generates formatted input files for DAVID, WebGestalt, GSEA, and others.

## Key Concepts

*   **Specific Genes:** Genes differentially expressed between a target condition and all other conditions at a specific time point.
*   **Signature Genes:** A subset of specific genes that also show significant differential expression compared to the reference time $t_0$ within that condition.
*   **Temporal Groups:** Genes clustered by the first time point at which they become significantly differentially expressed.

## Tips for Success

*   **Column Naming:** Ensure your raw count column names are consistent (e.g., `Group_Time_Rep`). If a position is missing (e.g., no multiple groups), set the corresponding `.position` argument to `NULL` in `DATAprepSE()`.
*   **Filtering:** Use `VARfilter` and `SUMfilter` in `DATAprepSE()` to remove low-count or low-variance genes early to speed up the DESeq2 steps.
*   **Retrieving Results:** Results are stored in the `metadata` slot of the `SummarizedExperiment` object. Access them via `metadata(resSE)$Results`.

## Reference documentation

- [MultiRNAflow Vignette](./references/MultiRNAflow_vignette-knitr.md)
- [Running Analysis with MultiRNAflow (Rmd)](./references/Running_analysis_with_MultiRNAflow.Rmd)
- [Running Analysis with MultiRNAflow (Markdown)](./references/Running_analysis_with_MultiRNAflow.md)