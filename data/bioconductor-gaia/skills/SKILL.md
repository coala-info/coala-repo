---
name: bioconductor-gaia
description: This tool identifies significant recurrent genomic copy number alterations in aCGH or sequencing data. Use when user asks to identify recurrent chromosomal aberrations, distinguish driver from passenger mutations, or perform statistical assessment of copy number variations across multiple samples.
homepage: https://bioconductor.org/packages/3.8/bioc/html/gaia.html
---

# bioconductor-gaia

name: bioconductor-gaia
description: Genomic Analysis of Important Aberrations (GAIA). Use this skill to identify significant recurrent copy number alterations (CNAs) in aCGH or sequencing data. It is specifically designed to distinguish driver mutations from passenger mutations using a permutation test and a "peel-off" procedure. Use when you need to perform statistical assessment of chromosomal aberrations across multiple samples.

## Overview

The `gaia` package provides a statistical framework to identify recurrent genomic aberrations. It uses a conservative permutation test to estimate the null distribution of mutations and assesses the statistical significance (q-values) of each marker. To refine results and identify independent driver regions, it employs a "peel-off" procedure, including an "homogeneous peel-off" option that preserves within-sample homogeneity.

## Typical Workflow

### 1. Data Preparation
GAIA requires two primary data structures: a Marker Descriptor Matrix and an Aberrant Region Descriptor Matrix.

*   **Marker Matrix**: Columns for `Probe Name`, `Chromosome`, `Start`, and (optional) `End`.
*   **Aberrant Region Matrix**: Columns for `Sample Name`, `Chromosome`, `Start`, `End`, `Num of Markers`, and `Aberration` (integer code, e.g., 0 for loss, 1 for LOH, 2 for gain).

### 2. Loading Data into GAIA Objects
Before running the analysis, raw matrices must be converted into optimized GAIA objects.

```R
library(gaia)

# Load marker information
# markers_matrix is a data.frame/matrix with probe details
markers_obj <- load_markers(markers_matrix)

# Load CNV information
# cnv_matrix is a data.frame/matrix with aberrant regions
# n_samples is the total number of samples in the study
cnv_obj <- load_cnv(cnv_matrix, markers_obj, n_samples)
```

### 3. Running the Analysis
The `runGAIA` function executes the permutation test and peel-off procedure.

```R
# Basic execution
results <- runGAIA(cnv_obj, markers_obj, output_file_name = "results.txt")

# Advanced execution with specific parameters
results <- runGAIA(cnv_obj, 
                   markers_obj, 
                   aberrations = -1,      # -1 for all, or specific codes (e.g., 0, 1, 2)
                   chromosomes = -1,      # -1 for all, or vector (e.g., c(1, 7, 14))
                   threshold = 0.25,      # q-value significance threshold
                   hom_threshold = 0.12,  # Threshold for homogeneous peel-off
                   num_iterations = 10)   # Number of permutations
```

### 4. Approximated Approach
For high-resolution datasets where permutations are computationally expensive, use the `approximation` flag.

```R
res_approx <- runGAIA(cnv_obj, 
                      markers_obj, 
                      approximation = TRUE, 
                      num_iterations = 5000)
```

## Interpreting Results

The output is a matrix where each row represents a significant aberrant region:
1.  **Chromosome**: Location of the aberration.
2.  **Aberration Kind**: The integer code provided during data loading.
3.  **Region Start/End [bp]**: Genomic coordinates.
4.  **Region Size [bp]**: Length of the region.
5.  **q-value**: Statistical significance (lower is more significant).

To find the most significant regions:
```R
top_regions <- results[which(results[,6] == min(results[,6])), ]
```

## Tips and Best Practices
*   **Homogeneous Peel-off**: This is recommended when you have exactly two kinds of aberrations. It helps in detecting regions that are both statistically significant and consistent within samples. Set `hom_threshold` to a value > 0 (suggested: 0.12).
*   **IGV Integration**: GAIA produces a `.gistic` file. This file can be loaded directly into the Integrative Genomics Viewer (IGV) to visualize q-values across the genome.
*   **Memory Management**: Because GAIA objects can be large, it is best to load markers and CNVs once and reuse the objects for different `runGAIA` parameter sweeps.

## Reference documentation
- [GAIA: Genomic Analysis of Important Aberrations](./references/gaia.md)