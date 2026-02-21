---
name: bioconductor-bsgenome.btaurus.ucsc.bostau6.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau6.masked.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau6.masked

name: bioconductor-bsgenome.btaurus.ucsc.bostau6.masked
description: Genomic sequences for Bos taurus (Cow) from UCSC (build bosTau6, Nov. 2009) with four built-in masks (AGAPS, AMB, RM, and TRF). Use this skill when performing genomic analysis on the cow genome that requires masked sequences, such as motif searching, sequence extraction, or gap analysis.

# bioconductor-bsgenome.btaurus.ucsc.bostau6.masked

## Overview

This package provides the full genome sequences for *Bos taurus* (UCSC version bosTau6) stored as `BSgenome` objects. Unlike the standard `BSgenome.Btaurus.UCSC.bosTau6` package, this version includes four specific masks for every sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in R:

```r
library(BSgenome.Btaurus.UCSC.bosTau6.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Btaurus.UCSC.bosTau6.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Because this package returns `MaskedDNAString` objects, you can manipulate which masks are active.

### Viewing Active Masks
```r
# Check which masks are present
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))
```

### Activating/Deactivating Masks
```r
# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Deactivate all masks
active(masks(chr1)) <- FALSE
```

### Extracting Unmasked Sequences
If you need the raw sequence without any masks (identical to the non-masked BSgenome package):
```r
raw_seq <- unmasked(genome$chr1)
```

## Common Workflows

### Motif Searching
When searching for motifs, active masks prevent the search from returning hits in repetitive or gap regions.
```r
library(Biostrings)
# Search for a specific pattern in masked chr1
matchPattern("TATAWAW", genome$chr1)
```

### Analyzing Assembly Gaps
You can use the AGAPS mask to identify or verify gap regions:
```r
# Invert the AGAPS mask to focus only on the gaps
seq <- genome$chr1
masks(seq) <- gaps(masks(seq)["AGAPS"])

# Check unique letters in the gap regions (should be 'N')
uniqueLetters(seq)
```

## Tips
- **Memory Management**: Loading many masked chromosomes can be memory-intensive. Use `genome[[seqname]]` to load sequences dynamically.
- **Mask Persistence**: Changes to mask activity on a retrieved object (e.g., `chr1`) do not persist in the global `genome` object; you must re-apply settings if you re-load the sequence.
- **Coordinate System**: UCSC bosTau6 uses 1-based indexing in R/Bioconductor.

## Reference documentation
- [BSgenome.Btaurus.UCSC.bosTau6.masked](./references/reference_manual.md)