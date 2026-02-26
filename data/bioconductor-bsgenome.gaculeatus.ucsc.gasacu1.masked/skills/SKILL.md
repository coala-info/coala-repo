---
name: bioconductor-bsgenome.gaculeatus.ucsc.gasacu1.masked
description: This package provides masked genome sequences for the Gasterosteus aculeatus (Stickleback) gasAcu1 assembly. Use when user asks to access Stickleback genomic sequences, perform motif searching in non-masked regions, or analyze assembly gaps and repeat sequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Gaculeatus.UCSC.gasAcu1.masked.html
---


# bioconductor-bsgenome.gaculeatus.ucsc.gasacu1.masked

name: bioconductor-bsgenome.gaculeatus.ucsc.gasacu1.masked
description: Provides access to the full masked genome sequences for Gasterosteus aculeatus (Stickleback) based on the UCSC gasAcu1 assembly (Feb. 2006). Use this skill when you need to perform genomic analysis on Stickleback that requires masked sequences (assembly gaps, ambiguities, RepeatMasker, and Tandem Repeats Finder).

# bioconductor-bsgenome.gaculeatus.ucsc.gasacu1.masked

## Overview

This package provides a `BSgenome` data object containing the genome of *Gasterosteus aculeatus* (Stickleback), UCSC version gasAcu1. Unlike the standard BSgenome package, this version includes four specific masks for each sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Gaculeatus.UCSC.gasAcu1.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Gaculeatus.UCSC.gasAcu1.masked

# List available sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chrI
```

## Working with Masks

Because the sequences are `MaskedDNAString` objects, you can manage which masks are active or retrieve the underlying raw sequence.

### Viewing and Activating Masks
```r
# Check which masks are available
masknames(genome$chrI)

# Check which masks are currently active
active(masks(genome$chrI))

# Activate the RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(genome$chrI))["RM"] <- TRUE
active(masks(genome$chrI))["TRF"] <- TRUE
```

### Unmasking Sequences
If you need the raw sequence without any masks (identical to the non-masked BSgenome package):
```r
# Get the unmasked DNAString
raw_seq <- unmasked(genome$chrI)
```

## Common Workflows

### Genome-wide Motif Searching
When searching for motifs, active masks prevent the search from returning hits in masked regions (e.g., gaps or repeats).

```r
library(Biostrings)

# Define a motif
motif <- DNAString("ATGCATGC")

# Match pattern on a masked chromosome
# Hits will only be found in non-masked regions
matches <- matchPattern(motif, genome$chrI)
```

### Analyzing Gap Content
You can verify that assembly gaps (AGAPS) consist only of "N" characters:

```r
# Example: Check gaps on chromosome I
seq_segment <- genome$chrI
masks(seq_segment) <- gaps(masks(seq_segment)["AGAPS"])
uniqueLetters(seq_segment) # Should return "N"
```

## Tips
- **Memory Management**: BSgenome objects use a caching mechanism. If you iterate through all chromosomes, use `options(verbose=TRUE)` to monitor memory/cache behavior.
- **Coordinate Systems**: Coordinates in this package are 1-based, consistent with standard Bioconductor `Biostrings` and `GenomicRanges` conventions.
- **Mask Persistence**: Changes to mask activity (via `active()`) are applied to the specific object in memory, not the global package state.

## Reference documentation
- [BSgenome.Gaculeatus.UCSC.gasAcu1.masked Reference Manual](./references/reference_manual.md)