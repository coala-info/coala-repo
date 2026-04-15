---
name: bioconductor-dnabarcodecompatibility
description: This tool designs and optimizes DNA barcode combinations for multiplex sequencing on Illumina platforms while ensuring chemical compatibility and error robustness. Use when user asks to design compatible barcode sets, optimize barcode entropy for multiplexing, filter barcodes for sequencing error robustness, or select optimal barcode combinations for specific Illumina chemistry platforms.
homepage: https://bioconductor.org/packages/release/bioc/html/DNABarcodeCompatibility.html
---

# bioconductor-dnabarcodecompatibility

name: bioconductor-dnabarcodecompatibility
description: Design and optimize DNA barcode combinations for multiplex sequencing on Illumina platforms. Use this skill to identify compatible barcode sets that satisfy chemistry constraints (1, 2, or 4-channel SBS), filter for error robustness (substitution/indels), and maximize entropy to ensure uniform barcode usage across lanes.

## Overview

The `DNABarcodeCompatibility` package provides tools to select optimal combinations of DNA barcodes for multiplexed experiments. It ensures that pooled barcodes are compatible with specific Illumina chemistry constraints and robust against sequencing errors. The core value lies in its ability to maximize Shannon entropy, which minimizes the repeated use of the same barcodes across different lanes or flow cells, thereby reducing potential demultiplexing bias.

## Core Workflow

### 1. Automated Experiment Design
The `experiment_design()` function is the primary high-level interface. It handles barcode loading, compatibility checking, and entropy optimization in a single call.

```r
library(DNABarcodeCompatibility)

# Single Indexing Example
# 12 samples, multiplexed in groups of 3, on a 2-channel platform (NextSeq/NovaSeq)
results <- experiment_design(
  file1 = "path/to/barcodes.txt", 
  sample_number = 12, 
  mplex_level = 3, 
  platform = 2
)

# Dual Indexing Example
# Requires two separate barcode files
results_dual <- experiment_design(
  file1 = "i7_barcodes.txt",
  file2 = "i5_barcodes.txt",
  sample_number = 12,
  mplex_level = 3,
  platform = 4 # HiSeq/MiSeq
)
```

### 2. Step-by-Step Custom Workflow
For more control, you can execute the pipeline manually:

**A. Load and Validate Barcodes**
```r
# Checks for uniqueness, GC content, and homopolymers
barcodes <- file_loading_and_checking("barcodes.txt")
```

**B. Generate Compatible Combinations**
Use `get_all_combinations()` for small sets (exhaustive) or `get_random_combinations()` for large sets.
```r
# Exhaustive search for compatible pairs
combos <- get_all_combinations(barcodes, mplex_level = 2, platform = 4)
```

**C. Filter for Error Robustness**
Filter combinations based on distance metrics (Hamming for substitutions, Levenshtein/Seqlev for indels).
```r
# Keep combinations where barcodes have a minimum Hamming distance of 3
filtered_combos <- distance_filter(
  index_df = barcodes, 
  combinations_m = combos, 
  metric = "hamming", 
  d = 3
)
```

**D. Optimize Barcode Usage**
Maximize entropy to ensure barcodes are used as uniformly as possible across the experiment.
```r
optimized_set <- optimize_combinations(
  combination_m = filtered_combos, 
  nb_lane = 10,      # Number of lanes/multiplexes needed
  index_number = 48  # Total number of available barcodes in the library
)
```

## Key Parameters

- **platform**: 
  - `4`: Four-channel SBS (MiSeq, HiSeq)
  - `2`: Two-channel SBS (MiniSeq, NextSeq, NovaSeq)
  - `1`: One-channel SBS (iSeq)
- **metric**: 
  - `"hamming"`: Standard for substitution errors.
  - `"seqlev"`: Recommended for robustness against insertions and deletions.
- **d**: The minimum distance threshold (e.g., `d=3` allows for 1 error correction).

## Tips for Success
- **Entropy Check**: If the "Entropy of the optimized set" is significantly lower than the "Theoretical max entropy," it indicates that your distance constraints (`d`) are too strict for the number of available barcodes, forcing the tool to reuse specific barcodes frequently.
- **Input Format**: Barcode files should be simple text files with two columns: `Id` and `sequence`.
- **Built-in Data**: Use `data(IlluminaIndexes)` or `data(IlluminaIndexesRaw)` for testing and benchmarking.

## Reference documentation
- [Introduction to DNABarcodeCompatibility](./references/introduction.md)