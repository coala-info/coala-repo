---
name: bioconductor-derfinderhelper
description: This tool calculates F-statistics for genomic features using nested models to identify differential expression. Use when user asks to calculate F-statistics for genomic data, perform differential expression analysis within the derfinder framework, or optimize memory usage during parallel RNA-seq data processing.
homepage: https://bioconductor.org/packages/release/bioc/html/derfinderHelper.html
---

# bioconductor-derfinderhelper

name: bioconductor-derfinderhelper
description: Calculate F-statistics for genomic features (base-level, exon, or gene) using nested models. Use when performing differential expression analysis within the derfinder framework, specifically to accelerate F-stats calculations in parallel environments or to manage memory efficiency during large-scale RNA-seq data analysis.

# bioconductor-derfinderhelper

## Overview

`derfinderHelper` is a specialized utility package designed to accelerate the F-statistics approach used in the `derfinder` package. Its primary purpose is to provide a memory-efficient and fast implementation of F-statistic calculations through the `fstats.apply()` function. By separating this functionality into a lightweight package, it reduces the overhead of loading the full `derfinder` suite in parallel child processes (e.g., when using `BiocParallel`).

## Core Functionality

The package revolves around a single function: `fstats.apply()`. This function calculates F-statistics for a data matrix given a null model and an alternative model.

### fstats.apply() Parameters

- `data`: A matrix or `DataFrame` where rows are genomic features and columns are samples.
- `mod`: The alternative model matrix (including the covariates of interest).
- `mod0`: The null model matrix (nested within `mod`).
- `method`: Controls the calculation engine:
    - `"Matrix"`: (Recommended) Uses sparse matrix operations; balances speed and memory.
    - `"regular"`: Uses base R; can be memory-intensive.
    - `"Rle"`: Uses the least memory but is significantly slower as sample size increases.
- `scalefac`: A scaling factor applied to the data (default is 1).
- `adjustF`: A small value added to the denominator to prevent division by zero or extremely small values.

## Typical Workflow

### 1. Prepare Data and Models

Data should be organized with features as rows and samples as columns. Models must be nested.

```R
library(derfinderHelper)
library(IRanges)

# Example: 1000 features, 16 samples
# data <- ... (your matrix or DataFrame)

# Define groups and depth
group <- factor(rep(c("A", "B"), each = 8))
sampleDepth <- colSums(as.matrix(data))

# Create nested models
mod <- model.matrix(~ sampleDepth + group)
mod0 <- model.matrix(~ sampleDepth)
```

### 2. Calculate F-statistics

```R
# Calculate F-stats
fstats <- fstats.apply(
    data = data, 
    mod = mod, 
    mod0 = mod0, 
    method = "Matrix", 
    scalefac = 1
)

# Results are returned as a Run Length Encoded (Rle) numeric vector
```

## Usage Tips

- **Parallelization**: This package is specifically optimized for use with `BiocParallel::SnowParam()`. Because `derfinderHelper` is small, child processes start much faster than if they had to load the entire `derfinder` package.
- **Memory Management**: If you are hitting memory limits, ensure your data is converted to a `dgCMatrix` (from the `Matrix` package) before calling `fstats.apply()`.
- **Integration**: While you can use this package standalone, it is most commonly invoked internally by `derfinder::analyzeChr()` or `derfinder::calculateStats()`. Use it directly when you need to perform custom F-tests on large matrices outside the standard `derfinder` pipeline.

## Reference documentation

- [derfinderHelper](./references/derfinderHelper.md)