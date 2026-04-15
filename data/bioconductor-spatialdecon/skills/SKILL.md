---
name: bioconductor-spatialdecon
description: SpatialDecon estimates cell type abundances from spatial transcriptomics data by performing deconvolution against a reference cell profile matrix. Use when user asks to estimate cell type composition in spatial regions, create custom cell profile matrices from single-cell data, or perform deconvolution on GeoMx DSP datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialDecon.html
---

# bioconductor-spatialdecon

name: bioconductor-spatialdecon
description: Estimation of cell type abundance from spatial gene expression data (e.g., Nanostring GeoMx). Use this skill to perform deconvolution on spatial transcriptomics datasets, create custom cell profile matrices from single-cell RNA-seq data, and visualize cell type distributions.

# bioconductor-spatialdecon

## Overview
SpatialDecon is an R package designed to estimate the mixed cell type composition within spatial transcriptomics regions of interest (ROIs). It uses a constrained least-squares regression model to decompose bulk gene expression into cell type-specific contributions based on a reference "cell profile matrix." It is particularly optimized for GeoMx Digital Spatial Profiling (DSP) data, offering specialized handling for background noise and tumor-specific signal contamination.

## Core Workflow

### 1. Data Preparation
SpatialDecon requires three primary inputs:
- **Normalized Data**: A matrix of normalized expression values (genes in rows, observations in columns).
- **Background Matrix**: A matrix of the same dimensions as the normalized data representing expected background noise (often derived from Negative Control probes).
- **Cell Profile Matrix (X)**: A reference matrix of expected expression profiles for each cell type.

```r
library(SpatialDecon)

# Estimate background for GeoMx data
bg = derive_GeoMx_background(norm = norm_matrix,
                             probepool = feature_metadata$Module,
                             negnames = "NegProbe")
```

### 2. Cell Profile Matrices
You can use pre-loaded matrices, download from the Nanostring library, or create custom ones.
- **SafeTME**: Pre-loaded matrix for immune and stroma cells in the tumor microenvironment.
- **Download**: Use `download_profile_matrix(species, age_group, matrixname)`.
- **Custom**: Create from single-cell data (Seurat or matrix) using `create_profile_matrix`.

```r
custom_mtx <- create_profile_matrix(mtx = sc_counts, 
                                    cellAnnots = sc_metadata, 
                                    cellTypeCol = "cell_type", 
                                    cellNameCol = "cell_id",
                                    minCellNum = 5)
```

### 3. Running Deconvolution
There are two main entry points depending on your data object:
- `spatialdecon()`: For standard matrices.
- `runspatialdecon()`: For `NanoStringGeoMxSet` objects (GeomxTools).

**Basic Run:**
```r
res = spatialdecon(norm = norm, bg = bg, X = safeTME, align_genes = TRUE)
# Main result is the 'beta' matrix (cell abundances)
head(res$beta)
```

**Advanced Run (with Tumor Modeling):**
If analyzing tumor samples, provide a logical vector identifying pure tumor segments to allow the algorithm to model and remove cancer-specific expression.
```r
restils = spatialdecon(norm = norm,
                       raw = raw_counts,
                       bg = bg,
                       X = safeTME,
                       is_pure_tumor = annot$is_tumor,
                       n_tumor_clusters = 5,
                       cell_counts = annot$nuclei_counts)
```

### 4. Interpreting Results
The output object contains:
- `beta`: Estimated cell abundance scores.
- `prop_of_nontumor`: Rescaled proportions of non-tumor cells.
- `cell.counts`: Estimated total cell numbers (if `cell_counts`/nuclei were provided).
- `yhat` / `resids`: Fitted values and residuals for QC.

### 5. Visualization
- `TIL_barplot()`: Create stacked barplots of cell abundances.
- `florets()`: Plot cell abundances as pie-like "florets" on 2D coordinates (e.g., PCA or X/Y coordinates).

```r
TIL_barplot(res$beta, draw_legend = TRUE)

florets(x = pc1, y = pc2, b = res$beta, cex = 2)
```

## Advanced Functions
- **collapseCellTypes**: Merge closely related cell types (e.g., CD8+ naive and memory) into a single score to increase stability.
- **reverseDecon**: Model gene expression as a function of cell abundance to identify genes that vary independently of cell mixing (e.g., genes regulated by the microenvironment).
- **mergeTumorIntoX**: Manually append tumor profiles to a reference matrix before running deconvolution.

## Reference documentation
- [Use of SpatialDecon in a small GeoMx dataset](./references/SpatialDecon_vignette.md)
- [Use of SpatialDecon in a large GeoMx dataset with GeomxTools](./references/SpatialDecon_vignette_NSCLC.md)