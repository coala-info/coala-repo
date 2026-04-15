---
name: bioconductor-bcseq
description: bioconductor-bcseq performs fast sequence alignment for high-throughput shRNA and CRISPR screens using a Trie data structure. Use when user asks to align barcode reads to a library, perform Hamming or Edit distance matching, or generate read count tables for CRISPR screens.
homepage: https://bioconductor.org/packages/release/bioc/html/bcSeq.html
---

# bioconductor-bcseq

name: bioconductor-bcseq
description: Fast sequence alignment for high-throughput shRNA and CRISPR screens. Use this skill to perform barcode matching using Hamming or Edit distance, evaluate alignment qualities using Bayes' classifiers, and handle large-scale read datasets with multi-threading support.

## Overview

The `bcSeq` package is designed for the rapid alignment of CRISPR or shRNA reads to a library of sequences using a 'Trie' data structure. It is particularly efficient for short sequence alignment where unique barcode matching is required. The package supports both Hamming distance (mismatches only) and Edit distance (mismatches, insertions, and deletions), and allows for user-defined probability models to resolve ambiguous alignments.

## Core Functions

### Hamming Distance Alignment
Use `bcSeq_hamming` when only substitutions (mismatches) are expected and sequence lengths are identical.

```r
library(bcSeq)
# Basic alignment
bcSeq_hamming(
  sampleFile = "reads.fastq", 
  libFile = "library.fasta", 
  outFile = "counts.csv", 
  misMatch = 2,      # Max mismatches allowed
  numThread = 4,     # Parallel processing
  count_only = TRUE  # Returns count table
)
```

### Edit Distance Alignment
Use `bcSeq_edit` when the alignment needs to account for indels (insertions/deletions) in addition to mismatches.

```r
bcSeq_edit(
  sampleFile = "reads.fastq",
  libFile = "library.fasta",
  outFile = "counts.csv",
  misMatch = 2,
  gap_left = 2,      # Deletion penalty
  gap_right = 2,     # Insertion penalty
  pen_max = 5,       # Maximum total penalty allowed
  numThread = 4
)
```

## Workflows

### 1. Data Preparation
`bcSeq` accepts either file paths (strings) or `DNAStringSet` objects from the `Biostrings` package.
- **Library**: Should contain unique barcode sequences.
- **Reads**: High-throughput sequencing data (FASTQ).

### 2. Handling Output
By default (`count_only = TRUE`), the functions write a CSV to `outFile` and return a list to R.
- The CSV contains: `barcode_sequence, read_count`.
- To get alignment probabilities for ambiguous reads, set `count_only = FALSE`. This returns a sparse matrix where rows are read IDs and columns are barcode IDs.

### 3. Custom Probability Models
You can influence how alignment quality is evaluated in two ways:

**A. Prior Error Probabilities (`tMat`):**
Provide a dataframe to `tMat` with two columns: the sequence context and the error probability.
```r
# Example: Higher error rate for a specific sequence context
custom_tMat <- data.frame(
  seq = c("AAAA", "CCCC"),
  prob = c(0.5, 0.4)
)
```

**B. Custom Alignment Score (`userProb`):**
For `bcSeq_edit`, you can provide an R function to calculate custom scores based on penalties.
```r
customizeP <- function(max_pen, prob, pen_val) {
  # prob: combined match/mismatch probability
  # pen_val: total penalties for the alignment
  prob * (1 - log(2) + log(1 + max_pen / (max_pen + pen_val)))
}

bcSeq_edit(..., userProb = customizeP)
```

## Tips for Performance
- **Multi-threading**: Always adjust `numThread` to match your available CPU cores for significant speedups.
- **Memory**: The 'Trie' structure is memory efficient, but very large libraries or high `misMatch` values will increase memory consumption.
- **Unique Barcodes**: Ensure your library file contains unique sequences; `bcSeq` will only keep unique barcodes during the Trie construction.

## Reference documentation
- [bcSeq](./references/bcSeq.md)