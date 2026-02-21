---
name: bioconductor-gsri
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GSRI.html
---

# bioconductor-gsri

name: bioconductor-gsri
description: Use this skill to estimate the number and fraction of significantly regulated genes in gene sets using the Gene Set Regulation Index (GSRI). This is applicable for analyzing differential gene expression between groups (e.g., treatment vs. control) without requiring arbitrary p-value cut-offs. Use this skill when you need to rank gene sets by their regulatory effect, visualize p-value distributions, or incorporate gene-specific weights into enrichment analysis.

## Overview

The `GSRI` package provides a method to estimate the fraction of regulated genes ($r$) within a gene set. It works by analyzing the distribution of p-values, which are expected to be uniform under the null hypothesis and shifted toward zero when regulation occurs. The primary metric, the Gene Set Regulation Index ($\eta$), is the 5% quantile of the estimated number of differentially expressed genes (derived via bootstrapping), providing a conservative estimate that at least $\eta$ genes are regulated with 95% probability.

## Core Workflow

### 1. Data Preparation
The package typically works with `ExpressionSet` objects or expression matrices. You also need a factor defining the groups for comparison.

```r
library(GSRI)
library(Biobase)

# Example using provided sample data
data(sample.ExpressionSet)
eset <- sample.ExpressionSet
groups <- pData(eset)$type # Factor with groups like 'Case' and 'Control'
```

### 2. Basic GSRI Analysis
Use the `gsri()` function to perform the analysis. It can be applied to all genes in an object or specific gene sets.

```r
# Analysis for all genes in the ExpressionSet
res <- gsri(eset, groups)

# Analysis for a specific GeneSet object (requires GSEABase)
library(GSEABase)
gs <- GeneSet(eset, setName="myGeneSet")
res_gs <- gsri(eset, groups, gs)
```

### 3. Working with Multiple Gene Sets
To analyze multiple pathways or categories, use a `GeneSetCollection`.

```r
# Load gene sets (e.g., from a GMT file)
gmt <- getGmt(system.file("extdata", "c1c10.gmt", package="GSRI"))

# Run analysis on the collection
res_col <- gsri(eset, groups, gmt)

# Sort results by the number of regulated genes
res_sorted <- sortGsri(res_col, c("nRegGenes", "pRegGenes"))
summary(res_sorted)
```

### 4. Customizing the Statistical Test
By default, `gsri` uses a t-test (for 2 groups). You can use the provided `rowF` for multiple groups or define a custom function.

```r
# Using F-test for multiple groups
res_f <- gsri(eset, phenotypes$class, gsChr17, test=rowF)

# Custom test function structure:
# function(exprs, groups, id, index, testArgs)
```

### 5. Visualization
The `plot()` method visualizes the empirical cumulative distribution function (ECDF) of p-values and the linear fit used to estimate the regulated fraction.

```r
# Basic plot
plot(res_gs)

# Customized plot for a specific gene set in a collection
plot(res_col, index=1, ecdf=list(type="o"), reg=list(col="red"))
```

## Key Parameters for `gsri()`

- `nBoot`: Number of bootstrap samples (default 100). Increase for higher precision.
- `alpha`: Confidence level for the GSRI (default 0.05 for the 5% quantile).
- `grenander`: Logical; if `TRUE` (default), uses the Grenander estimator for the ECDF.
- `weight`: A numeric vector of weights for each gene, allowing integration of prior knowledge or certainty.

## Interpreting Results

The output table contains:
- `pRegGenes`: Estimated fraction of regulated genes.
- `pRegGenesSd`: Standard deviation of the fraction.
- `nRegGenes`: Estimated number of regulated genes.
- `GSRI(5%)`: The Gene Set Regulation Index (the conservative estimate).
- `nGenes`: Total number of genes in the set.

## Reference documentation

- [GSRI](./references/gsri.md)