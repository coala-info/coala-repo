---
name: bioconductor-bsgenome.drerio.ucsc.danrer6.masked
description: This package provides masked genome sequences for the Danio rerio (Zebrafish) danRer6 assembly within the Bioconductor BSgenome framework. Use when user asks to access Zebrafish genomic sequences, manage assembly gaps, or analyze repeat-masked regions using the RM and TRF masks.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer6.masked.html
---


# bioconductor-bsgenome.drerio.ucsc.danrer6.masked

name: bioconductor-bsgenome.drerio.ucsc.danrer6.masked
description: Provides access to the full masked genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer6 assembly (Dec. 2008). Use this skill when you need to perform genomic analysis on Zebrafish that requires masked sequences, such as repeat-masking or handling assembly gaps, using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.drerio.ucsc.danrer6.masked

## Overview

This package contains the full genome sequences for *Danio rerio* (Zebrafish) as provided by UCSC (assembly danRer6). It extends the standard `BSgenome.Drerio.UCSC.danRer6` package by adding four specific masks to every sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Drerio.UCSC.danRer6.masked)
genome <- BSgenome.Drerio.UCSC.danRer6.masked
```

### Inspecting Sequences
```r
# List all chromosome/sequence names
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

### Managing Masks
MaskedDNAString objects allow you to toggle masks to control which parts of the sequence are "visible" to analysis functions.

```r
# View active masks on a sequence
active(masks(genome$chr1))

# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(genome$chr1))["RM"] <- TRUE
active(masks(genome$chr1))["TRF"] <- TRUE

# Remove all masks to get the raw DNAString
raw_seq <- unmasked(genome$chr1)
```

## Common Workflows

### Analyzing Non-Masked Regions
Many Biostrings functions respect active masks. For example, calculating letter frequencies will only count letters in the unmasked (visible) regions.

```r
# Calculate GC content only in non-masked regions of chr1
alphabetFrequency(genome$chr1, as.prob = TRUE)
```

### Identifying Gap Locations
You can use the masks to find the coordinates of assembly gaps.

```r
chr1_seq <- genome$chr1
gap_mask <- masks(chr1_seq)[["AGAPS"]]
# gap_mask is a NormalIRanges object representing the masked regions
```

## Tips
- **Memory Management**: BSgenome objects use a caching mechanism. If you iterate through all chromosomes, R might consume significant memory. Use `options(verbose=TRUE)` to see when sequences are being cached or removed.
- **Masked vs. Unmasked**: If your analysis does not require masking (e.g., simple mapping where you want to allow hits in repeats), use the unmasked version `BSgenome.Drerio.UCSC.danRer6` or call `unmasked()` on the sequences from this package.
- **Default State**: Remember that RM and TRF masks are present but **inactive** by default. You must manually set them to `TRUE` in the `active()` vector to use them.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer6.masked](./references/reference_manual.md)