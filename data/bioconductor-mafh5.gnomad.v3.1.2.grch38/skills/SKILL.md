---
name: bioconductor-mafh5.gnomad.v3.1.2.grch38
description: This Bioconductor package provides Minor Allele Frequency data from gnomAD v3.1.2 for the GRCh38 assembly using an HDF5 backend. Use when user asks to retrieve allele frequencies for genomic variants, annotate variants with gnomAD data, or query population-specific frequency scores using GScores objects.
homepage: https://bioconductor.org/packages/3.16/data/annotation/html/MafH5.gnomAD.v3.1.2.GRCh38.html
---


# bioconductor-mafh5.gnomad.v3.1.2.grch38

## Overview

The `MafH5.gnomAD.v3.1.2.GRCh38` package is a Bioconductor annotation resource providing Minor Allele Frequency (MAF) data derived from the Genome Aggregation Database (gnomAD) version 3.1.2. It uses an HDF5 backend to store data efficiently, allowing for high-throughput annotation of variants on the GRCh38 assembly without loading the entire dataset into memory. The data is exposed as a `GScores` object.

## Key Features
- **Data Source**: gnomAD v3.1.2 whole genome variant set.
- **Populations**: Provides `AF` (global allele frequency) and `AF_allpopmax` (the maximum MAF across all populations).
- **Storage**: HDF5 format. Note that MAF values $\ge 0.1$ use two significant digits, while values $< 0.1$ use one significant digit to save space.

## Basic Workflow

### 1. Load the Package and Data
The data object is named identically to the package.

```r
library(MafH5.gnomAD.v3.1.2.GRCh38)

# Assign the GScores object to a shorter variable
mafh5 <- MafH5.gnomAD.v3.1.2.GRCh38
mafh5
```

### 2. Inspect Available Populations
Use the `populations()` function to see which frequency tracks are available.

```r
populations(mafh5)
# Expected output: "AF" "AF_allpopmax"
```

### 3. Querying Frequencies
Use the `gscores()` function from the `GenomicScores` package to retrieve frequencies for specific genomic ranges.

**Query by GRanges:**
```r
library(GenomicRanges)

# Query a specific SNP position
rng <- GRanges("chr15:28111713")
gscores(mafh5, rng)

# Query a range (e.g., for deletions/insertions)
# Use type="nonsnrs" for non-single nucleotide variants
rng_del <- GRanges("chr3:46373452-46373484")
gscores(mafh5, rng_del, type="nonsnrs")
```

**Query by rsID (requires SNPlocs package):**
```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng_snp <- snpsById(snpdb, ids="rs1129038")
gscores(mafh5, rng_snp)
```

## Implementation Tips
- **Performance**: Because the package uses an HDF5 backend, performance is significantly better when the package is installed on a local Solid State Drive (SSD) or Hard Disk Drive (HDD) rather than a network-attached storage (NFS).
- **Coordinate System**: Ensure your input `GRanges` are based on the **GRCh38** (hg38) assembly. Using GRCh37 coordinates will result in incorrect or missing data.
- **Memory**: The `GScores` object is a pointer to the HDF5 file; it is memory-efficient even when querying thousands of variants.

## Reference documentation
- [MafH5.gnomAD.v3.1.2.GRCh38 Reference Manual](./references/reference_manual.md)