---
name: bioconductor-plotgardenerdata
description: This package provides sample genomic datasets and raw files for the plotgardener visualization suite. Use when user asks to access example Hi-C, ChIP-seq, or GWAS data, retrieve paths to test BigWig and .hic files, or demonstrate genomic plotting functions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/plotgardenerData.html
---

# bioconductor-plotgardenerdata

name: bioconductor-plotgardenerdata
description: Access and use sample genomic datasets (Hi-C, ChIP-seq, GWAS, RNA-seq) and raw files (BigWig, .hic) provided by the plotgardenerData package. Use this skill when a user needs example data for the plotgardener visualization package or needs to demonstrate functions like readBigwig and readHic with small, valid test files.

# bioconductor-plotgardenerdata

## Overview

The `plotgardenerData` package is a companion data package for the `plotgardener` genomic visualization suite. It provides small, curated subsets of human genomic data (primarily `hg19`) including Hi-C contact matrices, ChIP-seq peaks, DNA looping data, and GWAS results. It also includes raw external files (BigWig and .hic) used to demonstrate file-reading capabilities within the plotgardener ecosystem.

## Loading Sample Datasets

The package contains several pre-processed datasets that can be loaded directly into the R environment using the `data()` function.

```R
library(plotgardenerData)

# Load specific datasets
data("IMR90_HiC_10kb")      # Hi-C contact data
data("IMR90_ChIP_H3K27ac")  # ChIP-seq data
data("GM12878_HiC_60kb")    # Hi-C contact data
```

Commonly available datasets include:
- `IMR90_HiC_10kb`: Hi-C data for IMR90 cells at 10kb resolution.
- `IMR90_ChIP_H3K27ac`: H3K27ac ChIP-seq signal.
- `hg19_pancan_Gwas`: GWAS data for various cancers.
- `IMR90_DNAloops`: Identified DNA loops in IMR90 cells.

## Accessing Raw External Files

For functions that require file paths (like `readBigwig` or `readHic` in the `plotgardener` package), use `system.file` to retrieve the paths to the included example files.

```R
# Get path to a sample BigWig file
bwFile <- system.file("extdata/test.bw", package = "plotgardenerData")

# Get path to a sample .hic file (Chromosome 22)
hicFile <- system.file("extdata/test_chr22.hic", package = "plotgardenerData")
```

## Typical Workflow

1. **Initialize**: Load the library.
2. **Identify Data**: Determine if you need a loaded R object (for plotting functions) or a file path (for reading functions).
3. **Load/Locate**: Use `data()` for objects or `system.file("extdata/...", package="plotgardenerData")` for files.
4. **Visualize**: Pass these objects or paths to `plotgardener` functions such as `plotHiC`, `plotSignal`, or `plotManhattan`.

## Tips
- **Genome Build**: All genomic data in this package is mapped to the **hg19** reference genome. Ensure your `plotgardener` page settings or other genomic annotation packages match this build.
- **Data Subsets**: These datasets are subsets of larger public datasets (e.g., from ENCODE or GEO) and are intended for demonstration and testing, not for biological inference.
- **Documentation**: Use `?datasetName` (e.g., `?IMR90_HiC_10kb`) to view the specific source and citation for any included dataset.

## Reference documentation

- [plotgardenerData](./references/plotgardenerData.md)