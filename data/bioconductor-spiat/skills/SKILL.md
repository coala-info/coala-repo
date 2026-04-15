---
name: bioconductor-spiat
description: SPIAT provides tools for the processing, quality control, and spatial analysis of single-cell proteomics data. Use when user asks to format spatial image data, define cell types, calculate distances between cells, quantify colocalization, or perform neighborhood analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SPIAT.html
---

# bioconductor-spiat

name: bioconductor-spiat
description: Spatial Image Analysis of Tissues (SPIAT) for processing, quality control, visualization, and analysis of single-cell spatial proteomics data (e.g., OPAL, CODEX, MIBI). Use this skill to perform cell colocalization analysis, neighborhood detection, spatial heterogeneity quantification, and tissue structure characterization from X/Y coordinates and marker intensities.

# bioconductor-spiat

## Overview
SPIAT (**Sp**atial **I**mage **A**nalysis of **T**issues) is an R package designed for the analysis of single-cell spatial proteomics data. It operates primarily on `SpatialExperiment` objects, integrating cell coordinates, marker intensities, and phenotypes. The package is structured into modules covering data formatting, quality control, distance-based metrics, colocalization, and neighborhood identification.

## Core Workflow

### 1. Data Loading and Formatting
The primary entry point is `format_image_to_spe()`. While it supports specific platforms (inForm, HALO, CODEX, cellprofiler), the "general" format is recommended for maximum compatibility.

```r
library(SPIAT)

# General format requires: intensity matrix, phenotypes, and X/Y coordinates
spe <- format_image_to_spe(format = "general", 
                           intensity_matrix = my_intensities, 
                           phenotypes = my_phenotypes, 
                           coord_x = my_x, 
                           coord_y = my_y)
```

### 2. Defining Cell Types
Use `define_celltypes` to map complex marker combinations (phenotypes) to human-readable names.

```r
formatted_image <- define_celltypes(
    simulated_image, 
    categories = c("Tumour_marker", "CD3,CD4", "OTHER"), 
    category_colname = "Phenotype", 
    names = c("Tumour", "T_Helper", "Others"),
    new_colname = "Cell.Type")
```

### 3. Basic Spatial Analysis
Calculate cell proportions and distances (pairwise or minimum) between cell types.

```r
# Cell proportions
proportions <- calculate_cell_proportions(formatted_image, feature_colname = "Cell.Type")

# Minimum distances to nearest neighbor of another type
min_dists <- calculate_minimum_distances_between_celltypes(
    spe_object = formatted_image, 
    cell_types_of_interest = c("Tumour", "T_Helper"),
    feature_colname = "Cell.Type")

# Summarize and visualize
summary_dist <- calculate_summary_distances_between_celltypes(min_dists)
plot_distance_heatmap(summary_dist, metric = "mean")
```

### 4. Quantifying Colocalization
SPIAT provides several metrics to determine if cell types are interacting, repelling, or forming specific structures like "immune rings."

*   **Mixing Score:** Ratio of interactions between different types vs. same types.
*   **Cross K Function:** Compares spatial distribution against a random Poisson process.
*   **Cells In Neighborhood (CIN):** Percentage of target cells within a specific radius of a reference cell.

```r
# Cross K Function
df_cross <- calculate_cross_functions(formatted_image, 
                                      method = "Kcross", 
                                      cell_types_of_interest = c("Tumour", "T_Helper"), 
                                      dist = 100)
auc_score <- AUC_of_cross_function(df_cross) # Positive = mixing, Negative = separation
```

### 5. Neighborhood Identification
Identify clusters of cells (homotypic or heterotypic) using hierarchical clustering or dbscan.

```r
clusters <- identify_neighborhoods(
    formatted_image, 
    method = "hierarchical", 
    radius = 50, 
    min_neighborhood_size = 100,
    cell_types_of_interest = c("T_Helper", "Immune_Other"),
    feature_colname = "Cell.Type")

# Analyze composition of identified neighborhoods
neigh_comp <- composition_of_neighborhoods(clusters, feature_colname = "Cell.Type")
plot_composition_heatmap(neigh_comp, feature_colname = "Cell.Type")
```

## Tips for Success
*   **Phenotype Formatting:** Ensure phenotypes are comma-separated strings (e.g., "CD3,CD8") without spaces. The order must match the order in the intensity matrix.
*   **Radius Selection:** Use `average_minimum_distance()` or `plot_average_intensity()` to help determine appropriate radii for neighborhood and colocalization functions.
*   **Large Images:** Use `image_splitter()` to divide large tissue sections into manageable chunks for analysis.
*   **Coordinate Units:** Ensure you know if your coordinates are in pixels or microns, as this affects radius parameters.

## Reference documentation
For detailed workflows and examples, refer to the following documentation:
- [Overview of the SPIAT package](./references/SPIAT.md)
- [Basic analyses with SPIAT](./references/basic_analysis.md)
- [Quantifying cell colocalisation with SPIAT](./references/cell-colocalisation.md)
- [Reading in data and data formatting in SPIAT](./references/data_reading-formatting.md)
- [Identifying cellular neighborhood with SPIAT](./references/neighborhood.md)
- [Quality control and visualisation](./references/quality-control_visualisation.md)
- [Spatial heterogeneity](./references/spatial-heterogeneity.md)
- [Tissue structure](./references/tissue-structure.md)