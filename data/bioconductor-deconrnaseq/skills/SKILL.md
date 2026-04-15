---
name: bioconductor-deconrnaseq
description: DeconRNASeq performs mRNA deconvolution to estimate the relative proportions of different cell types within heterogeneous bulk RNA-seq samples. Use when user asks to estimate cell type fractions, perform tissue deconvolution, or use non-negative least squares to analyze bulk gene expression data against a reference signature.
homepage: https://bioconductor.org/packages/release/bioc/html/DeconRNASeq.html
---

# bioconductor-deconrnaseq

name: bioconductor-deconrnaseq
description: Perform mRNA deconvolution using the DeconRNASeq R package. Use this skill when analyzing bulk RNA-seq data to estimate the relative proportions of different cell types within a heterogeneous sample using a reference signature matrix.

## Overview
DeconRNASeq is an R/Bioconductor package designed for the deconvolution of heterogeneous tissues based on mRNA expression data. It utilizes a globally optimized non-negative least squares (NNLS) algorithm to estimate the fractional contributions of different cell types. It is particularly useful for analyzing bulk RNA-seq data when a reference "signature" matrix (representing pure cell types) is available.

## Workflow

### 1. Data Preparation
The package requires two primary inputs:
- **Datasets (Bulk Matrix):** A numeric matrix or data frame of bulk gene expression data where rows are genes and columns are samples.
- **Signatures (Reference Matrix):** A numeric matrix or data frame of cell-type specific expression profiles where rows are genes and columns are cell types.

**Crucial:** The genes (rows) in both the datasets and signatures must match exactly. Use `intersect()` to find common genes and subset both matrices accordingly.

```r
# Example alignment
common_genes <- intersect(rownames(bulk_data), rownames(signature_data))
bulk_data <- bulk_data[common_genes, ]
signature_data <- signature_data[common_genes, ]
```

### 2. Running Deconvolution
The main function is `DeconRNASeq()`.

```r
library(DeconRNASeq)

results <- DeconRNASeq(
  datasets = bulk_data,
  signatures = signature_data,
  checksig = FALSE,    # Set TRUE to check the condition number of the signature matrix
  known.prop = NULL,   # Provide if you have ground truth for validation
  use.gradient = FALSE, # Whether to use the gradient method for optimization
  fig = TRUE           # Generates barplots of the estimated proportions
)
```

### 3. Interpreting Results
The function returns a list. The most important element is `out.all`.

- `results$out.all`: A matrix containing the estimated proportions for each cell type (columns) across each sample (rows).
- `results$average.error`: If `known.prop` was provided, this returns the mean error of the estimation.

## Tips and Best Practices
- **Normalization:** Ensure that both the bulk data and the signature matrix are normalized appropriately (e.g., TPM or RPKM). Deconvolution is typically performed in linear space, not log space.
- **Signature Selection:** The accuracy of deconvolution is highly dependent on the quality of the signature matrix. Ensure the signatures are representative of the cell types expected in the bulk mixture.
- **Scale:** If the scales of the bulk data and signatures differ significantly, consider scaling or ensuring they are in the same units before running the function.
- **Visualization:** When `fig = TRUE`, the package automatically generates stacked bar charts which are useful for a quick qualitative assessment of composition shifts across samples.

## Reference documentation
None