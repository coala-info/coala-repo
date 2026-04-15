---
name: bioconductor-motifmatchr
description: The motifmatchr package provides a fast interface for identifying motif occurrences in genomic ranges or sequences using position weight matrices. Use when user asks to find motif matches in ChIP-seq or ATAC-seq peaks, calculate motif scores and counts, or identify the exact genomic coordinates of motif hits.
homepage: https://bioconductor.org/packages/release/bioc/html/motifmatchr.html
---

# bioconductor-motifmatchr

## Overview

The `motifmatchr` package provides an interface to the MOODS C++ library for fast motif matching. It is designed to determine which genomic ranges or sequences contain specific motifs based on Position Weight Matrices (PWMs) or Position Frequency Matrices (PFMs). It is significantly faster than standard Biostrings `matchPWM` when dealing with large sets of motifs and sequences, such as analyzing ChIP-seq or ATAC-seq peaks against the JASPAR database.

## Core Workflow

### 1. Prepare Inputs
You need two primary components:
- **Motifs**: Objects of class `PWMatrix`, `PFMatrix`, `PWMatrixList`, or `PFMatrixList` (typically from the `TFBSTools` package).
- **Subjects**: Genomic ranges (`GRanges`), a `SummarizedExperiment`, or sequences (`DNAStringSet` or character vector).

### 2. Match Motifs
The primary function is `matchMotifs()`.

```r
library(motifmatchr)
library(GenomicRanges)

# Basic matching using a genome string (requires corresponding BSgenome package)
motif_ix <- matchMotifs(motifs, peaks, genome = "hg19")

# Extract the logical match matrix (TRUE/FALSE)
matches <- motifMatches(motif_ix)
```

### 3. Output Options
The `out` argument determines the detail of the returned object:
- `out = "matches"` (Default): Returns a `SummarizedExperiment` with a boolean matrix of matches.
- `out = "scores"`: Returns matches, plus matrices for the maximum log-likelihood **scores** and the **counts** of matches per range.
- `out = "positions"`: Returns a `GRangesList` containing the exact genomic coordinates of every motif hit.

```r
# Get scores and counts
motif_results <- matchMotifs(motifs, peaks, genome = "hg19", out = "scores")
scores <- motifScores(motif_results)
counts <- motifCounts(motif_results)

# Get exact positions
motif_pos <- matchMotifs(motifs, peaks, genome = "hg19", out = "positions")
```

## Advanced Configuration

### Genome Specification
If your subject is a `GRanges` object, you must provide a genome. This can be:
- A string (e.g., `"hg38"`), provided the `BSgenome.Hsapiens.UCSC.hg38` package is installed.
- A `BSgenome` object.
- A `DNAStringSet` or `FaFile` containing the genome sequences.

### Background Frequencies
Motif scores depend on background nucleotide frequencies.
- `bg = "auto"` (Default): Uses frequencies from the input sequences.
- `bg = "genome"`: Uses frequencies from the specified genome.
- `bg = "even"`: Uses 0.25 for each nucleotide.
- `bg = c(A=0.2, C=0.3, G=0.3, T=0.2)`: Custom frequencies.

### Thresholds
The default p-value cutoff is `5e-05`. You can adjust the stringency:
```r
# More stringent matching
motif_ix <- matchMotifs(motifs, peaks, genome = "hg19", p.cutoff = 1e-06)
```

## Tips for Success
- **Memory Efficiency**: For very large datasets, `motifmatchr` returns sparse matrices (from the `Matrix` package) to save memory. Use `as.matrix()` if you specifically need a dense representation, but be cautious of memory limits.
- **PFM to PWM**: If you provide PFMs, `motifmatchr` converts them to PWMs using `TFBSTools::toPWM()` with a default pseudocount of 0.8. To use custom pseudocounts, convert them manually before calling `matchMotifs`.
- **SummarizedExperiment**: If you pass a `RangedSummarizedExperiment` as the subject, the function returns a new `RangedSummarizedExperiment` with the motif matches added as an assay, preserving your original metadata.

## Reference documentation
- [motifmatchr](./references/motifmatchr.md)