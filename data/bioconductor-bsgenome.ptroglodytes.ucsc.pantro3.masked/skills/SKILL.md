---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro3.masked
description: This package provides masked genome sequences for the Pan troglodytes (Chimp) UCSC panTro3 assembly. Use when user asks to access chimpanzee genomic sequences with masks for assembly gaps, ambiguities, or repeats.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro3.masked.html
---

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro3.masked

name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro3.masked
description: Provides access to the full masked genome sequences for Pan troglodytes (Chimp) based on the UCSC panTro3 assembly (Oct. 2010). Use this skill when you need to perform genomic analysis on the chimpanzee genome that requires masking of assembly gaps, ambiguities, or repeats (RepeatMasker and Tandem Repeats Finder).

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro3.masked

## Overview

This package provides a `BSgenome` object containing the masked genome sequences for *Pan troglodytes* (UCSC version panTro3). Unlike the standard `BSgenome.Ptroglodytes.UCSC.panTro3` package, this version includes four specific masks for every chromosome:
1.  **AGAPS**: Mask of assembly gaps.
2.  **AMB**: Mask of intra-contig ambiguities.
3.  **RM**: Mask of repeats from RepeatMasker.
4.  **TRF**: Mask of repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Loading and Basic Usage

To use the genome in R:

```r
library(BSgenome.Ptroglodytes.UCSC.panTro3.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Ptroglodytes.UCSC.panTro3.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1_masked <- genome$chr1
```

## Working with Masks

### Inspecting Active Masks
You can check which masks are currently active on a sequence:

```r
active_masks <- masks(genome$chr1)
print(active_masks)
```

### Activating/Deactivating Masks
The RM (RepeatMasker) and TRF (Tandem Repeats Finder) masks are present but inactive by default. To activate them:

```r
chr1 <- genome$chr1
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE
```

### Unmasking Sequences
To obtain the raw sequence without any masks (identical to the non-masked BSgenome package):

```r
raw_seq <- unmasked(genome$chr1)
```

## Common Workflows

### Analyzing Gap Content
A common task is verifying that assembly gaps (AGAPS) only contain "N" characters:

```r
chr_seq <- genome$chr1
# Invert the AGAPS mask to focus only on the gaps
masks(chr_seq) <- gaps(masks(chr_seq)["AGAPS"])
# Check unique letters in the masked regions
uniqueLetters(chr_seq) 
```

### Genome-Wide Motif Searching
When searching for motifs, using the masked genome prevents false positives in repetitive or unsequenced regions:

```r
library(Biostrings)
# Search for a specific pattern in masked chromosome 1
matchPattern("TTAGGG", genome$chr1)
```

## Tips
- Accessing `genome$chr1` returns a `MaskedDNAString`. Many `Biostrings` functions handle these objects by automatically skipping masked positions.
- If you need to perform analysis on the repeats themselves, ensure you toggle the `active` state of the "RM" or "TRF" masks.
- For high-performance loops across all chromosomes, use `seqnames(genome)` to iterate.

## Reference documentation
- [BSgenome.Ptroglodytes.UCSC.panTro3.masked](./references/reference_manual.md)