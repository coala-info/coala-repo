---
name: bioconductor-discordant
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/discordant.html
---

# bioconductor-discordant

name: bioconductor-discordant
description: Identify pairs of features (genes, miRNAs, metabolites) that correlate differently between two phenotypic groups (e.g., case vs. control) using mixture models. Use this skill when performing differential correlation analysis within a single -omics dataset or between two different -omics datasets (e.g., miRNA-mRNA integration).

# bioconductor-discordant

## Overview

The `discordant` package identifies differential correlation between two phenotypic groups using a mixture model approach. It "bins" feature pairs into classes based on their co-expression patterns (negative, positive, or no correlation) in each group. The primary output is a posterior probability (PP) that a pair is differentially correlated. It supports both "within-omics" (e.g., gene-gene) and "between-omics" (e.g., miRNA-gene) analyses and is compatible with various data types, including microarray and sequencing data.

## Workflow and Functions

### 1. Data Preprocessing and Outlier Filtering
Outliers can significantly skew correlation results. Use `splitMADOutlier()` for non-normal data (like sequencing counts).

```r
library(discordant)
# filter0 = TRUE removes features with any zero counts
# threshold = 4 is the number of MADs from the median
mat_filtered <- splitMADOutlier(your_data_matrix, filter0 = TRUE, threshold = 4)
```

### 2. Create Correlation Vectors
Generate correlation coefficients for each group. This function handles the pairing logic.

```r
# group: vector of 1s and 2s matching columns of x (and y)
groups <- c(rep(1, n_control), rep(2, n_treat))

# Within-omics (pairs all features in x)
vectors <- createVectors(x = data_matrix, groups = groups, cor.method = "spearman")

# Between-omics (pairs features in x with features in y)
vectors <- createVectors(x = matrix_x, y = matrix_y, groups = groups, cor.method = "spearman")
```
*   **Supported Methods**: `"spearman"` (default, recommended for sequencing), `"pearson"`, `"bwmc"` (biweight midcorrelation), and `"sparcc"`.

### 3. Run Discordant Algorithm
The `discordantRun()` function fits the mixture model using the EM algorithm.

```r
# For within-omics
result <- discordantRun(v1 = vectors$v1, v2 = vectors$v2, x = data_matrix)

# For between-omics
result <- discordantRun(v1 = vectors$v1, v2 = vectors$v2, x = matrix_x, y = matrix_y)
```

### 4. Interpreting Results
The output object contains several useful components:

*   `discordPPVector`: A named vector of posterior probabilities for differential correlation. High values (e.g., > 0.8) indicate strong evidence of differential correlation.
*   `discordPPMatrix`: The same probabilities in matrix format.
*   `classVector`: The most likely class (1-9) for each pair.
    *   **Diagonal (1, 5, 9)**: Equivalent correlation.
    *   **Off-diagonal (2, 3, 4, 6, 7, 8)**: Differential correlation.
*   `probMatrix`: All 9 posterior probabilities for every pair.

## Advanced Options

### Subsampling
For very large datasets, use `subsampling = TRUE` to speed up the EM algorithm by using a random sample of independent feature pairs.

```r
set.seed(123)
result <- discordantRun(v1, v2, x, subsampling = TRUE, iter = 100)
```

### Five-Component Model
By default, the model uses 3 components (-, 0, +). You can expand this to 5 (--, -, 0, +, ++) to identify "elevated" differential correlation, though this requires more features and may reduce performance.

```r
result <- discordantRun(v1, v2, x, components = 5)
```

## Tips
*   **Sample Matching**: For between-omics analysis, columns in matrix `x` and matrix `y` must represent the same samples in the same order.
*   **Data Size**: If you encounter an "Insufficient data" error, it means there aren't enough features to estimate the mixture components. Increase the number of features or stick to the 3-component model.
*   **Transformation**: For RNA-seq data, it is often beneficial to use `voom` transformed counts or similar normalized values before running `discordant`.

## Reference documentation
- [The discordant R Package: A Novel Approach to Differential Correlation](./references/Using_discordant.md)
- [The discordant R Package: A Novel Approach to Differential Correlation (RMarkdown Source)](./references/Using_discordant.Rmd)