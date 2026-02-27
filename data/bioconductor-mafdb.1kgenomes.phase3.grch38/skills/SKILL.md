---
name: bioconductor-mafdb.1kgenomes.phase3.grch38
description: This package provides minor allele frequency data from the 1000 Genomes Project Phase 3 mapped to the GRCh38 genome build. Use when user asks to retrieve population-specific allele frequencies for genomic variants, annotate SNPs with global or super-population frequencies, or filter variants based on frequency data in the GRCh38 coordinate system.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.1Kgenomes.phase3.GRCh38.html
---


# bioconductor-mafdb.1kgenomes.phase3.grch38

name: bioconductor-mafdb.1kgenomes.phase3.grch38
description: Annotation package for Minor Allele Frequency (MAF) data from the 1000 Genomes Project Phase 3, mapped to the GRCh38 genome build. Use this skill to retrieve population-specific allele frequencies for genomic variants (SNPs/Indels) using GScores objects and the GenomicScores framework.

# bioconductor-mafdb.1kgenomes.phase3.grch38

## Overview

The `MafDb.1Kgenomes.phase3.GRCh38` package provides access to allele frequency data from the final phase (Phase 3) of the 1000 Genomes Project. The data has been lifted over from the original GRCh37 coordinates to the GRCh38 assembly. 

Key features:
- **Data Structure**: Exposed as a `GScores` object.
- **Storage**: Optimized for memory; data is loaded per chromosome/population as queried.
- **Precision**: MAF values $\ge 0.1$ use two significant digits; values $< 0.1$ use one significant digit.
- **Populations**: Includes global and super-population frequencies (AF, EAS_AF, AMR_AF, AFR_AF, EUR_AF, SAS_AF).

## Basic Usage

### Loading the Package and Object
The package automatically creates a `GScores` object with the same name as the package.

```r
library(MafDb.1Kgenomes.phase3.GRCh38)

# Assign to a shorter variable for convenience
mafdb <- MafDb.1Kgenomes.phase3.GRCh38
mafdb
```

### Checking Available Populations
To see which population frequencies are available in this database:

```r
populations(mafdb)
```

### Querying Frequencies
Use the `gscores()` function from the `GenomicScores` package. You can query by `GRanges` objects or by SNP identifiers (if combined with a `SNPlocs` package).

#### By Genomic Coordinates
```r
library(GenomicRanges)

# Query a specific position on Chromosome 15
rng <- GRanges("15:28111713")
gscores(mafdb, rng)
```

#### By RS ID (requires SNPlocs)
To query by RS ID, you must first resolve the coordinates using a coordinate-compatible `SNPlocs` package.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for a specific SNP
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_snp)
```

## Workflow Integration

1. **Variant Annotation**: Use this package to filter common variants from a VCF file or a list of candidate mutations by checking the `AF` (Global Allele Frequency) or specific ancestry-matched populations.
2. **Memory Management**: Because the package uses lazy loading via `GScores`, it is efficient for genome-wide queries, but ensure you have the `GenomicScores` package installed to provide the necessary access methods.
3. **Coordinate System**: Always ensure your input `GRanges` are in **GRCh38** coordinates. If your data is in hg19/GRCh37, you must lift it over before querying this specific package.

## Reference documentation

- [MafDb.1Kgenomes.phase3.GRCh38 Reference Manual](./references/reference_manual.md)