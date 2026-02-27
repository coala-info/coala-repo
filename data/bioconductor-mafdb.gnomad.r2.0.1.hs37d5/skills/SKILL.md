---
name: bioconductor-mafdb.gnomad.r2.0.1.hs37d5
description: This package provides minor allele frequency data from gnomAD release 2.0.1 for the hs37d5 human reference genome. Use when user asks to query population-specific allele frequencies, annotate genetic variants with MAF data, or filter variants based on rarity in specific ethnic groups.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.gnomAD.r2.0.1.hs37d5.html
---


# bioconductor-mafdb.gnomad.r2.0.1.hs37d5

name: bioconductor-mafdb.gnomad.r2.0.1.hs37d5
description: Annotation package for minor allele frequency (MAF) data from the Genome Aggregation Database (gnomAD) release 2.0.1 for the hs37d5 (GRCh37) human reference genome. Use this skill to query population-specific allele frequencies for genetic variants using GScores objects and the GenomicScores framework.

# bioconductor-mafdb.gnomad.r2.0.1.hs37d5

## Overview

This package provides access to MAF data from gnomAD v2.0.1 (whole genome variant set) mapped to the hs37d5 (GRCh37) reference. The data is stored as a `GScores` object, which efficiently manages memory by loading specific chromosomes and populations only when queried. Note that to save space, MAF values $\ge$ 0.1 use two significant digits, while values < 0.1 use one significant digit.

## Basic Usage

### Loading the Package and Object
The data object is named identically to the package.

```r
library(MafDb.gnomAD.r2.0.1.hs37d5)
mafdb <- MafDb.gnomAD.r2.0.1.hs37d5
mafdb
```

### Checking Available Populations
Use the `populations()` function to see which ethnic groups/sub-populations are available in this release (e.g., AF, AF_AFR, AF_AMR, AF_ASJ, AF_EAS, AF_FIN, AF_NFE, AF_OTH).

```r
populations(mafdb)
```

### Querying Allele Frequencies
Use the `gscores()` function from the `GenomicScores` package to retrieve frequencies. You can query using `GRanges` objects or SNP IDs if a supporting `SNPlocs` package is loaded.

#### Query by Genomic Coordinates
```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

#### Query by SNP ID (requires SNPlocs)
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37
rng <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng)
```

## Workflows & Tips

### Filtering Variants by MAF
A common workflow involves annotating a set of user-defined variants and filtering out common variants (e.g., MAF > 0.01) to focus on rare alleles.

```r
# Assume 'my_variants' is a GRanges object
annotated_variants <- gscores(mafdb, my_variants)
# Filter for rare variants in the Non-Finnish European population
rare_variants <- annotated_variants[annotated_variants$AF_NFE < 0.01]
```

### Metadata and Citation
To properly attribute the data source and check versioning:
```r
citation(mafdb)
```

### Memory Management
The `GScores` object uses "lazy loading." While the object itself is small in the global environment, querying large numbers of variants across many chromosomes will increase memory usage as data chunks are cached.

## Reference documentation

- [MafDb.gnomAD.r2.0.1.hs37d5 Reference Manual](./references/reference_manual.md)