---
name: bioconductor-bsgenome.btaurus.ucsc.bostau3.masked
description: This package provides the full masked genome sequences for Bos taurus based on the UCSC bosTau3 assembly. Use when user asks to access cow genomic sequences with assembly gaps, ambiguities, or repeats masked for analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau3.masked.html
---


# bioconductor-bsgenome.btaurus.ucsc.bostau3.masked

name: bioconductor-bsgenome.btaurus.ucsc.bostau3.masked
description: Provides the full masked genome sequences for Bos taurus (Cow) based on the UCSC bosTau3 assembly (Aug. 2006). Use this skill when you need to perform genomic analysis on the cow genome that requires masking of assembly gaps, ambiguities, or repeats (RepeatMasker and Tandem Repeats Finder).

# bioconductor-bsgenome.btaurus.ucsc.bostau3.masked

## Overview

This package contains a `BSgenome` object providing the masked genome sequences for *Bos taurus* (UCSC version bosTau3). Unlike the standard `BSgenome.Btaurus.UCSC.bosTau3` package, this version includes four built-in masks for every chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Installation and Loading

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Btaurus.UCSC.bosTau3.masked")
library(BSgenome.Btaurus.UCSC.bosTau3.masked)
```

## Usage and Workflows

### Accessing the Genome Object
The main object is named identically to the package.

```r
genome <- BSgenome.Btaurus.UCSC.bosTau3.masked
genome
```

### Inspecting Sequences and Masks
Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Get chromosome 1
chr1 <- genome$chr1

# View active masks
active(masks(chr1))

# Check sequence lengths
seqlengths(genome)
```

### Managing Masks
You can toggle masks to include or exclude repeats in your analysis.

```r
# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Remove all masks to get the raw sequence (equivalent to the unmasked package)
raw_seq <- unmasked(chr1)
```

### Genomic Analysis Example
When masks are active, functions in the `Biostrings` and `BSgenome` packages (like `matchPattern` or `vcountPattern`) will skip the masked regions.

```r
# Count occurrences of a motif in non-masked regions of chr1
motif <- "TTAGGG"
vcountPattern(motif, genome$chr1)
```

## Tips
- **Memory Management**: BSgenome objects use a cache. If you iterate through all chromosomes, the memory usage may grow.
- **Mask Defaults**: Remember that RM and TRF masks are present but **inactive** by default. You must manually set them to `TRUE` if you wish to exclude repeats from your analysis.
- **Coordinate System**: This package uses the UCSC naming convention (e.g., "chr1", "chrM").

## Reference documentation
- [BSgenome.Btaurus.UCSC.bosTau3.masked Reference Manual](./references/reference_manual.md)