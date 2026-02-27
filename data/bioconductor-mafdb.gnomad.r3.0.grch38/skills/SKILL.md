---
name: bioconductor-mafdb.gnomad.r3.0.grch38
description: This package provides minor allele frequency data from gnomAD release 3.0 for the GRCh38 reference genome using GScores objects. Use when user asks to retrieve allele frequencies for specific genomic coordinates, query population-specific frequency data, or look up gnomAD variant scores by rsID.
homepage: https://bioconductor.org/packages/3.11/data/annotation/html/MafDb.gnomAD.r3.0.GRCh38.html
---


# bioconductor-mafdb.gnomad.r3.0.grch38

## Overview

This package provides a `GScores` object containing minor allele frequency (MAF) data from the Genome Aggregation Database (gnomAD) release 3.0, based on the GRCh38 reference genome. It allows for efficient, memory-mapped lookup of allele frequencies across different global populations. Note that to save space, MAF values $\ge 0.1$ are stored with two significant digits, while values $< 0.1$ are stored with one.

## Basic Usage

### Loading the Package and Data
The data is exposed as a `GScores` object named after the package.

```r
library(MafDb.gnomAD.r3.0.GRCh38)

# Assign the object to a shorter variable for convenience
mafdb <- MafDb.gnomAD.r3.0.GRCh38
mafdb
```

### Checking Available Populations
Use the `populations()` function to see which gnomAD population groups (e.g., AF, AF_amr, AF_nfe) are available for querying.

```r
populations(mafdb)
```

### Querying Frequencies
The primary function for retrieving data is `gscores()`. You can query by `GRanges` objects or by SNP identifiers (if a SNP location package is loaded).

#### Query by Genomic Coordinates
```r
library(GenomicRanges)

# Query a specific position
rng <- GRanges("15:28111713")
gscores(mafdb, rng)

# Query a range (e.g., for deletions or multi-nucleotide variants)
# Use type="nonsnrs" for non-single nucleotide variants
rng_del <- GRanges("3:46373452-46373484")
gscores(mafdb, rng_del, type="nonsnrs")
```

#### Query by rsID
To query by rsID, you must use a coordinate-mapping package like `SNPlocs.Hsapiens.dbSNP149.GRCh38`.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for an rsID
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve frequencies
gscores(mafdb, rng_snp)
```

## Workflow Tips

1.  **Memory Management**: The package uses lazy loading. Data is only loaded into memory for the specific chromosomes and populations being queried.
2.  **Genome Build Consistency**: Ensure your input `GRanges` or SNP positions are strictly in **GRCh38** coordinates. Using GRCh37/hg19 coordinates will result in incorrect or missing data.
3.  **Missing Values**: If a variant is not present in the gnomAD v3.0 dataset, the returned score will be `NA`.
4.  **Non-SNPs**: For indels or structural variants, ensure the `type` argument in `gscores()` is handled correctly (default is "snrs", use "nonsnrs" for ranges).

## Reference documentation

- [MafDb.gnomAD.r3.0.GRCh38 Reference Manual](./references/reference_manual.md)