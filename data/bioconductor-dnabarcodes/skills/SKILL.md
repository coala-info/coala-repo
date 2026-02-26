---
name: bioconductor-dnabarcodes
description: This tool creates, analyzes, and demultiplexes DNA barcodes with error correction for substitutions, insertions, and deletions. Use when user asks to generate robust barcode sets for sequencing, evaluate the error-correction properties of existing barcodes, or assign reads to samples based on barcode sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/DNABarcodes.html
---


# bioconductor-dnabarcodes

name: bioconductor-dnabarcodes
description: Create, analyze, and demultiplex DNA barcodes with error correction (substitutions, insertions, and deletions). Use this skill when you need to generate robust barcode sets for NGS experiments, evaluate the error-correction properties of existing barcodes, or assign reads to samples based on barcode sequences.

# bioconductor-dnabarcodes

## Overview

The `DNABarcodes` package provides tools for the design and use of DNA barcodes in multiplexed sequencing. Its primary strength is the ability to handle not just substitution errors (Hamming distance) but also insertions and deletions (Sequence-Levenshtein distance), which are critical for platforms like PacBio or Oxford Nanopore.

## Core Workflows

### 1. Creating New Barcode Sets
Use `create.dnabarcodes()` to generate a set of barcodes from scratch.

```r
library(DNABarcodes)

# Generate 7bp barcodes, default Hamming distance = 3 (corrects 1 substitution)
barcodes <- create.dnabarcodes(7)

# Generate barcodes for PacBio (corrects 1 indel/substitution)
# Uses Sequence-Levenshtein distance and Ashlock evolutionary algorithm for better results
barcodes_seqlev <- create.dnabarcodes(7, metric="seqlev", heuristic="ashlock")

# Target a specific number of samples by increasing distance or length
# dist=5 corrects 2 errors
barcodes_robust <- create.dnabarcodes(8, dist=5, heuristic="ashlock")
```

### 2. Filtering and Heuristics
*   **Heuristics**: Use `heuristic="conway"` (default) for speed or `heuristic="ashlock"` for larger sets (recommended for final designs).
*   **Filters**: By default, the tool removes triplets (e.g., AAA), GC-biased sequences, and self-complementary sequences.
    *   Disable filters if needed: `filter.triplets=FALSE`, `filter.gc=FALSE`, `filter.selfcomplementary=FALSE`.
*   **Ashlock Tuning**: Increase `population` (e.g., 500) and `iterations` (e.g., 200) for maximum set size.

### 3. Subsetting Existing Barcodes
If you have a pool of barcodes (e.g., from a commercial kit) and want to select the most robust subset:

```r
data(supplierSet) # Example pool
my_subset <- create.dnabarcodes(7, dist=5, pool=supplierSet, heuristic="ashlock")
```

### 4. Analyzing Barcode Properties
Evaluate the error correction/detection capabilities of any set of sequences.

```r
# Returns mean/min/max distances and guaranteed correction/detection levels
analysis <- analyse.barcodes(my_subset)
print(analysis)
```

### 5. Demultiplexing Reads
Assign sequences to their original barcodes.

```r
# mutatedReads is a character vector of sequences starting with barcodes
results <- demultiplex(mutatedReads, barcodes, metric="hamming")

# Results include the assigned barcode and the distance
head(results)
```

## Distance Metrics Guide

| Metric | Parameter | Use Case |
| :--- | :--- | :--- |
| **Hamming** | `metric="hamming"` | Substitutions only (Illumina). |
| **Sequence-Levenshtein** | `metric="seqlev"` | Indels + Substitutions in DNA context (PacBio/Nanopore). **Recommended for indels.** |
| **Levenshtein** | `metric="levenshtein"` | Indels + Substitutions (isolated barcodes only). Rarely used in NGS. |
| **Phaseshift** | `metric="phaseshift"` | Experimental; substitutions and front-end indels. |

## Error Correction Logic
The number of correctable errors ($k_c$) based on the minimum distance ($dist$) is:
$k_c \le \lfloor (dist - 1) / 2 \rfloor$

*   **dist=3**: Corrects 1 error.
*   **dist=5**: Corrects 2 errors.
*   **dist=7**: Corrects 3 errors.

## Reference documentation
- [DNABarcodes](./references/DNABarcodes.md)