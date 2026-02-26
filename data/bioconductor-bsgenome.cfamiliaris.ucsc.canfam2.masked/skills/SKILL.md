---
name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam2.masked
description: This package provides the masked genome sequences for Canis lupus familiaris based on the UCSC canFam2 assembly. Use when user asks to load the dog genome with built-in masks for assembly gaps and repeats, perform motif searching in non-masked regions, or manage genomic masks for Canis lupus familiaris.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cfamiliaris.UCSC.canFam2.masked.html
---


# bioconductor-bsgenome.cfamiliaris.ucsc.canfam2.masked

## Overview

This package provides a `BSgenome` object containing the genome of *Canis lupus familiaris* (Dog) as provided by UCSC (version canFam2). Unlike the standard `BSgenome.Cfamiliaris.UCSC.canFam2` package, this version includes four built-in masks for every sequence:
1. **AGAPS**: Assembly gaps.
2. **AMB**: Intra-contig ambiguities.
3. **RM**: Repeats from RepeatMasker.
4. **TRF**: Repeats from Tandem Repeats Finder.

By default, only the **AGAPS** and **AMB** masks are active.

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Cfamiliaris.UCSC.canFam2.masked)
genome <- BSgenome.Cfamiliaris.UCSC.canFam2.masked
```

### Inspecting Sequences
```r
# List all sequence names (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString object)
chr1 <- genome$chr1
```

### Managing Masks
Masks allow you to "hide" specific regions of the genome during analysis (e.g., when counting k-mers or searching for motifs).

```r
# View active masks on a sequence
active(masks(chr1))

# Activate RepeatMasker (RM) and Tandem Repeats Finder (TRF) masks
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Deactivate all masks to see the raw sequence
active(masks(chr1)) <- FALSE

# Get the unmasked DNAString
raw_seq <- unmasked(chr1)
```

## Common Workflows

### Genome-Wide Motif Searching
When searching for motifs, active masks prevent matches in repetitive or gap regions.

```r
library(Biostrings)
pattern <- "TTAGGG" # Example telomeric repeat
matchPattern(pattern, genome$chr1) # Only searches unmasked regions
```

### Checking Assembly Gaps
You can verify that assembly gaps (AGAPS) consist only of "N" characters:

```r
chr_seq <- genome$chr1
# Invert the AGAPS mask to focus only on the gaps
masks(chr_seq) <- gaps(masks(chr_seq)["AGAPS"])
# Check unique letters in the gap regions
uniqueLetters(chr_seq) 
```

## Tips
- **Memory Management**: `BSgenome` objects use a cache. If you iterate through all chromosomes in a loop, use `options(verbose=TRUE)` to monitor memory/cache behavior.
- **MaskedDNAString vs DNAString**: Most `Biostrings` functions work on `MaskedDNAString` objects but will respect the `active` status of the masks. If a function requires a `DNAString`, use `unmasked()`.
- **Coordinate Systems**: All coordinates are 1-based, following standard Bioconductor conventions.

## Reference documentation
- [BSgenome.Cfamiliaris.UCSC.canFam2.masked Reference Manual](./references/reference_manual.md)