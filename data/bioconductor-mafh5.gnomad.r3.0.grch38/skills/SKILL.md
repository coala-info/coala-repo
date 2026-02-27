---
name: bioconductor-mafh5.gnomad.r3.0.grch38
description: "This Bioconductor package provides access to Minor Allele Frequency data from gnomAD v3.0 for the GRCh38 genome build. Use when user asks to annotate human genetic variants with population frequency data, query allele frequencies by genomic coordinates or rsID, or retrieve gnomAD v3.0 data for the GRCh38 assembly."
homepage: https://bioconductor.org/packages/3.11/data/annotation/html/MafH5.gnomAD.r3.0.GRCh38.html
---


# bioconductor-mafh5.gnomad.r3.0.grch38

name: bioconductor-mafh5.gnomad.r3.0.grch38
description: Access and query Minor Allele Frequency (MAF) data from gnomAD v3.0 for the GRCh38 genome build. Use this skill when you need to annotate human genetic variants with population frequency data, specifically for whole-genome sequencing (WGS) data from the Genome Aggregation Database (gnomAD) release 3.0.

# bioconductor-mafh5.gnomad.r3.0.grch38

## Overview

The `MafH5.gnomAD.r3.0.GRCh38` package is a Bioconductor annotation resource that provides Minor Allele Frequency (MAF) data from gnomAD v3.0. It uses an HDF5 backend to store data efficiently, loading only the necessary genomic regions into memory during queries. The data is exposed as a `GScores` object, which is compatible with the `GenomicScores` infrastructure.

Key features:
- **Data Source**: gnomAD v3.0 (GRCh38).
- **Storage**: HDF5 backend for low memory footprint.
- **Precision**: MAF >= 0.1 stored with two significant digits; MAF < 0.1 stored with one significant digit.
- **Populations**: Supports querying global and population-specific frequencies.

## Basic Usage

### Loading the Package and Data

```r
library(MafH5.gnomAD.r3.0.GRCh38)

# The GScores object is named exactly like the package
mafh5 <- MafH5.gnomAD.r3.0.GRCh38
mafh5
```

### Inspecting Available Populations

To see which population-specific frequencies are available in this version:

```r
populations(mafh5)
```

### Querying Allele Frequencies

Use the `gscores()` function from the `GenomicScores` package to retrieve frequencies. You can provide genomic coordinates as a `GRanges` object.

#### Querying by Coordinates
```r
library(GenomicRanges)

# Query a specific SNP by position
rng <- GRanges("15:28111713")
gscores(mafh5, rng)

# Query a range (e.g., for deletions or regions)
rng_range <- GRanges("3:46373452-46373484")
gscores(mafh5, rng_range)
```

#### Querying by rsID
To query by rsID, you must first map the ID to coordinates using a SNP locator package like `SNPlocs.Hsapiens.dbSNP149.GRCh38`.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for an rsID
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Get frequencies
gscores(mafh5, rng_snp)
```

## Advanced Workflows

### Annotating a VCF or Large GRanges Object
When working with many variants, ensure your `GRanges` object uses the "UCSC" chromosome naming convention (e.g., "chr1") or "NCBI" (e.g., "1") to match the package's internal structure.

```r
# Check seqlevels style
seqlevelsStyle(my_variants)

# If needed, change to match the mafh5 object
seqlevelsStyle(my_variants) <- seqlevelsStyle(mafh5)

# Annotate
annotated_variants <- gscores(mafh5, my_variants)
```

### Handling Non-SNP Variants
For indels or non-single nucleotide variants, use the `type` argument if specific behavior is required:

```r
# Querying non-SNRs (non-single nucleotide residues)
gscores(mafh5, GRanges("3:46373452-46373484"), type="nonsnrs")
```

## Performance Tips
- **Disk Speed**: Because this package uses an HDF5 backend, it performs significantly better on local SSDs than on network-attached storage (NFS).
- **Memory**: The package is designed to be memory-efficient. You do not need to "load" the whole dataset; `gscores()` handles the on-demand data retrieval.

## Reference documentation
- [MafH5.gnomAD.r3.0.GRCh38 Reference Manual](./references/reference_manual.md)