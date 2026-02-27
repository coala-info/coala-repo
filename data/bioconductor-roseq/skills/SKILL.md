---
name: bioconductor-roseq
description: ROSeq performs differential expression analysis in scRNA-seq data using a rank-based modeling approach to handle technical noise and outliers. Use when user asks to perform differential expression analysis on single-cell RNA-seq data, calculate FDR-adjusted p-values for genes, or identify significant genes using rank-based modeling.
homepage: https://bioconductor.org/packages/release/bioc/html/ROSeq.html
---


# bioconductor-roseq

## Overview

ROSeq is a Bioconductor package designed for differential expression (DE) analysis in scRNA-seq data. It utilizes a rank-based modeling approach, making it particularly robust against the technical noise and outliers common in single-cell experiments. The core workflow involves taking a filtered and normalized expression matrix and a categorical condition vector to produce unadjusted and FDR-adjusted p-values for each gene.

## Installation

To install the package via BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ROSeq")
```

## Core Workflow

### 1. Data Preparation
ROSeq requires a gene expression matrix (genes in rows, cells in columns) and a corresponding vector of cell annotations (conditions/groups).

```r
library(ROSeq)
library(limma)
library(edgeR)

# Example using internal Tung dataset
data_counts <- ROSeq::L_Tung_single$NA19098_NA19101_count
cell_groups <- ROSeq::L_Tung_single$NA19098_NA19101_group
```

### 2. Preprocessing and Normalization
Before running ROSeq, data should be filtered for low-quality cells/genes and normalized. A common pipeline involves TMM normalization followed by a `voom` transformation.

```r
# 1. Filter cells (e.g., cells with > 2000 detected genes)
counts_filtered <- data_counts[, colSums(data_counts > 0) > 2000]

# 2. Filter genes (e.g., genes expressed in at least 3 cells with count >= 2)
g_keep <- apply(counts_filtered, 1, function(x) sum(x >= 2) >= 3)
counts_filtered <- counts_filtered[g_keep, ]

# 3. TMM Normalization and Voom Transformation
# ROSeq provides a helper for TMM normalization
tmm_counts <- ROSeq::TMMnormalization(counts_filtered)
voom_data <- limma::voom(tmm_counts)
```

### 3. Differential Expression Analysis
The primary function is `ROSeq()`. It supports parallel processing via the `numCores` parameter.

```r
# countData: The expression matrix (log2-cpm from voom or similar)
# condition: Vector indicating the group for each cell
results <- ROSeq(countData = voom_data$E, 
                 condition = cell_groups, 
                 numCores = 1)

# View top results
head(results)
```

## Interpreting Results

The output is a data frame with two main columns:
- `pVals`: The raw, unadjusted p-values derived from the rank-based model.
- `pAdj`: Adjusted p-values calculated using the Benjamini-Hochberg (FDR) method.

Genes with low `pAdj` values (typically < 0.05) are considered significantly differentially expressed between the conditions.

## Tips
- **Input Scale**: Ensure the `countData` passed to `ROSeq()` is normalized and transformed (e.g., log2-transformed values from `voom`).
- **Parallelization**: For large scRNA-seq datasets, increase `numCores` to significantly reduce computation time, provided the hardware supports it.
- **Memory**: Rank-based modeling can be memory-intensive; ensure your R session has sufficient overhead for large matrices.

## Reference documentation
- [ROSeq Vignette (Rmd)](./references/ROSeq.Rmd)
- [ROSeq Vignette (Markdown)](./references/ROSeq.md)