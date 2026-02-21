---
name: bioconductor-bcrank
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BCRANK.html
---

# bioconductor-bcrank

name: bioconductor-bcrank
description: Predicts binding site consensus from ranked DNA sequences (e.g., ChIP-chip or ChIP-seq data). Use this skill when you need to perform de novo motif discovery or score known consensus sequences in a ranked list of genomic regions where the top sequences are most likely to contain binding sites.

## Overview

The `BCRANK` package implements a heuristic search algorithm to identify short DNA sequences (motifs) overrepresented in the top-ranked portion of a genomic sequence list. It uses IUPAC nucleotide symbols and can automatically extend or shorten motifs during the search. The scoring function is based on a t-statistic comparing the distribution of consensus occurrences in the ranked list against random reorderings.

## Core Workflow

### 1. Input Data Requirements
- **Format**: A FASTA file containing DNA sequences.
- **Ordering**: Sequences must be pre-ranked (e.g., by fold-enrichment or p-value), with the most significant sequences at the top.
- **Nucleotides**: Supports all IUPAC symbols; however, only A, C, G, and T are used for the core search logic.

### 2. Running the Search
The primary function is `bcrank()`. It performs a breadth-first search starting from random or specified consensus sequences.

```R
library(BCRANK)

# Path to ranked FASTA file
fastaFile <- "path/to/your_ranked_sequences.fa"

# Run de novo search
# restarts: number of random starting points
# use.P1: penalty for non-specific bases (IUPAC vs ACGT)
# use.P2: penalty for repetitive motifs
set.seed(42) # For reproducibility
BCRANKout <- bcrank(fastaFile, restarts = 25, use.P1 = TRUE, use.P2 = TRUE)
```

### 3. Inspecting Results
The output is a `BCRANKresult` object. Use `toptable()` to view the predicted motifs.

```R
# View top predicted motifs
BCRANKout

# Extract a specific motif (e.g., the top one)
topMotif <- toptable(BCRANKout, 1)

# View the search path and PWM for the top motif
topMotif
searchPath(topMotif)
pwm(topMotif, normalize = TRUE)
```

### 4. Visualization and Downstream Analysis
- **Sequence Logos**: Use the `seqLogo` package with the normalized PWM.
- **Search Path**: Plot the `BCRANKsearch` object to see how the score improved.
- **Site Localization**: Find specific genomic coordinates of the consensus.

```R
# Plot search path
plot(topMotif)

# Get individual matching sites in the FASTA file
topConsensus <- as.character(toptable(BCRANKout)[1, "Consensus"])
sites <- matchingSites(fastaFile, topConsensus)
head(sites)
```

## Key Parameters and Tips

- **reorderings**: Increasing this parameter (default is often sufficient) reduces the variability of the score by using more random permutations.
- **do.search**: Set to `FALSE` if you only want to score specific `startguesses` without performing the heuristic search.
- **Motif Length**: Use the `length` parameter to set the initial length of random start guesses (default is 10).
- **Palindromes**: When using `matchingSites()`, set `revComp = FALSE` for palindromic motifs to avoid duplicate entries from the sense and anti-sense strands.
- **Memory/Time**: For very large datasets, consider using a subset of the top-ranked regions (e.g., top 5000) to speed up the search while maintaining sensitivity.

## Reference documentation

- [BCRANK](./references/BCRANK.md)