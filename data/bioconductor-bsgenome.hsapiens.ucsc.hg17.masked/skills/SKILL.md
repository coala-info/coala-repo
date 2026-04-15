---
name: bioconductor-bsgenome.hsapiens.ucsc.hg17.masked
description: This package provides masked genomic sequences for the Homo sapiens hg17 assembly including assembly gaps, ambiguities, and repeat regions. Use when user asks to access masked human genome data, analyze non-masked genomic regions, or manage sequence masks for the hg17 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg17.masked.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg17.masked

name: bioconductor-bsgenome.hsapiens.ucsc.hg17.masked
description: Full masked genome sequences for Homo sapiens (Human) based on UCSC build hg17 (May 2004). Use this skill when you need to access human genomic sequences with built-in masks for assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker (RM), and Tandem Repeats Finder (TRF). This is specifically for the hg17/NCBI35 assembly.

# bioconductor-bsgenome.hsapiens.ucsc.hg17.masked

## Overview

This package provides a `BSgenome` data object containing the masked genomic sequence of Homo sapiens (UCSC hg17). Unlike the standard `BSgenome.Hsapiens.UCSC.hg17` package, this version includes four layers of masks to hide specific regions of the genome. By default, only the assembly gaps (AGAPS) and intra-contig ambiguities (AMB) masks are active.

## Key Features

- **Four Mask Layers**: 
  1. `AGAPS`: Assembly gaps.
  2. `AMB`: Intra-contig ambiguities.
  3. `RM`: Repeats from RepeatMasker.
  4. `TRF`: Repeats from Tandem Repeats Finder.
- **Default State**: AGAPS and AMB are active; RM and TRF are present but inactive by default.
- **Data Type**: Chromosome sequences are returned as `MaskedDNAString` objects.

## Basic Usage

### Loading the Genome
```r
library(BSgenome.Hsapiens.UCSC.hg17.masked)
genome <- BSgenome.Hsapiens.UCSC.hg17.masked
```

### Inspecting Sequences
```r
# List available sequences (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (returns a MaskedDNAString)
chr1_masked <- genome$chr1
```

### Managing Masks
```r
# Check which masks are available
masknames(chr1_masked)

# Activate or deactivate masks
active(masks(chr1_masked))["RM"] <- TRUE  # Activate RepeatMasker
active(masks(chr1_masked))["AGAPS"] <- FALSE # Deactivate Assembly Gaps

# Remove all masks to get a standard DNAString
chr1_unmasked <- unmasked(chr1_masked)
```

## Common Workflows

### Analyzing Non-Masked Regions
When masks are active, functions like `alphabetFrequency` or `matchPattern` will only consider the unmasked (visible) parts of the sequence.

```r
# Calculate GC content of non-masked regions only
alphabetFrequency(genome$chr1, as.prob = TRUE)
```

### Iterating Over Chromosomes
To perform a genome-wide check (e.g., verifying that gaps only contain "N"s):

```r
for (seqname in seqnames(genome)) {
  seq <- genome[[seqname]]
  # Set only AGAPS as active
  active(masks(seq)) <- FALSE
  active(masks(seq))["AGAPS"] <- TRUE
  
  # The 'gaps' function on masks returns the masked regions
  # You can then inspect the underlying letters in those gaps
}
```

## Implementation Tips
- **Memory Management**: Accessing `genome$chr1` loads the sequence into memory. If processing many chromosomes, use `genome[[seqname]]` within a loop to allow the cache to manage memory.
- **Compatibility**: This package is intended for legacy studies using the hg17 assembly. For modern human genome analysis, use hg19 (GRCh37) or hg38 (GRCh38) versions of BSgenome.
- **MaskedDNAString**: Remember that many `Biostrings` functions behave differently on `MaskedDNAString` objects compared to standard `DNAString` objects (they respect the `active` status of masks).

## Reference documentation

- [BSgenome.Hsapiens.UCSC.hg17.masked Reference Manual](./references/reference_manual.md)