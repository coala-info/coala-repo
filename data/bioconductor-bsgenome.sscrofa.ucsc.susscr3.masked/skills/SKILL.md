---
name: bioconductor-bsgenome.sscrofa.ucsc.susscr3.masked
description: This package provides the full masked genome sequences for Sus scrofa based on the UCSC susScr3 assembly. Use when user asks to access pig genome sequences, perform genomic analysis with masked repeats or assembly gaps, or search for motifs in the Sus scrofa genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Sscrofa.UCSC.susScr3.masked.html
---


# bioconductor-bsgenome.sscrofa.ucsc.susscr3.masked

name: bioconductor-bsgenome.sscrofa.ucsc.susscr3.masked
description: Provides access to the full masked genome sequences for Sus scrofa (Pig) based on the UCSC susScr3 assembly (Aug. 2011). Use this skill when you need to perform genomic analysis on the pig genome that requires masked sequences (assembly gaps, intra-contig ambiguities, RepeatMasker, and Tandem Repeats Finder).

# bioconductor-bsgenome.sscrofa.ucsc.susscr3.masked

## Overview

The `BSgenome.Sscrofa.UCSC.susScr3.masked` package is a Bioconductor data package containing the full genome sequence for *Sus scrofa* (Pig). It extends the standard `susScr3` genome by adding four specific masks to the sequences:
1.  **AGAPS**: Assembly gaps.
2.  **AMB**: Intra-contig ambiguities.
3.  **RM**: Repeats from RepeatMasker.
4.  **TRF**: Repeats from Tandem Repeats Finder.

By default, only the AGAPS and AMB masks are active. This package is essential for bioinformatics workflows where repetitive or ambiguous regions must be excluded from analysis (e.g., read mapping, motif searching).

## Loading and Basic Usage

To use the genome, load the library and assign the provider object to a variable:

```r
library(BSgenome.Sscrofa.UCSC.susScr3.masked)
genome <- BSgenome.Sscrofa.UCSC.susScr3.masked

# View available sequences and lengths
seqnames(genome)
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access a specific chromosome
chr1 <- genome$chr1

# View active masks
masknames(chr1)

# Toggle masks (e.g., activate RepeatMasker and TRF)
active(masks(chr1))["RM"] <- TRUE
active(masks(chr1))["TRF"] <- TRUE

# Get the unmasked sequence (identical to the non-masked BSgenome package)
unmasked_seq <- unmasked(chr1)
```

## Common Workflows

### Motif Searching
When searching for motifs, the masked regions are automatically skipped by `matchPattern` if the masks are active.

```r
library(Biostrings)
# Search for a specific motif in chr1, respecting active masks
motif <- "TATAWAW"
matches <- matchPattern(motif, genome$chr1)
```

### Iterating Over the Genome
To perform operations across all chromosomes while respecting masks:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on 'seq' (a MaskedDNAString)
  # ...
}
```

## Tips
*   **Memory Management**: BSgenome objects use a cache. If you iterate through many chromosomes, R might use significant memory. Use `options(verbose=TRUE)` to monitor cache clearing.
*   **Mask Defaults**: Remember that RM (RepeatMasker) and TRF (Tandem Repeats Finder) are present but **inactive** by default. You must manually set them to `TRUE` in the `active()` vector if you wish to mask repeats.
*   **Coordinate Systems**: Masking does not change the coordinates of the sequence; it simply hides specific intervals from certain functions.

## Reference documentation

- [BSgenome.Sscrofa.UCSC.susScr3.masked Reference Manual](./references/reference_manual.md)