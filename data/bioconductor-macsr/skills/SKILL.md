---
name: bioconductor-macsr
description: This tool provides an R interface for the MACS3 toolkit to perform peak calling and signal analysis on ChIP-Seq and ATAC-Seq data. Use when user asks to call narrow or broad peaks, identify transcription factor binding sites, perform differential peak detection, or use the HMMRATAC algorithm for ATAC-seq analysis within R.
homepage: https://bioconductor.org/packages/release/bioc/html/MACSr.html
---

# bioconductor-macsr

name: bioconductor-macsr
description: Expert guidance for using the MACSr Bioconductor package to perform Model-based Analysis of ChIP-Seq (MACS) within R. Use this skill when a user needs to identify transcription factor binding sites, call peaks (narrow or broad) from ChIP-Seq or ATAC-Seq data, or perform differential peak detection using the MACS3 engine via an R interface.

## Overview

MACSr is an R wrapper for the MACS3 (Model-based Analysis of ChIP-Seq) toolkit. It leverages the `basilisk` package to manage a Python environment containing the `macs3` library, allowing users to perform high-performance peak calling without leaving the R environment. It is suitable for ChIP-Seq, ATAC-Seq, and other DNA enrichment assays.

## Core Workflow

### 1. Loading the Package
```r
library(MACSr)
```

### 2. Peak Calling with `callpeak`
The primary function is `callpeak`. It requires treatment (ChIP) and optionally control (Input) files.

```r
# Basic narrow peak calling
res <- callpeak(
    tfile = "path/to/chip.bam", 
    cfile = "path/to/control.bam", 
    gsize = "hs",           # Effective genome size (e.g., 'hs', 'mm', or numeric)
    name = "experiment_1",  # Prefix for output files
    outdir = tempdir(),     # Directory for results
    format = "BAM"          # AUTO, BAM, BED, etc.
)

# Broad peak calling
res_broad <- callpeak(
    tfile = CHIP, 
    cfile = CTRL, 
    gsize = 5.2e7, 
    broad = TRUE, 
    name = "broad_peaks"
)
```

### 3. Handling Results (`macsList`)
Functions in MACSr return a `macsList` object, which organizes the execution details:
- `res$outputs`: Character vector of paths to generated files (.narrowPeak, .broadPeak, .bed, .xls, .bdg).
- `res$arguments`: The parameters used for the run.
- `res$log`: The standard output/error from the MACS3 engine (crucial for debugging and checking predicted fragment sizes).

### 4. Specialized Functions
MACSr provides several utility functions for bedGraph manipulation and advanced analysis:

| Function | Use Case |
| --- | --- |
| `hmmratac` | Dedicated peak calling for ATAC-seq data using Hidden Markov Models. |
| `bdgdiff` | Differential peak detection using paired bedGraph files. |
| `filterdup` | Remove duplicate reads from alignment files. |
| `predictd` | Predict the fragment size (d) from alignment results. |
| `bdgcmp` | Compare two signal tracks (e.g., treatment vs control) in bedGraph format. |
| `pileup` | Create a pileup bedGraph from aligned reads. |

## Tips for Success

- **Genome Size (`gsize`)**: This is a required parameter. You can use shortcuts for common organisms: "hs" (human, 2.7e9), "mm" (mouse, 1.87e9), "ce" (C. elegans, 9e7), and "dm" (fruit fly, 1.2e8).
- **File Formats**: While `format = "AUTO"` usually works, explicitly setting it to "BAM", "BAMPE" (paired-end), or "BED" can prevent detection errors.
- **Environment Setup**: On the first run, `basilisk` will automatically download and install the necessary Python dependencies into a private conda environment. This may take several minutes.
- **Output Files**: MACSr writes files to disk (specified by `outdir`). Use `res$outputs` to programmatically locate these files for downstream analysis (e.g., importing into `GenomicRanges`).

## Reference documentation

- [MACSr](./references/MACSr.md)