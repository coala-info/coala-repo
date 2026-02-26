---
name: r-spdep
description: This tool provides expert guidance for spatial dependence analysis in R using the spdep package. Use when user asks to create spatial weights, calculate global or local spatial autocorrelation statistics like Moran's I, or perform hypothesis testing for spatial patterns in areal data.
homepage: https://cloud.r-project.org/web/packages/spdep/index.html
---


# r-spdep

name: r-spdep
description: Expert guidance for spatial dependence analysis in R using the spdep package. Use this skill when performing spatial weight construction (contiguity, distance-based, k-nearest neighbors), calculating spatial autocorrelation statistics (Moran's I, Geary's C), or conducting hypothesis testing for spatial patterns in areal data.

# r-spdep

## Overview
The `spdep` package is the standard R library for managing spatial weights and calculating statistics of spatial dependence. It provides tools for creating neighbor objects (`nb`), converting them into spatial weights matrices (`listw`), and testing for spatial autocorrelation in both global and local contexts.

## Installation
```R
install.packages("spdep")
library(spdep)
```

## Core Workflow

### 1. Creating Neighbors (`nb` objects)
Neighbors define which spatial units are related.
*   **Contiguity (Polygons):**
    ```R
    # Queen (shares point or edge) or Rook (shares edge only)
    nb_queen <- poly2nb(sf_obj, queen = TRUE)
    nb_rook <- poly2nb(sf_obj, queen = FALSE)
    ```
*   **Distance-based (Points):**
    ```R
    coords <- st_coordinates(st_centroid(sf_obj))
    # K-nearest neighbors
    nb_knn <- knn2nb(knearneigh(coords, k = 4))
    # Distance threshold (e.g., 0 to 50km)
    nb_dist <- dnearneigh(coords, d1 = 0, d2 = 50, longlat = TRUE)
    ```
*   **Graph-based:** `tri2nb()` (Delaunay), `gabrielneigh()`, `relativeneigh()`.

### 2. Managing Weights (`listw` objects)
Convert `nb` objects into weights matrices used in statistical tests.
```R
# Style "W" is row-standardized (sum of weights for each row = 1)
# Style "B" is binary (0/1)
lw <- nb2listw(nb_queen, style = "W", zero.policy = TRUE)
```

### 3. Global Spatial Autocorrelation
Test if the overall spatial pattern is clustered, dispersed, or random.
*   **Moran's I:**
    ```R
    moran.test(sf_obj$variable, lw)
    # Monte Carlo permutation test (more robust for small N)
    moran.mc(sf_obj$variable, lw, nsim = 999)
    ```
*   **Geary's C:** `geary.test(sf_obj$variable, lw)`
*   **Join Count Tests:** For categorical/binary data: `joincount.test(factor_var, lw)`

### 4. Local Indicators of Spatial Association (LISA)
Identify specific "hot spots" or "cold spots."
```R
local_m <- localmoran(sf_obj$variable, lw)
# Returns matrix with Ii, E.Ii, Var.Ii, Z.Ii, and p-values
```

## Advanced Features
*   **Higher-order neighbors:** Use `nblag(nb, maxlag = 2)` to find neighbors of neighbors.
*   **Saddlepoint/Exact tests:** For global Moran's I, use `lm.morantest.sad()` or `lm.morantest.exact()` for better p-value estimation in small samples.
*   **Handling Islands:** If a region has no neighbors, set `zero.policy = TRUE` in `nb2listw` and subsequent test functions to avoid errors.

## Tips for Success
*   **Coordinate Systems:** For `dnearneigh` and `knearneigh`, ensure your data is projected (UTM) or explicitly set `longlat = TRUE` for decimal degrees.
*   **sf Integration:** `spdep` works seamlessly with `sf` objects. Always prefer `sf` over the legacy `sp` (SpatialPolygons) format.
*   **Connectivity:** Use `n.comp.nb(nb)` to check if your neighbor graph is connected or split into disjoint subgraphs.

## Reference documentation
- ["The Problem of Spatial Autocorrelation:" forty years on](./references/CO69.Rmd)
- [Creating Neighbours](./references/nb.Rmd)
- [Creating Neighbours using sf objects](./references/nb_sf.Rmd)
- [Introduction to the North Carolina SIDS data set](./references/sids.Rmd)
- [No-neighbour observation and subgraph handling](./references/subgraphs.Rmd)