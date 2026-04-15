---
name: r-spacexr
description: This R package performs cell type deconvolution and cell type-specific differential expression analysis for spatial transcriptomics data. Use when user asks to deconvolute spatial pixels into cell type proportions, run Robust Cell Type Decomposition, or identify cell type-specific differential expression across spatial covariates.
homepage: https://cran.r-project.org/web/packages/spacexr/index.html
---

# r-spacexr

name: r-spacexr
description: Specialized R package for spatial transcriptomics analysis, specifically Robust Cell Type Decomposition (RCTD) and Cell type-Specific Inference of Differential Expression (C-SIDE). Use this skill when analyzing spatial transcriptomics data (Slide-seq, Visium, MERFISH) to identify cell type mixtures within pixels or to detect differential expression across spatial covariates.

## Overview

The `spacexr` package provides two primary algorithms for spatial transcriptomics:
1. **RCTD (Robust Cell Type Decomposition)**: Deconvolutes spatial pixels into cell type proportions using a single-cell RNA-seq reference. It accounts for platform effects and handles both singlets and cell type mixtures.
2. **C-SIDE (Cell type-Specific Inference of Differential Expression)**: Identifies genes that are differentially expressed within specific cell types as a function of spatial covariates (e.g., position, microenvironment, or cell-cell interactions).

## Installation

```R
# Install from GitHub (recommended for full CSIDE functionality)
if (!require("devtools", quietly = TRUE)) install.packages("devtools")
options(timeout = 600000000)
devtools::install_github("dmcable/spacexr", build_vignettes = FALSE)
```

## Workflow: RCTD (Cell Type Decomposition)

### 1. Data Preparation
Create `SpatialRNA` and `Reference` objects from your count matrices and coordinates.

```R
# Spatial data (puck)
puck <- SpatialRNA(coords, counts)

# Reference data (scRNA-seq)
reference <- Reference(counts_ref, cell_types_ref)
```

### 2. Run RCTD
Initialize the RCTD object and run the decomposition.

```R
# Create RCTD object
myRCTD <- create.RCTD(puck, reference, max_cores = 8, test_mode = FALSE)

# Run RCTD
# doublet_mode: 'doublet' (1-2 types), 'full' (any mixture), or 'multi'
myRCTD <- run.RCTD(myRCTD, doublet_mode = 'doublet')
```

### 3. Access Results
Results are stored in the `@results` slot.
- `myRCTD@results$weights`: Cell type weights for each pixel.
- `myRCTD@results$results_df`: Classification (singlet/doublet) and predicted types.

## Workflow: C-SIDE (Differential Expression)

### 1. Define Covariates
Covariates must be numeric vectors named with pixel barcodes, typically standardized between 0 and 1.

```R
# Example: spatial x-coordinate as a covariate
my_covariate <- puck@coords$x
names(my_covariate) <- rownames(puck@coords)
my_covariate <- (my_covariate - min(my_covariate)) / (max(my_covariate) - min(my_covariate))
```

### 2. Run C-SIDE
Use the RCTD object containing cell type assignments.

```R
# For a single covariate
myRCTD <- run.CSIDE.single(myRCTD, my_covariate, gene_threshold = 0.01, 
                           cell_type_threshold = 125, fdr = 0.05)
```

### 3. Visualization
```R
# Generate standard DE plots
make_all_de_plots(myRCTD, resultsdir)
```

## Key Functions and Tips

- `create.RCTD`: Always check `test_mode = FALSE` for production runs.
- `doublet_mode`: Use `'doublet'` for high-resolution data (Slide-seq) and `'full'` for lower resolution (Visium) where many cells occupy one spot.
- `import_weights`: Use this if you have cell type assignments from another tool but want to use C-SIDE for DE.
- `run.CSIDE.regions`: Use for DE between discrete spatial regions.
- `run.CSIDE.nonparametric`: Use for discovering spatial patterns without a predefined functional form.

## Reference documentation

- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Package Home Page](./references/home_page.md)