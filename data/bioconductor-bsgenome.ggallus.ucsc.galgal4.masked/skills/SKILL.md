---
name: bioconductor-bsgenome.ggallus.ucsc.galgal4.masked
description: This package provides a masked version of the Gallus gallus (chicken) galGal4 genome assembly for use in Bioconductor. Use when user asks to access chicken genome sequences with assembly gaps, ambiguities, or repeats masked for downstream analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal4.masked.html
---


# bioconductor-bsgenome.ggallus.ucsc.galgal4.masked

## Overview

This package provides a `BSgenome` data object for the *Gallus gallus* (chicken) genome, assembly version galGal4. Unlike the standard version, this package includes four specific masks for each sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome, load the library and assign the object to a variable for easier access:

```r
library(BSgenome.Ggallus.UCSC.galGal4.masked)
genome <- BSgenome.Ggallus.UCSC.galGal4.masked

# View available sequences and lengths
seqnames(genome)
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access chromosome 1
chr1 <- genome$chr1

# View active masks
active(masks(chr1))

# Toggle masks (e.g., activate RepeatMasker)
active(masks(chr1))["RM"] <- TRUE

# To remove all masks and get the raw sequence
raw_seq <- unmasked(chr1)
```

## Common Workflows

### Analyzing Non-Masked Regions
You can use the `gaps()` function on the masks to identify the "visible" (unmasked) parts of the genome.

```r
# Get the regions not covered by active masks
visible_regions <- gaps(masks(chr1))
```

### Genome-Wide Sequence Checking
A common task is iterating through all chromosomes to perform calculations on unmasked regions:

```r
for (seqname in seqnames(genome)) {
  seq <- genome[[seqname]]
  # Perform analysis on 'seq' which respects active masks
  # Example: calculate GC content of non-masked regions
  alphabetFrequency(seq, baseOnly=TRUE)
}
```

### Motif Searching
When searching for motifs, the search functions in `Biostrings` will skip masked regions by default.

```r
library(Biostrings)
# Search for a specific motif in chromosome 2, respecting active masks
matchPattern("TATAWAW", genome$chr2)
```

## Tips
- **Memory Management**: These objects load sequences into a cache. If you are iterating over many chromosomes, use `options(verbose=TRUE)` to monitor cache management.
- **Mask Defaults**: Remember that RM (RepeatMasker) and TRF (Tandem Repeats Finder) are present but **inactive** by default. You must manually set them to `TRUE` in the `active()` vector if you wish to exclude repeats from your analysis.
- **Comparison**: If you need the unmasked version for comparison, it is available in the `BSgenome.Ggallus.UCSC.galGal4` package.

## Reference documentation
- [BSgenome.Ggallus.UCSC.galGal4.masked Reference Manual](./references/reference_manual.md)