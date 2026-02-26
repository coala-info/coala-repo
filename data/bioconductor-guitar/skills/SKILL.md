---
name: bioconductor-guitar
description: This tool visualizes the distribution of RNA-related genomic features relative to standardized transcript landmarks like the TSS, start codon, stop codon, and TES. Use when user asks to analyze the distribution of genomic features across RNA transcripts, compare multiple feature sets, or generate Guitar plots to standardize transcript lengths into a common coordinate system.
homepage: https://bioconductor.org/packages/release/bioc/html/Guitar.html
---


# bioconductor-guitar

name: bioconductor-guitar
description: Visualization of RNA-related genomic features relative to transcript landmarks (TSS, start codon, stop codon, and TES). Use this skill when analyzing the distribution of genomic features (such as m6A methylation sites, RNA-binding protein sites, or peaks from MeRIP-Seq/m6A-Seq) across RNA transcripts. It is particularly useful for comparing multiple feature sets and generating "Guitar plots" that standardize transcript lengths into a common coordinate system.

## Overview

The **Guitar** package is designed for landmark-guided transcriptomic analysis. It projects genomic features onto a standardized transcript coordinate system, allowing researchers to see if features are enriched in specific regions like the 5' UTR, CDS, or 3' UTR. It handles the complexity of varying transcript lengths by rescaling components into a uniform "Guitar" coordinate space.

## Core Workflow

The typical workflow involves three main steps:
1.  **Input Preparation**: Loading genomic features (BED files, GRanges, or GRangesList).
2.  **Coordinate Building**: Creating a `GuitarTxdb` object from a `TxDb` annotation.
3.  **Visualization**: Generating the distribution plot using `GuitarPlot`.

### 1. Loading Genomic Features
Features should be provided as a named list of file paths (BED) or R objects (GRanges/GRangesList).

```r
library(Guitar)

# From BED files
stBedFiles <- list(
  feature1 = "path/to/peaks1.bed",
  feature2 = "path/to/peaks2.bed"
)

# From GRanges objects
# stGRanges <- list(Group1 = gr1, Group2 = gr2)
```

### 2. Building Guitar Coordinates
While `GuitarPlot` can build coordinates automatically, it is more efficient to create a `GuitarTxdb` object once and reuse it.

```r
library(GenomicFeatures)
# Load a TxDb object (e.g., from a local SQLite file or Bioconductor annotation package)
txdb <- loadDb("your_annotation.sqlite")

# Build the Guitar coordinates
guitarTxdb <- makeGuitarTxdb(txdb = txdb, txPrimaryOnly = FALSE)
```

### 3. Generating the Guitar Plot
The `GuitarPlot` function is the primary interface for visualization.

```r
# Basic plot
GuitarPlot(
  txTxdb = txdb,
  stBedFiles = stBedFiles,
  miscOutFilePrefix = "my_analysis"
)

# Advanced plot with specific parameters
GuitarPlot(
  txTxdb = txdb,
  stBedFiles = stBedFiles,
  headOrtail = TRUE,           # Include 1kb promoter and tail regions
  enableCI = TRUE,             # Show Confidence Intervals
  pltTxType = c("mrna"),       # Focus only on mRNA
  stGroupName = c("Set1", "Set2") # Custom labels for the legend
)
```

## Key Functions

- `makeGuitarTxdb()`: Pre-processes transcript landmarks. You can adjust the relative proportions of transcript components (5'UTR, CDS, 3'UTR) using `txMrnaComponentProp`.
- `GuitarPlot()`: The main plotting function. It can accept `txGenomeVer` (e.g., "hg38") to download annotations automatically, or a pre-loaded `txTxdb`.
- `getTxdb()`: A helper to download `TxDb` objects from UCSC/Ensembl based on genome version.
- `samplePoints()`: Used internally to sample points from genomic features for distribution calculation.

## Tips for Success

- **Genome Versions**: Ensure your BED files and the `TxDb` object use the exact same genome assembly (e.g., both mm10 or both hg38).
- **Ambiguity Filter**: `makeGuitarTxdb` includes an ambiguity filter. If you have overlapping gene definitions that cause issues, check the `txAmblguity` parameter.
- **Output**: By default, `GuitarPlot` saves a PDF to the working directory. Set `miscOutFilePrefix = NA` if you only want the R object returned and no file written.
- **Feature Types**: You can plot distributions for different transcript types separately (e.g., `mrna`, `ncrna`, or `tx` for all) using the `pltTxType` argument.

## Reference documentation
- [Guitar Overview](./references/Guitar-Overview.md)