---
name: r-smvar
description: This tool performs statistical analysis of gene expression data using a structural model for variances to detect differentially expressed genes. Use when user asks to identify differentially expressed genes, stabilize variance estimates in small sample sizes, or perform paired and unpaired transcriptomics data analysis.
homepage: https://cran.r-project.org/web/packages/smvar/index.html
---


# r-smvar

name: r-smvar
description: Statistical analysis of gene expression data using the Structural Model for Variances (SMVar). Use this skill to detect differentially expressed genes in transcriptomics datasets, especially when dealing with small sample sizes where stable variance estimation is critical.

# r-smvar

## Overview
The `smvar` package implements a structural model for variances to detect differentially expressed genes. By assuming a structural model for the variances, it provides a more powerful alternative to the standard t-test or moderated t-tests when the number of replicates is small. It accounts for the relationship between the variance and the mean expression level to stabilize variance estimates.

## Installation
To install the package from CRAN:
```R
install.packages("SMVar")
```

## Main Functions and Workflows

### 1. Unpaired Data Analysis
Use `SMVar.unpa` when comparing two independent groups (e.g., Control vs. Treatment).

```R
library(SMVar)
# geneData: matrix or data frame with genes in rows and samples in columns
# cond: vector indicating the group for each column (e.g., c(1,1,2,2))
results <- SMVar.unpa(geneData, cond, logged = TRUE)

# The output contains:
# - deg: indices of differentially expressed genes
# - p.value: raw p-values
# - adj.pvalue: p-values adjusted for multiple testing
```

### 2. Paired Data Analysis
Use `SMVar.pa` for paired experimental designs (e.g., Before vs. After treatment on the same subjects).

```R
# cond: vector of condition labels
# block: vector indicating the pairs/blocks
results <- SMVar.pa(geneData, cond, block, logged = TRUE)
```

### 3. Gaussian Structural Model
The `SMVar.gauss` function is the core engine that fits the structural model assuming a Gaussian distribution for the log-variances.

```R
# Often called internally by .pa or .unpa, but can be used directly
# for custom variance modeling.
res <- SMVar.gauss(geneData, cond, logged = TRUE)
```

## Tips for Usage
- **Data Preprocessing**: Ensure data is normalized before running SMVar. The package expects log-transformed data by default (or set `logged = FALSE` if providing raw counts, though log-transformed data is preferred for the structural model assumptions).
- **Filtering**: It is often beneficial to filter out genes with very low expression or zero variance across all samples before running the analysis to improve the stability of the structural model fit.
- **Multiple Testing**: The package provides adjusted p-values. Always check the `adj.pvalue` column to control the False Discovery Rate (FDR).
- **Missing Values**: Handle missing values (NAs) before passing the matrix to SMVar functions, as the structural model estimation requires complete observations for the variance-mean relationship.

## Reference documentation
- [SMVar Home Page](./references/home_page.md)