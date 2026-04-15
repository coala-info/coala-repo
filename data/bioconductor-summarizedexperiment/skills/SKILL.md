---
name: bioconductor-summarizedexperiment
description: The SummarizedExperiment package provides a container for coordinating rectangular experimental data with feature and sample metadata in Bioconductor. Use when user asks to create data containers for assays, access sample or feature metadata, subset experimental data while maintaining synchronization, or perform range-based queries on genomic coordinates.
homepage: https://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html
---

# bioconductor-summarizedexperiment

## Overview

The `SummarizedExperiment` package provides the standard Bioconductor container for rectangular experimental data (e.g., RNA-seq counts, microarray intensities). It ensures that assays, feature metadata (rows), and sample metadata (columns) remain synchronized during operations like subsetting or merging. The `RangedSummarizedExperiment` subclass specifically integrates genomic coordinates (`GRanges`) for feature-level data, enabling range-based overlaps and queries.

## Core Workflows

### 1. Object Construction
Create a `SummarizedExperiment` by providing a list of matrices (assays) and corresponding metadata.

```r
library(SummarizedExperiment)

# Basic construction
se <- SummarizedExperiment(
    assays = list(counts = count_matrix, logcounts = log_matrix),
    colData = sample_metadata_dataframe,
    rowData = feature_metadata_dataframe
)

# Ranged construction (with genomic coordinates)
rse <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    rowRanges = granges_object,
    colData = sample_metadata_dataframe
)
```

### 2. Accessing Data
Use specific accessors to retrieve components. Avoid using `@` to access slots directly.

*   **Assays**: `assay(se, "counts")` for a specific matrix; `assays(se)` for the full list.
*   **Metadata**: `colData(se)` for samples; `rowData(se)` for features; `metadata(se)` for experiment-wide lists.
*   **Ranges**: `rowRanges(rse)` (only for `RangedSummarizedExperiment`).
*   **Dimensions**: `rownames(se)`, `colnames(se)`, `dim(se)`.

### 3. Subsetting and Coordination
Subsetting a `SummarizedExperiment` automatically subsets all internal components.

```r
# Subset by index (rows 1:10, columns 1:5)
se_sub <- se[1:10, 1:5]

# Subset by column metadata (using the $ shortcut)
se_treated <- se[, se$treatment == "treated"]

# Range-based subsetting (requires RangedSummarizedExperiment)
roi <- GRanges("chr1", IRanges(100000, 1100000))
se_in_roi <- subsetByOverlaps(rse, roi)
```

### 4. Extending the Class
When developing new Bioconductor packages, you can derive custom classes to enforce specific constraints (e.g., requiring a "counts" assay).

*   **Definition**: Use `setClass("MyClass", contains = "SummarizedExperiment")`.
*   **Validity**: Use `setValidity2` to enforce data integrity (e.g., non-negative values).
*   **Methods**: Implement `[` (subsetting), `rbind`/`cbind` (merging), and `show` (printing) to ensure custom slots are handled correctly.
*   **Efficiency**: Use `BiocGenerics:::replaceSlots(object, ..., check = FALSE)` inside methods to update slots without triggering expensive validity checks repeatedly.

## Tips for Efficient Usage

*   **Dimnames**: By default, `assay(se)` applies the top-level `dimnames` of the SE object to the returned matrix. Use `withDimnames = FALSE` for faster extraction of the raw underlying matrix.
*   **Metadata Storage**: Use `metadata(se)` (a simple list) to store non-rectangular data like model formulas, session info, or processing parameters.
*   **Visualization**: Use the `iSEE` package for interactive exploration of `SummarizedExperiment` objects.

## Reference documentation

- [Extending the SummarizedExperiment class](./references/Extensions.md)
- [SummarizedExperiment for Coordinating Experimental Assays, Samples, and Regions of Interest](./references/SummarizedExperiment.md)