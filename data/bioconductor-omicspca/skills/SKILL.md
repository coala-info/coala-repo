---
name: bioconductor-omicspca
description: This tool integrates and analyzes heterogeneous omics datasets using PCA-based frameworks to identify sources of variation across biological conditions. Use when user asks to integrate multi-modal omics data, identify discriminatory factors across cell lines, perform exploratory data analysis on genomic features, or cluster samples based on consolidated epigenetic states.
homepage: https://bioconductor.org/packages/release/bioc/html/OMICsPCA.html
---

# bioconductor-omicspca

name: bioconductor-omicspca
description: Quantitative integration and analysis of multiple heterogeneous omics assays (e.g., ChIP-seq, RNA-seq) from different samples or sources using PCA-based frameworks. Use this skill when you need to identify sources of variation across cell lines/conditions, integrate multi-modal data, perform exploratory data analysis on genomic features (TSSs, genes), or cluster individuals based on consolidated epigenetic states.

# bioconductor-omicspca

## Overview
`OMICsPCA` is a Bioconductor package designed for the unsupervised integration of heterogeneous omics datasets. It addresses the challenge of integrating data where samples (e.g., cell lines) may not be perfectly matched across different modalities. It uses Principal Component Analysis (PCA) to reduce dimensionality, identify discriminatory factors, and cluster genomic features (like TSSs or exons) based on their integrated multi-omics profiles.

## Core Workflow

### 1. Data Preparation
The package works with `MultiAssayExperiment` objects. You can prepare data frames from BED files using `prepare_dataset()`.

```r
library(OMICsPCA)
library(MultiAssayExperiment)

# Aggregate sample files (BED) for a specific assay
assay_df <- prepare_dataset(
  factdir = "path/to/assay_files/", 
  annofile = "annotation.bed", 
  annolist = "feature_list.txt"
)

# Create MultiAssayExperiment
mae <- MultiAssayExperiment(experiments = list("H3k9ac" = assay_df))
```

### 2. Grouping and EDA
Divide features into groups (e.g., based on expression levels) to compare distributions.

```r
# Create groups based on a specific assay (e.g., CAGE expression)
groupinfo <- create_group(
  name = mae, 
  group_names = c("High", "Low", "None"),
  grouping_factor = "CAGE",
  comparison = c(">=", "%in%", "=="),
  condition = c("25", "1:5", "0")
)

# Visualize distribution of factors across groups
descriptor(name = mae, factors = c("H2az", "H3k9ac"), groups = c("High", "Low"), choice = 1, groupinfo = groupinfo)

# Check correlations between cell lines within an assay
chart_correlation(name = mae, Assay = "H2az", groups = "High", choice = "all", groupinfo = groupinfo)
```

### 3. Integrating Variables (Cell Lines/Conditions)
Use PCA to integrate multiple samples of the same assay.

```r
# Integrate cell lines for specific assays
PCAlist <- integrate_variables(
  Assays = c("H2az", "H3k9ac"), 
  name = mae, 
  groups = c("High", "Low"), 
  groupinfo = groupinfo
)

# Analyze variance and loadings
analyse_variables(name = PCAlist, Assay = "H2az", choice = 1) # Variance barplot
analyse_variables(name = PCAlist, Assay = "H2az", choice = 2) # Variable loadings
```

### 4. Integrating Multiple Modalities
Combine different types of assays into a single integrated PCA space.

```r
# Integrate multiple assays, optionally excluding outlier cell lines
# exclude: list where each element corresponds to an assay's column indices to drop
int_PCA <- integrate_pca(
  Assays = c("H2az", "H3k9ac"),
  name = mae,
  groupinfo = groupinfo,
  mergetype = 2, # 1 for specific groups, 2 for all individuals
  exclude = list(0, c(1)) 
)

# Density analysis to find discriminatory patterns
plot_integrated_density(name = int_PCA$int_PCA, PC = 1, groups = c("High", "Low"), groupinfo = groupinfo)
```

### 5. Cluster Analysis
Identify similar genomic features based on the integrated omics state.

```r
# Extract data for clustering
clust_data <- extract(
  name = int_PCA$int_PCA, 
  PC = 1:4, 
  groups = c("High", "Low"), 
  integrated = TRUE, 
  groupinfo = groupinfo
)

# Determine optimal cluster number
clusterstats <- cluster_parameters(name = clust_data, n = 2:6, comparisonAlgorithm = "NbClust")

# Perform clustering (e.g., kmeans or density-based)
res <- cluster(name = clust_data, n = 2, choice = "kmeans")
print(res$plot)
```

## Tips for Success
- **Memory Management**: Functions like `cluster_parameters()` are computationally expensive. Use the `rand` argument in `extract()` to subset rows for parameter testing.
- **Choice Arguments**: Many functions (`analyse_variables`, `cluster`, `descriptor`) use a `choice` integer or string to toggle between plot types and table outputs.
- **Group Info**: Ensure the `groupinfo` object created by `create_group()` is passed to downstream analysis functions to maintain consistent feature labeling.
- **Outlier Detection**: Use `analyse_variables()` choice 3 (correlation matrix) or choice 4 (squared loadings) to identify cell lines that deviate significantly from the primary variance components before final integration.

## Reference documentation
- [OMICsPCA Vignette](./references/vignettes.md)