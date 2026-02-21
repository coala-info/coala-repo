---
name: bioconductor-gcrma
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gcrma.html
---

# bioconductor-gcrma

name: bioconductor-gcrma
description: Background adjustment and summarization for Affymetrix GeneChip data using probe sequence information. Use this skill when processing Affymetrix .CEL files to account for optical noise and non-specific binding (NSB) using the GCRMA algorithm. It is particularly useful when you need higher precision than standard RMA by leveraging GC-content and positional probe sequence data.

# bioconductor-gcrma

## Overview

The `gcrma` package provides a robust method for background correcting Affymetrix microarray data. Unlike the standard RMA (Robust Multi-array Average) which ignores probe sequence, GCRMA uses probe sequence information (specifically the position-specific base contributions of A, T, G, and C) to estimate probe affinities and adjust for non-specific binding (NSB).

The workflow typically converts raw probe intensities (from an `AffyBatch` object) into a summarized `ExpressionSet`.

## Core Workflow

### 1. Loading Data and Libraries
You must have the `affy` package and the specific chip-type annotation packages (CDF and probe packages) installed.

```r
library(gcrma)
library(affy)
# Example: if using hgu95av2 chips, ensure hgu95av2cdf and hgu95av2probe are installed
data <- ReadAffy() # Reads all .CEL files in the working directory
```

### 2. Basic GCRMA Processing
The simplest way to get expression measures is to run the `gcrma` function directly on your `AffyBatch` object.

```r
eset <- gcrma(data)
```

### 3. Advanced Options
The `gcrma` function supports several parameters to tune the background correction:

*   **type**: 
    *   `"fullmodel"` (default): Uses both sequence info and MM (Mismatch) intensities.
    *   `"affinities"`: Uses sequence info and ignores MM intensities.
    *   `"MM"`: Uses MM intensities and ignores sequence info.
*   **fast**: Set to `TRUE` for a faster ad hoc procedure. Default is `FALSE` in version 2.0+.
*   **GSB.adjust**: Set to `FALSE` if you want to skip the adjustment for gene-specific binding.

### 4. Background Adjustment Only
If you want to perform GCRMA background correction but use a different summarization method (or inspect the adjusted probe levels), use `bg.adjust.gcrma`.

```r
# Background adjust only
data.bgadj <- bg.adjust.gcrma(data)

# Then summarize using standard RMA (skipping its internal background step)
eset <- rma(data.bgadj, background=FALSE)
```

## Efficiency Tips

### Pre-computing Affinities
Computing probe affinities is the most time-consuming part of the process. If you work with the same chip type repeatedly, compute the affinity info once and reuse it.

```r
# Compute and save
aff.info <- compute.affinities("hgu95av2")
save(aff.info, file="hgu95av2_affinities.RData")

# Reuse in future sessions
load("hgu95av2_affinities.RData")
eset <- gcrma(data, affinity.info=aff.info)
```

### Using Local Negative Controls
If you do not want to use the default reference data, you can estimate affinities using the MM probes (or specific Negative Control probes) from your own arrays:

```r
# Use local MM probes as negative controls
eset <- gcrma(data, affinity.source="local")
```

## Reference documentation
- [Description of gcrma package](./references/gcrma2.0.md)