---
name: bioconductor-bsgenome.hsapiens.ucsc.hg18.masked
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg18.masked.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hg18.masked

name: bioconductor-bsgenome.hsapiens.ucsc.hg18.masked
description: Access and analyze the full masked genome sequences for Homo sapiens (UCSC version hg18). Use this skill when you need to retrieve human genomic sequences from the hg18 assembly with specific masks applied, including assembly gaps (AGAPS), intra-contig ambiguities (AMB), RepeatMasker (RM), and Tandem Repeats Finder (TRF).

# bioconductor-bsgenome.hsapiens.ucsc.hg18.masked

## Overview

The `BSgenome.Hsapiens.UCSC.hg18.masked` package provides an infrastructure for accessing the human genome (hg18/Build 36.1) with four layers of masks. Unlike the standard `BSgenome.Hsapiens.UCSC.hg18` package, this version allows users to hide specific genomic regions (like repeats or gaps) during analysis. By default, only the assembly gaps (AGAPS) and intra-contig ambiguities (AMB) masks are active.

## Loading and Inspection

To use the package, load it into your R session:

```r
library(BSgenome.Hsapiens.UCSC.hg18.masked)
genome <- BSgenome.Hsapiens.UCSC.hg18.masked

# List available chromosomes/sequences
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
```

## Working with Masked Sequences

Accessing a chromosome returns a `MaskedDNAString` object rather than a standard `DNAString`.

```r
# Access chromosome 1
chr1 <- genome$chr1

# View active masks
masknames(chr1)

# Check mask statistics
alphabetFrequency(chr1)
```

## Managing Masks

You can toggle masks to include or exclude specific genomic features (RM for RepeatMasker, TRF for Tandem Repeats Finder).

```r
# Activate all masks
active(masks(chr1)) <- TRUE

# Deactivate specific masks (e.g., RepeatMasker)
active(masks(chr1))["RM"] <- FALSE

# Remove all masks to get the raw sequence (equivalent to hg18 non-masked package)
raw_seq <- unmasked(chr1)
```

## Common Workflows

### Analyzing Non-Masked Regions
To perform operations only on the visible (unmasked) parts of the genome:

```r
# Calculate GC content of non-masked regions
letterFrequency(chr1, letters="GC")
```

### Iterating Over the Genome
When processing the whole genome, it is efficient to use `seqnames()`:

```r
for (sname in seqnames(genome)) {
  seq <- genome[[sname]]
  # Perform analysis on 'seq'
}
```

## Tips
- **Memory Management**: Accessing sequences via `genome$chr1` or `genome[["chr1"]]` loads them into memory. If you process many chromosomes, R's internal cache will manage them, but you can use `options(verbose=TRUE)` to monitor cache hits/misses.
- **Mask Types**: 
  - `AGAPS`: Assembly gaps (usually Ns).
  - `AMB`: Intra-contig ambiguities.
  - `RM`: Repeats identified by RepeatMasker.
  - `TRF`: Repeats identified by Tandem Repeats Finder.

## Reference documentation

- [BSgenome.Hsapiens.UCSC.hg18.masked](./references/reference_manual.md)