---
name: bioconductor-harman
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Harman.html
---

# bioconductor-harman

name: bioconductor-harman
description: Batch effect removal from biological datasets using PCA and constrained optimization. Use this skill when you need to: (1) Remove technical batch noise while preserving biological signal, (2) Perform PCA-based batch correction on transcriptome, methylation, or mass spectrometry data, (3) Visualize batch effects using arrow plots and PCA plots, (4) Reconstruct corrected data matrices for downstream analysis like limma.

# bioconductor-harman

## Overview

Harman is a PCA-based batch correction method that maximizes the removal of batch effects while ensuring the probability of overcorrection (removing genuine biological signal) remains below a user-defined threshold. Unlike ComBat, which works feature-by-feature, Harman operates in the principal component domain, making coordinated adjustments to features.

## Core Workflow

### 1. Data Preparation
Harman requires a data matrix (features in rows, samples in columns) and two factors: the experimental variable (`expt`) and the batch variable (`batch`).

```R
library(Harman)
# data: matrix or data.frame
# expt: factor of experimental conditions
# batch: factor of batch assignments
```

### 2. Running Harman
The main function is `harman()`. The `limit` parameter (default 0.95) sets the confidence threshold for correction. A lower limit (e.g., 0.75) is more aggressive.

```R
# Basic execution
harman_results <- harman(data_matrix, expt = expt_factor, batch = batch_factor, limit = 0.95)

# For small datasets, consider a lower limit
harman_results_aggressive <- harman(data_matrix, expt = expt_factor, batch = batch_factor, limit = 0.75)
```

### 3. Visualizing and Inspecting Results
Use specialized plotting functions to evaluate the extent of the batch effect and the correction applied.

```R
# Summary of corrected PCs
summary(harman_results)

# PCA plot colored by batch or experiment
pcaPlot(harman_results, colBy = 'batch', pchBy = 'expt')

# Arrow plot showing the shift from original to corrected PC scores
arrowPlot(harman_results, pc_x = 1, pc_y = 2)
```

### 4. Data Reconstruction
After correction, reconstruct the data matrix to its original dimensions for downstream analysis.

```R
corrected_matrix <- reconstructData(harman_results)

# To verify reconstruction accuracy on original data
original_remade <- reconstructData(harman_results, this = 'original')
```

## Domain-Specific Guidance

### Methylation Data (450k/EPIC)
*   **Use M-values:** Always input M-values, not Beta-values, as M-values are unbounded and more Gaussian-distributed.
*   **Handle Infinities:** Use `shiftBetas()` to move Beta values of 0 or 1 slightly (e.g., 1e-4) before converting to M-values to avoid `Inf` values.
*   **Cluster Awareness:** For methylation, use `discoverClusteredMethylation`, `kClusterMethylation`, and `clusterStats` to identify probes where correction might inappropriately destroy biological clustering (e.g., due to SNPs/ASM).

### Mass Spectrometry
*   **Preprocessing:** Use `pp.msms.data()` to remove all-zero rows and replace `NA` with 0.
*   **Transformation:** Log-transform the data (e.g., `log2(x + 1)`) before running Harman, then back-transform after reconstruction.

## Tips for Success
*   **Balanced Design:** Harman performs best when experimental factors are balanced across batches.
*   **Confounding:** If an experimental factor is completely confounded with a batch (e.g., all "Treatment A" samples are in "Batch 1"), Harman cannot distinguish between the two.
*   **Aggressiveness:** If `summary(harman_results)` shows no correction (correction values = 1.0) but batch effects are visible in PCA, decrease the `limit` parameter.

## Reference documentation
- [An Introduction to Harman](./references/IntroductionToHarman.md)