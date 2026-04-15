---
name: bioconductor-treg
description: This tool identifies Total RNA Expression Genes (TREGs) from single-cell or single-nucleus RNA-seq data to serve as proxies for total RNA content. Use when user asks to identify candidate genes for smFISH probe design, calculate rank invariance across cell types, or estimate RNA abundance for deconvolution normalization.
homepage: https://bioconductor.org/packages/release/bioc/html/TREG.html
---

# bioconductor-treg

name: bioconductor-treg
description: Identify Total RNA Expression Genes (TREGs) from single-cell or single-nucleus RNA-seq data. Use this skill when you need to find candidate genes whose expression is proportional to total RNA content, typically for estimating RNA abundance in assays like smFISH or for normalizing deconvolution algorithms.

## Overview

The `TREG` package provides a data-driven framework to identify genes that can serve as proxies for total RNA content in a cell. A good TREG candidate is characterized by high rank invariance across different cell types and low "Proportion Zero" (meaning it is expressed in most cells). This is particularly useful for smFISH experiments where counting TREG puncta allows researchers to infer the total RNA expression of a cell.

## Core Workflow

### 1. Data Preparation
The package works with `SingleCellExperiment` objects. Ensure your data is filtered for quality and contains cell type annotations in the `colData`.

```R
library(TREG)
library(SingleCellExperiment)

# Example: Filter to major cell types and remove rare groups (< 50 cells)
# sce is your SingleCellExperiment object
sce <- sce[, !sce$cellType %in% c("RareType1", "RareType2")]
```

### 2. Gene Filtering
To reduce noise and sparsity, filter genes based on expression levels and the proportion of cells with zero counts.

*   **Expression Filter:** Keep the top 50% of genes by mean expression.
*   **Proportion Zero Filter:** Use `get_prop_zero()` to calculate the fraction of zeros per group and `filter_prop_zero()` to apply a cutoff (typically 0.75 to 0.90).

```R
# Filter by mean expression
row_means <- rowMeans(assays(sce)$logcounts)
sce <- sce[row_means > median(row_means), ]

# Filter by Proportion Zero
prop_zeros <- get_prop_zero(sce, group_col = "cellType")
filtered_genes <- filter_prop_zero(prop_zeros, cutoff = 0.9)
sce <- sce[filtered_genes, ]
```

### 3. Calculating Rank Invariance
Rank Invariance (RI) identifies genes that maintain a consistent expression rank relative to other genes across different cell types.

You can run the full process using the wrapper function:

```R
# Calculate Rank Invariance
rank_invar <- rank_invariance_express(sce, group_col = "cellType")

# Identify top candidates
top_candidates <- head(sort(rank_invar, decreasing = TRUE))
print(top_candidates)
```

Alternatively, you can run the steps manually for more control:
1. `rank_group()`: Rank genes by mean expression within each group.
2. `rank_cells()`: Rank genes within each individual cell.
3. `rank_invariance()`: Combine the rankings to produce the final RI score.

## Key Functions

- `get_prop_zero(sce, group_col)`: Returns a matrix of the proportion of zero counts per gene per group.
- `filter_prop_zero(prop_zeros, cutoff)`: Returns a character vector of genes that fall below the maximum Proportion Zero cutoff in all groups.
- `rank_invariance_express(sce, group_col)`: The primary high-level function to calculate RI scores for all genes in an SCE object.
- `rank_group(sce, group_col)`: Calculates the rank of mean gene expression for each group.
- `rank_cells(sce, group_col)`: Calculates the rank of gene expression for every individual cell.

## Tips for Selection

- **Experimental Validation:** Top candidates like *MALAT1* may be too highly expressed for certain assays (e.g., RNAscope), leading to signal saturation. Always check if the candidate's dynamic range is compatible with your imaging technology.
- **Threshold Balancing:** A lower `cutoff` in `filter_prop_zero` (e.g., 0.75) is more stringent and ensures the gene is present in more cells, but may return fewer candidates.
- **Sparsity:** TREG identification relies on non-zero values to avoid rank ties. Ensure your input SCE has been properly normalized (e.g., `logcounts`).

## Reference documentation

- [How to find Total RNA Expression Genes (TREGs)](./references/finding_Total_RNA_Expression_Genes.md)