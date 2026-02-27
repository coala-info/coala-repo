---
name: bioconductor-quantiseqr
description: This tool performs immune cell deconvolution to estimate the absolute fractions of ten immune cell types and uncharacterized cells from bulk RNA-seq or microarray data. Use when user asks to quantify immune cell infiltration, estimate tumor purity from expression data, or run the quanTIseq method on transcriptomic samples.
homepage: https://bioconductor.org/packages/release/bioc/html/quantiseqr.html
---


# bioconductor-quantiseqr

name: bioconductor-quantiseqr
description: Comprehensive immune cell deconvolution from bulk RNA-seq or microarray data using the quanTIseq method. Use when Claude needs to estimate fractions of 10 immune cell types (B cells, Macrophages M1/M2, Monocytes, Neutrophils, NK cells, CD4+ T cells, CD8+ T cells, Tregs, Dendritic cells) and uncharacterized "Other" cells (often tumor content) from gene expression data.

# bioconductor-quantiseqr

## Overview
The `quantiseqr` package implements the quanTIseq deconvolution method, which quantifies the absolute fractions of 10 different immune cell types from bulk transcriptomics data. It utilizes a specialized signature matrix called **TIL10**. A unique feature of this method is its ability to estimate a fraction of "Other" (uncharacterized) cells, which in tumor samples typically represents the malignant cell content.

## Core Workflow

### 1. Data Preparation
The package requires gene expression data as **TPM (Transcripts Per Million)** values. Gene identifiers must be **HGNC gene symbols**.

Supported input formats:
- A numeric matrix or data frame (genes as rows, samples as columns).
- An `ExpressionSet` object.
- A `SummarizedExperiment` object (uses the "abundance" assay by default).

### 2. Running Deconvolution
The primary function is `run_quantiseq()`.

```r
library(quantiseqr)

# Basic execution for tumor RNA-seq data
ti_results <- run_quantiseq(
  expression_data = my_tpm_matrix,
  signature_matrix = "TIL10",
  is_arraydata = FALSE,
  is_tumordata = TRUE,
  scale_mRNA = TRUE
)
```

### 3. Key Parameters
- `is_arraydata`: Set to `FALSE` for RNA-seq (default) or `TRUE` for microarrays.
- `is_tumordata`: Set to `TRUE` for tumor samples. This allows the estimation of the "Other" cell fraction. Set to `FALSE` for blood/PBMC samples.
- `scale_mRNA`: Set to `TRUE` (default) to correct for cell-type-specific mRNA content bias. This should only be `FALSE` when working with simulated data where no mRNA bias was modeled.

### 4. Working with SummarizedExperiment
If a `SummarizedExperiment` is provided as input, the function returns a `SummarizedExperiment` with the deconvolution results appended to the `colData` slot.

```r
# Run on SummarizedExperiment
se_output <- run_quantiseq(expression_data = my_se, is_tumordata = TRUE)

# Extract results into a data frame
ti_df <- extract_ti_from_se(se_output)
```

## Visualization
The package provides a convenient wrapper for `ggplot2` to visualize cell fractions as stacked bar charts.

```r
# Works on the output data frame or the SummarizedExperiment object
quantiplot(ti_results)
```

## Tips and Best Practices
- **Gene Symbols**: If your data uses Ensembl IDs or other identifiers, convert them to HGNC symbols (e.g., using `AnnotationDbi` or `biomaRt`) before running `quantiseqr`.
- **TPM Requirement**: Do not use raw counts or log-transformed values. If you have Salmon/tximport data, use the "abundance" assay.
- **Interpreting "Other"**: In tumor datasets, the "Other" fraction is a proxy for tumor purity. In blood samples, it represents cells not covered by the TIL10 signature.
- **Species**: The TIL10 signature is specifically designed for **human** samples. While ortholog conversion can be used for mouse data, results should be interpreted with caution.

## Reference documentation
- [Using quantiseqr](./references/using_quantiseqr.md)