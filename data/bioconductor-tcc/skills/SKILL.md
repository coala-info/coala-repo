---
name: bioconductor-tcc
description: bioconductor-tcc performs robust differential expression analysis of RNA-seq count data using the DEGES normalization framework to eliminate bias from differentially expressed genes. Use when user asks to normalize RNA-seq data using DEGES, identify differentially expressed genes with edgeR or DESeq2 wrappers, analyze paired or multi-group samples, or simulate biased read count data.
homepage: https://bioconductor.org/packages/release/bioc/html/TCC.html
---

# bioconductor-tcc

## Overview

TCC (Tag Count Comparison) is a Bioconductor package designed for robust differential expression (DE) analysis of RNA-seq count data. Its core strength is the **DEGES** (Differential Expression Gene Elimination Strategy) normalization framework. Unlike standard methods that assume balanced DE, TCC iteratively identifies and removes potential DEGs before calculating final normalization factors, preventing biased DE from skewing the results. It acts as a unified wrapper for popular tools like `edgeR` and `DESeq2`.

## Core Workflow

### 1. Object Construction
TCC uses a specialized `TCC` class object. You need a raw count matrix (integers) and a group vector.

```R
library(TCC)
data(hypoData) # Example data: 1000 genes, 2 groups (3 replicates each)
group <- c(1, 1, 1, 2, 2, 2)
tcc <- new("TCC", hypoData, group)
```

### 2. Normalization (DEGES)
The `calcNormFactors` function implements the multi-step normalization. The recommended default is iterative DEGES/edgeR (`iDEGES/edgeR`).

```R
# Recommended for data with replicates
tcc <- calcNormFactors(tcc, 
                       norm.method = "tmm", 
                       test.method = "edger", 
                       iteration = 3, 
                       FDR = 0.1, 
                       floorPDEG = 0.05)

# Retrieve normalization factors
factors <- tcc$norm.factors
```

### 3. Differential Expression Analysis
After normalization, use `estimateDE` to identify DEGs.

```R
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1)

# Retrieve results as a data frame
result <- getResult(tcc, sort = TRUE)
# Columns: gene_id, a.value (mean), m.value (logFC), p.value, q.value, rank, estimatedDEG
```

## Specialized Workflows

### Paired Samples
For paired designs (e.g., Tumor vs. Normal from the same patient), provide a `pair` vector in a data frame.

```R
pair <- c(1, 2, 3, 1, 2, 3)
cl <- data.frame(group = group, pair = pair)
tcc <- new("TCC", hypoData, cl)

tcc <- calcNormFactors(tcc, norm.method = "tmm", test.method = "edger", 
                       iteration = 1, paired = TRUE)
tcc <- estimateDE(tcc, test.method = "edger", FDR = 0.1, paired = TRUE)
```

### Multi-group Analysis
For more than two groups, define a design matrix and coefficients.

```R
group_mg <- c(1, 1, 1, 2, 2, 2, 3, 3, 3)
tcc <- new("TCC", hypoData_mg, group_mg)

# TCC can automatically generate design/coef if not provided
tcc <- calcNormFactors(tcc, iteration = 1)
tcc <- estimateDE(tcc, test.method = "edger")
```

### Data Simulation
TCC includes a powerful simulator to test DE methods under biased conditions.

```R
tcc_sim <- simulateReadCounts(Ngene = 1000, 
                              PDEG = 0.2, 
                              DEG.assign = c(0.9, 0.1), # 90% up in G1 (Biased)
                              DEG.foldchange = c(4, 4), 
                              replicates = c(3, 3))
```

## Visualization and Utilities

*   **M-A Plot**: `plot(tcc)` highlights identified DEGs in magenta.
*   **Normalized Counts**: `getNormalizedData(tcc)` retrieves the scaled count matrix.
*   **Filtering**: `filterLowCountGenes(tcc)` removes genes with zero counts across all samples.
*   **AUC Calculation**: `calcAUCValue(tcc)` evaluates performance if using simulated data.

## Reference documentation
- [TCC: Differential expression analysis for tag count data](./references/TCC.md)