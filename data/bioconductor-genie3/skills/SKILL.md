---
name: bioconductor-genie3
description: This tool infers directed gene regulatory networks from gene expression data using tree-based ensemble methods like Random Forest or Extra-Trees. Use when user asks to infer gene regulatory networks, identify regulatory links between transcription factors and target genes, or rank regulatory interactions based on expression matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/GENIE3.html
---

# bioconductor-genie3

name: bioconductor-genie3
description: Infer gene regulatory networks (GRN) from gene expression data using the GENIE3 (Gene Network Inference with Ensemble of trees) algorithm. Use this skill when you need to identify potential regulatory links between transcription factors and target genes, rank regulatory interactions, or process expression matrices to find directed links using Random Forest or Extra-Trees methods.

# bioconductor-genie3

## Overview
GENIE3 is a Bioconductor package used to infer directed gene regulatory networks from expression data. It decomposes the problem of predicting a network of $n$ genes into $n$ different regression problems. For each gene, it trains a tree-based ensemble (Random Forest or Extra-Trees) to predict its expression level based on the expression of other candidate regulators. The importance of a regulator in the ensemble is used as a weight for the regulatory link.

## Core Workflow

### 1. Data Preparation
The input must be a numeric matrix where rows are genes and columns are samples. Gene names must be in the row names.

```r
# Example: 20 genes, 10 samples
exprMatr <- matrix(runif(200), nrow=20)
rownames(exprMatr) <- paste0("Gene", 1:20)
colnames(exprMatr) <- paste0("Sample", 1:10)
```

### 2. Running GENIE3
The `GENIE3()` function returns a weight matrix where `weightMat[i,j]` is the weight of the link from gene $i$ to gene $j$.

```r
library(GENIE3)

# Default run (uses all genes as potential regulators)
set.seed(123) # Recommended for reproducibility
weightMat <- GENIE3(exprMatr)

# Restrict regulators (e.g., only known Transcription Factors)
regulators <- c("Gene2", "Gene4", "Gene7")
weightMat_sub <- GENIE3(exprMatr, regulators=regulators)
```

### 3. Advanced Parameters
- **treeMethod**: "RF" (Random Forest, default) or "ET" (Extra-Trees).
- **K**: Number of regulators randomly selected at each node. Options: "sqrt" (default), "all", or an integer.
- **nTrees**: Number of trees per ensemble (default 1000).
- **nCores**: Number of cores for parallel processing.

```r
# High-performance configuration
weightMat <- GENIE3(exprMatr, treeMethod="ET", K=7, nTrees=500, nCores=4)
```

### 4. Extracting Results
Use `getLinkList()` to convert the weight matrix into a ranked data frame of regulatory links.

```r
# Get all links ranked by weight
linkList <- getLinkList(weightMat)

# Get top 100 links
topLinks <- getLinkList(weightMat, reportMax=100)

# Get links above a specific weight threshold
significantLinks <- getLinkList(weightMat, threshold=0.1)
```

## Implementation Tips
- **Weight Interpretation**: Weights are relative importance scores and do not have a formal statistical p-value. They are used for ranking only.
- **Parallelization**: When using `nCores > 1`, `set.seed()` ensures reproducibility within that specific core count, but results may differ slightly from single-core runs.
- **Memory**: For very large datasets, restrict the `regulators` list to known TFs to reduce computation time and memory usage.
- **Normalization**: While GENIE3 does not require specific normalization, the input scale (e.g., log-transformation) will influence the tree splits and resulting weights.

## Reference documentation
- [GENIE3 vignette](./references/GENIE3.md)