---
name: bioconductor-pwalign
description: This tool performs pairwise sequence alignment and computes edit distances for DNA, RNA, or protein sequences using the Bioconductor R package pwalign. Use when user asks to perform global, local, or overlap alignments, calculate Levenshtein distances, or conduct adapter trimming and quality-based sequence analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/pwalign.html
---


# bioconductor-pwalign

name: bioconductor-pwalign
description: Perform pairwise sequence alignment (global, local, overlap) and compute edit distances using the Bioconductor R package pwalign. Use this skill when you need to align DNA, RNA, or protein sequences, calculate Levenshtein distances, or perform adapter trimming and quality assurance on sequencing reads.

# bioconductor-pwalign

## Overview

The `pwalign` package is the primary Bioconductor tool for pairwise sequence alignment. It provides a robust implementation of the Needleman-Wunsch (global), Smith-Waterman (local), and ends-free (overlap) alignment algorithms. It is designed to work seamlessly with `Biostrings` objects like `DNAStringSet` and `AAStringSet`.

## Core Functions

### pairwiseAlignment()
The central function for performing alignments.
- **pattern**: One or more sequences to align.
- **subject**: A single sequence to align against.
- **type**: "global", "local", "overlap", "global-local", or "local-global".
- **substitutionMatrix**: A scoring matrix (e.g., `BLOSUM62`, `PAM250`, or created via `nucleotideSubstitutionMatrix()`).
- **gapOpening / gapExtension**: Penalties for gaps (default is affine).
- **scoreOnly**: Set to `TRUE` to return only numeric scores for speed.

### stringDist()
Computes a Levenshtein edit distance matrix or pairwise alignment score matrix for a set of strings.

## Common Workflows

### 1. Basic Global Alignment
```R
library(pwalign)
pattern <- "succeed"
subject <- "supersede"
align <- pairwiseAlignment(pattern, subject, type = "global")
```

### 2. Protein Alignment with BLOSUM
```R
data(BLOSUM62)
p1 <- AAString("PAWHEAE")
s1 <- AAString("HEAGAWGHEE")
align <- pairwiseAlignment(p1, s1, substitutionMatrix = BLOSUM62, gapOpening = 12, gapExtension = 4)
```

### 3. Adapter Trimming (Overlap Alignment)
To find and remove adapters from the ends of reads:
```R
# Use 'overlap' type to find matches at the ends
align <- pairwiseAlignment(reads, adapter, type = "overlap")
# Filter by score and use narrow() to trim based on alignment start/end
```

### 4. Quality-Based Alignment
If Phred or Solexa quality scores are available:
```R
align <- pairwiseAlignment(pattern, subject, 
                           patternQuality = SolexaQuality(quals), 
                           type = "global-local")
```

## Helper Functions for Results

Use these functions on a `PairwiseAlignments` object instead of direct slot access:
- `score(x)`: Returns the alignment scores.
- `nmatch(x)` / `nmismatch(x)`: Number of matches/mismatches.
- `nedit(x)`: Levenshtein edit distance.
- `aligned(x)`: Returns the gapped sequences.
- `mismatchTable(x)`: Detailed table of mismatch positions.
- `consensusMatrix(x)`: Frequency of letters at each alignment position.
- `pid(x)`: Percent sequence identity.

## Tips
- **Performance**: If you only need to know which sequence matches best, use `scoreOnly = TRUE` to reduce computation time by ~50%.
- **Memory**: For large sets of patterns against a single subject, `pwalign` is efficient, but computation time is proportional to the product of the string lengths.
- **Subject vs Pattern**: `pairwiseAlignment` is optimized for many patterns against one subject. If you have many-to-many, consider vectorizing or looping carefully.

## Reference documentation
- [Pairwise Sequence Alignments](./references/PairwiseAlignments.md)