---
name: bioconductor-bsgenome.drerio.ucsc.danrer5.masked
description: This package provides masked genome sequences for Danio rerio based on the UCSC danRer5 assembly. Use when user asks to access zebrafish genomic sequences, manage assembly gaps and repeat masks, or perform sequence analysis on non-repetitive regions.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer5.masked.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer5.masked

name: bioconductor-bsgenome.drerio.ucsc.danrer5.masked
description: Provides access to the full masked genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer5 assembly (Jul. 2007). Use this skill when you need to perform genomic analysis on Zebrafish that requires masked sequences, such as repeat-masking, handling assembly gaps, or searching for motifs in non-repetitive regions using Bioconductor.

# bioconductor-bsgenome.drerio.ucsc.danrer5.masked

## Overview

The `BSgenome.Drerio.UCSC.danRer5.masked` package is a genomic data package containing the full genome sequences for *Danio rerio* (Zebrafish) as provided by UCSC (assembly danRer5). This package is an extension of the standard `BSgenome.Drerio.UCSC.danRer5` package, with the addition of four specific masks:
1.  **AGAPS**: Assembly gaps (active by default).
2.  **AMB**: Intra-contig ambiguities (active by default).
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

This skill helps you load the genome, manage masks, and perform sequence analysis on the Zebrafish genome.

## Loading and Inspecting the Genome

To use the package, load it into your R session and assign the genome object to a variable for easier access.

```r
library(BSgenome.Drerio.UCSC.danRer5.masked)

# Assign to a shorter variable name
genome <- BSgenome.Drerio.UCSC.danRer5.masked

# List available sequences (chromosomes)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

When you access a chromosome, it returns a `MaskedDNAString` object.

```r
# Access a specific chromosome (e.g., chr1)
chr1_masked <- genome$chr1

# View active masks
masknames(chr1_masked)

# To see the underlying sequence without any masks
chr1_unmasked <- unmasked(chr1_masked)
```

## Managing Masks

By default, only AGAPS and AMB masks are active. You can toggle masks to include or exclude repetitive elements (RM and TRF).

```r
# Activate all masks for a specific sequence
active(masks(chr1_masked)) <- TRUE

# Deactivate specific masks (e.g., RepeatMasker)
active(masks(chr1_masked))["RM"] <- FALSE

# Check the number of masked vs unmasked bases
alphabetFrequency(chr1_masked)
```

## Common Workflows

### Iterating Over Chromosomes
A common task is to perform an operation across the entire genome while respecting the masks.

```r
for (seqname in seqnames(genome)) {
  seq <- genome[[seqname]]
  # Perform analysis on 'seq', which respects active masks
  # Example: calculate GC content of non-masked regions
  gc <- letterFrequency(seq, "GC", as.prob = TRUE)
  cat(seqname, "GC content:", gc, "\n")
}
```

### Motif Searching
Use the `matchPattern` function from the `Biostrings` package to find motifs. Masked regions are automatically skipped by the search functions.

```r
library(Biostrings)
pattern <- "TATAWAW"
# Search on chr1 with active masks
matches <- matchPattern(pattern, genome$chr1)
```

## Tips
- **Memory Management**: BSgenome objects use lazy loading. Sequences are loaded into memory only when accessed. If you iterate through many chromosomes, R might cache them; use `options(verbose=TRUE)` to monitor cache eviction.
- **Mask Persistence**: Changes to mask activity (using `active()`) are applied to the specific instance of the sequence object you have extracted, not the global `genome` object.
- **Unmasked Comparison**: If you need the sequence without any masks for a specific calculation, use `unmasked(genome$chr1)` or the non-masked package `BSgenome.Drerio.UCSC.danRer5`.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer5.masked](./references/reference_manual.md)