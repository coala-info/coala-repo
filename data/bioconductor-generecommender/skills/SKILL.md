---
name: bioconductor-generecommender
description: This tool identifies coexpressed genes in microarray data by ranking them based on their correlation with a specific set of query genes. Use when user asks to rank genes by functional similarity, find genes coexpressed with a query set, or identify genes related to a specific biological process in datasets with missing values.
homepage: https://bioconductor.org/packages/release/bioc/html/geneRecommender.html
---


# bioconductor-generecommender

name: bioconductor-generecommender
description: Identify coexpressed genes in microarray data using the Gene Recommender algorithm. Use this skill when a user needs to rank genes based on their correlation with a specific set of query genes (genes known to be involved in a process of interest), especially when dealing with datasets containing missing values.

# bioconductor-generecommender

## Overview

The `geneRecommender` package implements an algorithm to find genes that are functionally related to a user-defined query set. It ranks genes by how strongly they correlate with the query genes across a subset of experiments where the query genes themselves show similar expression patterns. This targeted approach is more robust than global correlation measures, particularly in large datasets with missing data.

## Main Workflow

The typical workflow involves three main steps: normalization, query execution, and optional validation.

### 1. Data Normalization
Before running the recommender, data must be normalized so that expression values for each gene are distributed uniformly between -1 and 1.

```r
library(geneRecommender)
# Assuming 'exp_data' is a matrix or ExpressionSet
normalized.data <- gr.normalize(exp_data)
```

*Tip: To achieve a standard normal distribution instead of a uniform one, you can transform the output:*
```r
normal.normalized.data <- qnorm((normalized.data + 1) / 2)
```

### 2. Running the Recommender
Use `gr.main` to identify coexpressed genes. You must provide the normalized data and a character vector of query gene IDs.

```r
my.query <- c("GeneID1", "GeneID2", "GeneID3")
result <- gr.main(normalized.data, my.query, ngenes = 20)

# View the ranked list
print(result$main.result)
```

### 3. Cross-Validation
To evaluate how well the query genes work together, use `gr.cv`. This performs leave-one-out cross-validation.

```r
cv.ranks <- gr.cv(normalized.data, my.query)
# Small values indicate the gene is well-supported by the rest of the query.
# Large values suggest a gene might not belong in the query set.
```

## Advanced Options

### Custom Scoring Functions
By default, the algorithm uses the `median` to determine the number of experiments to include. You can provide a custom function to the `fun` argument in `gr.main`.

```r
# Example: Using a square root sum scoring function
my.fun <- function(input.vector) { sum(input.vector^(1/2), na.rm = TRUE) }
res <- gr.main(normalized.data, my.query, ngenes = 10, fun = my.fun)

# Example: To include ALL experiments (constant function)
res_all <- gr.main(normalized.data, my.query, ngenes = 10, fun = function(x) { 1 })
```

### Detailed Output
Set `extra = TRUE` in `gr.main` to retrieve diagnostic information:
- `fifty.percent.recall`: Number of genes found at 50% recall.
- `experiments.included`: Names of experiments used in the calculation.
- `z.g.i`: Statistical significance measures for each gene.
- `contribution`: A matrix showing how much each experiment contributed to each gene's rank.

```r
detailed.res <- gr.main(normalized.data, my.query, extra = TRUE)
```

## Reference documentation

- [Using the geneRecommender Package](./references/geneRecommender.md)