---
name: r-funrar
description: This tool computes functional rarity indices to quantify species distinctiveness, scarcity, uniqueness, and restrictedness within ecological communities. Use when user asks to calculate functional rarity metrics, compute functional distances between species, or analyze species rarity based on trait and abundance data.
homepage: https://cran.r-project.org/web/packages/funrar/index.html
---

# r-funrar

name: r-funrar
description: Computes functional rarity indices (Distinctiveness, Scarcity, Uniqueness, Restrictedness) for ecological communities using the funrar R package. Use this skill when analyzing species rarity from both abundance-based and functional trait-based perspectives, or when calculating indices proposed by Violle et al. (2017).

# r-funrar

## Overview
The `funrar` package provides a framework to characterize functional rarity at local and regional scales. It quantifies how "rare" a species is based on its functional traits (functional distance to others) and its distribution/abundance.

## Installation
```R
install.packages("funrar")
library(funrar)
```

## Core Workflow

### 1. Data Preparation
`funrar` requires two main inputs:
- **Site-Species Matrix**: Sites as rows, species as columns. Can be presence-absence (0/1) or abundances.
- **Functional Distance Matrix**: A symmetric matrix of pairwise functional distances between species.

**Format Conversion:**
Use `matrix_to_stack()` and `stack_to_matrix()` to toggle between wide (matrix) and long (tidy) formats.

### 2. Computing Functional Distances
If you have a trait data frame (species as rownames), compute the distance matrix first:
```R
# Default is Gower distance (handles mixed trait types)
dist_mat <- compute_dist_matrix(traits_df, metric = "gower")
```

### 3. Calculating Indices
You can compute all indices at once or individually.

**The Four Main Indices:**
- **Distinctiveness (Di)**: How functionally different a species is from others in its local community.
- **Scarcity (Si)**: How locally rare a species is in terms of abundance.
- **Uniqueness (Ui)**: The functional distance to the nearest neighbor in the regional pool.
- **Restrictedness (Ri)**: Geographic rarity based on occupancy across sites.

**Batch Computation:**
```R
# Returns a list containing Di, Si, Ui, and Ri
results <- funrar(pres_matrix = site_sp_mat, dist_matrix = dist_mat, rel_abund = TRUE)
```

**Individual Functions:**
- `distinctiveness(pres_matrix, dist_matrix)`
- `scarcity(pres_matrix)` (requires relative abundances)
- `uniqueness(pres_matrix, dist_matrix)`
- `restrictedness(pres_matrix)`

## Advanced Usage

### Relative Abundances
Indices like Scarcity require relative abundances (proportions summing to 1 per site).
```R
rel_mat <- make_relative(absolute_abund_matrix)
```

### Sparse Matrices
For large datasets with many zeros, use `Matrix` package objects to save memory and improve performance.
```R
library(Matrix)
sparse_mat <- as(my_mat, "dgCMatrix")
di_sparse <- distinctiveness(sparse_mat, dist_mat)
```

### Dimensional Analysis
To see how specific traits contribute to rarity, use dimension-specific functions:
- `distinctiveness_dimensions(site_sp_mat, traits_df)`: Computes Di for each trait separately and all combined.
- `uniqueness_dimensions(site_sp_mat, traits_df)`: Computes Ui for each trait separately and all combined.

## Tips
- **Species Names**: Ensure species names match exactly between the site-species matrix columns and the distance matrix row/column names.
- **Global Scale**: Use `distinctiveness_global(dist_matrix)` to compute distinctiveness relative to the entire regional pool rather than local communities.
- **Trait Range**: For specific niche analysis, an alternative definition of distinctiveness can be implemented by truncating distances beyond a specific trait range (T).

## Reference documentation
- [Introduction to funrar through an example](./references/funrar.Rmd)
- [Alternative definition of distinctiveness](./references/new_distinctiveness.Rmd)
- [Other functions of interest](./references/other_functions.Rmd)
- [Sparse Matrices within funrar](./references/sparse_matrices.Rmd)