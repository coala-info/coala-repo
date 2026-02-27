---
name: bioconductor-methylinheritance
description: This tool performs statistical analysis of inherited DNA methylation changes across multiple generations using permutation-based Monte Carlo sampling. Use when user asks to infer the inheritance of differentially methylated elements, perform permutation analysis on multi-generational datasets, or determine the statistical significance of conserved methylation patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/methylInheritance.html
---


# bioconductor-methylinheritance

name: bioconductor-methylinheritance
description: Statistical analysis of inherited DNA methylation changes across multiple generations. Use this skill to perform permutation-based Monte Carlo sampling to distinguish treatment-induced epigenetic inheritance from stochastic effects in inter-generational and trans-generational datasets.

# bioconductor-methylinheritance

## Overview

The `methylInheritance` package provides a permutation-based framework to infer the inheritance of differentially methylated elements (DME)—either sites (DMS) or tiles (DMT)—across multiple generations. It addresses the "stochastic overlap" problem where common DMEs between generations might occur by chance. By shuffling treatment labels and recalculating overlaps, it determines if the observed conservation of methylation patterns is statistically significant.

## Core Workflow

### 1. Data Preparation
The package requires a `list` of `methylRawList` objects (from the `methylKit` package). Each element in the list represents one generation (F1, F2, F3, etc.) in chronological order.

```r
library(methylInheritance)
library(methylKit)

# Example: Creating a 2-generation input list
# generation_01 and generation_02 are methylRawList objects
multi_gen_data <- list(generation_01, generation_02)
```

### 2. Running the Analysis
You can run the observation analysis (real data) and permutation analysis (shuffled data) separately or together.

**Observation Analysis:**
Calculates the reference number of conserved DMEs.
```r
runObservation(methylKitData = multi_gen_data,
               type = "sites", # or "tiles"
               outputDir = "obs_results",
               nbrCores = 1,
               minMethDiff = 10,
               qvalue = 0.01)
```

**Permutation Analysis:**
Generates the null distribution.
```r
runPermutation(methylKitData = multi_gen_data,
               type = "sites",
               outputDir = "perm_results",
               nbrPermutations = 1000,
               runObservationAnalysis = TRUE) # Can run both at once
```

### 3. Loading and Merging Results
Results are typically saved as RDS files in the specified `outputDir`.

```r
# Load results from directories
obs_res <- loadAllRDSResults(analysisResultsDir = "obs_results", doingSites = TRUE)
perm_res <- loadAllRDSResults(permutationResultsDir = "perm_results", doingSites = TRUE)

# Merge for comparison
all_res <- mergePermutationAndObservation(permutationResults = perm_res,
                                          observationResults = obs_res)
```

### 4. Extracting and Visualizing Results
Use `extractInfo` to pull specific generational comparisons.

*   `inter = "i2"`: Consecutive generations (e.g., F1 vs F2).
*   `inter = "iAll"`: Cumulative inheritance (e.g., F1 vs F2 vs F3).

```r
# Extract F1 and F2 comparison
f1_f2_data <- extractInfo(all_res, type = "sites", inter = "i2", position = 1)

# Plot distribution and calculate p-value
plotGraph(f1_f2_data)
```

## Key Parameters and Tips

*   **Restarting Calculations**: For long-running permutations, set `restartCalculation = TRUE` in `runPermutation()`. It will skip permutations already present in the `outputDir`.
*   **Reproducibility**: Always set `vSeed` in `runObservation` and `runPermutation` to ensure consistent results across runs.
*   **Tiles vs Sites**: Use `type = "tiles"` for regional analysis. Ensure your `methylKit` objects are tiled if using this option.
*   **Memory Management**: Permutation analysis is computationally intensive. Use `nbrCores` to parallelize, but monitor RAM usage as each core loads the dataset.

## Reference documentation

- [Inferring inheritance of differentially methylated changes across multiple generations](./references/methylInheritance.Rmd)
- [methylInheritance Vignette](./references/methylInheritance.md)