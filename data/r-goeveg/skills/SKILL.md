---
name: r-goeveg
description: A collection of functions useful in (vegetation) community analyses and ordinations. Includes automatic species selection for ordination diagrams, NMDS stress/scree plots, species response curves, merging of taxa as well as calculation and sorting of synoptic tables.</p>
homepage: https://cloud.r-project.org/web/packages/goeveg/index.html
---

# r-goeveg

## Overview
The `goeveg` package provides utilities for community data analysis, specifically designed to complement the `vegan` package. It excels in automating species selection for plots, visualizing NMDS dimensionality (scree plots), and generating synoptic tables for phytosociological studies.

## Installation
```r
install.packages("goeveg")
library(goeveg)
```

## Core Workflows

### 1. Ordination Diagnostics and Visualization
Use these functions to determine the appropriate number of dimensions for NMDS and to declutter ordination plots.

*   **NMDS Scree Plot**: Determine optimal dimensions by plotting stress vs. number of axes.
    ```r
    # Where 'veg_data' is a community matrix
    screeplot_NMDS(veg_data, distance = "bray", k = 6)
    ```
*   **Automatic Species Selection**: Select species for `orditkplot` or `text()` based on abundance or fit (correlation with axes).
    ```r
    # Select top 10 species based on abundance
    sel <- ordiselect(veg_data, ord, ablim = 0.1, fitlim = 0.5, choices = c(1,2))
    plot(ord, display = "sites")
    text(ord, display = "species", select = sel)
    ```

### 2. Species Response Curves
Model individual species distributions along environmental gradients using GLM or GAM.
```r
# Plot response of a species to an environmental variable
specresponse(veg_data$SpeciesName, env_variable, method = "gam")
```

### 3. Community Structure
*   **Rank-Abundance Curves (Whittaker plots)**:
    ```r
    # Single sample
    racurve(veg_data[1, ])
    # Multiple samples
    racurves(veg_data)
    ```
*   **HCR Resampling**: Perform Heterogeneity-Constrained Random resampling to reduce spatial autocorrelation or oversampling in specific vegetation types.
    ```r
    hcr_resampling(veg_data, dist_matrix, n = 50)
    ```

### 4. Data Manipulation and Synoptic Tables
*   **Synoptic Tables**: Calculate frequency and fidelity (phi-coefficient) for clusters.
    ```r
    # Create synoptic table based on clustering
    syn_tab <- syntable(veg_data, cluster_vector, abund = "mean")
    # Sort table to highlight differential species
    sorted_tab <- synsort(syn_tab, cluster_vector)
    ```
*   **Matrix Cleaning**:
    ```r
    # Remove empty rows/columns and transpose if necessary
    clean_veg <- clean_matrix(veg_data, n_min = 1)
    ```
*   **Cover Conversion**: Convert between Braun-Blanquet (or other codes) and percentage values.
    ```r
    # Convert codes to percentages
    perc_cover <- cov2per(veg_data)
    ```

## Tips for Success
*   **Integration with vegan**: Most functions expect data frames in the standard "sites as rows, species as columns" format used by the `vegan` package.
*   **Species Selection**: When using `ordiselect`, start with `ablim` (abundance limit) to remove rare species, then use `fitlim` to ensure the displayed species actually represent the ordination axes well.
*   **Synoptic Tables**: Use `synsort` after `syntable` to automatically group species by their diagnostic value for specific plant communities.

## Reference documentation
- [goeveg: Functions for Community Data and Ordinations](./references/README.md)