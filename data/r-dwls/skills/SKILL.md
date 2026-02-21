---
name: r-dwls
description: R package dwls (documentation from project home).
homepage: https://cran.r-project.org/web/packages/dwls/index.html
---

# r-dwls

## Overview
The `dwls` package provides a robust method for deconvolving bulk RNA-expression data. It utilizes a dampened weighted least squares approach to estimate the relative abundance of cell types based on a signature matrix derived from single-cell RNA-sequencing (scRNA-seq) data. This method is particularly effective at handling the technical noise and biological variability inherent in transcriptomic datasets.

## Installation
To install the package from CRAN:
```R
install.packages("dwls")
```

## Core Workflow

### 1. Signature Matrix Construction
Before deconvolution, you must create a signature matrix from a reference scRNA-seq dataset.
- `buildSignatureMatrix()`: Generates the signature matrix using labeled single-cell data.
- `trimSignatureMatrix()`: Refines the matrix by removing lowly informative genes to improve deconvolution accuracy.

### 2. Deconvolution (DWLS)
The primary function for estimating cell type proportions.
- `solveDWLS()`: The core function that applies the dampened weighted least squares algorithm.
- `solveOLS()`: Performs standard Ordinary Least Squares (often used as an initial step or for comparison).
- `solveSVR()`: Support Vector Regression deconvolution (alternative method included in the package).

### 3. Differential Expression in Deconvolution
- `m_logic()`: Internal logic for handling model constraints.
- `DEAnalysis()`: Identifies differentially expressed genes that are most useful for distinguishing cell types within the signature matrix.

## Usage Example
```R
library(dwls)

# 1. Load your bulk data (Bulk) and signature matrix (Sig)
# 2. Run DWLS deconvolution
results <- solveDWLS(Sig, Bulk)

# 3. View estimated proportions
print(results)
```

## Tips for Success
- **Gene Filtering**: Ensure that the gene symbols in your bulk data match those in your signature matrix. Use only the intersection of genes present in both datasets.
- **Normalization**: Bulk data should be properly normalized (e.g., TPM or CPM) before running `solveDWLS`.
- **Weighting**: The "Weighted" aspect of DWLS helps account for the variance in gene expression; if results seem skewed, re-examine the quality of the single-cell reference used to build the signature.

## Reference documentation
- [GitHub Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)