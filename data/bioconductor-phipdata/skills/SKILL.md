---
name: bioconductor-phipdata
description: The PhIPData package provides a standardized S4 container for managing and analyzing PhIP-Seq experimental data including counts, fold-changes, and enrichment probabilities. Use when user asks to create a PhIPData object, access or modify PhIP-Seq assays and metadata, filter samples by bead controls, or convert data for differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/PhIPData.html
---


# bioconductor-phipdata

## Overview

The `PhIPData` package provides a standardized S4 container for PhIP-Seq experimental results. It is built upon the `RangedSummarizedExperiment` class, ensuring that peptide (row) and sample (column) metadata remain synchronized during subsetting and analysis. A valid `PhIPData` object requires three specific assays: `counts` (raw reads), `logfc` (log2 fold-changes vs. controls), and `prob` (enrichment probabilities).

## Core Workflow

### 1. Installation and Loading
```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("PhIPData")
library(PhIPData)
```

### 2. Creating a PhIPData Object
Use the `PhIPData()` constructor. It automatically handles dimension name alignment and initializes missing required assays with empty matrices.

```r
# Required components:
# counts, logfc, prob: matrices (peptides x samples)
# peptideInfo: data.frame or GRanges of peptide metadata
# sampleInfo: data.frame of sample metadata
# metadata: list of experimental-wide metadata

phip_obj <- PhIPData(counts_dat, logfc_dat, prob_dat, 
                     peptideInfo = virscan_info, 
                     sampleInfo = sample_meta, 
                     metadata = exp_meta)
```

### 3. Accessing and Modifying Data
`PhIPData` provides dedicated getters and setters for the three core assays:

*   **Assays**: `counts(obj)`, `logfc(obj)`, `prob(obj)`.
*   **Metadata**: 
    *   `peptideInfo(obj)` (or `rowRanges(obj)`) for peptide annotations.
    *   `sampleInfo(obj)` (or `colData(obj)`) for sample annotations.
    *   `metadata(obj)` for experiment-wide info.
*   **Shortcuts**: Use `obj$column_name` to access sample metadata columns directly.

### 4. Common Operations

*   **Subsetting**: Use standard R matrix notation `obj[rows, cols]`.
*   **Filtering by Metadata**: Use `subset(obj, row_condition, col_condition)`.
*   **Bead Controls**: Use `subsetBeads(obj)` to quickly isolate negative control samples (requires a "beads" entry in the sample group metadata).
*   **Library Sizes**: `librarySize(obj)` calculates total reads per sample.
*   **Proportional Reads**: `propReads(obj)` calculates the fraction of total sample reads for each peptide.

### 5. Advanced Features

*   **Template Libraries**: Save peptide sets for reuse across experiments.
    *   `makeLibrary(metadata_df, "my_lib_name")`
    *   `getLibrary("my_lib_name")`
*   **Aliases**: Create regex shortcuts for long species names.
    *   `setAlias("hiv", "[Hh]uman immunodeficiency virus")`
    *   `subset(obj, grepl(getAlias("hiv"), species))`
*   **Coercion**: Convert to other Bioconductor formats for differential expression analysis.
    *   `as(obj, "DGEList")` (for edgeR)
    *   `as(obj, "DataFrame")` (long-format data frame)

## Reference documentation

- [PhIPData: A Container for PhIP-Seq Experiments](./references/PhIPData.Rmd)
- [PhIPData: A Container for PhIP-Seq Experiments](./references/PhIPData.md)