---
name: bioconductor-spotlight
description: SPOTlight deconvolutes cell-type proportions in spatial transcriptomics data by leveraging single-cell RNA-seq references through seeded Non-Negative Matrix Factorization. Use when user asks to deconvolute spatial transcriptomics spots, estimate cell-type composition using scRNA-seq references, or integrate spatial and single-cell datasets to analyze cell-type co-localization.
homepage: https://bioconductor.org/packages/release/bioc/html/SPOTlight.html
---


# bioconductor-spotlight

name: bioconductor-spotlight
description: Deconvolution of cell types in spatial transcriptomics (ST) data using single-cell RNA-seq (scRNA-seq) references. Use this skill to integrate scRNA-seq and ST datasets (like 10X Visium) to estimate cell-type proportions within spatial spots using seeded Non-Negative Matrix Factorization (NMF) and Non-negative Least Squares (NNLS).

# bioconductor-spotlight

## Overview

`SPOTlight` is a computational tool designed to deconvolute spatial transcriptomics (ST) capture locations (spots) that typically contain multiple cells. It leverages a single-cell RNA-seq (scRNA-seq) reference to learn cell-type-specific "topic profiles" via a seeded NMF regression. These profiles are then used to estimate the composition of cell types within each spatial spot.

The workflow generally involves:
1.  **Preprocessing**: Feature selection (HVGs) and identifying marker genes for the scRNA-seq reference.
2.  **Deconvolution**: Running the `SPOTlight` function to decompose ST spots.
3.  **Visualization**: Analyzing topic profiles, spatial correlation, and co-localization of cell types.

## Core Workflow

### 1. Data Preparation
The package accepts `SingleCellExperiment` (SCE) for the reference and `SpatialExperiment` (SPE) for the spatial data.

```r
library(SPOTlight)
library(scran)
library(scater)

# 1. Feature Selection (Reference)
# Identify marker genes for each cell type
mgs <- scoreMarkers(sce)
mgs_fil <- lapply(names(mgs), function(i) {
    x <- mgs[[i]]
    x <- x[x$mean.AUC > 0.8, ] # Filter for high-quality markers
    x$gene <- rownames(x)
    x$cluster <- i
    data.frame(x)
})
mgs_df <- do.call(rbind, mgs_fil)

# Identify Highly Variable Genes (HVGs)
dec <- modelGeneVar(sce)
hvg <- getTopHVGs(dec, n = 3000)
```

### 2. Deconvolution
The main function `SPOTlight` performs both the training of the NMF model and the deconvolution of the spatial spots.

```r
res <- SPOTlight(
    x = sce,                # SingleCellExperiment reference
    y = spe,                # SpatialExperiment target
    groups = sce$type,      # Cell type annotations
    mgs = mgs_df,           # Marker gene dataframe
    hvg = hvg,              # Highly variable genes
    weight_id = "mean.AUC", # Column in mgs_df for weighting
    group_id = "cluster",   # Column in mgs_df for cell types
    gene_id = "gene"        # Column in mgs_df for gene names
)

# Extract the deconvolution matrix (proportions)
decon_matrix <- res$mat
```

### 3. Advanced: Two-Step Execution
For large datasets or when reusing a reference, you can split the process:

```r
# Step 1: Train the model
mod_ls <- trainNMF(x = sce, groups = sce$type, mgs = mgs_df, hvg = hvg, ...)

# Step 2: Run deconvolution on spatial data
res <- runDeconvolution(x = spe, mod = mod_ls[["mod"]], ref = mod_ls[["topic"]])
```

## Visualization and Interpretation

### Topic Profiles
Verify that the model learned distinct signatures for each cell type.
```r
plotTopicProfiles(x = res$NMF, y = sce$type, facet = FALSE)
```

### Spatial Scatterpie
Visualize cell type proportions directly on the spatial coordinates.
```r
plotSpatialScatterpie(
    x = spe,
    y = decon_matrix,
    cell_types = colnames(decon_matrix),
    pie_scale = 0.4
)
```

### Co-localization
Identify which cell types frequently appear together in the same spots.
```r
# Network representation
plotInteractions(decon_matrix, which = "network")

# Heatmap representation
plotInteractions(decon_matrix, which = "heatmap", metric = "prop")
```

## Tips for Success
- **Downsampling**: For the reference SCE, using ~100 cells per cell type is usually sufficient and significantly reduces computation time without sacrificing accuracy.
- **Gene Filtering**: Exclude ribosomal and mitochondrial genes from the marker selection to avoid noise from metabolic activity.
- **Residuals**: Check `res[[2]]` (Sum of Squares) to identify spots where the model fit is poor, which may indicate the presence of cell types not included in your reference.

## Reference documentation
- [Spatial Transcriptomics Deconvolution with SPOTlight](./references/SPOTlight_kidney.md)