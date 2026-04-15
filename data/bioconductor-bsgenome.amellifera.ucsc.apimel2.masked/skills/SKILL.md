---
name: bioconductor-bsgenome.amellifera.ucsc.apimel2.masked
description: This package provides masked genome sequences for the Apis mellifera (Honey Bee) based on the UCSC apiMel2 assembly. Use when user asks to access honey bee genomic sequences with assembly gap, ambiguity, or repeat masks, perform motif searching in masked regions, or analyze the apiMel2 genome assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Amellifera.UCSC.apiMel2.masked.html
---

# bioconductor-bsgenome.amellifera.ucsc.apimel2.masked

name: bioconductor-bsgenome.amellifera.ucsc.apimel2.masked
description: Provides access to the full masked genome sequences for Apis mellifera (Honey Bee) based on the UCSC apiMel2 assembly (Jan. 2005). Use this skill when you need to perform genomic analysis on the honey bee genome that requires masking of assembly gaps, ambiguities, or repeats.

# bioconductor-bsgenome.amellifera.ucsc.apimel2.masked

## Overview

This package provides a `BSgenome` data object containing the masked genome sequences for *Apis mellifera*. It is based on the UCSC `apiMel2` assembly. Unlike the standard `BSgenome.Amellifera.UCSC.apiMel2` package, this version includes three specific masks for each sequence:
1.  **AGAPS**: Mask of assembly gaps.
2.  **AMB**: Mask of intra-contig ambiguities.
3.  **RM**: Mask of repeats from RepeatMasker.

By default, only the **AGAPS** and **AMB** masks are active.

## Installation and Loading

To use this package in R:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Amellifera.UCSC.apiMel2.masked")

library(BSgenome.Amellifera.UCSC.apiMel2.masked)
```

## Basic Usage

### Accessing the Genome Object
The main object is named the same as the package:

```r
genome <- BSgenome.Amellifera.UCSC.apiMel2.masked

# View sequence names and lengths
seqnames(genome)
seqlengths(genome)
```

### Working with Masked Sequences
Accessing a specific chromosome or group returns a `MaskedDNAString` object.

```r
# Access Group1
group1 <- genome$Group1

# View active masks
active(masks(group1))

# Toggle masks (e.g., activate RepeatMasker)
active(masks(group1))["RM"] <- TRUE
```

### Unmasking Sequences
If you need the raw sequence without any masks (identical to the non-masked BSgenome package):

```r
unmasked_seq <- unmasked(genome$Group1)
```

## Common Workflows

### Iterating Over Sequences
To perform an operation across the entire genome while respecting masks:

```r
for (seqname in seqnames(genome)) {
    seq <- genome[[seqname]]
    # Perform analysis on masked sequence
    # Masks are automatically respected by many Biostrings functions
}
```

### Motif Searching
When searching for motifs, the masks prevent false positives in gap or repeat regions:

```r
library(Biostrings)
# Search for a specific pattern in Group1
matchPattern("TTAGGGTTAGGG", genome$Group1)
```

## Tips
- **Memory Management**: BSgenome objects use lazy loading. Sequences are loaded into memory only when accessed.
- **Mask Behavior**: Note that `alphabetFrequency()` and other Biostrings functions behave differently on `MaskedDNAString` objects compared to standard `DNAString` objects; they typically ignore masked regions.
- **RepeatMasker**: The `RM` mask is present but **inactive** by default. You must manually set `active(masks(x))["RM"] <- TRUE` to use it.

## Reference documentation
- [BSgenome.Amellifera.UCSC.apiMel2.masked](./references/reference_manual.md)