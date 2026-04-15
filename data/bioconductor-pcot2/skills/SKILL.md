---
name: bioconductor-pcot2
description: This package implements a permutation-based method for detecting coordinated changes in gene set activity by accounting for inter-gene correlations. Use when user asks to test for differential expression in gene sets, perform dimensionality reduction on pathways, or visualize correlation structures within functional gene groups.
homepage: https://bioconductor.org/packages/3.5/bioc/html/pcot2.html
---

# bioconductor-pcot2

## Overview

The `pcot2` package provides a two-stage permutation-based approach for testing changes in activity in pre-specified gene sets. Unlike single-gene analyses, PCOT2 utilizes inter-gene correlation to detect small but coordinated changes in expression among functionally related genes. It includes tools for dimensionality reduction via principal coordinates, statistical testing via Hotelling's T2, and visualization of gene-set correlations.

## Core Workflow

### 1. Data Preparation
PCOT2 requires three primary inputs:
- **Expression Data**: A matrix of normalized expression values (rows = genes, columns = samples).
- **Class Labels**: A vector indicating the experimental conditions (e.g., 0 for control, 1 for treatment).
- **Indicator Matrix**: A binary matrix (1/0) where rows are genes and columns are gene sets (e.g., KEGG pathways).

```r
library(pcot2)

# Example: Creating an indicator matrix from a list of gene sets
# 'gene_list' is a list where each element contains gene identifiers for a pathway
imat <- getImat(expression_matrix, gene_list, ms = 10) # ms = minimum gene set size
```

### 2. Running PCOT2
The `pcot2` function performs the main analysis. It reduces dimensionality and calculates the T2 statistic.

```r
# Run PCOT2 with 1000 permutations
results <- pcot2(expression_matrix, class_labels, imat, iter = 1000)

# View significant pathways
results$res.sig

# View all results
results$res.all
```

**Key Parameters:**
- `ncomp`: Number of principal components for dimensionality reduction (default = 2).
- `var.equal`: Logical; if FALSE, uses unpooled correlation estimates (default = TRUE).
- `permu`: Set to "ByRow" to permute genes instead of sample labels.
- `dist.method`: Distance metric for transformed groups (default = "euclidean").

### 3. Visualization
Use `corplot` or `corplot2` to visualize correlation structures within specific gene sets.

```r
# corplot uses pooled correlation; corplot2 uses unpooled
# 'selgene' is a vector of gene identifiers within the pathway of interest
corplot2(expression_matrix, selgene, class_labels, main = "Pathway Name")
```

### 4. Handling Multiple Probes
If the data contains multiple probe sets per gene, use `aveProbe` to collapse them to unique gene identifiers by taking the median.

```r
# Collapse probes to unique IDs
output <- aveProbe(x = expression_matrix, imat = imat, ids = gene_symbols)
new_data <- output$newx
new_imat <- output$newimat
```

## Tips for Analysis
- **Permutations**: For publication-quality results, use at least 1000 iterations. For quick testing, reduce `iter`.
- **Gene Locator**: In `corplot`, set `gene.locator = TRUE` to interactively identify highly correlated genes by clicking on the plot diagonal.
- **External P-values**: You can pass p-values from other packages (like `limma`) into the `inputP` argument of `corplot` to overlay per-gene significance on the correlation plot.

## Reference documentation
- [PCOT2: Principal Coordinates and Hotelling’s T2 for the analysis of microarray data](./references/pcot2.md)