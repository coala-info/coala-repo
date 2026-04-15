---
name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam3.masked
description: This package provides the full masked genome sequences for the Canis lupus familiaris (dog) based on the UCSC canFam3 assembly. Use when user asks to access dog genome sequences, perform genomic analysis with masked assembly gaps or repeats, or manage specific masks like RepeatMasker and Tandem Repeats Finder.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cfamiliaris.UCSC.canFam3.masked.html
---

# bioconductor-bsgenome.cfamiliaris.ucsc.canfam3.masked

name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam3.masked
description: Provides access to the full masked genome sequences for Canis lupus familiaris (Dog) based on the UCSC canFam3 assembly (Sep. 2011). Use this skill when you need to perform genomic analysis on the dog genome that requires masking of assembly gaps, ambiguities, or repeats (RepeatMasker and Tandem Repeats Finder).

## Overview

The `BSgenome.Cfamiliaris.UCSC.canFam3.masked` package is a Bioconductor data package containing the genome of the domestic dog (*Canis lupus familiaris*). It differs from the standard `BSgenome.Cfamiliaris.UCSC.canFam3` package by including four specific masks for every chromosome:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the package, load it into your R session:

```r
library(BSgenome.Cfamiliaris.UCSC.canFam3.masked)
genome <- BSgenome.Cfamiliaris.UCSC.canFam3.masked
```

### Inspecting the Genome
```r
# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Because this is a masked genome package, sequences are returned as `MaskedDNAString` objects.

### Managing Active Masks
You can check which masks are available and toggle them to control which regions are "visible" to analysis functions (like `matchPattern`).

```r
# Check available masks on a chromosome
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))

# Activate or deactivate specific masks
active(masks(chr1))["RM"] <- TRUE   # Activate RepeatMasker
active(masks(chr1))["AGAPS"] <- FALSE # Deactivate Assembly Gaps
```

### Extracting Unmasked Sequences
If you need the raw sequence without any masks (identical to the non-masked BSgenome package):

```r
# Get the unmasked DNAString
raw_seq <- unmasked(genome$chr1)
```

## Common Workflows

### Genome-wide Motif Searching
When searching for motifs, active masks prevent the search from returning hits in masked regions (e.g., gaps or repeats).

```r
library(Biostrings)
pattern <- "TTAGGG" # Example telomeric repeat
# This will only search in non-masked regions of chr1
matches <- matchPattern(pattern, genome$chr1)
```

### Analyzing Masked Regions
You can extract the coordinates of the masked regions (e.g., where the gaps are):

```r
# Get the ranges of the AGAPS mask
gap_ranges <- masks(genome$chr1)[["AGAPS"]]
```

## Tips
- **Memory Management**: BSgenome objects use lazy loading. Accessing a chromosome (e.g., `genome$chr1`) loads it into memory. If you are iterating through all chromosomes, the cache might fill up.
- **Default State**: Remember that RM (RepeatMasker) and TRF (Tandem Repeats Finder) are **inactive** by default. You must manually activate them if your analysis requires repeat masking.
- **Compatibility**: Most Bioconductor functions that accept `DNAString` objects also accept `MaskedDNAString` objects, respecting the active masks.

## Reference documentation
- [BSgenome.Cfamiliaris.UCSC.canFam3.masked](./references/reference_manual.md)