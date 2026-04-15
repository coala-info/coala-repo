---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn4.masked
description: This package provides a masked version of the Rattus norvegicus (rn4) genome for use in Bioconductor. Use when user asks to access the rn4 rat genome with assembly gap, ambiguity, RepeatMasker, or Tandem Repeats Finder masks applied.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn4.masked.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn4.masked

## Overview

This package contains a `BSgenome` object for the *Rattus norvegicus* (rn4) genome. Unlike the standard `BSgenome.Rnorvegicus.UCSC.rn4` package, this version includes four built-in masks for every chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Inspection

To use the genome, load the library and assign the object to a variable for easier access.

```r
library(BSgenome.Rnorvegicus.UCSC.rn4.masked)

# Reference the genome object
genome <- BSgenome.Rnorvegicus.UCSC.rn4.masked

# List available sequences (chromosomes)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access a specific chromosome
chr1 <- genome$chr1

# View active masks
active(masks(chr1))

# Activate or deactivate specific masks
# Example: Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF)
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# To get the unmasked sequence (identical to the non-masked BSgenome package)
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Motif Searching with Masks
Masks are particularly useful for motif searching to avoid false positives in repetitive regions or gaps.

```r
library(Biostrings)

# Define a motif
motif <- "TTAGGG"

# Match pattern on a masked chromosome
# Matches will NOT be found in masked regions
matches <- matchPattern(motif, genome$chr1)
```

### Analyzing Mask Statistics
You can determine how much of a chromosome is covered by a specific mask.

```r
chr1 <- genome$chr1

# Calculate percentage of chromosome covered by assembly gaps (AGAPS)
gap_mask <- masks(chr1)[["AGAPS"]]
gap_coverage <- sum(width(gap_mask)) / nchar(chr1) * 100
```

## Tips
*   **Memory Management**: `BSgenome` objects use a cache. If you iterate through all chromosomes, the memory usage may grow. Use `options(verbose=TRUE)` to monitor when sequences are being cached or removed.
*   **Mask Persistence**: When you extract a sub-sequence using `views()`, the masks are preserved relative to the new coordinates.
*   **Default State**: Remember that RM and TRF masks are present but **inactive** by default. You must manually set them to `TRUE` if your analysis requires repeat masking.

## Reference documentation
- [BSgenome.Rnorvegicus.UCSC.rn4.masked Reference Manual](./references/reference_manual.md)