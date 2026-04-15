---
name: bioconductor-scfind
description: Bioconductor-scfind indexes and searches single-cell RNA-seq data to identify cell types and individual cells using gene lists. Use when user asks to build cell type or cell indices from SingleCellExperiment objects, search for cell populations expressing specific genes, or calculate cell-type specificity p-values.
homepage: https://bioconductor.org/packages/3.8/bioc/html/scfind.html
---

# bioconductor-scfind

name: bioconductor-scfind
description: Search and analyze single-cell RNA-seq data using gene lists to identify specific cell types or individual cells. Use this skill when a user needs to index SingleCellExperiment objects and perform gene-based queries to find representative cell populations or calculate cell-type specificity p-values.

## Overview

`scfind` is a Bioconductor package designed for fast searching of single-cell expression data. It allows users to create compressed indices of gene expression from `SingleCellExperiment` objects. Once indexed, users can query the data with a list of genes to identify which cell types or specific cells most highly express that gene combination. This is particularly useful for cell type annotation, marker gene validation, and identifying rare cell populations.

## Core Workflow

### 1. Data Preparation
`scfind` operates on `SingleCellExperiment` (SCE) objects. Ensure your data is formatted correctly:
- Cell type labels must be in `colData(sce)$cell_type1`.
- Feature symbols should be in `rowData(sce)$feature_symbol`.

```r
library(SingleCellExperiment)
library(scfind)

# Example setup if starting from a matrix
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(yan)), colData = ann)
counts(sce) <- normcounts(sce)
rowData(sce)$feature_symbol <- rownames(sce)
```

### 2. Cell Type Search
Use this workflow to find which cell types are most specific to a list of genes.
- **Build Index**: `buildCellTypeIndex(sce)`
- **Search**: `findCellType(index, gene_list)`

```r
# Create the index
geneIndex <- buildCellTypeIndex(sce)

# Search for cell types expressing SOX6 and SNAI3
# Returns p-values for each cell type
p_values <- -log10(findCellType(geneIndex, c("SOX6", "SNAI3")))
barplot(p_values, ylab = "-log10(pval)", las = 2)
```

### 3. Individual Cell Search
Use this workflow to identify specific cell IDs that express the entire gene list.
- **Build Index**: `buildCellIndex(sce)`
- **Search**: `findCell(index, gene_list)`

```r
# Create the cell-level index
cellIndex <- buildCellIndex(sce)

# Find specific cells
res <- findCell(cellIndex, c("SOX6", "SNAI3"))

# View cells expressing the genes
print(res$common_exprs_cells)

# View cell-type specificity p-values for this search
barplot(-log10(res$p_values), ylab = "-log10(pval)")
```

## Tips for Success
- **Gene Symbols**: Ensure the gene list provided to `findCell` or `findCellType` matches the case and nomenclature used in `rowData(sce)$feature_symbol`.
- **Memory Efficiency**: The indexing process is designed to be memory efficient, making it suitable for large-scale single-cell datasets.
- **Interpretation**: The p-values returned indicate the significance of the overlap between your query genes and the genes expressed in that specific cell type/cell. Higher `-log10(p-value)` indicates higher specificity.

## Reference documentation
- [scfind package vignette](./references/scfind.md)