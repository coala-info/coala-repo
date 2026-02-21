---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro2.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro2.masked.html
---

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro2.masked

name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro2.masked
description: Access and analyze the masked genome sequences for Pan troglodytes (Chimp) based on the UCSC panTro2 assembly (March 2006). Use this skill when you need to perform genomic analysis on the chimpanzee genome that requires masking of assembly gaps, ambiguities, or repeats (RepeatMasker and Tandem Repeats Finder).

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro2.masked

## Overview

This package provides a `BSgenome` object containing the full genome sequences for *Pan troglodytes* (UCSC version panTro2). Unlike the standard `BSgenome.Ptroglodytes.UCSC.panTro2` package, this version includes four built-in masks for each chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading the Genome

To use the package, load it into your R session:

```r
library(BSgenome.Ptroglodytes.UCSC.panTro2.masked)
genome <- BSgenome.Ptroglodytes.UCSC.panTro2.masked
```

## Basic Operations

### Inspecting the Genome
Check sequence names and lengths:
```r
seqnames(genome)
seqlengths(genome)
```

### Accessing Chromosomes
Accessing a chromosome returns a `MaskedDNAString` object:
```r
chr1 <- genome$chr1
# or
chr1 <- genome[["chr1"]]
```

### Managing Masks
You can check which masks are available and which are active:
```r
masknames(chr1)
active(masks(chr1))
```

To activate or deactivate specific masks (e.g., activating RepeatMasker):
```r
active(masks(chr1))["RM"] <- TRUE
```

To remove all masks and get the raw sequence:
```r
raw_seq <- unmasked(chr1)
```

## Typical Workflows

### Analyzing Non-Masked Regions
To perform operations only on the "visible" (unmasked) parts of the genome:
```r
# Calculate GC content of unmasked regions only
alphabetFrequency(chr1, as.prob = TRUE)
```

### Motif Searching
When searching for motifs, the search will respect the active masks (skipping masked regions):
```r
library(Biostrings)
matchPattern("TATA", chr1)
```

### Verifying Assembly Gaps
A common task is verifying that assembly gaps (AGAPS) only contain "N" characters:
```r
# Activate only the AGAPS mask
active(masks(chr1)) <- FALSE
active(masks(chr1))["AGAPS"] <- TRUE

# Get the gaps as a DNAStringSet
gaps_only <- gaps(masks(chr1)["AGAPS"])
# Further analysis can be performed on these specific ranges
```

## Tips
*   **Memory Management**: `BSgenome` objects use lazy loading. Sequences are loaded into memory only when accessed.
*   **Mask Persistence**: Changes to mask activity are local to the object in your session.
*   **Comparison**: If you need the sequence without any masking overhead for high-performance computing where masks aren't needed, use the unmasked version `BSgenome.Ptroglodytes.UCSC.panTro2`.

## Reference documentation

- [BSgenome.Ptroglodytes.UCSC.panTro2.masked](./references/reference_manual.md)