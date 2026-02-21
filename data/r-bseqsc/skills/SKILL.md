---
name: r-bseqsc
description: R package bseqsc (documentation from project home).
homepage: https://cran.r-project.org/web/packages/bseqsc/index.html
---

# r-bseqsc

name: r-bseqsc
description: Deconvolution of bulk RNA-seq data using single-cell transcriptomic references. Use this skill to estimate cell type proportions and cell type-specific expression from bulk samples by leveraging single-cell data.

# r-bseqsc

## Overview
bseqsc is an R package that provides a pipeline for the deconvolution of bulk RNA-seq data using single-cell gene expression data. It leverages the specificity of single-cell profiles to estimate cell type proportions in heterogeneous bulk samples and can help identify cell type-specific gene expression differences. The package typically uses CIBERSORT as the underlying deconvolution engine but streamlines the process of building signature matrices from single-cell datasets.

## Installation
To install the package, use the following command in R:
install.packages("r-bseqsc")

Note: While the CRAN package is named bseqsc, ensure you have the necessary dependencies such as Biobase and any required optimization libraries installed.

## Main Functions and Workflow

The standard workflow involves preparing a single-cell reference, generating a basis matrix, and then deconvolving the bulk data.

1. Prepare Single-Cell Data
The single-cell data should be formatted as an ExpressionSet object. The phenoData must contain a column specifying the cell type for each cell.

2. Generate Basis Matrix
Use the bseq_basis function to create a signature matrix from the single-cell data. This matrix represents the typical expression profile of marker genes for each cell type.
basis <- bseq_basis(eset_sc, stats = "mean", markers = marker_list)

3. Deconvolve Bulk Data
Use the bseq_deconvolve function to estimate cell type proportions in your bulk RNA-seq samples. The bulk data should be an ExpressionSet or a matrix of gene expression values.
estimates <- bseq_deconvolve(eset_bulk, basis, nm = 100)

## Key Parameters and Tips

- Marker Selection: The quality of deconvolution depends heavily on the selection of marker genes. Use genes that are highly specific to individual cell types.
- Normalization: Ensure that both bulk and single-cell data are appropriately normalized (e.g., CPM, TPM) before processing.
- CIBERSORT Integration: bseqsc often requires the CIBERSORT.R script. You may need to provide the path to this script or have it loaded in your environment depending on the version.
- Interpret Results: The output provides a matrix of proportions where rows represent cell types and columns represent bulk samples.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [index.md](./references/index.md)