---
name: bioconductor-mafdb.gnomadex.r2.0.1.hs37d5
description: This Bioconductor package provides minor allele frequency data from the gnomAD exome variant set version 2.0.1 for the hs37d5 reference genome. Use when user asks to retrieve population-specific allele frequencies, query genomic coordinates for variant scores, or annotate variants using gnomAD exome data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.gnomADex.r2.0.1.hs37d5.html
---

# bioconductor-mafdb.gnomadex.r2.0.1.hs37d5

## Overview

The `MafDb.gnomADex.r2.0.1.hs37d5` package is a Bioconductor annotation resource providing minor allele frequency (MAF) data from the Genome Aggregation Database (gnomAD) exome variant set (v2.0.1). The data is stored as a `GScores` object, which allows for efficient, memory-light querying of frequencies across different human populations.

Key characteristics:
- **Reference Genome**: hs37d5 (compatible with GRCh37/hg19).
- **Data Source**: gnomAD exomes v2.0.1.
- **Storage**: MAF values $\ge 0.1$ use two significant digits; values $< 0.1$ use one significant digit to optimize space.

## Installation and Loading

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MafDb.gnomADex.r2.0.1.hs37d5")

library(MafDb.gnomADex.r2.0.1.hs37d5)
mafdb <- MafDb.gnomADex.r2.0.1.hs37d5
```

## Core Workflows

### 1. Inspecting the Database
Check available populations and metadata.

```r
# List available populations (e.g., AF, AF_AFR, AF_AMR, AF_ASJ, AF_EAS, AF_FIN, AF_NFE, AF_OTH, AF_SAS)
populations(mafdb)

# View object metadata
mafdb
citation(mafdb)
```

### 2. Querying by Genomic Coordinates
Use `GRanges` objects to retrieve frequencies for specific positions.

```r
library(GenomicRanges)

# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

### 3. Querying by rsID
To query by rsID, you must map the ID to a genomic coordinate first, typically using a `SNPlocs` package.

```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for a specific SNP
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve gnomAD exome frequencies
gscores(mafdb, rng_snp)
```

### 4. Handling Results
The `gscores()` function returns a `GRanges` object where the scores (frequencies) are stored in the metadata columns (mcols).

```r
res <- gscores(mafdb, rng)
# Convert to data frame for easier inspection
as.data.frame(res)
```

## Usage Tips
- **Genome Version**: Ensure your input coordinates are based on GRCh37/hg19. If using GRCh38, you must lift over coordinates or use the corresponding GRCh38 MafDb package.
- **Memory Management**: The package loads data into memory only as specific chromosomes or populations are queried, making it efficient for large-scale annotation.
- **Population Codes**: "AF" usually refers to the global allele frequency, while codes like "AF_NFE" refer to Non-Finnish Europeans.

## Reference documentation
- [MafDb.gnomADex.r2.0.1.hs37d5 Reference Manual](./references/reference_manual.md)