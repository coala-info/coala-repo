---
name: bioconductor-bsgenome.dmelanogaster.ucsc.dm3.masked
description: This package provides the full masked genome sequences for Drosophila melanogaster (UCSC version dm3) as a BSgenome data object in R. Use when user asks to access the fruit fly reference genome, perform motif searching in masked sequences, or analyze genomic regions while accounting for assembly gaps and repeats.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Dmelanogaster.UCSC.dm3.masked.html
---


# bioconductor-bsgenome.dmelanogaster.ucsc.dm3.masked

name: bioconductor-bsgenome.dmelanogaster.ucsc.dm3.masked
description: Provides access to the full masked genome sequences for Drosophila melanogaster (UCSC version dm3). Use this skill when performing genomic analysis in R that requires the fruit fly reference genome with masks for assembly gaps, ambiguities, and repeats (RepeatMasker/TRF).

# bioconductor-bsgenome.dmelanogaster.ucsc.dm3.masked

## Overview

This package contains a `BSgenome` data object for *Drosophila melanogaster* (dm3, April 2006). Unlike the standard `BSgenome.Dmelanogaster.UCSC.dm3` package, this version includes four built-in masks for every chromosome:
1. **AGAPS**: Assembly gaps.
2. **AMB**: Intra-contig ambiguities.
3. **RM**: Repeats from RepeatMasker.
4. **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Dmelanogaster.UCSC.dm3.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Dmelanogaster.UCSC.dm3.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access chromosome 2L
chr2L <- genome$chr2L

# View active masks
active(masks(chr2L))

# Toggle masks (e.g., activate RepeatMasker)
active(masks(chr2L))["RM"] <- TRUE

# Remove all masks to get the raw sequence
raw_seq <- unmasked(chr2L)
```

## Common Workflows

### Checking Sequence Content in Gaps
A common task is verifying that assembly gaps (AGAPS) only contain "N" characters:

```r
seq <- genome$chrX
# Invert the AGAPS mask to focus only on the gaps
masks(seq) <- gaps(masks(seq)["AGAPS"])
uniqueLetters(seq) # Should return "N"
```

### Genome-Wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package. Masked regions are automatically skipped by these functions if the masks are active.

```r
library(Biostrings)
pattern <- "TATAWAW"
# Search across all chromosomes
matches <- vmatchPattern(pattern, genome)
```

## Tips
- **Memory Management**: `BSgenome` objects use a caching mechanism. If you iterate through all chromosomes, R might consume significant memory. Use `options(verbose=TRUE)` to monitor when sequences are being cached or removed.
- **Mask Sensitivity**: If your analysis (like SNP calling or motif finding) is sensitive to repetitive elements, ensure you activate the `RM` (RepeatMasker) and `TRF` (Tandem Repeats Finder) masks manually, as they are inactive by default.

## Reference documentation
- [BSgenome.Dmelanogaster.UCSC.dm3.masked Reference Manual](./references/reference_manual.md)