---
name: bioconductor-mafh5.gnomad.v3.1.1.grch38
description: This tool provides access to minor allele frequency data from gnomAD v3.1.1 for the GRCh38 genome build using an HDF5-backed GScores object. Use when user asks to annotate genetic variants with population-level frequency statistics, query allele frequencies by genomic coordinates, or retrieve gnomAD data for specific rsIDs.
homepage: https://bioconductor.org/packages/3.13/data/annotation/html/MafH5.gnomAD.v3.1.1.GRCh38.html
---


# bioconductor-mafh5.gnomad.v3.1.1.grch38

name: bioconductor-mafh5.gnomad.v3.1.1.grch38
description: Access and query minor allele frequency (MAF) data from gnomAD v3.1.1 for the GRCh38 genome build. Use this skill when you need to annotate human genetic variants with population-level frequency statistics, specifically using the HDF5-backed GScores object from the MafH5.gnomAD.v3.1.1.GRCh38 Bioconductor package.

# bioconductor-mafh5.gnomad.v3.1.1.grch38

## Overview

The `MafH5.gnomAD.v3.1.1.GRCh38` package is an annotation resource providing minor allele frequencies (MAF) derived from the Genome Aggregation Database (gnomAD) version 3.1.1. It uses an HDF5 backend to store data efficiently, loading only the necessary chromosomes and populations into memory during queries. The data is exposed as a `GScores` object, which is managed via the `GenomicScores` framework.

## Key Workflows

### Loading the Package and Data
To use the frequency data, load the library and reference the singleton object named after the package.

```r
library(MafH5.gnomAD.v3.1.1.GRCh38)

# Reference the GScores object
mafh5 <- MafH5.gnomAD.v3.1.1.GRCh38
mafh5
```

### Inspecting Populations
Check which specific populations or sub-groups are available for frequency lookups.

```r
populations(mafh5)
```

### Querying Frequencies by Coordinates
Use the `gscores()` function to retrieve frequencies for specific genomic positions. You must provide a `GRanges` object.

```r
library(GenomicRanges)

# Query a single SNP position
gscores(mafh5, GRanges("15:28111713"))

# Query a range (e.g., for deletions or multi-nucleotide variants)
# Use type="nonsnrs" for non-single nucleotide replacements if applicable
gscores(mafh5, GRanges("3:46373452-46373484"), type="nonsnrs")
```

### Querying by rsID
To query by dbSNP identifiers, you typically need a corresponding `SNPlocs` package to resolve the coordinates first.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for an rsID
rng <- snpsById(snpdb, ids="rs1129038")

# Retrieve gnomAD frequencies for those coordinates
gscores(mafh5, rng)
```

## Usage Tips
- **Memory Efficiency**: The HDF5 backend is disk-based. Performance is significantly better on local SSDs compared to network drives (NFS).
- **Precision**: To save space, MAF values $\ge 0.1$ are stored with two significant digits; values $< 0.1$ are stored with one significant digit.
- **Genome Build**: This package is strictly for **GRCh38**. Ensure your input coordinates or `GRanges` objects use the same assembly.
- **Metadata**: Use `citation(mafh5)` to get the correct attribution for the gnomAD data and the package.

## Reference documentation
- [MafH5.gnomAD.v3.1.1.GRCh38 Reference Manual](./references/reference_manual.md)