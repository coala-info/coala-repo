---
name: bioconductor-bsgenome.mmusculus.ucsc.mm8.masked
description: This package provides the full masked genome sequences for the Mus musculus (mouse) UCSC mm8 assembly. Use when user asks to perform genomic analysis on the mm8 mouse assembly, mask assembly gaps or repeats, or search for motifs in unmasked regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm8.masked.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm8.masked

name: bioconductor-bsgenome.mmusculus.ucsc.mm8.masked
description: Provides the full masked genome sequences for Mus musculus (Mouse) based on the UCSC mm8 build (Feb. 2006). Use this skill when you need to perform genomic analysis on the mm8 mouse assembly that requires masking of assembly gaps, ambiguities, or repeats (RepeatMasker/TRF).

# bioconductor-bsgenome.mmusculus.ucsc.mm8.masked

## Overview

The `BSgenome.Mmusculus.UCSC.mm8.masked` package is a data container for the Mus musculus (mouse) genome, version mm8. It differs from the standard `BSgenome.Mmusculus.UCSC.mm8` package by including four built-in masks for every chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active. This package is essential for workflows where genomic features (like motifs or alignments) should not be searched or mapped within repetitive or gap regions.

## Loading and Basic Usage

To use the genome, load the library and assign the object to a variable for easier access:

```r
library(BSgenome.Mmusculus.UCSC.mm8.masked)
genome <- BSgenome.Mmusculus.UCSC.mm8.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
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
active(masks(chr1))["RM"] <- TRUE  # Activate RepeatMasker mask
active(masks(chr1))["AGAPS"] <- FALSE # Deactivate Assembly Gaps mask

# Get the unmasked sequence (returns a DNAString)
pure_seq <- unmasked(chr1)
```

## Common Workflows

### 1. Analyzing Masked Regions
You can inspect the gaps or the content of the masks using the `gaps()` function from the `Biostrings` package.

```r
# Find all non-masked regions (the "gaps" in the masks)
available_regions <- gaps(masks(chr1))
```

### 2. Genome-wide Motif Searching
When searching for motifs, the `matchPattern` function will respect the active masks, ignoring masked regions.

```r
library(Biostrings)
pattern <- "TATAWAW"
# Matches will only be found in unmasked areas
matches <- matchPattern(pattern, genome$chr1)
```

### 3. Iterating Over All Chromosomes
To perform an operation across the entire masked genome:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on masked sequence 'seq'
  cat("Processing", sname, "with", sum(active(masks(seq))), "active masks\n")
}
```

## Tips
*   **Memory Management**: BSgenome objects use a cache. If you iterate over many chromosomes, R might consume significant memory. Use `options(verbose=TRUE)` to monitor when sequences are being cached or evicted.
*   **Mask Persistence**: Changes to mask activity (e.g., `active(masks(chr1))["RM"] <- TRUE`) are local to the object in your session and do not modify the package data on disk.
*   **Standard vs. Masked**: If you do not need repeat masking for your specific analysis, using the non-masked version (`BSgenome.Mmusculus.UCSC.mm8`) is generally faster and uses less memory.

## Reference documentation
- [BSgenome.Mmusculus.UCSC.mm8.masked](./references/reference_manual.md)