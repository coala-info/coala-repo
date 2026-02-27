---
name: bioconductor-metaseqr
description: "This package provides an integrated pipeline for RNA-Seq differential expression analysis and meta-analysis. Use when user asks to perform multi-algorithm RNA-Seq analysis, combine p-values from different statistical methods, or generate interactive HTML reports for gene expression data."
homepage: https://bioconductor.org/packages/3.8/bioc/html/metaseqR.html
---


# bioconductor-metaseqr

name: bioconductor-metaseqr
description: Comprehensive RNA-Seq analysis pipeline for differential expression. Use when performing multi-algorithm meta-analysis of RNA-Seq count data, generating interactive HTML reports, or combining results from multiple statistical methods like DESeq, edgeR, limma, baySeq, and NOISeq.

# bioconductor-metaseqr

## Overview
The `metaseqR` package provides an integrated pipeline for RNA-Seq gene expression analysis. It acts as a wrapper for several Bioconductor packages, allowing users to perform normalization, statistical testing, and meta-analysis (combining p-values from different algorithms) within a single function call. It is particularly useful for generating comprehensive, publication-ready HTML reports with interactive diagnostic plots.

## Core Workflow

The primary interface is the `metaseqr` function. To run a standard analysis, you need a count matrix, a sample list, and defined contrasts.

### 1. Data Preparation
Prepare a count matrix where rows are gene IDs (Ensembl recommended) and columns are samples.

```r
library(metaseqR)

# Example data structure
# counts: matrix or data frame of raw reads
# sample.list: list where names are conditions and values are sample names
sample.list <- list(
    control = c("ctrl_1", "ctrl_2"),
    treated = c("treat_1", "treat_2")
)

# libsize.list: list of library sizes (optional, can be calculated)
libsize.list <- list(ctrl_1=3102907, ctrl_2=2067905, treat_1=3742059, treat_2=4403954)
```

### 2. Running the Pipeline
The `metaseqr` function handles filtering, normalization, and statistics.

```r
result <- metaseqr(
    counts = my_counts,
    sample.list = sample.list,
    contrast = c("control_vs_treated"),
    annotation = "download", # Downloads Ensembl annotation automatically
    org = "mm9",             # Organism (e.g., hg19, mm9, rn5)
    count.type = "gene",
    normalization = "edger", # Options: edger, edaseq, noiseq, nbpseq
    statistics = "edger",    # Options: deseq, edger, noiseq, bayseq, limma, nbpseq
    export.where = "~/my_analysis_results",
    fig.format = c("png", "pdf")
)
```

### 3. Meta-Analysis (Multiple Algorithms)
To increase robustness, you can run multiple statistical tests and combine their p-values.

```r
result <- metaseqr(
    counts = my_counts,
    sample.list = sample.list,
    contrast = c("control_vs_treated"),
    org = "mm9",
    normalization = "edaseq",
    statistics = c("deseq", "edger"), # Run both
    meta.p = "fisher",                # Combine using Fisher's method
    preset = "medium.normal",         # Use a preset for filtering/QC
    export.where = "~/meta_analysis"
)
```

## Key Parameters and Options

### Normalization and Statistics
*   **`normalization`**: Supports `edaseq` (default), `edger`, `noiseq`, `nbpseq`.
*   **`statistics`**: Supports `deseq`, `edger`, `noiseq`, `bayseq`, `limma`, `nbpseq`.
*   **`meta.p`**: Methods to combine p-values: `simes` (default), `fisher`, `whitlock`, `max` (intersection), `min` (union), or `weight`.

### Filtering
Filtering can be applied `prenorm` or `postnorm`.
*   **`gene.filters`**: A list defining filters for `length`, `avg.reads`, `expression`, and `biotype`.
*   **`biotype`**: Useful for excluding specific categories like `rRNA` or `pseudogene`.

### Presets
Use the `preset` argument to quickly set complex parameters:
*   `"all.basic"`: Minimal filtering and QC.
*   `"medium.normal"`: Standard filtering and comprehensive QC.

## Advanced Features

### Estimating Weights for Meta-Analysis
If using `meta.p = "weight"`, you can estimate algorithm performance weights using simulations based on your own data:

```r
multic <- check.parallel(0.8) # Use 80% of available cores
weights <- estimate.aufc.weights(
    counts = as.matrix(my_counts),
    normalization = "edaseq",
    statistics = c("edger", "limma"),
    nsim = 1, N = 10, model.org = "mm9",
    multic = multic
)
```

### Memory Management
Analysis of exon-level data or large datasets can be memory-intensive.
*   Use `restrict.cores` (e.g., `0.2`) to limit parallel processing and prevent RAM exhaustion.
*   For exon data, ensure at least 64GB of RAM is available if using high core counts.

## Interpreting Results
The output of `metaseqr` is a list containing:
*   `result$data`: Data frames for each contrast containing p-values, fold changes, and normalized counts.
*   `result$plots`: Paths to generated QC and diagnostic plots.
*   **HTML Report**: Located in the `export.where` directory. This is the primary tool for result exploration, containing interactive tables and explanatory text.

## Reference documentation
- [RNA-Seq data analysis using mulitple statistical algorithms with metaseqR](./references/metaseqr-pdf.md)