---
name: bioconductor-infercnv
description: This tool identifies somatic copy number alterations in single-cell RNA-Seq data by comparing gene expression intensities between tumor and reference cells. Use when user asks to infer chromosomal gains or losses, analyze tumor heterogeneity, or visualize copy number variations in single-cell datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/infercnv.html
---


# bioconductor-infercnv

## Overview

The `infercnv` package is designed to explore tumor single-cell RNA-Seq data for evidence of somatic copy number alterations. It works by comparing the expression intensities of genes at specific genomic positions in "query" cells (e.g., tumor cells) against a set of "reference" cells (e.g., normal cells). By smoothing expression across genomic windows, it highlights regions of chromosomal gain or loss.

## Core Workflow

### 1. Prepare Input Data
You require three main inputs:
- **Raw Counts Matrix**: A numeric matrix of non-log-transformed genetic expression counts (genes as rows, cells as columns).
- **Annotations File**: A tab-delimited file with two columns: Cell ID and Cell Type (matching the column names of the counts matrix).
- **Gene Order File**: A tab-delimited file with four columns: Gene Name, Chromosome, Start, and End positions.

### 2. Create the InferCNV Object
Initialize the analysis using `CreateInfercnvObject()`. You must specify which cell types in your annotations file serve as the "normal" reference.

```r
library(infercnv)

infercnv_obj = CreateInfercnvObject(
  raw_counts_matrix = "counts.matrix",
  annotations_file = "annotations.txt",
  delim = "\t",
  gene_order_file = "gene_ordering_pos.txt",
  ref_group_names = c("Normal_Cell_Type_A", "Normal_Cell_Type_B")
)
```

### 3. Run the Pipeline
The `run()` function executes the standard preprocessing, normalization, and CNV inference steps.

```r
infercnv_obj = infercnv::run(
  infercnv_obj,
  cutoff = 1,             # 1 for Smart-seq2, 0.1 for 10x Genomics
  out_dir = "output_dir", # Directory for plots and data
  cluster_by_groups = TRUE, 
  denoise = TRUE,
  HMM = FALSE             # Set TRUE to predict discrete CNV states
)
```

## Key Parameters and Tips

- **Cutoff**: This is the minimum average read count per gene among reference cells to be included in the analysis. Use `0.1` for sparse data like 10x Genomics and `1` for deeper sequencing like Smart-seq2.
- **Reference Groups**: If no `ref_group_names` are provided, the average of all cells is used as the reference, which is only recommended if the dataset is a mix of diverse cell types where the global average approximates a diploid state.
- **Denoising**: Setting `denoise = TRUE` helps reduce technical noise and improves the clarity of the resulting heatmap.
- **HMM**: Enabling the Hidden Markov Model (`HMM = TRUE`) allows the package to transition from continuous relative expression values to discrete CNV classifications (e.g., state 1: complete loss, state 3: neutral, state 6: high-level amplification).
- **Subclustering**: If you suspect heterogeneity within tumor groups, use `analysis_mode = "subclusters"`. Ensure you run `options(scipen = 100)` before execution to avoid scientific notation errors during clustering.

## Interpreting Results

- **Heatmap (`infercnv.png`)**: The primary output. Red indicates genomic gains (increased expression); blue indicates genomic deletions (decreased expression).
- **Residuals**: The values in the final object represent the relative expression after normalization and smoothing. A value of 1 is neutral (diploid).

## Reference documentation

- [Visualizing Large-scale Copy Number Variation in Single-Cell RNA-Seq Expression Data](./references/inferCNV.Rmd)
- [Visualizing Large-scale Copy Number Variation in Single-Cell RNA-Seq Expression Data (Markdown)](./references/inferCNV.md)