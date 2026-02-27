---
name: bioconductor-lungexpression
description: This package provides gene expression datasets from three major lung cancer studies formatted as ExpressionSet objects for Bioconductor analysis. Use when user asks to access lung cancer expression data, perform cross-study comparisons, or conduct survival analysis using the Harvard, Michigan, and Stanford datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/lungExpression.html
---


# bioconductor-lungexpression

name: bioconductor-lungexpression
description: Access and use the lungExpression Bioconductor package, which provides ExpressionSet objects from three major lung cancer studies (Harvard, Michigan, and Stanford). Use this skill when a user needs to perform cross-study comparisons, survival analysis, or gene expression profiling using the datasets from Parmigiani et al. (2004).

# bioconductor-lungexpression

## Overview
The `lungExpression` package is a Bioconductor experiment data package containing three large-scale lung cancer gene expression datasets. These datasets are formatted as `ExpressionSet` objects, making them compatible with standard Bioconductor analysis workflows (e.g., `limma`, `survival`, `Biobase`). The data originates from the clinical cancer research paper by Parmigiani et al. (2004) and includes studies from Harvard, Michigan, and Stanford.

## Installation and Loading
To use this package, ensure it is installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lungExpression")
library(lungExpression)
```

## Accessing Datasets
The package provides three primary datasets. Each is loaded into the global environment using the `data()` function.

### 1. Harvard Study
Based on Bhattacharjee et al. (2001).
```r
data(harvard)
# View summary
harvard
# Access expression matrix
exprs(harvard)[1:5, 1:5]
# Access phenotype/clinical data
pData(harvard)[1:5, ]
```

### 2. Michigan Study
Based on Beer et al. (2002).
```r
data(michigan)
# View summary
michigan
# Access expression matrix
exprs(michigan)[1:5, 1:5]
# Access phenotype/clinical data
pData(michigan)[1:5, ]
```

### 3. Stanford Study
Based on Garber et al. (2001).
```r
data(stanford)
# View summary
stanford
# Access expression matrix
exprs(stanford)[1:5, 1:5]
# Access phenotype/clinical data
pData(stanford)[1:5, ]
```

## Typical Workflows

### Cross-Study Comparison
Since all three datasets are `ExpressionSet` objects, you can compare them by identifying common features (genes/probes):

```r
# Find common genes across all three studies
common_genes <- intersect(featureNames(harvard), 
                          intersect(featureNames(michigan), featureNames(stanford)))

# Subset datasets to common genes for meta-analysis
harvard_sub <- harvard[common_genes, ]
michigan_sub <- michigan[common_genes, ]
stanford_sub <- stanford[common_genes, ]
```

### Clinical Data Exploration
The `pData` (phenotype data) contains clinical variables used in the original studies. Note that annotations for `phenoData` may require manual inspection to align column names across different studies (e.g., survival time, stage, or histology).

```r
# Check available clinical variables
varLabels(harvard)
varLabels(michigan)
varLabels(stanford)
```

## Tips
- **Data Structure**: These are `ExpressionSet` objects. Use `exprs()` to get the expression matrix and `pData()` to get the clinical metadata.
- **Normalization**: The data is provided as processed by the original authors; if performing a meta-analysis, consider if additional batch correction (e.g., `ComBat` from the `sva` package) is necessary.
- **Feature Mapping**: Ensure that probe IDs or gene symbols are consistent across the three datasets before merging or comparing results.

## Reference documentation
- [Package Manual](./references/reference_manual.md)