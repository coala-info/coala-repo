---
name: bioconductor-spasim
description: bioconductor-spasim simulates complex spatial patterns of cells in tissue images to generate synthetic SpatialExperiment objects. Use when user asks to simulate background cells, generate tumor clusters or immune rings, create synthetic tissue images, or produce datasets for benchmarking spatial analysis tools.
homepage: https://bioconductor.org/packages/release/bioc/html/spaSim.html
---


# bioconductor-spasim

name: bioconductor-spasim
description: Simulate spatial point data for tissue images, including tumor-immune microenvironments with clusters, rings, and vessels. Use when needing to generate synthetic SpatialExperiment objects for benchmarking spatial analysis tools or testing spatial metrics in R.

# bioconductor-spasim

## Overview

`spaSim` (Spatial Simulator) is an R package designed to simulate complex spatial patterns of cells in tissue images. It allows for the sequential construction of synthetic datasets, starting from a background of cells and layering higher-order structures like tumor clusters, immune rings, and blood vessels. The output is typically a `SpatialExperiment` object, making it compatible with downstream analysis packages like `SPIAT`.

## Core Workflow

### 1. Simulating Background Cells
Every simulation begins with a background "canvas".
- **Tumor tissues**: Use `method = "Hardcore"` to maintain a minimum distance between cells.
- **Normal tissues**: Use `method = "Even"` for hexagonal-like spacing.

```r
library(spaSim)

# Generate background
bg <- simulate_background_cells(n_cells = 5000, 
                                width = 2000, 
                                height = 2000, 
                                method = "Hardcore", 
                                min_d = 10, 
                                oversampling_rate = 1.6)
```

### 2. Adding Spatial Patterns
Patterns are added on top of the background. You can define properties (size, shape, infiltration) using list objects.

- **Mixing**: Randomly assign identities to background cells using `simulate_mixing()`.
- **Clusters**: Use `simulate_clusters()` for aggregated cell groups (Oval, Circle, or Irregular).
- **Immune Rings**: Use `simulate_immune_rings()` to create a cluster surrounded by a margin of a different cell type.
- **Double Rings**: Use `simulate_double_rings()` for internal and external margins.
- **Vessels**: Use `simulate_stripes()` to simulate linear structures.

### 3. Integrated Simulation (TIS)
The `TIS()` (Tissue Image Simulator) function allows for one-call generation of complex images by passing all pattern properties at once.

```r
sim_image <- TIS(n_cells = 5000, width = 2000, height = 2000,
                 bg_method = "Hardcore",
                 n_clusters = 1, properties_of_clusters = my_cluster_list,
                 n_immune_rings = 1, properties_of_immune_rings = my_ring_list,
                 plot_image = TRUE)
```

## Simulating Multiple Images
To generate cohorts of images with varying parameters (e.g., increasing tumor size or infiltration), use the `multiple_` family of functions:
- `multiple_background_images()`
- `multiple_images_with_clusters()`
- `multiple_images_with_immune_rings()`

Pass a numeric vector to the parameter you wish to vary (e.g., `cluster_size = seq(200, 500, 100)`).

## Tips for Success
- **Oversampling**: If `simulate_background_cells` returns fewer cells than requested, increase the `oversampling_rate`.
- **Reproducibility**: Always use `set.seed()` before running simulations as cell placement and identity assignment are stochastic.
- **SPIAT Integration**: Simulated objects are compatible with `SPIAT`. Use `SPIAT::plot_cell_categories()` to visualize the results if the built-in `plot_image = TRUE` is insufficient.
- **Overlapping Shapes**: You can define multiple entries in the properties lists with overlapping coordinates to create complex, cohesive tissue structures.

## Reference documentation
- [spaSim Vignette](./references/vignette.md)