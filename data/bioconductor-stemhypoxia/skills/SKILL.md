---
name: bioconductor-stemhypoxia
description: This package provides access to the Prado-Lopez et al. (2010) gene expression dataset for studying human embryonic stem cell differentiation under varying oxygen levels. Use when user asks to load the stemHypoxia microarray data, analyze gene expression changes across normoxic and hypoxic conditions, or explore time-series data for hESC differentiation.
homepage: https://bioconductor.org/packages/release/data/experiment/html/stemHypoxia.html
---


# bioconductor-stemhypoxia

name: bioconductor-stemhypoxia
description: Access and analyze the Prado-Lopez et al. (2010) gene expression dataset regarding human embryonic stem cell (hESC) differentiation under hypoxic conditions. Use this skill when a user needs to load, explore, or analyze microarray data (Agilent 4x44K) comparing normoxia (21% O2) vs. hypoxia (1% and 5% O2) across multiple time points (0 to 15 days).

## Overview

The `stemHypoxia` package is a Bioconductor data experiment package. It provides a processed microarray dataset (RMA normalized) from a study investigating how oxygen levels modulate the differentiation of hESCs into functional endothelium. The data is particularly useful for studying angio- and vasculogenesis, pluripotency marker downregulation, and time-series gene expression under varying oxygen concentrations.

## Loading the Data

The package contains two primary objects: `M` (the expression matrix) and `design` (the experimental metadata). Both are loaded simultaneously using the `data()` function.

```r
# Install if necessary
# BiocManager::install("stemHypoxia")

# Load the package and data
library(stemHypoxia)
data(stemHypoxia)
```

## Data Structures

### Experimental Design (`design`)
The `design` object is a data frame describing the 22 samples in the study.
- **time**: Numeric (0, 0.5, 1, 5, 10, or 15 days).
- **oxygen**: Numeric oxygen percentage (1, 5, or 21%).
- **samplename**: Unique identifier for each chip/treatment.

```r
# Explore the design
head(design)
summary(design)
table(design$time, design$oxygen)
```

### Expression Matrix (`M`)
The `M` object is a data frame containing 40,736 features (Agilent probes).
- **Column 1 (Gene_ID)**: Agilent Oligo ID.
- **Column 2 (GeneName)**: Gene Symbol.
- **Remaining Columns**: RMA-normalized expression values corresponding to the samples in `design`.

```r
# Explore the expression matrix
dim(M)
# View first few genes and their symbols
M[1:5, 1:5]
```

## Typical Workflow

### 1. Filtering or Selecting Genes
You can subset the matrix `M` based on specific gene symbols of interest (e.g., pluripotency markers like POU5F1/OCT4 or vascular markers like VEGFA).

```r
# Find VEGFA expression
vegfa_data <- M[M$GeneName == "VEGFA", ]
```

### 2. Visualizing Expression Profiles
To visualize the data, you often need to map the columns of `M` to the rows of `design`. Note that the first two columns of `M` are identifiers, so expression data starts at index 3.

```r
# Basic boxplot of all samples
# Exclude ID and Symbol columns
boxplot(M[, -(1:2)], las=2, main="RMA Normalized Expression", cex.axis=0.7)

# Plotting a specific gene over time
gene_idx <- 1 # Example: first gene
gene_values <- as.numeric(M[gene_idx, -(1:2)])
plot(design$time, gene_values, col=as.factor(design$oxygen), 
     pch=19, xlab="Days", ylab="Expression", main=M[gene_idx, "GeneName"])
legend("topright", legend=levels(as.factor(design$oxygen)), 
       col=1:3, pch=19, title="Oxygen %")
```

### 3. Integration with Differential Expression Tools
While this package provides the data, users typically pipe these objects into `limma` or `DESeq2` (after converting back to counts if necessary, though this is RMA data) for formal differential expression analysis between oxygen levels.

## Tips
- The first two samples in the `design` object are often treated as baseline control conditions.
- Because the data is already RMA-normalized, it is on a log2 scale.
- Use `M$GeneName` to filter for specific biological pathways related to hypoxia or stem cell potency.

## Reference documentation
- [stemHypoxia Reference Manual](./references/reference_manual.md)