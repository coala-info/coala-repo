---
name: bioconductor-bsgenome.ggallus.ucsc.galgal3.masked
description: This package provides the full masked genome sequences for the Gallus gallus (chicken) UCSC galGal3 assembly. Use when user asks to access chicken genomic sequences, handle assembly gaps and ambiguities, or analyze non-masked regions using RepeatMasker and Tandem Repeats Finder data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal3.masked.html
---

# bioconductor-bsgenome.ggallus.ucsc.galgal3.masked

name: bioconductor-bsgenome.ggallus.ucsc.galgal3.masked
description: Genomic data package providing the full masked genome sequences for Gallus gallus (Chicken) based on the UCSC galGal3 assembly (May 2006). Use this skill when you need to access chicken genomic sequences with built-in masks for assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker (RM), and Tandem Repeats Finder (TRF).

# bioconductor-bsgenome.ggallus.ucsc.galgal3.masked

## Overview

This package provides a `BSgenome` object for the *Gallus gallus* (galGal3) genome. It is an extension of the standard `BSgenome.Ggallus.UCSC.galGal3` package, with the addition of four specific masks. By default, only the assembly gaps (AGAPS) and intra-contig ambiguities (AMB) masks are active. This package is essential for genomic analyses where repetitive elements or assembly gaps need to be excluded or specifically handled.

## Loading and Basic Usage

To use the genome in R:

```r
library(BSgenome.Ggallus.UCSC.galGal3.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Ggallus.UCSC.galGal3.masked

# List available chromosomes/sequences
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access chromosome 1
chr1 <- genome$chr1

# View active masks
active(masks(chr1))

# Toggle masks (e.g., activate RepeatMasker 'RM' and Tandem Repeats Finder 'TRF')
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Get the unmasked sequence (identical to the non-masked BSgenome package)
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Analyzing Non-Masked Regions
To perform operations only on the "visible" (non-masked) parts of the genome:

```r
# Calculate frequency of oligonucleotides in non-masked regions of chr1
alphabetFrequency(chr1)

# Find motifs while respecting masks
matchPattern("TATA", chr1)
```

### Iterating Over the Genome
When processing the whole genome, it is efficient to loop through `seqnames`:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on 'seq'
  cat("Processing", sname, "...\n")
}
```

## Tips
- **Memory Management**: Masked genomes can be memory-intensive. Access specific chromosomes using `[[` or `$` to load them into memory only when needed.
- **Mask Defaults**: Remember that RM (RepeatMasker) and TRF (Tandem Repeats Finder) masks are present but **inactive** by default. You must manually set them to `TRUE` in the `active()` vector to use them.
- **Compatibility**: This package is designed to work with the `Biostrings` and `BSgenome` infrastructure. Functions like `vmatchPattern` can be used for genome-wide searches.

## Reference documentation

- [BSgenome.Ggallus.UCSC.galGal3.masked Reference Manual](./references/reference_manual.md)