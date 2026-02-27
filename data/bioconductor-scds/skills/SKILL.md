---
name: bioconductor-scds
description: The scds package provides methods for annotating and scoring doublets in single-cell RNA-seq data using co-expression and binary classification algorithms. Use when user asks to identify doublets, calculate doublet scores, or run cxds and bcds algorithms on SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/scds.html
---


# bioconductor-scds

## Overview

The `scds` package provides methods for annotating doublets in single-cell RNA-seq data. It operates on `SingleCellExperiment` objects and offers three primary algorithms:
1. **cxds**: Co-expression based doublet scoring (uses presence/absence of gene pairs).
2. **bcds**: Binary classification based doublet scoring (uses full counts and artificial doublets).
3. **cxds_bcds_hybrid**: A hybrid approach combining both scores for improved accuracy.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("scds")
```

## Core Workflow

The package expects a `SingleCellExperiment` (SCE) object with raw counts in the `counts` assay.

### 1. Data Preparation
Ensure your SCE object is formatted correctly.
```R
library(scds)
library(SingleCellExperiment)

# Assuming 'sce' is your SingleCellExperiment object
# scds uses assay(sce, "counts")
```

### 2. Running Doublet Annotation
You can run the methods individually or sequentially. Each function adds a score to the `colData` of the SCE object.

```R
# Co-expression based (fast, uses binary data)
sce <- cxds(sce, retRes = TRUE)

# Binary classification based (uses counts, generates artificial doublets)
sce <- bcds(sce, retRes = TRUE)

# Hybrid approach (recommended for best performance)
sce <- cxds_bcds_hybrid(sce)
```

### 3. Interpreting Results
Higher scores indicate a higher probability that a cell is a doublet. The scores are stored in `colData(sce)` under the following names:
- `cxds_score`
- `bcds_score`
- `hybrid_score`

To visualize the distribution of scores:
```R
# Example: Boxplot of scores
boxplot(sce$hybrid_score ~ sce$sample_id) 

# Or visualize on reduced dimensions (e.g., UMAP/TSNE)
library(scater)
plotReducedDim(sce, "UMAP", color_by = "hybrid_score")
```

## Advanced Features

### Visualizing Gene Pairs (cxds)
For `cxds`, you can inspect the gene pairs that are driving the doublet scores. This is useful for identifying which cell types are likely merging to form doublets.

```R
# Access top pairs from metadata
top_pairs <- metadata(sce)$cxds$topPairs
# Get gene names for the top pair
hvg_names <- rowData(sce)$cxds_hvg_ordr[rowData(sce)$cxds_hvg_bool]
gene1 <- hvg_names[top_pairs[1,1]]
gene2 <- hvg_names[top_pairs[1,2]]
```

## Tips and Best Practices
- **Input Data**: Always use raw counts. Do not use normalized or log-transformed data as input for the scoring functions.
- **Hybrid Method**: The `cxds_bcds_hybrid` method generally provides the most robust results by balancing the strengths of both underlying algorithms.
- **Thresholding**: `scds` provides scores, not hard calls. Users must typically determine a threshold based on the expected doublet rate of their specific experimental platform (e.g., 10x Genomics).

## Reference documentation
- [scds: single cell doublet scoring](./references/scds.md)