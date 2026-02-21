---
name: bioconductor-gsva
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GSVA.html
---

# bioconductor-gsva

## Overview

GSVA (Gene Set Variation Analysis) is a Bioconductor package that implements four single-sample gene set enrichment methods: **GSVA** (default), **ssGSEA**, **PLAGE**, and **z-score**. It allows for pathway-centric analysis of molecular data (microarray, bulk RNA-seq, and scRNA-seq) by calculating enrichment scores for each sample and gene set.

## Core Workflow

The modern GSVA API (v2.0+) uses a parameter-object dispatch system.

### 1. Prepare Input Data
GSVA requires two main inputs:
- **Expression Data**: A `matrix`, `ExpressionSet`, `SummarizedExperiment`, or `SingleCellExperiment`.
- **Gene Sets**: A `list` of character vectors or a `GeneSetCollection` (from `GSEABase`).

### 2. Initialize Parameter Object
Select the method by creating the corresponding parameter object:
- `gsvaParam(expr, geneSets, ...)`: Default GSVA method.
- `ssgseaParam(expr, geneSets, ...)`: Single-sample GSEA.
- `zscoreParam(expr, geneSets, ...)`: Combined z-score.
- `plageParam(expr, geneSets, ...)`: Pathway level analysis of gene expression.

### 3. Run Analysis
Execute the analysis using the `gsva()` function:
```r
library(GSVA)

# Example with default GSVA method
params <- gsvaParam(expression_matrix, gene_set_list)
gsva_results <- gsva(params)
```

## Method-Specific Guidance

### Bulk RNA-seq (Integer Counts)
When using raw integer counts with the default GSVA method, set the kernel consensus distribution function (kcdf) to Poisson:
```r
params <- gsvaParam(counts_matrix, gene_sets, kcdf = "Poisson")
```
*Note: For log-transformed data (log-CPM, log-TPM), use the default `kcdf = "Gaussian"`.*

### Single-Cell RNA-seq
GSVA supports sparse matrices (`dgCMatrix`) and `SingleCellExperiment` objects.
- **Sparse Optimization**: By default, `sparse = TRUE` in `gsvaParam()` treats zeros differently to optimize for scRNA-seq.
- **Two-step execution**: For large scRNA-seq datasets, you can separate ranking and scoring:
```r
ranks <- gsvaRanks(params)
scores <- gsvaScores(ranks)
```

### ssGSEA Normalization
By default, `ssgseaParam()` normalizes scores by the range. To disable this:
```r
params <- ssgseaParam(expr, geneSets, normalization = FALSE)
```

## Handling Gene Identifiers

If using `SummarizedExperiment` or `GeneSetCollection`, GSVA can automatically map identifiers (e.g., Ensembl to Entrez) if metadata is provided:
```r
library(GSEABase)
# Set annotation metadata
gsvaAnnotation(sce_object) <- EntrezIdentifier("org.Hs.eg.db")
```

## Utility Functions

- `readGMT(file)`: Imports gene sets from GMT files into a `GeneSetCollection` or `list`.
- `geneSetSizes(results)`: Returns the sizes of gene sets after filtering.
- `igsva()`: Launches an interactive Shiny web application for GSVA analysis.
- `gsvaEnrichment()`: Generates GSEA-style enrichment plots for specific samples and gene sets.

## Reference documentation

- [GSVA: gene set variation analysis](./references/GSVA.md)
- [GSVA on single-cell RNA-seq data](./references/GSVA_scRNAseq.md)