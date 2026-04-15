---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac3.masked
description: This package provides masked genome sequences for the Macaca mulatta (Rhesus monkey) based on the UCSC rheMac3 assembly. Use when user asks to access Rhesus monkey genomic sequences, perform motif searching in non-masked regions, or manage assembly gaps and repeat masks for genomic analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac3.masked.html
---

# bioconductor-bsgenome.mmulatta.ucsc.rhemac3.masked

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac3.masked
description: Provides access to the full masked genome sequences for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac3 assembly (Oct. 2010). Use this skill when you need to perform genomic analysis on the Rhesus monkey genome that requires masked sequences (assembly gaps, intra-contig ambiguities, RepeatMasker, and Tandem Repeats Finder).

# bioconductor-bsgenome.mmulatta.ucsc.rhemac3.masked

## Overview

This package provides a `BSgenome` data object containing the masked genome for *Macaca mulatta* (UCSC rheMac3). Unlike the standard `BSgenome.Mmulatta.UCSC.rheMac3` package, this version includes four specific masks for each sequence:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Mmulatta.UCSC.rheMac3.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Mmulatta.UCSC.rheMac3.masked
```

### Exploring the Genome
```r
# List sequence names (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

### Managing Masks
Masks allow you to hide specific regions of the genome during analysis (e.g., when counting oligonucleotides or searching for motifs).

```r
# Check available masks on a sequence
masknames(chr1)

# Check which masks are currently active
active(masks(chr1))

# Activate or deactivate specific masks
active(masks(chr1))["RM"] <- TRUE   # Activate RepeatMasker mask
active(masks(chr1))["AGAPS"] <- FALSE # Deactivate Assembly Gaps mask

# Remove all masks to get a standard DNAString
unmasked_chr1 <- unmasked(chr1)
```

## Common Workflows

### Motif Searching in Non-Masked Regions
When searching for motifs, active masks ensure that matches are not reported in "masked-out" regions (like repeats or gaps).

```r
library(Biostrings)
# Find a specific pattern in chr1, respecting active masks
matches <- matchPattern("TTAGGG", genome$chr1)
```

### Iterating Over Chromosomes
To perform an operation across the entire masked genome:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on 'seq' (a MaskedDNAString)
  # Example: calculate alphabet frequency of unmasked regions
  freq <- alphabetFrequency(seq)
}
```

## Tips
*   **Memory Management**: BSgenome objects use a cache. If you iterate through many chromosomes, R might use significant memory. You can use `options(verbose=TRUE)` to monitor when sequences are being loaded or removed from the cache.
*   **Masked vs. Unmasked**: If your analysis does not require masking (e.g., you want the raw sequence including repeats), use the `unmasked()` function or the non-masked version of the package (`BSgenome.Mmulatta.UCSC.rheMac3`).
*   **Inverting Masks**: You can use `gaps(masks(seq)["AGAPS"])` to focus specifically on the regions defined by the mask (e.g., to analyze the gaps themselves).

## Reference documentation
- [BSgenome.Mmulatta.UCSC.rheMac3.masked](./references/reference_manual.md)