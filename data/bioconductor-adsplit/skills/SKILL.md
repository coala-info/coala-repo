---
name: bioconductor-adsplit
description: This tool performs annotation-driven unsupervised clustering of microarray gene expression data using functional gene sets like GO terms or KEGG pathways. Use when user asks to perform unsupervised clustering of samples based on biological annotations, identify patient subgroups using specific gene sets, or calculate DLD scores and empirical p-values for gene set splits.
homepage: https://bioconductor.org/packages/release/bioc/html/adSplit.html
---


# bioconductor-adsplit

name: bioconductor-adsplit
description: Annotation-driven class discovery for microarray gene expression data. Use this skill to perform unsupervised clustering of samples (e.g., patients) based on specific biological gene sets (GO terms or KEGG pathways). It is particularly useful for identifying clinically relevant patient subgroups that are characterized by specific biological processes, providing both a clustering and a functional rationale.

## Overview

The `adSplit` package implements a method for "Annotation-Driven Splits." Unlike standard clustering which uses all genes, `adSplit` uses functional annotations to define candidate gene sets. For each set, it performs a 2-means clustering (initialized via divisive hierarchical clustering) and calculates a Diagonal Linear Discriminant (DLD) score to assess clustering strength. It also supports empirical p-value calculation via random gene set sampling to determine the statistical significance of the observed splits.

## Core Workflow

### 1. Data Preparation
The package works with `ExpressionSet` objects or expression matrices. It requires Bioconductor annotation metadata packages (e.g., `hu6800.db`) to map probes to GO/KEGG terms.

```r
library(adSplit)
library(golubEsets)
data(Golub_Merge)

# Extract expression matrix if needed
e <- exprs(Golub_Merge)
```

### 2. Basic Clustering (diana2means)
To perform a split on a specific matrix without annotation logic, use `diana2means`. This function uses a robust initialization (centroids from `diana`) for `k-means`.

```r
# Perform split on the 10% most variable genes
vars <- apply(e, 1, var)
e_sub <- e[vars > quantile(vars, 0.9), ]

# Get DLD score only
score <- diana2means(e_sub)

# Get split object (assignments and score)
result <- diana2means(e_sub, return.cut = TRUE)
print(result$cut)   # Cluster assignments (0 and 1)
print(result$score) # DLD score
```

### 3. Annotation-Driven Splits (adSplit)
The primary function `adSplit` automates the process of fetching genes for a term and performing the clustering.

```r
# Split based on a specific GO term
# Arguments: ExpressionSet, Term ID, Chip name
result <- adSplit(Golub_Merge, "GO:0006915", "hu6800")

# Split based on all KEGG pathways
kegg_splits <- adSplit(Golub_Merge, "KEGG", "hu6800")

# Filter by max probes to avoid overly generic terms
generic_split <- adSplit(Golub_Merge, "GO:0007165", "hu6800", max.probes=7000)
```

### 4. Significance Testing
To compute empirical p-values, set the `B` argument (number of permutations). This compares the observed DLD score against scores from `B` random gene sets of the same size.

```r
# Compute splits with 1000 permutations for p-values
significant_splits <- adSplit(Golub_Merge, "KEGG", "hu6800", B=1000)

# Access results
significant_splits$pvalue   # Empirical p-values
significant_splits$qvalues  # FDR corrected (Benjamini-Hochberg)
```

## Visualization

The package provides specific methods for `splitSet` objects:

```r
# Histogram of p-values with FDR (q-value) curve
hist(significant_splits)

# Heatmap of splits
# filter.fdr: only show splits meeting a specific False Discovery Rate threshold
image(significant_splits, filter.fdr = 0.3)
```

## Key Parameters
- `max.probes`: Maximum number of genes allowed for a term (default is often too restrictive for generic terms).
- `min.probes`: Minimum number of genes required to attempt a split (default is 20).
- `ignore.genes`: Number of top-scoring genes to ignore when calculating DLD score (prevents single-gene dominance).
- `B`: Number of random draws for empirical p-value calculation.

## Reference documentation

- [Annotation-Driven Class Discovery: User's Guide to the Bioconductor package adSplit](./references/tr_2005_02.md)