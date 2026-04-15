---
name: bioconductor-rmspc
description: This tool performs joint analysis of ChIP-seq replicates to rescue weak peaks by combining p-values using the Multiple Sample Peak Calling method. Use when user asks to rescue weak peaks in biological or technical replicates, generate consensus peak sets from multiple BED files or GRanges objects, or refine peak calling results across samples.
homepage: https://bioconductor.org/packages/release/bioc/html/rmspc.html
---

# bioconductor-rmspc

name: bioconductor-rmspc
description: Joint analysis of ChIP-seq replicates to rescue weak peaks by combining p-values. Use when Claude needs to perform peak calling refinement, rescue weak peaks in biological or technical replicates, or generate consensus peak sets from multiple BED files or GRanges objects using the MSPC (Multiple Sample Peak Calling) method.

# bioconductor-rmspc

## Overview

The `rmspc` package provides an R interface to the MSPC (Multiple Sample Peak Calling) method. It is designed to analyze ChIP-seq samples (or similar enriched regions) across replicates. By combining p-values of overlapping regions, it allows for the "rescue" of weak peaks that are consistently present across samples, thereby reducing false negatives without significantly increasing false positives.

## Prerequisites

The package requires the **.NET 9.0 Runtime** to be installed on the system, as the underlying engine is a C# .NET library.

## Core Workflow

The primary function in the package is `mspc()`. It supports two main input scenarios: file paths to BED files or `GRanges` objects.

### 1. Input as BED Files
Provide a character vector of file paths.

```r
library(rmspc)

# Define paths to BED files
bed_files <- c("path/to/rep1.bed", "path/to/rep2.bed")

# Run MSPC
results <- mspc(
    input = bed_files,
    replicateType = "Biological", # or "Technical"
    stringencyThreshold = 1e-8,   # Threshold for stringent peaks
    weakThreshold = 1e-4,         # Threshold for weak peaks
    gamma = 1e-8,                 # Combined stringency threshold
    keep = FALSE,                 # Whether to keep generated files on disk
    GRanges = TRUE                # Return results as GRanges objects
)
```

### 2. Input as GRanges Objects
Provide a `GRangesList` containing the replicate data.

```r
library(GenomicRanges)
library(rmspc)

# Create a GRangesList from existing GRanges objects
gr_input <- GRangesList("Rep1" = gr1, "Rep2" = gr2)

# Run MSPC
results <- mspc(
    input = gr_input,
    replicateType = "Biological",
    stringencyThreshold = 1e-8,
    weakThreshold = 1e-4,
    c = 2,                        # Minimum number of supporting replicates
    alpha = 0.05,                 # Benjamini-Hochberg FDR level
    GRanges = TRUE
)
```

## Key Arguments

- `input`: Character vector (paths) or `GRangesList`.
- `replicateType`: "Biological" (or "Bio") or "Technical" (or "Tec").
- `stringencyThreshold`: Peaks with p-values below this are "Stringent".
- `weakThreshold`: Peaks with p-values between this and stringency are "Weak".
- `gamma`: The threshold for the combined p-value (Fisher's method).
- `c`: Minimum number of overlapping peaks required to support a consensus peak.
- `multipleIntersections`: How to handle multiple overlaps ("Lowest", "Highest", or "Mid").
- `keep`: Boolean. If TRUE, keeps the output BED files in the export directory.
- `GRanges`: Boolean. If TRUE, returns results as R objects.

## Interpreting Results

The `mspc` function returns a list containing:
1. `status`: `0` indicates success.
2. `filesCreated`: Paths to the generated output files (logs, consensus peaks, and per-replicate classifications).
3. `GRangesObjects`: A list of `GRanges` objects (if `GRanges = TRUE`):
   - `ConsensusPeaks`: The final set of rescued and confirmed peaks.
   - `Confirmed`: Peaks supported by sufficient evidence.
   - `Discarded`: Peaks failing to meet thresholds or support requirements.
   - `TruePositive`: Confirmed peaks passing Benjamini-Hochberg correction.
   - `Stringent/Weak/Background`: Original peaks classified by p-value.

## Reference documentation

- [rmspc User Guide](./references/rmspc.md)