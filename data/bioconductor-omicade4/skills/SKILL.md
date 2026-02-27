---
name: bioconductor-omicade4
description: This tool performs Multiple Co-inertia Analysis (MCIA) to integrate and visualize multiple omics datasets measured on the same samples. Use when user asks to perform multi-omics data integration, identify covariant patterns across different data modalities, visualize sample similarity across platforms, or select variables that contribute most to the variance in a multi-omics study.
homepage: https://bioconductor.org/packages/release/bioc/html/omicade4.html
---


# bioconductor-omicade4

name: bioconductor-omicade4
description: Perform Multiple Co-inertia Analysis (MCIA) for integrating and visualizing multiple omics datasets (e.g., transcriptomics, proteomics, metabolomics) measured on the same samples. Use this skill when you need to identify covariant patterns across different data modalities, visualize sample similarity across platforms, or select variables (genes/proteins) that contribute most to the variance in a multi-omics study.

# bioconductor-omicade4

## Overview

The `omicade4` package is designed for the multivariate analysis of multiple "omics" datasets. It extends the methods available in `ade4` and `made4` to support more than two tables. Its primary tool is **Multiple Co-inertia Analysis (MCIA)**, which projects different datasets into a common space to visualize similarities between samples and identify variables that are highly associated with specific sample groups across all platforms.

## Core Workflow

### 1. Data Preparation
Datasets must be organized as a `list` of data frames or matrices. 
- **Requirement**: Columns (samples) must be identical and in the same order across all datasets.
- **Flexibility**: Rows (variables/genes) can differ in identity and number between datasets.

```r
# Check if sample names are identical across all datasets in the list
all(apply((x <- sapply(my_data_list, colnames))[,-1], 2, function(y) identical(y, x[,1])))
```

### 2. Performing MCIA
The `mcia` function is the primary entry point. It performs a transformation (usually PCA) on each dataset and then links them.

```r
library(omicade4)
# cia.nf: number of kept axes (default is 2)
mcoin <- mcia(my_data_list, cia.nf = 10)
```

### 3. Visualization
The `plot` method for `mcia` objects provides a four-panel summary:
1.  **Sample Space**: Shows how samples from different platforms cluster.
2.  **Variable Space**: Shows which variables (genes/proteins) are associated with which samples.
3.  **Eigenvalues**: Shows the variance explained by each axis.
4.  **Pseudo-eigenvalues**: Shows the contribution of each dataset to each axis.

```r
# phenovec: a factor defining sample groups (e.g., cancer type)
plot(mcoin, axes = 1:2, phenovec = my_phenotypes, sample.lab = FALSE, df.color = 1:4)
```

### 4. Variable Selection
To identify specific variables that drive the separation on the axes, use `selectVar`.

```r
# Select variables with high loading on the first axis
selected_vars <- selectVar(mcoin, a1.lim = c(2, Inf))

# Visualize specific genes of interest in the co-inertia space
plotVar(mcoin, var = c("GENE1", "GENE2"), var.lab = TRUE)
```

## Key Functions

- `mcia()`: Performs Multiple Co-inertia Analysis.
- `plot.mcia()`: Generates the 4-panel summary plot.
- `selectVar()`: Extracts variables based on their coordinates in the common space.
- `plotVar()`: Plots specific variables of interest to see their distribution across platforms.

## Tips for Success
- **Normalization**: While `mcia` handles some internal scaling, ensure your data is pre-processed (e.g., log-transformed) appropriately for the biological question.
- **Axis Selection**: Check the eigenvalue barplot (bottom-left of the summary plot). If the third axis has a high eigenvalue, visualize it using `axes = c(1, 3)` or `axes = c(2, 3)`.
- **Interpretation**: In the sample space, shorter edges linking the same sample across platforms indicate higher correlation/consistency between those datasets.

## Reference documentation

- [Multiple Co-inertia Analysis of Multiple OMICS Data using omicade4](./references/omicade4.md)