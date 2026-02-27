---
name: bioconductor-mafdb.gnomad.r2.1.grch38
description: This package provides minor allele frequencies from gnomAD release 2.1 for the GRCh38 assembly using GScores objects. Use when user asks to retrieve minor allele frequencies, query genomic coordinates for population data, or annotate variants with gnomAD frequency information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.gnomAD.r2.1.GRCh38.html
---


# bioconductor-mafdb.gnomad.r2.1.grch38

## Overview

The `MafDb.gnomAD.r2.1.GRCh38` package is a specialized annotation resource providing minor allele frequencies (MAF) from the Genome Aggregation Database (gnomAD) release 2.1, lifted over to the GRCh38 assembly. The data is stored as a `GScores` object, which allows for efficient, memory-mapped querying of genomic coordinates.

## Basic Usage

### Loading the Package and Data
To begin, load the library and assign the main database object to a variable for easier access.

```r
library(MafDb.gnomAD.r2.1.GRCh38)
mafdb <- MafDb.gnomAD.r2.1.GRCh38
mafdb
```

### Exploring Populations
gnomAD contains frequency data for various global populations. Use the `populations()` function to see which groups are available in this specific package.

```r
populations(mafdb)
```

### Querying Allele Frequencies
You can query frequencies using genomic coordinates (as `GRanges` objects) or by RS identifiers (if used in conjunction with a `SNPlocs` package).

**By Genomic Coordinates:**
Note: Ensure your coordinates are based on the GRCh38 assembly.

```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28111713")
gscores(mafdb, rng)
```

**By RS ID (requires SNPlocs):**
```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng_rs <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng_rs)
```

## Workflow Tips

1.  **Memory Management**: The package uses a "lazy loading" approach via the `GenomicScores` infrastructure. It only loads data into memory for the specific chromosomes and populations being queried, making it suitable for large-scale annotation tasks.
2.  **Precision**: To save space, MAF values $\ge 0.1$ are stored with two significant digits, while values $< 0.1$ are stored with one significant digit.
3.  **Liftover Note**: The original gnomAD v2.1 data was mapped to GRCh37. This package uses coordinates that have been lifted over to GRCh38. If your input data is in GRCh37, use the `MafDb.gnomAD.r2.1.hs37d5` package instead.
4.  **Metadata**: Use `citation(mafdb)` to get the proper reference for research papers and `object@provider` to check the data source details.

## Reference documentation

- [MafDb.gnomAD.r2.1.GRCh38 Reference Manual](./references/reference_manual.md)