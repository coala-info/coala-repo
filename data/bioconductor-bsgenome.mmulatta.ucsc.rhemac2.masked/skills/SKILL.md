---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac2.masked
description: This package provides full masked genome sequences for the Macaca mulatta (Rhesus monkey) based on the UCSC rheMac2 assembly. Use when user asks to perform genomic analysis on the Rhesus monkey genome, access masked sequences for assembly gaps or repeats, or search for motifs while excluding specific genomic regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac2.masked.html
---

# bioconductor-bsgenome.mmulatta.ucsc.rhemac2.masked

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac2.masked
description: Full masked genome sequences for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac2 assembly (Jan. 2006). Use this skill when you need to perform genomic analysis on the Rhesus monkey genome that requires masked sequences (Assembly Gaps, Ambiguities, RepeatMasker, or Tandem Repeats Finder).

# bioconductor-bsgenome.mmulatta.ucsc.rhemac2.masked

## Overview

This package provides a `BSgenome` data object containing the full genome sequence for *Macaca mulatta* (UCSC version rheMac2). Unlike the standard `BSgenome.Mmulatta.UCSC.rheMac2` package, this version includes four built-in masks for every chromosome:
1.  **AGAPS**: Assembly gaps (active by default).
2.  **AMB**: Intra-contig ambiguities (active by default).
3.  **RM**: Repeats from RepeatMasker (inactive by default).
4.  **TRF**: Repeats from Tandem Repeats Finder (inactive by default).

Note: In this specific assembly (rheMac2), the TRF mask contains *all* Tandem Repeats Finder results, not just those with a period <= 12.

## Loading and Basic Usage

To use the genome in an R session:

```r
library(BSgenome.Mmulatta.UCSC.rheMac2.masked)

# Assign to a shorter variable for convenience
genome <- BSgenome.Mmulatta.UCSC.rheMac2.masked

# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

## Working with Masks

Because the sequences are `MaskedDNAString` objects, you can manipulate which masks are active to control what parts of the sequence are "visible" to downstream Biostrings functions.

### Inspecting Masks
```r
# View active masks on a chromosome
active(masks(chr1))

# View specific mask details (e.g., Tandem Repeats Finder)
masks(chr1)$TRF
```

### Activating/Deactivating Masks
```r
# Activate the RepeatMasker (RM) mask
active(masks(chr1))["RM"] <- TRUE

# Deactivate all masks to see the raw sequence
active(masks(chr1)) <- FALSE

# Alternatively, use unmasked() to get a DNAString object
raw_seq <- unmasked(chr1)
```

## Common Workflows

### Genome-wide Motif Searching
When searching for motifs, active masks prevent the search from returning hits in masked regions (like gaps or repeats).

```r
library(Biostrings)

# Search for a specific pattern in chr1 with active masks
matchPattern("TTAGGG", chr1) 
```

### Checking Assembly Gaps
You can verify that the AGAPS mask correctly identifies regions containing only "N"s:

```r
# Invert the AGAPS mask to focus only on the gaps
gap_regions <- gaps(masks(chr1)["AGAPS"])
# Apply this inverted mask to the sequence
masks(chr1) <- gap_regions
# Check unique letters in the masked regions
uniqueLetters(chr1) # Should return "N"
```

## Tips
- **Memory Management**: BSgenome objects load sequences into memory lazily. If you iterate through all chromosomes, use `options(verbose=TRUE)` to see when sequences are being cached or removed.
- **Compatibility**: This package is designed to work with the `Biostrings` and `GenomicRanges` infrastructure. Most functions that accept `DNAString` objects will also accept `MaskedDNAString` objects, respecting the active masks.

## Reference documentation

- [BSgenome.Mmulatta.UCSC.rheMac2.masked Reference Manual](./references/reference_manual.md)