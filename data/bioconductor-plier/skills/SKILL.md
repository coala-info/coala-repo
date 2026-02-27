---
name: bioconductor-plier
description: The bioconductor-plier package implements the Affymetrix PLIER algorithm to estimate signal intensities from oligonucleotide array probe data. Use when user asks to calculate expression levels from AffyBatch objects, perform model-based signal estimation using PM and MM probes, or run the PLIER algorithm on raw microarray data.
homepage: https://bioconductor.org/packages/release/bioc/html/plier.html
---


# bioconductor-plier

## Overview

The `plier` package provides an R interface to the Affymetrix PLIER algorithm. PLIER is a model-based signal estimation method for oligonucleotide arrays that accounts for experimentally observed patterns in probe behavior. It is designed to provide an improved signal-to-noise ratio, particularly at low abundance, by utilizing both Perfect Match (PM) and Mismatch (MM) probes (though MM usage is optional).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("plier")
```

## Core Workflow

The primary function in this package is `justPlier()`, which acts as a wrapper for the underlying C++ implementation of the algorithm.

### Basic Usage

To run PLIER on an `AffyBatch` object (typically created using the `affy` package):

```r
library(plier)
library(affy)

# Load raw data
data <- ReadAffy()

# Run PLIER with default settings
eset <- justPlier(data)

# Access the expression matrix
exp_matrix <- exprs(eset)
```

### Key Parameters

- `eset`: An `AffyBatch` object containing raw probe intensities.
- `normalize`: If `TRUE`, performs quantile normalization on the probes before signal estimation.
- `usemm`: Logical. If `TRUE` (default), the model uses Mismatch probes. Set to `FALSE` for PM-only models.
- `get.affinities`: If `TRUE`, probe affinities are returned in the `description@preprocessing` slot of the resulting `ExpressionSet`.
- `replicate`: A factor or vector defining sample replicates. By default, each array is treated as an independent sample.

### Advanced Configuration

For specific experimental designs, you can adjust the model penalties and convergence criteria:

```r
eset <- justPlier(data, 
                  normalize = TRUE, 
                  norm.type = "together", 
                  usemm = TRUE,
                  plieriteration = 3000,
                  plierconvergence = 0.000001)
```

## Tips for Success

1. **Data Input**: Ensure your data is in an `AffyBatch` format. If you have summarized data already, PLIER is likely not the appropriate tool as it operates on probe-level intensities.
2. **Normalization**: While `justPlier` can perform quantile normalization internally, you should decide whether to normalize "together" (all probes) or "separate" based on your experimental design.
3. **Memory**: Like many probe-level algorithms, `justPlier` can be memory-intensive for very large datasets. Ensure your R environment has sufficient RAM for the number of chips being processed.
4. **Comparison**: PLIER is often compared to RMA or MAS5.0. It generally provides better sensitivity at low expression levels than MAS5.0 while maintaining better dynamic range than RMA in some contexts.

## Reference documentation

- [plier Reference Manual](./references/reference_manual.md)