---
name: bioconductor-mafdb.exac.r1.0.hs37d5
description: This package provides minor allele frequency data from the Exome Aggregation Consortium (ExAC) release 1.0 for the hs37d5 human reference genome. Use when user asks to retrieve population-specific allele frequencies, annotate genomic coordinates with ExAC data, or query variant frequencies by RS ID.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.ExAC.r1.0.hs37d5.html
---

# bioconductor-mafdb.exac.r1.0.hs37d5

## Overview

The `MafDb.ExAC.r1.0.hs37d5` package is a Bioconductor annotation resource providing MAF data from ExAC (v1.0). It exposes data as a `GScores` object, which allows for efficient, memory-mapped querying of allele frequencies across different human populations. The data is specifically mapped to the `hs37d5` reference (GRCh37).

To save space, MAF values $\ge 0.1$ are stored with two significant digits, while values $< 0.1$ are stored with one.

## Basic Usage

### Loading the Package and Data
The package automatically creates a `GScores` object named after the package.

```r
library(MafDb.ExAC.r1.0.hs37d5)

# Assign to a shorter variable for convenience
mafdb <- MafDb.ExAC.r1.0.hs37d5
mafdb
```

### Inspecting Populations
ExAC contains data for several distinct populations. Use `populations()` to see available metadata columns.

```r
populations(mafdb)
# Common outputs: AF (Global), AF_AFR (African), AF_AMR (Admixed American), 
# AF_EAS (East Asian), AF_FIN (Finnish), AF_NFE (Non-Finnish European), 
# AF_OTH (Other), AF_SAS (South Asian)
```

### Querying Allele Frequencies
Queries are performed using the `gscores()` function from the `GenomicScores` package. You can query by `GRanges` objects or by SNP identifiers (if combined with a `SNPlocs` package).

#### Query by Genomic Coordinates
```r
library(GenomicRanges)

# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

#### Query by RS ID (requires SNPlocs)
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for a specific RS ID
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_snp)
```

## Workflows & Tips

### Annotating a VCF or Variant List
If you have a set of variants in a `GRanges` object, you can append the ExAC frequencies directly to the metadata columns:

```r
my_variants <- GRanges(c("1:1000000", "2:2000000"))
annotated_variants <- gscores(mafdb, my_variants)
```

### Memory Management
The package uses a lazy-loading mechanism. It only loads data into main memory for the specific chromosomes and populations being queried. You do not need to worry about the large size of the underlying database during initial loading.

### Reference Genome Consistency
Ensure your input coordinates are based on **GRCh37/hs37d5**. Using GRCh38 coordinates will result in incorrect frequency assignments or empty results.

## Reference documentation

- [MafDb.ExAC.r1.0.hs37d5 Reference Manual](./references/reference_manual.md)