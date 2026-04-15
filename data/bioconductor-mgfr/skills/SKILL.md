---
name: bioconductor-mgfr
description: MGFR identifies tissue-specific or cell-type-specific marker genes from RNA-seq expression data using a distribution-based marker score. Use when user asks to detect marker genes, identify genes with high sample specificity, or calculate marker scores for RNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/MGFR.html
---

# bioconductor-mgfr

name: bioconductor-mgfr
description: Marker Gene Finder in RNA-seq (MGFR) for identifying tissue-specific or cell-type-specific marker genes from RNA-seq expression data. Use this skill when you need to detect genes that are uniquely or highly expressed in specific samples compared to others using the MGFR algorithm.

# bioconductor-mgfr

## Overview
MGFR is a Bioconductor package designed to identify marker genes from RNA-seq data. It uses a distribution-based approach to detect genes that show high specificity to a particular sample group (e.g., a specific tissue or cell type). The core logic relies on calculating a "Marker Score" for each gene across samples, where a low score indicates high specificity.

## Installation
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MGFR")
library(MGFR)
```

## Core Workflow

### 1. Data Preparation
The input should be an expression matrix (e.g., Read Counts, FPKM, or RPKM) where rows are genes and columns are samples.
- Ensure the data is normalized (e.g., CPM, TPM, or RPKM).
- The column names should represent the sample types/groups.

### 2. Marker Gene Detection
The primary function is `getMarkerGenes()`.

```r
# Basic usage
# data: matrix or data frame of expression values
# samples2compare: vector of sample names/types to analyze
# annotate: boolean, if TRUE, uses biomaRt for annotation (requires internet)

markers <- getMarkerGenes(data_matrix, samples2compare = colnames(data_matrix), annotate = FALSE)
```

### 3. Parameters
- `data`: A data frame or matrix containing non-negative RNA-seq expression values.
- `samples2compare`: A character vector specifying which samples (columns) to include in the marker search.
- `annotate`: Set to `FALSE` by default to avoid external dependency issues during discovery. Set to `TRUE` if you want to map Gene IDs to symbols using biomaRt.

### 4. Interpreting Results
The function returns a list where each element corresponds to a sample type. Each element contains a data frame of identified marker genes.
- **Marker Score**: The lower the score, the more specific the gene is to that sample. A score of 0 indicates absolute specificity.
- **Rank**: Genes are typically ranked by their marker score.

```r
# Example: Accessing markers for a specific tissue 'Liver'
liver_markers <- markers[["Liver"]]
head(liver_markers)
```

## Tips for Success
- **Replicates**: If you have replicates, it is often best to average the expression across replicates for each group before running `getMarkerGenes()`, as the tool treats each column as a distinct entity to compare against all others.
- **Filtering**: Pre-filter your matrix to remove genes with very low counts across all samples to improve speed and reduce noise.
- **Normalization**: While the package can handle various scales, RPKM or TPM values are recommended for better inter-sample comparison.

## Reference documentation
- [MGFR Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/MGFR.html)