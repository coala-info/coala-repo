---
name: bioconductor-batchelor
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/batchelor.html
---

# bioconductor-batchelor

## Overview

The `batchelor` package provides a suite of methods for correcting batch effects in single-cell RNA sequencing data. Unlike bulk methods, `batchelor` does not require prior knowledge of population structure. Its primary strength is the Mutual Nearest Neighbors (MNN) approach, which identifies similar cell types across batches to calculate correction vectors. It integrates seamlessly with the `SingleCellExperiment` (SCE) framework.

## Core Workflow

### 1. Data Preparation
Before correction, datasets must be comparable. This involves subsetting to common genes and performing multi-batch normalization to handle differences in sequencing depth.

```r
library(batchelor)
library(scuttle)

# 1. Subset to common genes
universe <- intersect(rownames(sce1), rownames(sce2))
sce1 <- sce1[universe,]
sce2 <- sce2[universe,]

# 2. Multi-batch normalization
# Adjusts library sizes so batches are on the same scale
out <- multiBatchNorm(sce1, sce2)
sce1 <- out[[1]]
sce2 <- out[[2]]

# 3. Identify Highly Variable Genes (HVGs)
# Usually performed using scran to focus correction on biological signal
library(scran)
dec1 <- modelGeneVar(sce1)
dec2 <- modelGeneVar(sce2)
combined.dec <- combineVar(dec1, dec2)
chosen.hvgs <- getTopHVGs(combined.dec, n=5000)
```

### 2. Batch Correction Methods

#### Fast MNN (Recommended)
`fastMNN()` is the standard choice. It performs PCA on the HVGs and identifies MNNs in the low-dimensional space, making it faster and less noisy than the original method.

```r
set.seed(101)
# Returns an SCE with a 'corrected' reducedDim
f.out <- fastMNN(sce1, sce2, subset.row=chosen.hvgs)

# Access corrected coordinates for clustering/visualization
reducedDim(f.out, "corrected")

# Check batch origin
table(f.out$batch)
```

#### Cluster-based MNN
Use `clusterMNN()` if you have already characterized clusters in each batch and want to group matching clusters into "meta-clusters."

```r
clust.out <- clusterMNN(sce1, sce2, 
                        clusters=list(sce1$cluster_labels, sce2$cluster_labels),
                        subset.row=chosen.hvgs)
```

#### Rescaling and Regression
For simpler technical replicates where population composition is identical:
* `rescaleBatches()`: Centers batches in log-expression space (preserves sparsity).
* `regressBatches()`: Performs linear regression to remove batch effects.

### 3. High-Level Interface
The `correctExperiments()` function is a wrapper that preserves metadata from the original SCE objects.

```r
# Use NoCorrectParam() for diagnostic plots (checking if batch effect exists)
combined_unweighted <- correctExperiments(A=sce1, B=sce2, PARAM=NoCorrectParam())

# Use FastMnnParam() for actual correction
combined_corrected <- correctExperiments(A=sce1, B=sce2, PARAM=FastMnnParam())
```

## Advanced Utilities

### Multi-batch PCA
`multiBatchPCA()` ensures each batch contributes equally to the rotation vectors, preventing large batches from dominating the low-dimensional space.

```r
pca.out <- multiBatchPCA(sce1, sce2, subset.row=chosen.hvgs)
```

### Restricted Correction
If you have known "control" cells (e.g., the same cell line run in both batches), use the `restrict` argument to calculate the correction based only on those cells and extrapolate to the rest.

```r
# Pretend first 100 cells in each are controls
rescale.out <- rescaleBatches(sce1, sce2, restrict=list(1:100, 1:100))
```

## Tips for Success
* **Gene Selection**: Always use HVGs for `fastMNN()` to improve speed and reduce noise.
* **Corrected Values**: The output of `fastMNN()` is a low-dimensional matrix (PC scores). While you can obtain "corrected" expression values via the rotation vectors, these should be used cautiously for gene-level downstream analysis (like DE).
* **Merge Order**: By default, `fastMNN` merges batches in an order determined by the number of MNN pairs. You can manually specify `merge.order` if one batch is a known high-quality reference.

## Reference documentation
- [Correcting batch effects in single-cell RNA-seq data](./references/correction.md)
- [Extending dispatch to more batch correction methods](./references/extension.md)