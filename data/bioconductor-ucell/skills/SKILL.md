---
name: bioconductor-ucell
description: This tool calculates gene signature scores in single-cell datasets using a rank-based Mann-Whitney U statistic. Use when user asks to calculate module scores, evaluate gene signatures in Seurat or SingleCellExperiment objects, or perform signature smoothing to mitigate data sparsity.
homepage: https://bioconductor.org/packages/release/bioc/html/UCell.html
---


# bioconductor-ucell

name: bioconductor-ucell
description: Evaluate gene signatures (module scores) in single-cell datasets using the UCell R package. Use this skill to calculate Mann-Whitney U-based scores for gene sets in Seurat objects, SingleCellExperiment objects, or raw matrices. It is particularly useful for robust, rank-based signature scoring that is scalable to large datasets.

# bioconductor-ucell

## Overview
UCell is a Bioconductor package for calculating gene signature scores in single-cell RNA-seq data. Unlike methods that rely on average expression, UCell uses the Mann-Whitney U statistic based on gene relative ranks within each cell. This makes it robust to dataset heterogeneity, sparsity, and normalization methods. It integrates seamlessly with Seurat and SingleCellExperiment workflows.

## Core Workflows

### 1. Basic Matrix Scoring
Use `ScoreSignatures_UCell` for raw count or normalized matrices.

```r
library(UCell)

# Define signatures as a named list
signatures <- list(
  Tcell = c("CD3D", "CD3E", "CD2"),
  Myeloid = c("LYZ", "CSF1R")
)

# Calculate scores
scores <- ScoreSignatures_UCell(matrix_data, features = signatures)
head(scores)
```

### 2. Seurat Integration
Use `AddModuleScore_UCell` to add scores directly to Seurat metadata.

```r
library(Seurat)
seurat_obj <- AddModuleScore_UCell(seurat_obj, features = signatures, name = NULL)

# Visualize results
FeaturePlot(seurat_obj, features = names(signatures))
```

### 3. SingleCellExperiment Integration
Use `ScoreSignatures_UCell` on SCE objects; results are stored in `altExp`.

```r
library(SingleCellExperiment)
sce <- ScoreSignatures_UCell(sce, features = signatures, assay = "counts")

# Access scores
altExp(sce, "UCell")
```

### 4. Signature Smoothing (KNN)
Mitigate data sparsity by smoothing scores based on neighboring cells.

```r
# Requires a dimensionality reduction (e.g., PCA)
seurat_obj <- SmoothKNN(seurat_obj, signature.names = names(signatures), reduction = "pca")
# Creates new metadata columns with '_kNN' suffix
```

## Advanced Parameters

- **Positive/Negative Signatures**: Append `+` or `-` to gene names (e.g., `c("CD8A+", "CD4-")`). Use `w_neg` to adjust the weight of negative genes.
- **maxRank**: Capping rank for sparsity. Default is 1500. For low-depth data or spatial panels (Xenium/CosMx), set `maxRank` closer to the number of detected features or probes.
- **Pre-calculating Ranks**: For iterative signature testing, pre-calculate ranks to save time.
  ```r
  ranks <- StoreRankings_UCell(matrix_data)
  scores <- ScoreSignatures_UCell(features = signatures, precalc.ranks = ranks)
  ```
- **Parallelization**: Use `BPPARAM` for multi-core processing.
  ```r
  library(BiocParallel)
  scores <- ScoreSignatures_UCell(matrix_data, features = signatures, BPPARAM = MulticoreParam(workers = 4))
  ```

## Tips for Success
- **Normalization**: UCell is rank-based; it works on raw counts or normalized data as long as relative ranks are preserved.
- **Missing Genes**: By default (`missing_genes="impute"`), missing genes are treated as zero expression. Use `"skip"` to ignore them entirely.
- **Chunk Size**: Adjust `chunk.size` (default 100-1000) to balance RAM usage and speed.

## Reference documentation
- [Using UCell with Seurat](./references/UCell_Seurat.md)
- [Some important parameters for UCell](./references/UCell_parameters.md)
- [Using UCell with SingleCellExperiment](./references/UCell_sce.md)
- [Gene signature scoring with UCell](./references/UCell_vignette_basic.md)