---
name: bioconductor-mafdb.1kgenomes.phase1.grch38
description: This Bioconductor package provides minor allele frequency data from the 1000 Genomes Project Phase 1 lifted over to the GRCh38 assembly. Use when user asks to retrieve population-specific allele frequencies, query genomic scores for specific variants, or annotate GRCh38 coordinates with 1000 Genomes Phase 1 data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.1Kgenomes.phase1.GRCh38.html
---

# bioconductor-mafdb.1kgenomes.phase1.grch38

## Overview

The `MafDb.1Kgenomes.phase1.GRCh38` package is a Bioconductor annotation resource providing Minor Allele Frequency (MAF) data from Phase 1 of the 1000 Genomes Project. The data is stored as a `GScores` object, which is a memory-efficient container that loads data on-demand for specific genomic regions or populations. While the original Phase 1 data was based on GRCh37, this specific package provides the data lifted over to the **GRCh38** assembly.

## Key Workflows and Functions

### Loading the Database

To use the package, load the library and assign the main `GScores` object to a variable for easier access.

```r
library(MafDb.1Kgenomes.phase1.GRCh38)

# The object name matches the package name
mafdb <- MafDb.1Kgenomes.phase1.GRCh38
mafdb
```

### Identifying Available Populations

The 1000 Genomes Project contains data for various global populations. Use the `populations()` function to see which frequency columns are available.

```r
populations(mafdb)
# Common outputs include: AF (Global), AFR (African), AMR (Admixed American), 
# ASN (East Asian), EUR (European)
```

### Querying Frequencies

The primary function for retrieving data is `gscores()`. You can query using `GRanges` objects or specific genomic coordinates.

#### Using GRanges
```r
library(GenomicRanges)

# Query a specific position on Chromosome 15
rng <- GRanges("15:28111713")
res <- gscores(mafdb, rng)
```

#### Using rsIDs (requires SNPlocs)
To query by rsID, you typically use a `SNPlocs` package to get the coordinates first.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for a specific SNP
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF
gscores(mafdb, rng_snp)
```

### Data Precision and Storage

To optimize space, this package uses a specific storage schema for MAF values:
- MAF values $\ge$ 0.1 are stored with **two** significant digits.
- MAF values < 0.1 are stored with **one** significant digit.

## Tips for Efficient Usage

1.  **Genome Build Consistency**: Ensure your input coordinates are in **GRCh38**. If your data is in GRCh37 (hg19), you must lift it over before querying this specific package.
2.  **Memory Management**: The `GScores` object uses lazy loading. It does not load the entire database into RAM, making it suitable for high-throughput annotation of large VCF files when combined with `GenomicScores` methods.
3.  **Metadata**: Use `citation(mafdb)` to get the correct reference for the 1000 Genomes Phase 1 data and the liftOver procedure used.

## Reference documentation

- [MafDb.1Kgenomes.phase1.GRCh38 Reference Manual](./references/reference_manual.md)