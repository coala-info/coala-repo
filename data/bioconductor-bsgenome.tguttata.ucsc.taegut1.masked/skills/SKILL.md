---
name: bioconductor-bsgenome.tguttata.ucsc.taegut1.masked
description: This package provides masked genome sequences for the Zebra finch based on the UCSC taeGut1 assembly. Use when user asks to access Zebra finch genomic sequences with assembly gaps and intra-contig ambiguities masked, perform motif searching on masked sequences, or manage genome-wide masks for Taeniopygia guttata.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Tguttata.UCSC.taeGut1.masked.html
---

# bioconductor-bsgenome.tguttata.ucsc.taegut1.masked

name: bioconductor-bsgenome.tguttata.ucsc.taegut1.masked
description: Provides access to the full masked genome sequences for Taeniopygia guttata (Zebra finch) based on UCSC version taeGut1 (Jul. 2008). Use this skill when you need to perform genomic analysis on the Zebra finch genome that requires masking of assembly gaps (AGAPS) and intra-contig ambiguities (AMB).

## Overview

The `BSgenome.Tguttata.UCSC.taeGut1.masked` package is a Bioconductor data package containing the genome of the Zebra finch (*Taeniopygia guttata*). It extends the standard `BSgenome.Tguttata.UCSC.taeGut1` package by adding two default active masks:
1.  **AGAPS**: Mask of assembly gaps.
2.  **AMB**: Mask of intra-contig ambiguities.

This package is essential for bioinformatics workflows where these regions should be excluded from analysis, such as motif searching or sequence alignment.

## Loading and Basic Usage

To use the genome, load the library and assign the object to a variable for easier access.

```r
library(BSgenome.Tguttata.UCSC.taeGut1.masked)

# Reference the genome object
genome <- BSgenome.Tguttata.UCSC.taeGut1.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

When you access a chromosome, it returns a `MaskedDNAString` object.

```r
# Access a specific chromosome (e.g., chr1)
chr1_masked <- genome$chr1

# View active masks
masknames(chr1_masked)

# Check the number of masked bases
sum(width(masks(chr1_masked)))
```

## Common Workflows

### Unmasking Sequences
If you need the raw sequence without the masks for a specific operation:

```r
# Get the unmasked DNAString
chr1_unmasked <- unmasked(genome$chr1)
```

### Toggling Masks
You can programmatically activate or deactivate specific masks.

```r
# Deactivate the AMB mask
active(masks(genome$chr1))["AMB"] <- FALSE

# Reactivate it
active(masks(genome$chr1))["AMB"] <- TRUE
```

### Genome-wide Analysis
Iterating through chromosomes to perform checks or calculations:

```r
for (seqname in seqnames(genome)) {
  seq <- genome[[seqname]]
  # Perform analysis on masked sequence 'seq'
  cat("Processing", seqname, "with", length(seq), "bases\n")
}
```

## Tips
- **Memory Management**: BSgenome objects use a cache. If you are iterating over many chromosomes, R will manage memory, but you can use `options(verbose=TRUE)` to monitor when sequences are being loaded or removed from the cache.
- **Compatibility**: This package is designed to work with the `Biostrings` and `BSgenome` infrastructure. Functions like `matchPattern` or `vmatchPattern` will respect the active masks by default.

## Reference documentation

- [BSgenome.Tguttata.UCSC.taeGut1.masked Reference Manual](./references/reference_manual.md)