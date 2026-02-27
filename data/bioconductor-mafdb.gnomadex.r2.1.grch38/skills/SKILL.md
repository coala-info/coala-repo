---
name: bioconductor-mafdb.gnomadex.r2.1.grch38
description: This package provides access to Minor Allele Frequency data from gnomAD exomes release 2.1 lifted over to the GRCh38 genome assembly. Use when user asks to annotate genetic variants with population-specific allele frequencies, query MAF data by genomic coordinates, or retrieve gnomAD exome statistics for the GRCh38 build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.gnomADex.r2.1.GRCh38.html
---


# bioconductor-mafdb.gnomadex.r2.1.grch38

name: bioconductor-mafdb.gnomadex.r2.1.grch38
description: Access and query Minor Allele Frequency (MAF) data from gnomAD exomes (v2.1) for the GRCh38 genome build. Use this skill when you need to annotate human genetic variants with population-specific allele frequencies from the Genome Aggregation Database (gnomAD) exome dataset.

## Overview

The `MafDb.gnomADex.r2.1.GRCh38` package provides a `GScores` object containing Minor Allele Frequency (MAF) data derived from the Genome Aggregation Database (gnomAD) exome variant set (release 2.1). While the original gnomAD v2.1 data was aligned to GRCh37, this package contains data lifted over to the GRCh38 assembly.

The data is managed using the `GenomicScores` framework, which minimizes memory usage by loading specific chromosomes and populations into memory only when queried.

## Basic Usage

To use the package, load the library and access the main `GScores` object:

```r
library(MafDb.gnomADex.r2.1.GRCh38)

# Assign the object to a shorter variable name
mafdb <- MafDb.gnomADex.r2.1.GRCh38
mafdb
```

### Identifying Available Populations

You can check which populations are available for querying using the `populations()` function:

```r
populations(mafdb)
```

## Querying MAF Data

The primary method for retrieving frequency data is the `gscores()` function. You can query by genomic coordinates using `GRanges` objects.

### Query by Coordinates

```r
library(GenomicRanges)

# Query a specific position on chromosome 15
rng <- GRanges("15:28111713")
gscores(mafdb, rng)
```

### Query by rsID

To query by rsID, you typically need a corresponding `SNPlocs` package to resolve the coordinates for GRCh38:

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)

snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng)
```

## Data Precision and Storage

To optimize storage and performance, MAF values are stored with varying precision:
- MAF values >= 0.1 are stored with two significant digits.
- MAF values < 0.1 are stored with one significant digit.

## Workflow Tips

1. **Memory Management**: The package is designed to be memory-efficient. You do not need to worry about the size of the database as it uses lazy loading via the `GenomicScores` infrastructure.
2. **Lift-over Awareness**: Remember that these coordinates are lifted from GRCh37. If your input data is natively GRCh38, ensure your `GRanges` objects use the correct "chr" prefixing (e.g., "chr15" vs "15") to match the `seqlevelsStyle` of the `mafdb` object.
3. **Metadata**: Use `citation(mafdb)` to get the correct bibliographic information for research papers.

## Reference documentation

- [MafDb.gnomADex.r2.1.GRCh38 Reference Manual](./references/reference_manual.md)