---
name: bioconductor-bumphunter
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/bumphunter.html
---

# bioconductor-bumphunter

name: bioconductor-bumphunter
description: Statistical tool for identifying regions of interest (bumps) in genomic data. Use when analyzing high-throughput genomic data (like methylation or sequencing) to find contiguous regions where a covariate of interest (e.g., case vs. control) shows a significant effect.

# bioconductor-bumphunter

## Overview

The `bumphunter` package implements a statistical method for identifying "bumps" in genomic data—contiguous regions where a coefficient in a linear model is significantly different from zero. It is widely used for finding differentially methylated regions (DMRs) in epigenetics but is generalizable to any data with one-dimensional location information.

## Core Workflow

The typical workflow involves defining genomic clusters, fitting a linear model at each location, and then identifying regions where the effect size exceeds a specified threshold.

### 1. Defining Clusters
Clusters are groups of genomic locations where the distance between consecutive points is less than a specified `maxGap`. Smoothing and model fitting are typically restricted within these clusters.

```r
library(bumphunter)
# chr: vector of chromosomes
# pos: vector of genomic positions
cl <- clusterMaker(chr, pos, maxGap = 300)
```

### 2. Running the Bump Hunter
The `bumphunter` function is the primary interface. It fits a linear model to the data `y` using a design matrix `X`, identifies regions, and can perform permutation testing.

```r
# y: matrix of data (rows = locations, cols = samples)
# X: design matrix (e.g., model.matrix(~ group))
# cutoff: numeric value; only regions with effects above this are kept
tab <- bumphunter(y, X, chr, pos, cl, cutoff = 0.5, B = 0)
```

### 3. Interpreting Results
The output is a list containing a `table` of identified regions.
- `value`: The average difference (effect size) in the region.
- `area`: The sum of the statistics in the region (often used for ranking).
- `L`: The number of locations (probes/bins) in the bump.

## Advanced Features

### Permutation Testing
To assess the statistical significance of the identified bumps, use the `B` argument to specify the number of permutations.

```r
# B = 1000 performs 1000 permutations to calculate p-values
tab <- bumphunter(y, X, chr, pos, cl, cutoff = 0.5, B = 1000)
```

### Parallelization
Bumphunting with permutations is computationally intensive. Use `foreach` backends to speed up the process.

```r
library(doParallel)
registerDoParallel(cores = 4)
# bumphunter will now automatically use the registered backend
tab <- bumphunter(y, X, chr, pos, cl, cutoff = 0.5, B = 1000, verbose = TRUE)
```

### Low-level Components
For custom workflows, you can use the internal engines directly:
- `getSegments`: Finds positive, negative, or near-zero segments in a vector.
- `regionFinder`: Converts segments into a structured table of genomic regions.

## Tips for Success
- **Smoothing**: By default, `bumphunter` can smooth the coefficients. This is useful for noisy data like methylation arrays. Control this via `smooth = TRUE` and `smoothFunction`.
- **Design Matrix**: If your design matrix `X` has more than two columns (e.g., adjusting for age or sex), permutation testing is not recommended.
- **Memory**: For very large datasets (e.g., Whole Genome Bisulfite Sequencing), consider using specialized packages like `bsseq` which utilize `bumphunter` logic but are optimized for memory.

## Reference documentation
- [The bumphunter user's guide](./references/bumphunter.md)