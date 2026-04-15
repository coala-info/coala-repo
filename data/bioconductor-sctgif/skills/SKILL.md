---
name: bioconductor-sctgif
description: This tool performs functional annotation of single-cell RNA-Seq data by linking 2D cell coordinates to gene sets using joint Non-negative Matrix Factorization. Use when user asks to automate cell-type labeling, connect UMAP or t-SNE clusters to biological functions, or perform gene-set information fusion without prior marker gene knowledge.
homepage: https://bioconductor.org/packages/release/bioc/html/scTGIF.html
---

# bioconductor-sctgif

name: bioconductor-sctgif
description: Functional annotation of unannotated single-cell RNA-Seq data using joint Non-negative Matrix Factorization (jNMF). Use this skill to connect cell clusters/grids in 2D space (t-SNE/UMAP) with biological functions (MSigDB) without requiring prior marker gene knowledge or manual cluster labeling.

# bioconductor-sctgif

## Overview

`scTGIF` (Single-Cell Transcriptome and Gene-set Information Fusion) is an R package designed to automate the annotation of single-cell RNA-Seq data. It addresses the "trial-and-error" cycle of manual cell-type labeling by using joint Non-negative Matrix Factorization (jNMF) to link spatial distributions of cells in reduced dimensions (like UMAP or t-SNE) directly to gene sets (like MSigDB).

The workflow transforms 2D coordinates into a grid-based representation and finds shared latent variables between the gene expression in those grids and the functional gene sets.

## Core Workflow

### 1. Data Preparation
The package requires three main inputs:
- A gene expression matrix (counts or normalized).
- 2D coordinates (e.g., from PCA, t-SNE, or UMAP).
- A `GeneSetCollection` object (typically from MSigDB).

```r
library(scTGIF)
library(SingleCellExperiment)
library(GSEABase)
library(msigdbr)

# 1. Create SingleCellExperiment
sce <- SingleCellExperiment(assays = list(counts = exp_matrix))

# 2. Add reduced dimensions (e.g., UMAP)
reducedDims(sce) <- SimpleList(UMAP = umap_coords)

# 3. Prepare Gene Sets (Example: Mouse Hallmark sets)
m_df <- msigdbr(species = "Mus musculus", category = "H")
gsc <- lapply(unique(m_df$gs_name), function(h){
    geneIds <- unique(as.character(m_df$entrez_gene[m_df$gs_name == h]))
    GeneSet(setName=h, geneIds)
})
gmt <- GeneSetCollection(gsc)
```

### 2. Initialization (settingTGIF)
Register the data and gene sets into the `SingleCellExperiment` object. Note that `scTGIF` primarily supports Entrez IDs.

```r
# If using normalized data, register it in assayNames
settingTGIF(sce, gmt, 
            reducedDimNames = "UMAP", 
            assayNames = "counts")
```

### 3. Calculation (calcTGIF)
Perform the jNMF to calculate attention maps (H1) and function-related matrices (H2). The `ndim` parameter specifies the number of latent variables (patterns) to extract.

```r
# ndim is the number of patterns/factors to find
calcTGIF(sce, ndim = 5)
```

### 4. Reporting (reportTGIF)
Generate an interactive HTML report to visualize the relationship between cell grids and gene functions.

```r
reportTGIF(sce, 
           html.open = TRUE, 
           title = "My scRNA-Seq Annotation Report", 
           author = "Analyst Name")
```

## Key Functions

- `settingTGIF()`: Prepares the SCE object. It maps genes between the expression matrix and the gene sets.
- `calcTGIF()`: The engine of the package. It performs the jNMF. Increasing `ndim` allows for finer-grained discovery of cell populations but increases computation time.
- `reportTGIF()`: Outputs a directory containing an `index.html` file. This report visualizes "Attention Maps" (where specific functions are active in your 2D plot).

## Tips for Success

- **Gene IDs**: Ensure your expression matrix uses Entrez IDs (NCBI Gene IDs), as the package is optimized for this format.
- **Normalization**: While `counts` can be used, providing log-normalized data (e.g., in the `normcounts` slot) often yields cleaner latent variables.
- **Dimensionality**: If the resulting report shows patterns that are too broad, increase the `ndim` parameter in `calcTGIF`.
- **Memory**: For very large datasets, the grid-based summarization (50x50 grids by default) helps manage memory, but the jNMF step still requires significant RAM depending on the number of genes and gene sets.

## Reference documentation

- [Annotation for unannotated single-cell RNA-Seq data by scTGIF](./references/scTGIF.md)