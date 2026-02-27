---
name: bioconductor-mapscape
description: MapScape visualizes the spatial distribution of cancer clones by integrating clonal phylogenies, prevalences, and anatomical locations into interactive images. Use when user asks to visualize clonal evolution across anatomical sites, map cancer clone distributions to spatial coordinates, or create interactive HTML widgets of tumor clonal architecture.
homepage: https://bioconductor.org/packages/release/bioc/html/mapscape.html
---


# bioconductor-mapscape

## Overview

MapScape is a Bioconductor package designed to visualize the spatial distribution of cancer clones. It integrates three key data types: a clonal phylogeny (tree), clonal prevalences across multiple samples, and the anatomical locations of those samples. The resulting visualization features a central anatomical image (PNG) surrounded by sample-specific representations (cellular aggregates or donut charts) and the patient's clonal phylogeny.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mapscape")
library(mapscape)
```

## Core Function: mapscape()

The primary interface is the `mapscape()` function. It generates an interactive HTML widget (optimized for Chrome).

### Required Parameters

1.  **clonal_prev**: A data frame with columns:
    *   `sample_id` (character): Unique ID for the tumor sample.
    *   `clone_id` (character): Unique ID for the clone.
    *   `clonal_prev` (numeric): Prevalence of the clone in that sample (0 to 1).
2.  **tree_edges**: A data frame defining the phylogeny:
    *   `source` (character): Parent clone ID.
    *   `target` (character): Child clone ID.
3.  **sample_locations**: A data frame mapping samples to anatomy:
    *   `sample_id` (character): ID matching `clonal_prev`.
    *   `location_id` (character): Name of the anatomical site.
    *   `x` (numeric, optional): X-coordinate on the image (pixels).
    *   `y` (numeric, optional): Y-coordinate on the image (pixels).
4.  **img_ref**: A string providing the path or URL to a PNG anatomical image.

### Optional Parameters

*   **mutations**: Data frame with columns `chrom`, `coord`, `clone_id`, `sample_id`, and `VAF`. Providing this adds an interactive mutation table to the visualization.
*   **sample_ids**: A character vector specifying the radial order of samples.
*   **n_cells**: Integer (default 100) setting the number of cells in the cellular aggregate view.
*   **show_low_prev_gtypes**: Boolean (default FALSE). If TRUE, shows clones with prevalence < 0.01 as empty circles in the tree.
*   **phylogeny_title**, **anatomy_title**, **classification_title**: Strings to customize legend and plot titles.

## Typical Workflow

1.  **Data Preparation**: Ensure clone IDs are consistent across the tree and prevalence data frames.
2.  **Coordinate Mapping**: If using a custom anatomical image, identify the pixel coordinates (x, y) for each sample location to place markers accurately.
3.  **Execution**:
    ```R
    # Example call
    mapscape(clonal_prev = my_prev, 
             tree_edges = my_tree, 
             sample_locations = my_locs, 
             img_ref = "path/to/anatomy.png")
    ```
4.  **Interactivity**: Use the toolbar in the resulting widget to toggle between "Cellular Aggregate" (artistic cell distribution) and "Donut Chart" (precise proportions) views.

## Data Source Recommendations

MapScape typically visualizes results from clonal inference tools. A common pipeline involves:
*   **PyClone**: For estimating cellular prevalence from SNV read counts and copy number data.
*   **citup**: For inferring the clonal phylogeny and refined clone frequencies from PyClone output.

## Reference documentation

- [MapScape vignette](./references/mapscape_vignette.md)