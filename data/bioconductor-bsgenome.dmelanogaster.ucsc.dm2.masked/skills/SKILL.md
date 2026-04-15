---
name: bioconductor-bsgenome.dmelanogaster.ucsc.dm2.masked
description: This package provides the full masked genome sequences for Drosophila melanogaster (UCSC version dm2) as Biostrings objects in R. Use when user asks to access masked fly genome sequences, toggle assembly gap or repeat masks, or perform motif searching in non-repetitive regions of the dm2 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Dmelanogaster.UCSC.dm2.masked.html
---

# bioconductor-bsgenome.dmelanogaster.ucsc.dm2.masked

name: bioconductor-bsgenome.dmelanogaster.ucsc.dm2.masked
description: Access and analyze the full masked genome sequences for Drosophila melanogaster (UCSC version dm2). Use this skill when you need to work with the Fly genome in R, specifically requiring masked sequences (AGAPS, AMB, RM, and TRF masks) for genomic analysis, motif searching, or sequence extraction.

# bioconductor-bsgenome.dmelanogaster.ucsc.dm2.masked

## Overview

This skill provides guidance on using the `BSgenome.Dmelanogaster.UCSC.dm2.masked` R package. This package contains the full genome sequences for *Drosophila melanogaster* (April 2004, UCSC dm2) stored as `Biostrings` objects. 

Crucially, this version includes four types of masks:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome, first load the package:

```r
library(BSgenome.Dmelanogaster.UCSC.dm2.masked)
genome <- BSgenome.Dmelanogaster.UCSC.dm2.masked
```

### Inspecting the Genome
Check sequence names and lengths:

```r
seqnames(genome)
seqlengths(genome)
```

### Accessing Specific Chromosomes
Accessing a chromosome returns a `MaskedDNAString` object:

```r
chr2L <- genome$chr2L
# Or using double brackets
chr2L <- genome[["chr2L"]]
```

## Working with Masks

### Viewing Active Masks
Check which masks are available and which are active:

```r
masknames(chr2L)
# To see which are active, look at the 'active' slot of masks(chr2L)
active(masks(chr2L))
```

### Activating/Deactivating Masks
You can toggle masks to hide or reveal specific genomic regions (e.g., repeats):

```r
# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr2L))["RM"] <- TRUE
active(masks(chr2L))["TRF"] <- TRUE

# Deactivate all masks
active(masks(chr2L)) <- FALSE
```

### Unmasking Sequences
To obtain the raw `DNAString` without any masks (identical to the non-masked BSgenome package):

```r
raw_seq <- unmasked(chr2L)
```

## Common Workflows

### Motif Searching
When searching for motifs, active masks are treated as "N"s or skipped depending on the function, preventing false positives in repetitive or gap regions.

```r
library(Biostrings)
# Search for a specific pattern in the masked sequence
matchPattern("GCMGCMA", chr2L)
```

### Extracting Sequences
Extracting a sub-sequence from a masked chromosome:

```r
sub_seq <- views(chr2L, start=1000, end=2000)
```

### Checking Assembly Gaps
A common task is verifying that assembly gaps (AGAPS) only contain "N" characters:

```r
# Invert the AGAPS mask to focus only on the gaps
masks(chr2L) <- gaps(masks(chr2L)["AGAPS"])
# Check unique letters in the gap regions
uniqueLetters(chr2L) 
```

## Tips
- **Memory Management**: BSgenome objects use a cache. If you iterate over many chromosomes, R might use significant memory.
- **Masked vs. Unmasked**: Use this package (`.masked`) when you want to avoid repeats or gaps in your analysis. Use the standard `BSgenome.Dmelanogaster.UCSC.dm2` package if you need the full sequence without mask overhead.
- **Coordinate System**: UCSC dm2 coordinates are 1-based in Bioconductor.

## Reference documentation

- [BSgenome.Dmelanogaster.UCSC.dm2.masked Reference Manual](./references/reference_manual.md)