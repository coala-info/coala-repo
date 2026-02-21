---
name: r-presto
description: R package presto (documentation from project home).
homepage: https://cran.r-project.org/web/packages/presto/index.html
---

# r-presto

name: r-presto
description: Fast Wilcoxon rank sum test and auROC analysis for high-dimensional data. Use when performing differential expression analysis, marker discovery in single-cell genomics, or large-scale rank-based statistical testing on dense or sparse matrices, Seurat objects, or SingleCellExperiment objects.

## Overview

Presto is an R package designed for high-performance statistical testing. It provides a significantly faster implementation of the Wilcoxon rank sum test and Area Under the Receiver Operating Characteristic (auROC) analysis compared to standard R implementations. It is particularly optimized for single-cell RNA-seq data where one needs to compare thousands of features across thousands of observations and multiple groups.

## Installation

Install the package from CRAN:

```R
install.packages("presto")
```

For the development version:

```R
# install.packages("devtools")
devtools::install_github("immunogenomics/presto")
```

## Main Functions

### wilcoxauc

The primary function is `wilcoxauc`, which calculates the Wilcoxon rank sum test and auROC for all features across all groups in a single pass.

**Usage with a Matrix:**
```R
# X: feature-by-observation matrix (or observation-by-feature)
# y: vector of group labels
res <- wilcoxauc(X, y)
```

**Usage with Single-Cell Objects:**
Presto has built-in methods for common single-cell containers.
```R
# Seurat object
res <- wilcoxauc(seurat_obj, 'cluster_variable_name')

# SingleCellExperiment object
res <- wilcoxauc(sce_obj, 'cluster_variable_name')
```

### top_markers

After running `wilcoxauc`, use `top_markers` to extract the most significant features for each group.

```R
# Extract top 10 markers per group based on auROC
markers <- top_markers(res, n = 10, auc_min = 0.5)
```

## Workflows

### Differential Expression in Single-Cell Data

1. **Prepare Data**: Ensure your Seurat or SCE object has the desired grouping in the metadata.
2. **Run Test**: Execute `wilcoxauc`. It will automatically handle the sparse matrix typically found in these objects.
3. **Filter Results**: The output is a tidy data frame containing:
   - `feature`: Feature name (e.g., Gene).
   - `group`: The group being compared against all others.
   - `avgExpr`: Average expression in the group.
   - `logFC`: Log fold change.
   - `auc`: Area under the ROC curve (0.5 is random, 1.0 is perfect marker).
   - `pval`: P-value.
   - `padj`: Benjamini-Hochberg adjusted p-value.
   - `pct_in`: Percentage of cells in the group expressing the feature.
   - `pct_out`: Percentage of cells outside the group expressing the feature.

### Performance Tips

- **Sparse Matrices**: Presto is highly optimized for `dgCMatrix` (sparse) inputs. If working with large datasets, ensure your data is in a sparse format to see the greatest speed gains.
- **Memory**: While fast, calculating all-pairs-all-features can be memory-intensive. For extremely large datasets, ensure sufficient RAM is available for the resulting data frame.

## Reference documentation

- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)