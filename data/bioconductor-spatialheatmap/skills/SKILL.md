---
name: bioconductor-spatialheatmap
description: This tool generates spatial heatmaps by mapping biological assay data onto anatomical images. Use when user asks to visualize gene or protein expression on annotated SVG images, co-visualize single-cell embeddings with anatomical maps, or perform spatial enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/spatialHeatmap.html
---

# bioconductor-spatialheatmap

name: bioconductor-spatialheatmap
description: Use this skill to generate spatial heatmaps (SHMs) for visualizing biological assay data (transcriptomics, proteomics, metabolomics) on anatomical images. It supports bulk and single-cell data integration, co-visualization of embedding plots with SHMs, and spatial enrichment analysis. Use when you need to map numeric values from SummarizedExperiment or SingleCellExperiment objects onto annotated SVG (aSVG) images.

# bioconductor-spatialheatmap

## Overview
The `spatialHeatmap` package is designed to visualize biomolecule abundance patterns across specific cells, tissues, and organs. It maps numeric assay data onto "annotated SVG" (aSVG) files, where image features have unique identifiers matching the data. Key capabilities include generating static or interactive spatial heatmaps, co-visualizing single-cell embeddings (UMAP/tSNE) alongside anatomical plots, and performing automated co-clustering to assign single cells to tissues.

## Core Workflow

### 1. Data Preparation
The package primarily uses `SummarizedExperiment` (bulk) and `SingleCellExperiment` (single-cell) objects.
*   **Assay Data:** Rows are biomolecules (genes/proteins), columns are samples (tissues/cells).
*   **Metadata:** `colData` must contain identifiers that match the `feature` labels in the aSVG.

### 2. Importing aSVGs
Use `read_svg()` to load anatomical images.
```r
library(spatialHeatmap)
svg_path <- system.file("extdata/shinyApp/data", "homo_sapiens.brain.svg", package="spatialHeatmap")
svg_obj <- read_svg(svg_path)
```

### 3. Generating Spatial Heatmaps (SHM)
The `shm()` function is the primary tool for bulk data visualization.
```r
# Create SPHM container for data management
dat <- SPHM(svg = svg_obj, bulk = my_summarized_experiment)

# Plot SHM for a specific gene ID
res <- shm(data = dat, ID = 'GeneXYZ', ncol = 1)
```

### 4. Co-visualization (Single-Cell + SHM)
To visualize single-cell data alongside anatomical maps, use `covis()`. This requires a mapping list to link cell group labels to aSVG features.
```r
# Define mapping: names are cell labels, elements are aSVG features
match_list <- list(hypothalamus = c('hypothalamus'), cortex = c('cerebral.cortex'))

# Create SPHM container with single-cell data
dat_covis <- SPHM(svg = svg_obj, cell = my_sce, match = match_list)

# Generate co-visualization plot
covis_res <- covis(data = dat_covis, ID = 'Apod', dimred = 'UMAP', cell.group = 'label')
```

## Advanced Features

### Automated Co-clustering
If single-cell data is unlabeled, `cocluster()` can predict source tissues by comparing single-cell profiles to bulk tissue data.
```r
# Perform co-clustering
coclus_res <- cocluster(bulk = bulk_data, cell = cell_data, min.dim = 14, dimred = 'PCA')

# Filter assignments by similarity score
coclus_res <- filter_asg(coclus_res, min.sim = 0.1)
```

### Coloring Options in Co-visualization
*   **cell-by-group:** Cells and tissues share a color based on the group's mean expression.
*   **feature-by-group:** Colors are derived from bulk tissue values and mapped to cells.
*   **cell-by-value:** (Set `col.idp = TRUE`) Each cell and tissue is colored independently by its own expression value to show heterogeneity.
*   **fixed-group:** (Set `profile = FALSE`) Uses constant colors to show mapping without expression data.

### Spatially Resolved Single-Cell (SRSC)
For Visium or similar data, `spatialHeatmap` can overlay spatial spots onto anatomical aSVGs using an `overlay` shape defined in the SVG. Use `read_svg(..., srsc = TRUE)`.

## Tips for Success
*   **Identifier Matching:** Ensure `rownames(assay)` match the IDs you query, and `colnames(assay)` (or a specific `colData` column) match the `feature` column in the aSVG attributes.
*   **Caching:** Use `save_cache()` and `read_cache()` for large-scale normalization or dimension reduction results to save time.
*   **Interactive Mode:** Use `shiny_shm()` to launch the GUI for exploratory analysis and custom aSVG testing.

## Reference documentation
- [Co-visualizing Bulk and Single-cell Assay Data](./references/covisualize.md)
- [Creating Custom Annotated SVGs](./references/custom_SVGs.md)
- [Visualizing Spatial Assays in Anatomical Images](./references/spatialHeatmap.md)