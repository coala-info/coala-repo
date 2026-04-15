---
name: bioconductor-scdblfinder
description: This tool identifies doublets in single-cell RNA-seq and ATAC-seq data using simulation-based, cluster-based, or read-count-based methods. Use when user asks to detect multiplets, flag droplets containing multiple cells, run the AMULET algorithm, or process SingleCellExperiment objects to remove technical artifacts.
homepage: https://bioconductor.org/packages/release/bioc/html/scDblFinder.html
---

# bioconductor-scdblfinder

name: bioconductor-scdblfinder
description: Comprehensive doublet detection in single-cell RNA-seq and ATAC-seq data. Use this skill to identify heterotypic and homotypic doublets using simulation-based, cluster-based, or read-count-based (AMULET) methods. It is particularly useful for processing SingleCellExperiment objects to flag droplets containing multiple cells.

# bioconductor-scdblfinder

## Overview
The `scDblFinder` package provides a suite of methods for identifying doublets (multiplets) in single-cell sequencing data. The primary method, `scDblFinder()`, uses an iterative gradient-boosted tree classifier trained on artificial doublets generated from the dataset. It supports both scRNA-seq and scATAC-seq, handles multiple samples/captures, and can operate with or without prior clustering information.

## Core Workflow: scRNA-seq

The standard input is a `SingleCellExperiment` (SCE) object or a count matrix.

### Basic Usage
For a single-sample dataset, run the default random-doublet simulation:

```r
library(scDblFinder)
library(SingleCellExperiment)

# Assuming 'sce' is your SingleCellExperiment object
sce <- scDblFinder(sce)

# Results are stored in colData
# sce$scDblFinder.score: The doublet score (0 to 1)
# sce$scDblFinder.class: The classification ('singlet' or 'doublet')
table(sce$scDblFinder.class)
```

### Handling Multiple Samples
Doublets only form within a single capture. If your SCE contains multiple samples or batches, specify the `samples` argument to process them independently:

```r
# 'sample_id' is a column in colData(sce)
sce <- scDblFinder(sce, samples="sample_id")
```

### Cluster-Based Approach
If the data has clear clusters, the cluster-based approach is more efficient and helps identify the specific origins of doublets:

```r
# Use existing clusters or let the tool fast-cluster automatically
sce <- scDblFinder(sce, clusters="cluster_column") 

# To use internal fast clustering:
sce <- scDblFinder(sce, clusters=TRUE)
```

## Core Workflow: scATAC-seq

scATAC-seq data is sparse, requiring different strategies.

### Feature Aggregation
To use the `scDblFinder` classifier on ATAC data, aggregate features into meta-features first:

```r
sce <- scDblFinder(sce, aggregateFeatures=TRUE, nfeatures=25, processing="normFeatures")
```

### AMULET Method
AMULET identifies doublets based on the presence of more than two fragments at a single genomic locus in a diploid cell. It requires a fragment file:

```r
# Returns a data.frame with p-values (low p-value = likely doublet)
res <- amulet(fragment_file, regionsToExclude = toExclude_granges)
```

## Key Parameters and Tips

- **Doublet Rate (`dbr`)**: By default, the tool estimates the rate based on the number of cells (approx. 0.8% per 1000 cells for standard 10x). Manually set `dbr` if using high-throughput (HT) kits or if the recovery rate was unusual.
- **Reproducibility**: Use `set.seed()` for single-core runs. For multi-sample runs using `BPPARAM`, pass the seed to the param object: `MulticoreParam(3, RNGseed=1234)`.
- **QC Timing**: Run `scDblFinder` *after* removing empty droplets but *before* stringent QC filtering. Low-quality cells can still form doublets with high-quality cells.
- **Homotypic Doublets**: These (doublets of the same cell type) are harder to detect transcriptionally. If you need to find them, avoid the cluster-based approach and set `removeUnidentifiable=FALSE`.

## Interpreting Results

- **Bimodality**: A successful run typically shows a bimodal distribution in `hist(sce$scDblFinder.score)`, with peaks near 0 and 1.
- **Thresholding**: The tool automatically determines a threshold by balancing the expected doublet rate and the misclassification rate of artificial doublets.
- **Doublet Origins**: In cluster-based mode, check `sce$scDblFinder.mostLikelyOrigin` to see which cell types likely formed the doublet.

## Reference documentation

- [Introduction to the scDblFinder package](./references/introduction.md)
- [scDblFinder Method Details](./references/scDblFinder.md)
- [Scoring potential doublets from simulated densities](./references/computeDoubletDensity.md)
- [Detecting clusters of doublet cells with DE analyses](./references/findDoubletClusters.md)
- [Recovering intra-sample doublets](./references/recoverDoublets.md)
- [Doublet identification in single-cell ATAC-seq](./references/scATAC.md)