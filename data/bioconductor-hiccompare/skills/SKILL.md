---
name: bioconductor-hiccompare
description: This tool performs joint normalization and differential chromatin interaction detection for Hi-C datasets. Use when user asks to compare Hi-C contact matrices, normalize Hi-C data using LOESS, or identify statistically significant differences in chromatin interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/HiCcompare.html
---


# bioconductor-hiccompare

name: bioconductor-hiccompare
description: Joint normalization and differential chromatin interaction detection for Hi-C data. Use when comparing two or more Hi-C contact matrices to identify statistically significant differences in interaction frequencies. Supports sparse matrix, BEDPE, .hic, and .cool formats.

# bioconductor-hiccompare

## Overview

`HiCcompare` is an R package designed for the comparative analysis of Hi-C datasets. It provides a non-parametric joint normalization method (LOESS-based) to remove biases between two Hi-C matrices and a robust statistical framework (Z-score based) to detect differential chromatin interactions. The core workflow involves creating a `hic.table` object, performing joint normalization with `hic_loess`, and detecting differences with `hic_compare`.

## Core Workflow

### 1. Data Preparation and Import

`HiCcompare` works with intrachromosomal interaction matrices. You can import data from various formats:

```r
library(HiCcompare)

# From sparse upper triangular matrices (3 columns: region1, region2, IF)
data("HMEC.chr22")
data("NHEK.chr22")

# Create the hic.table object
# 'scale = TRUE' performs total sum scaling by default
chr22.table <- create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')

# From .cool files
# dat <- cooler2bedpe(path = "file.cool")

# From HiC-Pro
# dat <- hicpro2bedpe(matrix_file, bed_file)
```

### 2. Handling CNVs and Blacklists

To reduce false positives, exclude regions with Copy Number Variations (CNV) or known sequencing artifacts (blacklists).

```r
# Load provided blacklists
data('hg19_blacklist')

# Use the exclude.regions parameter during table creation
# exclude.overlap: percentage of bin overlap to trigger exclusion (default 0.2)
chr22.table <- create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22', 
                                exclude.regions = hg19_blacklist)
```

### 3. Joint Normalization (hic_loess)

This step removes technical biases between the two datasets using an MD plot (M = log2 fold change, D = unit distance).

```r
# Jointly normalize a single chromosome
# span = NA triggers automatic smoothing parameter selection
hic.table <- hic_loess(chr22.table, Plot = TRUE)

# For multiple chromosomes, use a list and parallel processing
# hic.list <- list(chr10.table, chr22.table)
# hic.list <- hic_loess(hic.list, parallel = TRUE)
```

### 4. Difference Detection (hic_compare)

Calculates Z-scores and p-values for differential interactions. It is critical to filter out low average expression (A) values to avoid artifacts.

```r
# Determine optimal filtering threshold
filter_params(hic.table)

# Perform comparison
# A.min: minimum average expression to include (if NA, uses 10th percentile)
# adjust.dist: whether to calculate Z-scores per distance (recommended)
hic.table <- hic_compare(hic.table, A.min = 15, adjust.dist = TRUE, p.method = 'fdr')
```

## Key Functions and Utilities

- `total_sum()`: Performs total sum scaling across a list of `hic.table` objects (recommended for whole-genome analysis).
- `make_InteractionSet()`: Converts `hic.table` results to an `InteractionSet` object for integration with other Bioconductor tools.
- `sparse2full()` / `full2sparse()`: Convert between sparse and full matrix formats.
- `MD.plot2()`: Visualizes the MD plot with optional p-value coloring.
- `hic_simulate()`: Generates simulated Hi-C matrices with known differences for benchmarking.

## Tips for Success

- **Resolution**: High-resolution matrices (e.g., 1kb - 50kb) are often too sparse for `HiCcompare`. Resolutions of 100kb, 500kb, or 1Mb are typically more robust.
- **Intrachromosomal Only**: The package is currently optimized for intrachromosomal interactions.
- **Memory Management**: For high-resolution data, manually setting the `span` in `hic_loess` (e.g., `span = 0.1`) significantly reduces computation time compared to automatic selection.
- **Parallelization**: Use `BiocParallel` by setting `parallel = TRUE` in `hic_loess` and `hic_compare` when processing a list of multiple chromosomes.

## Reference documentation

- [HiCcompare Vignette](./references/HiCcompare-vignette.md)
- [HiCcompare Rmarkdown Source](./references/HiCcompare-vignette.Rmd)