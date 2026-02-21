---
name: bioconductor-bsgenome.btaurus.ucsc.bostau9.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau9.masked.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau9.masked

name: bioconductor-bsgenome.btaurus.ucsc.bostau9.masked
description: Provides the full masked genome sequences for Bos taurus (Cow) based on the UCSC bosTau9 assembly. Use this skill when you need to perform genomic analysis on the cow genome that requires masking of assembly gaps, ambiguous bases, or repeats (RepeatMasker and Tandem Repeats Finder).

# bioconductor-bsgenome.btaurus.ucsc.bostau9.masked

## Overview

This package provides a `BSgenome` object containing the genome sequences for *Bos taurus* (UCSC version bosTau9). Unlike the standard `BSgenome.Btaurus.UCSC.bosTau9` package, this version includes four built-in masks for each chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Btaurus.UCSC.bosTau9.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Btaurus.UCSC.bosTau9.masked

# Check available sequences and lengths
seqnames(genome)
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Because the sequences are `MaskedDNAString` objects, functions from the `Biostrings` and `BSgenome` packages behave differently depending on which masks are active.

### Managing Active Masks
```r
# View available masks
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))

# Activate or deactivate specific masks
active(masks(chr1))["RM"] <- TRUE   # Activate RepeatMasker
active(masks(chr1))["AGAPS"] <- FALSE # Deactivate Assembly Gaps
```

### Accessing Sequence Data
```r
# Get the masked sequence (masked regions are hidden from many operations)
chr1

# Get the underlying sequence without any masks
unmasked_seq <- unmasked(chr1)

# Calculate GC content on non-masked regions
alphabetFrequency(chr1, as.prob = TRUE)
```

## Common Workflows

### Genome-wide Motif Searching
When searching for motifs, active masks prevent matches in repetitive or gap regions, reducing false positives.

```r
library(Biostrings)
# Find a specific DNA pattern in chr1, respecting active masks
matchPattern("TTAGGG", genome$chr1)
```

### Iterating Over Chromosomes
To perform an analysis across the entire masked genome:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on 'seq'
  # e.g., count non-masked bases
  total_visible <- sum(width(as(seq, "NormalIRangesList")))
}
```

## Tips
- **Memory Management**: Loading many chromosomes simultaneously can be memory-intensive. Use `genome[[sname]]` inside loops to load one at a time.
- **Mask Persistence**: Changes to `active(masks(seq))` are local to that R object. If you need the RM/TRF masks active for the whole analysis, ensure you set them after loading the sequence.
- **Comparison**: If you need the unmasked version for comparison, you can use `unmasked(genome$chr1)` or install the `BSgenome.Btaurus.UCSC.bosTau9` package.

## Reference documentation
- [BSgenome.Btaurus.UCSC.bosTau9.masked Reference Manual](./references/reference_manual.md)