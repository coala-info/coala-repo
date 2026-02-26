---
name: bioconductor-chromscape
description: ChromSCape performs comprehensive analysis of single-cell epigenomic data including quality control, normalization, clustering, and differential analysis. Use when user asks to analyze scChIP-seq or scATAC-seq data, perform dimensionality reduction and clustering on chromatin datasets, or identify differentially enriched genomic regions and pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/ChromSCape.html
---


# bioconductor-chromscape

name: bioconductor-chromscape
description: Analysis of single-cell epigenomic data (scChIP-seq, scATAC-seq, scCUT&Tag) using the ChromSCape R package. Use this skill to perform quality control, normalization, dimensionality reduction, clustering, differential analysis, and gene set enrichment for single-cell chromatin datasets.

# bioconductor-chromscape

## Overview

ChromSCape is designed for the interactive and programmatic analysis of single-cell epigenomic data. It addresses the sparsity and low coverage of single-cell chromatin datasets by providing specialized workflows for feature counting, normalization, and unsupervised clustering. While it is primarily known for its Shiny-based interactive application, it provides a robust R framework for processing various inputs including count matrices, Peak-Index-Barcode files, and raw BAM/BED files.

## Core Workflow

### 1. Launching the Interactive Application
The primary way to use ChromSCape is through its user-friendly Shiny interface.
```r
library(ChromSCape)
launchApp()
```

### 2. Data Import and Feature Summarization
ChromSCape supports multiple input formats. The choice of "features" depends on the histone mark or chromatin state:
- **Active Marks (H3K4me3, scATAC-seq):** Use small genomic bins (5-10kbp) or count around Gene TSS (default 2,500bp window).
- **Repressive Marks (H3K27me3):** Use larger genomic bins (50-100kbp) to capture broad domains.

### 3. Quality Control and Normalization
Filtering is essential to remove low-quality cells and potential doublets.
- **Cell Filtering:** Default thresholds include a minimum of 1,600 unique reads per cell and removing the top 5% of cells by coverage.
- **Feature Filtering:** Keep regions detected in at least 1% of cells.
- **Normalization:** Uses CPM (Counts Per Million) normalization, accounting for both total read count and region size.

### 4. Dimensionality Reduction and Clustering
- **PCA:** Typically the first 50 Principal Components are retained.
- **Visualization:** Supports UMAP and t-SNE for 2D projection.
- **Clustering:** Performs hierarchical clustering based on 1-Pearson correlation distance.
- **Consensus Clustering:** Use `ConsensusClusterPlus` integration to determine the optimal number of clusters (k) by evaluating cluster stability.

### 5. Differential Analysis
Identify regions enriched in specific clusters using:
- **Wilcoxon Rank Sum Test:** Non-parametric comparison of normalized counts.
- **edgeR:** Parametric test using raw counts (Negative Binomial distribution).
- **Batch Correction:** If batches are specified, `scran::pairwiseWilcox` is used with blocking levels to account for batch effects.

### 6. Gene Set Analysis
- **Refinement:** If using bins, peak calling (via MACS2) is recommended to refine annotations to specific genes.
- **Enrichment:** Performs hypergeometric tests against MSigDB gene sets to identify pathways associated with differentially enriched chromatin regions.

## Analysis Structure
ChromSCape organizes data into an "Analysis" folder structure:
- `scChIP_raw.RData`: The initial imported data.
- `Filtering_Normalize_Reduce/`: Objects after QC and PCA.
- `correlation_clustering/`: Results of hierarchical or consensus clustering.
- `Diff_Analysis_Gene_Sets/`: Results of differential tests and pathway enrichment.

## Reference documentation
- [ChromSCape Vignette (Rmd)](./references/vignette.Rmd)
- [ChromSCape Vignette (Markdown)](./references/vignette.md)