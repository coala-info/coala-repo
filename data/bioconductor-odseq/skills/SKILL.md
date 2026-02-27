---
name: bioconductor-odseq
description: The odseq package detects outlier sequences in biological datasets to improve the quality of multiple sequence alignments. Use when user asks to identify outlier sequences, remove noise from alignments, or detect anomalous sequences using distance matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/odseq.html
---


# bioconductor-odseq

## Overview

The `odseq` package provides methods to detect outlier sequences in biological datasets. It is primarily designed to identify sequences that degrade the quality of a multiple sequence alignment (MSA). By identifying these "noise" sequences, researchers can improve the robustness of downstream phylogenetic or comparative analyses. The package supports both aligned sequences (via the `msa` package) and unaligned sequences (via pre-computed distance or similarity matrices).

## Core Workflows

### 1. Outlier Detection from Aligned Sequences
This is the standard workflow when you have already performed an alignment using the `msa` package.

```r
library(odseq)
library(msa)

# 1. Perform alignment (e.g., using ClustalOmega)
alig <- msa(my_sequences)

# 2. Detect outliers
# B: number of bootstrap iterations (higher is more robust)
# distance_metric: "affine" (default) or "simple"
outliers <- odseq(alig, distance_metric = "affine", B = 1000, threshold = 0.025)

# 3. Results are a logical vector (TRUE = outlier)
clean_alignment <- alig[which(!outliers), ]
```

### 2. Outlier Detection from Unaligned Sequences
Use `odseq_unaligned` when a full MSA is computationally prohibitive. This requires a pre-computed similarity or distance matrix (e.g., from string kernels in the `kebabs` package).

```r
library(odseq)

# Assume 'mat' is a distance or similarity matrix
# type: "distance" or "similarity"
outliers_unaligned <- odseq_unaligned(mat, B = 1000, type = "similarity")

# Filter original sequence object
clean_seqs <- my_sequences[!outliers_unaligned]
```

## Key Functions

- `odseq()`: Main function for `MsaAAMultipleAlignments` objects. It calculates the distance of each sequence to the rest and uses bootstrapping to determine if that distance is statistically anomalous.
- `odseq_unaligned()`: Performs the same statistical test but accepts a raw numeric matrix. This is useful for custom distance metrics or large-scale k-mer based similarities.

## Parameters and Tuning

- `B`: The number of bootstrap replicates. While the default is often sufficient, increasing `B` (e.g., to 1000) provides more stable p-values for the outlier threshold.
- `threshold`: The alpha level for the statistical test (default is 0.025).
- `distance_metric`: For aligned sequences, "affine" takes gap penalties into account more realistically than "simple".

## Tips for Success

- **Alignment Quality**: The performance of `odseq` depends on the initial alignment. If the alignment is extremely poor, the "consensus" itself may be noise, leading to inaccurate outlier detection.
- **Metric Choice**: When using `odseq_unaligned`, the choice of string kernel or distance metric (e.g., Levenshtein, k-mer spectrum) significantly impacts accuracy. Aligned methods are generally more precise.
- **Memory**: For very large datasets, pre-calculating a distance matrix and using `odseq_unaligned` is more memory-efficient than attempting a massive MSA.

## Reference documentation

- [odseq Vignette](./references/vignette.md)