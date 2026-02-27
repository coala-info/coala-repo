---
name: bioconductor-muscle
description: This tool performs multiple sequence alignment of DNA, RNA, or amino acid sequences using the MUSCLE algorithm within the Bioconductor ecosystem. Use when user asks to align biological sequences, perform multiple sequence alignment on Biostrings objects, or optimize alignment parameters like gap penalties and speed.
homepage: https://bioconductor.org/packages/release/bioc/html/muscle.html
---


# bioconductor-muscle

name: bioconductor-muscle
description: Perform multiple sequence alignment (MSA) of DNA, RNA, or amino acid sequences using the MUSCLE algorithm within the Bioconductor ecosystem. Use this skill when you need to align biological sequences stored in Biostrings objects (DNAStringSet, RNAStringSet, AAStringSet) or when you need to optimize alignment parameters like gap penalties and speed.

# bioconductor-muscle

## Overview

The `muscle` package is an R interface to the MUSCLE (Multiple Sequence Comparison by Log-Expectation) algorithm. It is designed to work seamlessly with Bioconductor's `Biostrings` infrastructure, taking `XStringSet` objects as input and returning `MultipleAlignment` objects. MUSCLE is known for its high accuracy and speed, utilizing an iterative progressive alignment approach.

## Core Workflow

### 1. Data Preparation
Sequences must be in a `Biostrings` container. You can create these from character vectors or read them from FASTA files.

```r
library(muscle)
library(Biostrings)

# Reading from a FASTA file
fasta_path <- "path/to/sequences.fasta"
sequences <- readDNAStringSet(fasta_path)

# Or using provided example data
data(umax) # DNAStringSet of MAX gene
```

### 2. Performing Alignment
The `muscle()` function automatically detects the sequence type (DNA, RNA, or Amino Acid).

```r
# Basic alignment
aln <- muscle(sequences)

# View results
detail(aln)
```

### 3. Customizing Alignment Parameters
You can tune the algorithm for speed or specific biological constraints:

*   **Speed Optimization**: Use `diags = TRUE` to enable diagonal recovery, which speeds up the process for closely related sequences.
*   **Gap Penalties**: Adjust `gapopen` (must be negative). Default is usually -12.0.
*   **Resource Limits**: Use `maxhours` to set a hard time limit for long-running alignments.
*   **Quiet Mode**: Use `quiet = TRUE` to suppress progress output during batch processing.

```r
# Fast alignment with custom gap penalty
aln_fast <- muscle(sequences, diags = TRUE, gapopen = -30.0)
```

### 4. Handling Output
The result is a `MultipleAlignment` object (e.g., `DNAMultipleAlignment`). You can convert this back to a standard `XStringSet` or save it.

```r
# Convert to DNAStringSet
aligned_set <- as(aln, "DNAStringSet")

# Write to file
writeXStringSet(aligned_set, file = "aligned_results.fasta")
```

## Tips for Large Datasets
*   For thousands of sequences, always use `diags = TRUE`.
*   If the alignment is part of a pipeline, use `verbose = FALSE` and `quiet = TRUE` to keep the R console clean.
*   To inspect the exact parameters used by the underlying MUSCLE engine, use `log = "muscle_log.txt", verbose = TRUE`.

## Reference documentation
- [Using muscle to produce multiple sequence alignments in Bioconductor](./references/muscle-vignette.md)