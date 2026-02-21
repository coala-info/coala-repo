---
name: bioconductor-genomicdistributionsdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/GenomicDistributionsData.html
---

# bioconductor-genomicdistributionsdata

## Overview

`GenomicDistributionsData` is a Bioconductor data experiment package that provides essential reference datasets for genomic distribution analyses. It serves as the primary data source for the `GenomicDistributions` package, offering pre-processed information for human (hg19, hg38) and mouse (mm9, mm10) genomes. The package primarily interfaces with `ExperimentHub` to fetch data efficiently.

## Core Workflows

### Loading the Package
```r
library(GenomicDistributionsData)
library(ExperimentHub)
```

### Accessing Data via Named Functions
The simplest way to load data is using the built-in wrapper functions for specific assemblies.

*   **Chromosome Sizes:** `chromSizes_hg38()`, `chromSizes_hg19()`, `chromSizes_mm10()`, `chromSizes_mm9()`
*   **Transcription Start Sites (TSS):** `TSS_hg38()`, `TSS_hg19()`, `TSS_mm10()`, `TSS_mm9()`
*   **Gene Models (Exons, UTRs, etc.):** `geneModels_hg38()`, `geneModels_hg19()`, `geneModels_mm10()`, `geneModels_mm9()`
*   **Open Chromatin Signal Matrices:** `openSignalMatrix_hg38()`, `openSignalMatrix_hg19()`, `openSignalMatrix_mm10()`

### Accessing Data via ExperimentHub
For more control or to inspect metadata, use the `ExperimentHub` interface.

```r
hub <- ExperimentHub()
# Query available resources
query(hub, "GenomicDistributionsData")

# Retrieve specific record by ID (e.g., hg38 Chromosome Sizes)
c_sizes <- hub[["EH3473"]]

# Retrieve by specific search terms
res <- query(hub, c("GenomicDistributionsData", "geneModels_hg38"))
gene_models <- res[[1]]
```

### Data Structures
*   **Chromosome Sizes:** Returns a named integer vector where names are chromosomes and values are lengths.
*   **TSS:** Returns a `GRanges` object containing TSS coordinates and gene symbols.
*   **Gene Models:** Returns a list of `GRanges` objects (e.g., `exonsGR`, `genesGR`, `threeUTRGR`, `fiveUTRGR`).
*   **Open Signal Matrix:** Returns a matrix or data table of chromatin accessibility signals used for tissue specificity calculations.

## Usage Tips
*   **Integration:** These datasets are designed to be passed directly into `GenomicDistributions` functions like `calcChromBins()` or `calcFeatureDist()`.
*   **Caching:** `ExperimentHub` caches data locally after the first download, making subsequent calls much faster.
*   **Custom Genomes:** While the package focuses on hg19/38 and mm9/10, the underlying build functions (e.g., `buildChromSizes`) can sometimes be adapted for other assemblies if the source data is available in Bioconductor annotation packages.

## Reference documentation
- [Getting started with GenomicDistributionsData](./references/intro.md)
- [Introduction to GenomicDistributionsData](./references/intro.Rmd)