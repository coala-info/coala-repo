---
name: bioconductor-slqpcr
description: This package analyzes real-time quantitative PCR data to identify stable reference genes and perform normalization using geometric averaging. Use when user asks to select stable housekeeping genes using the Vandesompele method, calculate gene stability measures, or normalize qPCR expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/SLqPCR.html
---


# bioconductor-slqpcr

name: bioconductor-slqpcr
description: Analysis of real-time quantitative PCR (qPCR) data, specifically for selecting stable reference (housekeeping) genes using the Vandesompele method and performing normalization via geometric averaging. Use this skill when analyzing qPCR expression data to identify the most reliable internal controls or to normalize target gene expression.

# bioconductor-slqpcr

## Overview

The `SLqPCR` package provides tools for the statistical analysis of real-time quantitative RT-PCR data. Its primary utility lies in identifying the most stable reference genes from a set of candidates (based on the GeNorm/Vandesompele method) and normalizing expression data using the geometric mean of multiple housekeeping genes.

## Core Workflows

### 1. Data Preparation
The package expects data in a data frame where rows are observations (samples) and columns are genes (housekeeping candidates and/or target genes). Values are typically Cq/Ct values or relative quantities.

```r
library(SLqPCR)
# Example data: vandesompele (85 obs. of 10 housekeeping genes)
data(vandesompele)
```

### 2. Selecting Stable Reference Genes
The `selectHKgenes` function implements the Vandesompele et al. (2002) algorithm. It rank-orders genes by their stability measure $M$ (lower is more stable) by stepwise exclusion of the least stable gene.

```r
# Identify stable genes for a specific subset (e.g., Bone Marrow samples)
# minNrHK: minimum number of housekeeping genes to reach (usually 2)
res <- selectHKgenes(vandesompele[1:9, ], 
                     method = "Vandesompele", 
                     geneSymbol = names(vandesompele), 
                     minNrHK = 2, 
                     trace = TRUE)

# Access results
res$ranking # Gene names in order of stability
res$meanM   # Average expression stability M at each step
res$variation # Pairwise variation (V) to determine optimal number of genes
```

**Interpretation Tip:** A pairwise variation ($V$) value below 0.15 typically indicates that the inclusion of an additional housekeeping gene is not required for reliable normalization.

### 3. Calculating Relative Quantities
Before normalization, raw Ct values are often converted to relative quantities using the efficiency ($E$) of the PCR.

```r
# E = 2 assumes 100% efficiency
rel_quant <- apply(raw_ct_data, 2, relQuantPCR, E = 2)
```

### 4. Normalization by Geometric Averaging
Once the most stable housekeeping (HK) genes are identified, use `normPCR` to normalize the dataset. This function calculates the geometric mean of the specified HK genes and uses it as a normalization factor.

```r
# Normalize using columns 3 and 4 as reference genes
# Returns normalized expression values
normalized_data <- normPCR(SLqPCRdata, HKgenes = c(3, 4))
```

### 5. Gene Stability Measure (M)
To calculate the stability measure $M$ for a specific set of genes without the stepwise selection process:

```r
# relData should contain relative quantities of candidate genes
m_values <- geneStabM(relData[, c("HK1", "HK2")])
```

## Reference documentation

- [SLqPCR](./references/SLqPCR.md)