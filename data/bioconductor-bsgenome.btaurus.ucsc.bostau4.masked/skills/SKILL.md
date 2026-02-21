---
name: bioconductor-bsgenome.btaurus.ucsc.bostau4.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau4.masked.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau4.masked

name: bioconductor-bsgenome.btaurus.ucsc.bostau4.masked
description: Provides the full masked genome sequences for Bos taurus (Cow) based on the UCSC bosTau4 assembly (Oct. 2007). Use this skill when you need to perform genomic analysis on the cow genome that requires masked sequences (assembly gaps, ambiguities, RepeatMasker, and Tandem Repeats Finder).

# bioconductor-bsgenome.btaurus.ucsc.bostau4.masked

## Overview

This package contains the full genome sequences for *Bos taurus* (UCSC version bosTau4) stored as `BSgenome` objects. Unlike the standard `BSgenome.Btaurus.UCSC.bosTau4` package, this version includes four specific masks for each sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in R:

```r
library(BSgenome.Btaurus.UCSC.bosTau4.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Btaurus.UCSC.bosTau4.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Since the sequences are `MaskedDNAString` objects, you can manage which masks are active to control what parts of the sequence are "visible" to downstream analysis functions (like `matchPattern`).

### Inspecting Masks
```r
# View active masks on a chromosome
active(masks(genome$chr1))

# List all available mask names
masknames(genome)
```

### Activating/Deactivating Masks
```r
# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(genome$chr1))["RM"] <- TRUE
active(masks(genome$chr1))["TRF"] <- TRUE

# Deactivate all masks
active(masks(genome$chr1)) <- FALSE
```

### Extracting Unmasked Sequences
If you need the raw sequence without any masks (identical to the non-masked BSgenome package):
```r
raw_seq <- unmasked(genome$chr1)
```

## Common Workflows

### Genome-wide Motif Searching
When searching for motifs, active masks prevent matches in repetitive or gap regions:

```r
library(Biostrings)

# Define a motif
motif <- "TTAGGG" 

# Search on a masked chromosome (will skip masked regions)
matches <- matchPattern(motif, genome$chr1)
```

### Checking Assembly Gaps
To verify that assembly gaps (AGAPS) only contain "N" characters:

```r
# Invert the AGAPS mask to focus only on the gaps
seq <- genome$chr1
masks(seq) <- gaps(masks(seq)["AGAPS"])

# Check unique letters in the gap regions
uniqueLetters(seq) 
```

## Tips
- Use `genome[[seqname]]` for programmatic access to chromosomes in a loop.
- Remember that `RM` and `TRF` masks are **inactive** by default; you must manually set them to `TRUE` if your analysis requires repeat masking.
- For high-performance computing, use `options(verbose=TRUE)` to monitor sequence caching during large loops.

## Reference documentation
- [BSgenome.Btaurus.UCSC.bosTau4.masked](./references/reference_manual.md)