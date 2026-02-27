---
name: bioconductor-scnorm
description: SCnorm performs robust normalization of single-cell RNA-seq data by addressing non-linear relationships between gene expression and sequencing depth. Use when user asks to normalize scRNA-seq counts, evaluate count-depth relationships via slope distributions, or handle multiple experimental conditions and within-sample biases.
homepage: https://bioconductor.org/packages/release/bioc/html/SCnorm.html
---


# bioconductor-scnorm

name: bioconductor-scnorm
description: Robust normalization of single-cell RNA-seq (scRNA-seq) data. Use this skill when you need to normalize scRNA-seq counts to account for non-linear count-depth relationships, evaluate normalization quality via slope distributions, or handle multiple experimental conditions and within-sample biases (like GC content).

# bioconductor-scnorm

## Overview
SCnorm is a normalization approach for single-cell RNA-seq (scRNA-seq) data that addresses the fact that sequencing depth does not affect all gene counts equally. It groups genes based on their count-depth relationship and applies quantile regression within each group to estimate scaling factors. This method is particularly effective when the relationship between expression and sequencing depth varies across genes, making global scaling factors (like CPM or TMM) inadequate.

## Core Workflow

### 1. Data Preparation
SCnorm accepts a `matrix` (Genes x Cells) or a `SingleCellExperiment` object. Gene names must be in `rownames`.

```r
library(SCnorm)
library(SingleCellExperiment)

# Example with a matrix
# Data: G-by-S matrix of raw counts
# Conditions: Vector indicating group/condition for each cell
sce <- SingleCellExperiment(assays = list(counts = ExampleSimSCData))
conditions <- rep(c(1), each = 90)
```

### 2. Evaluate Count-Depth Relationship
Before normalizing, check if SCnorm is necessary. If slopes are not similar across expression levels, proceed with SCnorm.

```r
# Generates a plot of slope distributions for 10 expression groups
countDeptEst <- plotCountDepth(Data = sce, 
                               Conditions = conditions, 
                               FilterCellProportion = 0.1, 
                               NCores = 3)
```

### 3. Run Normalization
SCnorm automatically increases the number of groups (K) until the count-depth relationship is sufficiently removed (slopes near 0).

```r
DataNorm <- SCnorm(Data = sce,
                   Conditions = conditions,
                   PrintProgressPlots = TRUE,
                   FilterCellNum = 10, 
                   NCores = 3, 
                   reportSF = TRUE)

# Access normalized counts
normCounts <- SingleCellExperiment::normcounts(DataNorm)

# Access other results
scaleFactors <- results(DataNorm, type = "ScaleFactors")
filteredGenes <- results(DataNorm, type = "GenesFilteredOut")
```

## Advanced Usage

### Multiple Conditions
When multiple conditions exist, SCnorm normalizes them independently and then scales between them.
- Use `useZerosToScale = TRUE` if your downstream tool (e.g., DESeq2, edgeR) includes zeros in its model.
- Use `useZerosToScale = FALSE` (default) for tools like MAST.

```r
DataNorm <- SCnorm(Data = multiCondMatrix,
                   Conditions = multiCondVector,
                   useZerosToScale = TRUE,
                   NCores = 3)
```

### UMI and Sparse Data
For sparse data or data with many tied counts (common in UMI datasets):
- Set `ditherCounts = TRUE` to improve count-depth relationship estimation.
- If convergence fails, increase `FilterExpression` (e.g., 1 or 2) to exclude very low expressors from the scaling model.

```r
DataNorm <- SCnorm(Data = umiData, 
                   Conditions = conditions,
                   ditherCounts = TRUE,
                   FilterExpression = 1)
```

### Within-Sample Normalization
To correct for gene-specific features like GC-content or gene length before between-sample normalization:

```r
# 1. Visualize bias
withinFactorMatrix <- plotWithinFactor(Data = sce, withinSample = geneGCContent)

# 2. Run SCnorm with correction
DataNorm <- SCnorm(Data = sce, 
                   Conditions = conditions,
                   withinSample = geneGCContent)
```

### Spike-ins
If high-quality ERCC spike-ins are available, they can be used for the between-condition scaling step. SCnorm expects spike-ins to be named with the "ERCC-" prefix.

```r
DataNorm <- SCnorm(Data = sce_with_spikes, 
                   Conditions = conditions,
                   useSpikes = TRUE)
```

## Troubleshooting and Tips
- **Convergence Issues**: If SCnorm fails to converge (K > 25), it is often due to high sparsity. Increase `FilterExpression` to remove genes with very low non-zero medians.
- **Speed**: For large datasets, use the `NCores` parameter for parallel processing. Alternatively, cluster cells into similar groups and use those as `Conditions`.
- **Validation**: Always run `plotCountDepth()` on the normalized data. Successful normalization should result in slope modes near 0 for all expression groups.

## Reference documentation
- [SCnorm](./references/SCnorm.md)