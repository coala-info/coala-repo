---
name: bioconductor-hicrep
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/3.5/bioc/html/hicrep.html
---

# bioconductor-hicrep

## Overview

The `hicrep` package implements a unique framework for evaluating the reproducibility of Hi-C data. Unlike standard Pearson or Spearman correlations, which are often biased by the distance-dependent nature of Hi-C interactions and domain structures, `hicrep` uses a two-step process:
1.  **Smoothing**: A 2D moving window average filter reduces local noise and enhances domain structures.
2.  **Stratification**: Data is stratified by genomic distance, Pearson correlations are calculated within each stratum, and then aggregated into a **Stratum-adjusted Correlation Coefficient (SCC)**.

The SCC ranges from -1 to 1 and provides a robust metric for quality control and replicate comparison.

## Typical Workflow

### 1. Data Preparation and Input Format
Input matrices should be in a $N \times (3+N)$ format. The first three columns must be:
- `V1`: Chromosome name
- `V2`: Mid-point coordinate of bin 1
- `V3`: Mid-point coordinate of bin 2
The remaining columns represent the contact matrix.

### 2. Selecting Smoothing Parameter ($h$)
The smoothing parameter $h$ determines the neighborhood size. Use `htrain` to find the optimal $h$ where the SCC plateaus.

```r
library(hicrep)

# Find optimal h (e.g., checking h from 0 to 2)
# Arguments: matrix1, matrix2, resolution, max_dist, h_range
h_hat <- htrain(HiCR1, HiCR2, 1000000, 5000000, 0:2)
```

### 3. Equalizing Sequencing Depth
If replicates have significantly different total read counts, down-sample the higher-depth library using `depth.adj`.

```r
# Down-sample to 200,000 reads
# out = 0 returns the original matrix format
DS_HiCR1 <- depth.adj(HiCR1, 200000, 1000000, out = 0)
```

### 4. Pre-processing and Smoothing
The `prep` function transforms the matrix into a vectorized format, applies smoothing, and filters out bins that are zero in both replicates.

```r
# resolution: 1MB, h: 1, max_dist: 5MB
Pre_HiC <- prep(HiCR1, HiCR2, 1000000, 1, 5000000)
```

### 5. Calculating SCC
Calculate the final reproducibility score and its asymptotic standard deviation.

```r
SCC.out <- get.scc(Pre_HiC, 1000000, 5000000)

# Extract SCC score
scc_score <- SCC.out[[3]]

# Extract Standard Deviation
scc_sd <- SCC.out[[4]]
```

## Key Functions

- `htrain()`: Heuristic procedure to find the optimal smoothing parameter $h$.
- `depth.adj()`: Adjusts the sequencing depth of a Hi-C matrix to a target value.
- `prep()`: Vectorizes, smooths, and filters Hi-C matrices for SCC calculation.
- `get.scc()`: Computes the Stratum-adjusted Correlation Coefficient and its variance.

## Usage Tips
- **Resolution**: Ensure the `resolution` argument matches the bin size of your input matrices.
- **Max Distance**: The `max_dist` parameter should be chosen based on the range where biological signals are expected (e.g., 5MB for 40kb-1MB resolution).
- **Performance**: Calculation time scales with chromosome size. Large chromosomes (like Chr1) may take significantly longer than smaller ones (like Chr22).
- **Consistency**: When comparing multiple pairs of replicates, use the same smoothing parameter $h$ and resolution across all comparisons to ensure results are comparable.

## Reference documentation
- [Evaluate reproducibility of Hi-C data with hicrep](./references/hicrep-vigenette.md)