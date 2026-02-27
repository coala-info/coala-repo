---
name: bioconductor-oppar
description: This tool implements the modified Cancer Outlier Profile Analysis method to identify genes significantly up-regulated or down-regulated in subsets of samples. Use when user asks to detect outlier genes in cancer subtypes, generate outlier profile matrices, or calculate enrichment scores for gene sets with both up-regulated and down-regulated components.
homepage: https://bioconductor.org/packages/release/bioc/html/oppar.html
---


# bioconductor-oppar

## Overview

The `oppar` package implements the modified Cancer Outlier Profile Analysis (mCOPA) method. It is designed to identify genes that are significantly up-regulated or down-regulated in a subset of samples (outliers) rather than across the entire cohort. This is particularly useful for identifying driver genes in cancer subtypes. Additionally, it provides a modified GSVA implementation that aggregates up- and down-regulated gene sets into a single positive enrichment score.

## Core Workflow: Outlier Profile Analysis

### 1. Data Preparation
OPPAR typically works with `ExpressionSet` objects or numeric matrices (microarray RPKM or NGS data).

```r
library(oppar)
# Load your ExpressionSet (e.g., eset)
# Define a group factor (0 for control/normal, 1 for cases/condition)
g <- factor(c(rep(0, 10), rep(1, 20))) 
```

### 2. Generating Outlier Profiles
Use `opa()` to detect outliers. You can define the thresholds for what constitutes an outlier using quantiles.

```r
# lower.quantile: threshold for down-regulation (default 0.05)
# upper.quantile: threshold for up-regulation (default 0.95)
res <- opa(eset, group = g, lower.quantile = 0.1, upper.quantile = 0.95)

# Access the profile matrix (-1: down, 0: none, 1: up)
pm <- res$profileMatrix
```

### 3. Extracting Outliers
Retrieve specific outliers for samples or groups.

```r
# Get outliers for specific samples (by index or name)
sample_outliers <- getSampleOutlier(res, c(1, 5))

# Get all outliers for a specific subtype/group
outlier_list <- getSubtypeProbes(res, 1:ncol(res$profileMatrix))
# Returns a list with "up" and "down" components
up_genes <- outlier_list$up
down_genes <- outlier_list$down
```

## Core Workflow: Modified GSVA

The `oppar::gsva` function is modified to ensure that samples enriched for a signature (whether up or down) receive positive scores.

### Running Enrichment
To use the combined scoring, you must provide a named list with "up" and "down" keys and set `is.gset.list.up.down = TRUE`.

```r
# Define gene sets (using Entrez IDs or Symbols matching your data)
gene_sets <- list(
  up = c("GENE1", "GENE2"),
  down = c("GENE3", "GENE4")
)

# Calculate enrichment scores
# method can be "gsva" (default) or "ssgsea"
es <- gsva(data_matrix, 
           gene_sets, 
           is.gset.list.up.down = TRUE, 
           parallel.sz = 1)$es.obs
```

## Tips for Analysis
- **Input Values**: While developed for microarrays, `oppar` works effectively on RPKM/TPM values from RNA-seq.
- **Gene Set Testing**: After identifying outlier genes with `getSubtypeProbes`, it is common practice to use `limma::mroast` or `limma::camera` to find enriched GO terms or pathways within those specific outliers.
- **Visualization**: Use `hist()` or `density()` on GSVA enrichment scores to visualize the separation between control and condition groups.

## Reference documentation
- [OPPAR: Outlier Profile and Pathway Analysis in R](./references/oppar.md)