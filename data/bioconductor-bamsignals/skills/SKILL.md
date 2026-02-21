---
name: bioconductor-bamsignals
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/bamsignals.html
---

# bioconductor-bamsignals

name: bioconductor-bamsignals
description: Efficiently extract read counts, coverage, and profiles from BAM files into R. Use this skill when you need to quantify genomic signals from high-throughput sequencing data (ChIP-seq, RNA-seq, DNase-seq) using GenomicRanges. It is optimized for speed using C code and supports single-end and paired-end data.

# bioconductor-bamsignals

## Overview
The `bamsignals` package provides a fast interface for extracting data from BAM files directly into R objects. It bypasses the need to load all reads into memory by using efficient C-level access to indexed BAM files. It is primarily used to generate count vectors, base-pair resolution profiles, or coverage maps over specific genomic regions defined by `GenomicRanges`.

## Core Workflow

### 1. Data Preparation
Ensure your BAM file is sorted and indexed. The index must have the `.bai` extension (e.g., `sample.bam` and `sample.bam.bai`).

```r
library(bamsignals)
library(GenomicRanges)

bampath <- "path/to/your/file.bam"
# Define regions of interest
regions <- GRanges(seqnames = "chr1", ranges = IRanges(start = c(100, 500), end = c(200, 600)))
```

### 2. Counting Reads with `bamCount()`
Use `bamCount()` to get a single total count per range.
- **Basic**: `counts <- bamCount(bampath, regions)`
- **Shift**: For ChIP-seq, shift the 5' end to the fragment center: `bamCount(bampath, regions, shift = 75)`
- **Strand-specific**: Get sense/antisense counts: `bamCount(bampath, regions, ss = TRUE)`

### 3. Generating Profiles with `bamProfile()`
Use `bamProfile()` to get base-pair resolution counts.
- **Output**: Returns a `CountSignals` object (list-like).
- **Binning**: Summarize data into larger windows: `bamProfile(bampath, regions, binsize = 20)`
- **Alignment**: If all regions have the same width, convert to a matrix: `alignSignals(sigs)`

### 4. Calculating Coverage with `bamCoverage()`
Unlike `bamProfile()` (which counts 5' ends), `bamCoverage()` counts how many reads overlap each base pair, providing a smooth signal.
- **Usage**: `cov <- bamCoverage(bampath, regions)`

## Advanced Filtering and Paired-End Data

### Filtering
- **Map Quality**: Exclude multi-mapping or low-quality reads: `mapq = 20`
- **SAM Flags**: Filter specific read types (e.g., duplicates): `filteredFlag = 1024`

### Paired-End Handling
Set the `paired.end` argument to handle fragments correctly:
- `"ignore"`: Treat as single-end.
- `"filter"`: Use only the 5' end of the first mate.
- `"midpoint"`: Use the center of the fragment.
- `"extend"`: (For `bamCoverage`) Use the full fragment length defined by TLEN.
- **Fragment Size**: Filter by fragment length: `tlenFilter = c(120, 170)`

## Tips for Success
- **Chromosome Names**: Ensure `seqlevels(regions)` match the BAM header exactly.
- **Memory Efficiency**: `CountSignals` objects are read-only and memory-efficient. Convert to list (`as.list()`) or matrix (`alignSignals()`) only when necessary for downstream analysis.
- **Sense/Antisense**: When `ss = TRUE`, the "sense" row is relative to the strand of the `GRanges` object, not just the genomic strand.

## Reference documentation
- [Introduction to the bamsignals package](./references/bamsignals.md)
- [bamsignals R Markdown Source](./references/bamsignals.Rmd)