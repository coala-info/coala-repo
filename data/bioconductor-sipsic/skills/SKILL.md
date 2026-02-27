---
name: bioconductor-sipsic
description: SiPSiC calculates biological pathway activity scores for individual cells from single-cell RNA-seq data using a weighted normalization approach. Use when user asks to calculate per-cell pathway scores, analyze tissue heterogeneity, or identify functional subpopulations in scRNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SiPSiC.html
---


# bioconductor-sipsic

name: bioconductor-sipsic
description: Infer biological pathway activity from single-cell RNA-seq (scRNA-seq) data using the SiPSiC algorithm. Use this skill when a user needs to calculate per-cell pathway scores, analyze tissue heterogeneity, or identify functional subpopulations in scRNA-seq datasets (TPM/CPM normalized).

# bioconductor-sipsic

## Overview

SiPSiC (Single Pathway analysis in Single Cells) is a Bioconductor package designed to calculate biological pathway activity scores for individual cells. Unlike rank-based methods like AUCell, SiPSiC incorporates the transcriptome of different cells in the dataset to normalize and weigh gene contributions. It is particularly effective at revealing subpopulation characteristics that might be missed by other enrichment methods.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SiPSiC")
```

## Core Workflow

The package relies on a single primary function: `getPathwayScores()`.

### 1. Data Preparation
SiPSiC works best with data in **Transcripts-Per-Million (TPM)** or **Counts-Per-Million (CPM)** units. The input must be a sparse matrix (specifically `dgCMatrix`).

```r
library(SiPSiC)
library(SingleCellExperiment)

# Ensure your matrix is a sparse dgCMatrix
# counts_matrix should have genes as rows and cells as columns
sparse_counts <- as(counts_matrix, "dgCMatrix")
```

### 2. Calculating Pathway Scores
You need a character vector of gene symbols representing the pathway of interest.

```r
pathway_genes <- c("GENE1", "GENE2", "GENE3")

# Calculate scores
# percentForNormalization defaults to 5 (top 5% expressing cells)
results <- getPathwayScores(sparse_counts, pathway_genes, percentForNormalization = 5)

# Extract results
cell_scores <- results$pathwayScores  # Vector of scores per cell
gene_indices <- results$index         # Indices of pathway genes found in the matrix
```

## Algorithm Details

SiPSiC follows a five-step process:
1.  **Extraction**: Filters the matrix for genes in the provided pathway list.
2.  **Normalization**: Divides gene expression by the median of the top X% (default 5%) of expressing cells for that gene.
3.  **Ranking**: Ranks genes by total counts across all cells and scales ranks to (0,1].
4.  **Weighting**: Multiplies normalized expression by the scaled gene rank.
5.  **Scoring**: Averages the weighted values across all genes for each cell.

## Tips for Success

- **Input Units**: Always use TPM or CPM. Using raw counts may lead to biased results due to library size differences.
- **Gene Symbols**: Ensure the gene names in your pathway list match the rownames of your expression matrix exactly.
- **Sparsity**: The algorithm is optimized for sparse matrices; ensure your data is cast to `dgCMatrix` to avoid memory issues and ensure compatibility.
- **Normalization Parameter**: If your dataset has very rare cell populations, you might consider adjusting `percentForNormalization`, though the default 5% is robust for most tissue heterogeneity studies.

## Reference documentation

- [SiPSiC - Infer Biological Pathway Activity from Single-Cell RNA-Seq Data](./references/SiPSiC.Rmd)
- [SiPSiC Vignette](./references/SiPSiC.md)