---
name: bioconductor-mafdb.gnomadex.r2.1.hs37d5
description: This package provides minor allele frequency data from gnomAD exomes release 2.1 for the hs37d5 human reference genome. Use when user asks to retrieve population-specific allele frequencies, annotate genetic variants with gnomAD data, or filter variants based on frequency in the GRCh37 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.gnomADex.r2.1.hs37d5.html
---


# bioconductor-mafdb.gnomadex.r2.1.hs37d5

name: bioconductor-mafdb.gnomadex.r2.1.hs37d5
description: Access and query minor allele frequency (MAF) data from gnomAD exomes (release 2.1) for the hs37d5 (GRCh37) human reference genome. Use this skill when you need to annotate genetic variants with population-specific frequencies from the Genome Aggregation Database (gnomAD) exome dataset.

# bioconductor-mafdb.gnomadex.r2.1.hs37d5

## Overview

The `MafDb.gnomADex.r2.1.hs37d5` package is a Bioconductor annotation resource providing minor allele frequencies (MAF) from gnomAD exome release 2.1. It uses the `GScores` (Genomic Scores) framework from the `GenomicScores` package to provide efficient, memory-mapped access to frequency data across various global populations. The data is mapped to the `hs37d5` reference (GRCh37).

## Basic Usage

### Loading the Package and Object
The package exposes a `GScores` object with the same name as the package.

```r
library(MafDb.gnomADex.r2.1.hs37d5)

# Assign to a shorter variable for convenience
mafdb <- MafDb.gnomADex.r2.1.hs37d5
mafdb
```

### Checking Available Populations
To see which specific population frequencies are available in this release:

```r
populations(mafdb)
```

### Querying Frequencies
Use the `gscores()` function to retrieve frequencies for specific genomic coordinates. You must provide a `GRanges` object.

```r
library(GenomicRanges)

# Query a specific position (e.g., on chromosome 15)
rng <- GRanges("15:28356859")
gscores(mafdb, rng)

# Query using a SNP ID (requires a SNPlocs package)
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37
rng_snp <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng_snp)
```

## Workflows and Tips

### Filtering by Population
By default, `gscores()` returns all available population columns. To retrieve only specific populations:

```r
# Retrieve only Global (AF) and European (AF_nfe) frequencies
gscores(mafdb, rng, pop=c("AF", "AF_nfe"))
```

### Data Precision
To save space, this package stores MAF values with optimized precision:
- MAF ≥ 0.1: Stored with two significant digits.
- MAF < 0.1: Stored with one significant digit.

### Integration with Variant Annotation
This package is typically used within a variant filtering pipeline. After calling variants and creating a `VRanges` or `GRanges` object, use `gscores()` to append frequency data, then filter out common variants (e.g., MAF > 0.01) to focus on rare alleles.

### Memory Management
The data is loaded into memory only as specific chromosomes or populations are queried. You do not need to worry about the large size of the gnomAD dataset crashing your R session under normal usage.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)