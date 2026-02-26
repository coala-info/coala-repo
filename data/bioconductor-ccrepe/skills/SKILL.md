---
name: bioconductor-ccrepe
description: This tool calculates compositionality-corrected p-values and similarity measures for associations between features in sparse microbial community sequencing data. Use when user asks to calculate significance of correlations in compositional data, handle spurious correlations in relative abundance datasets, or compute N-dimensional checkerboard scores for ecological data.
homepage: https://bioconductor.org/packages/release/bioc/html/ccrepe.html
---


# bioconductor-ccrepe

name: bioconductor-ccrepe
description: Analysis of sparse compositional data using the ccrepe R package. Use this skill to calculate compositionality-corrected p-values and q-values for similarity measures (like Spearman or Pearson) between features in microbial community sequencing data. It is specifically designed to handle the spurious correlations induced by non-independent compositional values that sum to a fixed total.

## Overview

The `ccrepe` package (Compositionality Corrected by PErmutation and REnormalization) provides tools to determine the significance of associations between features in compositional datasets. It addresses the "compositionality problem" where the sum-to-one constraint of relative abundances creates false correlations. The package features two primary components:
1. **ccrepe**: A framework that uses permutation/renormalization and bootstrapping to generate corrected p-values.
2. **nc.score**: A novel similarity measure (N-dimensional checkerboard score) suited for ecological data.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or dataframe of relative abundances where rows are samples and columns are features.
- Rows should sum to a constant (e.g., 1).
- Ensure row names are present if merging two datasets.
- The package automatically handles `na.omit` and removes all-zero features/subjects.

### 2. Running CCREPE
The `ccrepe` function can compare features within one dataset or between two different datasets.

```R
library(ccrepe)

# Example with one dataset
results <- ccrepe(
  x = my_data, 
  iterations = 1000,      # Number of bootstrap/permutation iterations
  min.subj = 20,          # Minimum non-missing samples required
  sim.score = cor,        # Similarity measure (default: Spearman)
  sim.score.args = list(method = "spearman")
)

# Accessing results
scores <- results$sim.score
p_vals <- results$p.values
q_vals <- results$q.values
```

### 3. Using NC-Score
The NC-score is an extension of the checkerboard score to ordinal data, effectively Kendall’s $\tau$ on binned data. It can be used standalone or as the `sim.score` within `ccrepe`.

```R
# Standalone usage
# nbins: number of bins for discretization
# bin.cutoffs: manual edges for bins
score_matrix <- nc.score(x = my_data, nbins = 10)

# Integrated usage
results_nc <- ccrepe(x = my_data, sim.score = nc.score, iterations = 500)
```

## Advanced Usage

### Comparing Two Datasets
When providing both `x` and `y`, `ccrepe` merges them by row names. Only paired observations are kept.
```R
results_two <- ccrepe(x = dataset1, y = dataset2, iterations = 1000)
```

### Custom Similarity Measures
You can define a custom function to pass to `sim.score`. It must:
- Accept `x` and `y` as named arguments.
- Return a single number for two vector inputs.
- Return a symmetric matrix for a single matrix input.

### Column Subsetting
Use `subset.cols.x` and `subset.cols.y` to limit comparisons to specific indices, which significantly reduces computation time for high-dimensional data.

## Tips for Success
- **Iterations**: For publication-quality results, use at least 1000 iterations. For quick testing, 20-100 iterations are sufficient.
- **Filtering**: Features with a high proportion of zeros (controlled by `errthresh`) are excluded to prevent standard deviation errors.
- **Memory**: If working with very large matrices, set `make.output.table = FALSE` to save memory, or use `subset.cols.x` to focus on specific taxa of interest.

## Reference documentation
- [CCREPE: Compositionality Corrected by PErmutation and REnormalization](./references/ccrepe.md)