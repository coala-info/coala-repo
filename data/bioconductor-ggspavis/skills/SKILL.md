---
name: bioconductor-ggspavis
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ggspavis.html
---

# bioconductor-ggspavis

## Overview

The `ggspavis` package provides a specialized suite of `ggplot2`-based visualization functions for spatial transcriptomics data. It is designed to work seamlessly with the `SpatialExperiment` Bioconductor class. It supports both sequencing-based (Visium, Slide-seq) and imaging-based (Xenium, CosMx, MERSCOPE) technologies, offering tools for spatial spot/cell plotting, histology image overlays, and quality control (QC) metrics.

## Core Functions and Workflows

### 1. Spatial Coordinate Plotting
Use `plotCoords()` for a general-purpose spatial visualization of spots or cells.

```r
# Basic spatial plot colored by a variable (e.g., cluster or gene)
plotCoords(spe, annotate = "celltype", point_size = 0.5)

# For imaging-based data (Xenium/CosMx), set in_tissue = NULL
plotCoords(spe_xen, annotate = "gene_expression", in_tissue = NULL)

# Add text labels to the center of clusters
plotCoords(spe, annotate = "label", text_by = "label")
```

### 2. Visium-Specific Visualization
Use `plotVisium()` to overlay spatial data on H&E histology images. This function requires a `SpatialExperiment` object containing `imgData`.

```r
# Overlay spots on histology
plotVisium(spe, annotate = "sum", highlight = "in_tissue")

# Show only the histology image (no spots)
plotVisium(spe, spots = FALSE)

# Show only spots (no histology)
plotVisium(spe, image = FALSE)

# Visium HD (square bins): Change point_shape to 22 (square with border)
plotVisium(spe_hd, annotate = "gene", point_shape = 22, point_size = 2)
```

### 3. Quality Control (QC) Plots
Use `plotObsQC()` for observation-level (spot/cell) QC and `plotFeatureQC()` for feature-level (gene) QC.

```r
# Spot-level QC: Histogram, Violin, or Spatial Spot plot
plotObsQC(spe, plot_type = "histogram", x_metric = "sum")
plotObsQC(spe, plot_type = "violin", x_metric = "subsets_mito_percent")
plotObsQC(spe, plot_type = "spot", annotate = "low_libsize")

# Scatter plot for QC metrics (e.g., mito vs library size)
plotObsQC(spe, plot_type = "scatter", x_metric = "subsets_mito_percent", y_metric = "sum")

# Feature-level QC
plotFeatureQC(spe, plot_type = "histogram", x_metric = "feature_sum")
```

### 4. Reduced Dimension Plots
Use `plotDimRed()` to visualize PCA, UMAP, or t-SNE results stored in the `reducedDims` slot.

```r
plotDimRed(spe, plot_type = "UMAP", annotate = "cluster_labels")
```

## Implementation Tips

- **Object Compatibility**: `plotVisium()` requires a `SpatialExperiment` object. Most other functions (`plotCoords`, `plotObsQC`, `plotDimRed`) accept either `SpatialExperiment` or `SingleCellExperiment`.
- **Palettes**: Use the `pal` argument to specify color schemes. It supports standard color vectors or specific strings like `"viridis"`, `"magma"`, or `"libd_layer_colors"`.
- **Point Shapes**: 
    - Standard Visium/Slide-seq: `point_shape = 16` (default for `plotCoords`) or `21` (default for `plotVisium`).
    - Visium HD (Square bins): Use `point_shape = 15` for `plotCoords` and `22` for `plotVisium`.
- **Combining Plots**: Since `ggspavis` returns `ggplot` objects, use the `patchwork` package (e.g., `p1 | p2`) to create multi-panel figures.

## Reference documentation

- [ggspavis overview](./references/ggspavis_overview.md)