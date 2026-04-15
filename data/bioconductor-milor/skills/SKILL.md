---
name: bioconductor-milor
description: Milo performs differential abundance analysis on single-cell data using k-nearest neighbor graphs to identify changes in cell state composition between experimental conditions. Use when user asks to perform differential abundance analysis, identify shifts in cell state abundance without discrete clustering, or analyze single-cell composition using KNN neighborhoods.
homepage: https://bioconductor.org/packages/release/bioc/html/miloR.html
---

# bioconductor-milor

name: bioconductor-milor
description: Differential abundance analysis for single-cell data using k-nearest neighbor (KNN) graphs and neighborhoods. Use when you need to identify cell state abundance changes between experimental conditions in replicated multi-condition single-cell experiments (SingleCellExperiment, Seurat, or AnnData objects).

# bioconductor-milor

## Overview

`miloR` implements Milo, a method for differential abundance (DA) analysis on single-cell datasets. Unlike cluster-based DA, Milo uses partially overlapping neighborhoods on a KNN graph to detect changes in composition. This approach avoids the need for discrete clustering and can identify subtle shifts in cell states along trajectories or within complex populations.

The workflow follows three main stages:
1.  **Neighborhood Sampling**: Defining representative neighborhoods on a KNN graph.
2.  **Cell Counting**: Quantifying cells from each experimental sample within these neighborhoods.
3.  **DA Testing**: Using a Generalized Linear Model (GLM) framework (via `edgeR`) to test for abundance changes, followed by a weighted Spatial FDR correction.

## Core Workflow

### 1. Initialization and Graph Building
Convert your data (e.g., `SingleCellExperiment`) to a `Milo` object and construct the KNN graph.

```r
library(miloR)
library(SingleCellExperiment)

# Create Milo object
milo <- Milo(sce_object)

# Build KNN graph (k=30 and d=30 are common starting points)
# 'd' is the number of reduced dimensions (e.g., PCA) to use
milo <- buildGraph(milo, k = 30, d = 30, reduced.dim = "PCA")
```

### 2. Defining Neighborhoods
Sample representative cells to serve as neighborhood indices.

```r
# prop: proportion of cells to sample (0.1 for <30k cells, 0.05 for larger)
milo <- makeNhoods(milo, prop = 0.1, k = 30, d = 30, refined = TRUE)

# Diagnostic: Check neighborhood size distribution (aim for peak between 50-100)
plotNhoodSizeHist(milo)
```

### 3. Counting and Experimental Design
Count cells per sample in each neighborhood and define the metadata for testing.

```r
# Count cells
milo <- countCells(milo, meta.data = as.data.frame(colData(milo)), samples = "SampleID")

# Prepare design matrix (must be unique per sample)
design_df <- data.frame(colData(milo))[, c("SampleID", "Condition", "Batch")]
design_df <- unique(design_df)
rownames(design_df) <- design_df$SampleID

# Reorder to match count matrix columns
design_df <- design_df[colnames(nhoodCounts(milo)), ]
```

### 4. Differential Abundance Testing
Calculate neighborhood distances for Spatial FDR and run the GLM.

```r
# Calculate distances (required for Spatial FDR)
milo <- calcNhoodDistance(milo, d = 30)

# Run test
da_results <- testNhoods(milo, design = ~ Batch + Condition, design.df = design_df)

# Significant results (SpatialFDR < 0.1)
head(da_results[order(da_results$SpatialFDR), ])
```

## Advanced Comparisons (Contrasts)

For experiments with >2 groups, use contrasts to specify comparisons.

```r
# Example: Comparing GroupA vs GroupB in a multi-level 'Condition' variable
# Use ~ 0 + Condition in the design to get separate levels
da_results <- testNhoods(milo, 
                         design = ~ 0 + Condition, 
                         design.df = design_df, 
                         model.contrasts = "ConditionGroupA - ConditionGroupB")
```

## Visualization and Interpretation

### Spatial Visualization
Project DA results onto the single-cell embedding (UMAP/TSNE).

```r
milo <- buildNhoodGraph(milo)
plotNhoodGraphDA(milo, da_results, alpha = 0.1) + 
  plotReducedDim(milo, "UMAP", colour_by = "Condition")
```

### Annotation and Beeswarm Plots
Assign cell type labels to neighborhoods based on majority voting.

```r
da_results <- annotateNhoods(milo, da_results, coldata_col = "celltype")
plotDAbeeswarm(da_results, group.by = "celltype")
```

### Finding Marker Genes
Identify genes that characterize specific DA neighborhood groups.

```r
# Group neighborhoods by LFC and connectivity
da_results <- groupNhoods(milo, da_results, max.lfc.delta = 2)

# Find markers for a specific group
markers <- findNhoodGroupMarkers(milo, da_results, 
                                 aggregate.samples = TRUE, 
                                 sample_col = "SampleID",
                                 subset.groups = "1")
```

## Tips for Success
- **Batch Correction**: If your data is batch-corrected (e.g., via `fastMNN`), ensure you build the graph using the corrected reduced dimensions (e.g., `reduced.dim = "pca.corrected"`).
- **K-selection**: If `plotNhoodSizeHist` shows very small neighborhoods (mean < 20), increase `k` or `prop`.
- **Replicates**: Milo requires biological replicates to estimate variance. Do not run DA testing on single-sample-per-condition datasets.

## Reference documentation

- [Making comparisons for differential abundance using contrasts](./references/milo_contrasts.md)
- [Differential abundance testing with Milo](./references/milo_demo.md)
- [Differential abundance testing with Milo - Mouse gastrulation example](./references/milo_gastrulation.md)
- [GLMM for differential abundance testing](./references/milo_glmm.md)