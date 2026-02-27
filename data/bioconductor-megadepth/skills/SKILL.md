---
name: bioconductor-megadepth
description: This package provides an R interface to the Megadepth utility for high-performance processing of BigWig and BAM files. Use when user asks to quantify genomic coverage, convert BAM files to BigWig format, or extract splice junctions.
homepage: https://bioconductor.org/packages/release/bioc/html/megadepth.html
---


# bioconductor-megadepth

name: bioconductor-megadepth
description: R interface for the Megadepth tool, providing high-performance processing of BigWig and BAM files. Use when needing to quantify genomic coverage, convert BAM to BigWig, or extract splice junctions within an R/Bioconductor environment.

# bioconductor-megadepth

## Overview
The `megadepth` package provides a fast R interface to the Megadepth command-line utility. It is specifically designed for rapid coverage quantification from BigWig files and processing BAM files to extract junctions or Area Under Coverage (AUC). It is significantly faster than traditional tools for remote BigWig processing and integrates with the Bioconductor ecosystem by returning `GRanges` objects.

## Installation and Setup
Before using the analysis functions, the Megadepth binary must be installed.

```r
library(megadepth)
# Install the latest binary for the current OS
install_megadepth()
```

## Core Workflows

### Quantifying Coverage
The primary function for coverage analysis is `get_coverage()`. It computes statistics (mean, sum, min, max) for specific genomic regions.

```r
# Compute mean coverage for regions defined in a BED file
bw_cov <- get_coverage(
    "path/to/file.bw",
    op = "mean",
    annotation = "path/to/regions.bed"
)

# Returns a GRanges object with a 'score' metadata column
```

### BAM to BigWig Conversion
Convert BAM files to BigWig format for visualization or downstream analysis. Note: This is currently not supported on Windows.

```r
# Convert BAM to BigWig
bw_files <- bam_to_bigwig("sample.bam", overwrite = TRUE)
# Returns paths to the created BigWig files (e.g., all.bw)
```

### Junction Extraction
Extract locally co-occurring junctions from BAM files, which is useful for alternative splicing analysis.

```r
# Extract junctions
jxn_file <- bam_to_junctions("sample.bam", overwrite = TRUE)

# Read the resulting TSV into a tibble
jxn_table <- read_junction_table(jxn_file)

# Convert to STAR-compatible format
star_jxns <- process_junction_table(jxn_table)
```

## Key Functions Reference
- `get_coverage()`: Main wrapper for BigWig/BAM coverage. Supports `op` values: "sum", "mean", "min", "max".
- `bam_to_bigwig()`: Converts BAM to BigWig.
- `bam_to_junctions()`: Extracts splice junctions from BAM.
- `read_coverage()` / `read_coverage_table()`: Utilities to load Megadepth output files into R.
- `megadepth_shell()`: A flexible interface to call any Megadepth command and capture the output in R.

## Usage Tips
- **Remote Files**: `megadepth` is highly optimized for remote BigWig files (e.g., from `recount3`). Use a large `bwbuffer` (default 1GB) for better performance on high-latency connections.
- **Windows Support**: While most functions work, `bam_to_bigwig` is restricted to Linux and macOS.
- **Sorting**: For `get_coverage()`, performance is improved if the annotation BED file is sorted (`sort -k1,1 -k2,2n`).
- **Integration**: The output of `get_coverage()` is a `GRanges` object, making it immediately compatible with `GenomicRanges`, `rtracklayer`, and `derfinder`.

## Reference documentation
- [megadepth](./references/megadepth.md)