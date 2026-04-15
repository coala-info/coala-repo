---
name: bioconductor-bsgenome.mmusculus.ucsc.mm10.masked
description: This package provides the Mus musculus (mm10) genome sequence with built-in masks for assembly gaps and ambiguous regions. Use when user asks to load the masked mouse genome, perform motif searching in non-gap regions, or access chromosome sequences for the mm10 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm10.masked.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm10.masked

## Overview

This package provides a `BSgenome` object containing the DNA sequences for the Mus musculus (mm10) genome. Unlike the standard `BSgenome.Mmusculus.UCSC.mm10` package, this version includes built-in masks. These masks prevent specific regions—specifically assembly gaps (represented as Ns) and intra-contig ambiguities—from being processed during certain operations like motif searching or sequence alignment, ensuring more accurate genomic analysis.

## Core Usage

### Loading the Genome
To use the masked genome, load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Mmusculus.UCSC.mm10.masked)
genome <- BSgenome.Mmusculus.UCSC.mm10.masked
```

### Inspecting Sequences
The genome object contains `MaskedDNAString` objects for each chromosome.

```r
# View available sequences and their lengths
seqinfo(genome)
head(seqlengths(genome))

# Access a specific chromosome (returns a MaskedDNAString)
chr1_masked <- genome$chr1
```

### Managing Masks
By default, operations on a `MaskedDNAString` respect the active masks. You can inspect, toggle, or bypass these masks.

```r
# List active masks on a sequence
masknames(chr1_masked)

# To treat the sequence as unmasked (identical to the non-masked BSgenome package)
chr1_unmasked <- unmasked(chr1_masked)

# Check the number of masked bases
sum(width(masks(chr1_masked)))
```

## Common Workflows

### Genome-Wide Motif Searching
When searching for motifs, the masks ensure that hits are not reported in assembly gaps or ambiguous regions.

```r
library(Biostrings)
pattern <- "TATAWAW" # Example motif

# Search on a specific masked chromosome
match_hits <- matchPattern(pattern, genome$chr1)

# The resulting hits will automatically exclude masked regions
```

### Validating Assembly Gaps
If you need to verify that the "AGAPS" mask correctly identifies regions containing only "N" characters:

```r
seq <- genome$chr1
# Invert the AGAPS mask to focus only on the gaps
masks(seq) <- gaps(masks(seq)["AGAPS"])
# Check unique letters in the masked regions
unique_letters <- uniqueLetters(seq)
# Should return "N"
```

## Tips
- **Memory Management**: BSgenome objects use "on-disk" caching. If you iterate through all chromosomes, R may consume significant memory. Use `options(verbose=TRUE)` to monitor when sequences are being loaded or removed from the cache.
- **Mask Compatibility**: Many Bioconductor functions (like those in `Biostrings`) are "mask-aware." If a function does not support `MaskedDNAString`, use `unmasked()` to convert it to a standard `DNAString`.
- **Coordinate System**: This package uses the UCSC coordinate system (e.g., "chr1", "chrM"). Ensure your annotation data (GRanges) matches this naming convention.

## Reference documentation
- [BSgenome.Mmusculus.UCSC.mm10.masked Reference Manual](./references/reference_manual.md)