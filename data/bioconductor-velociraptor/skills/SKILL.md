---
name: bioconductor-velociraptor
description: This tool performs RNA velocity analysis on single-cell data by providing a Bioconductor interface to the scVelo Python package. Use when user asks to calculate velocity vectors, estimate latent time, or project velocity onto low-dimensional embeddings from SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/velociraptor.html
---

# bioconductor-velociraptor

name: bioconductor-velociraptor
description: RNA velocity analysis for single-cell data using the Bioconductor framework. Use when Claude needs to calculate, embed, or visualize RNA velocity from SingleCellExperiment objects by interfacing with the scVelo Python package.

# bioconductor-velociraptor

## Overview

The `velociraptor` package provides a Bioconductor-friendly interface to the Python package `scvelo`. It allows users to perform RNA velocity analysis directly on `SingleCellExperiment` objects, bridging the gap between R-based single-cell workflows and Python-based velocity estimation.

## Basic Workflow

### 1. Prepare Data
Ensure your `SingleCellExperiment` object contains `spliced` and `unspliced` count matrices in its assays.

```r
library(velociraptor)
library(scRNAseq)

# Example: Loading spermatogenesis data
sce <- HermannSpermatogenesisData()
# assays(sce) should contain "spliced" and "unspliced"
```

### 2. Feature Selection
Perform standard feature selection (e.g., using `scran`) to identify highly variable genes (HVGs) before running velocity calculations.

```r
library(scran)
library(scuttle)

sce <- logNormCounts(sce)
dec <- modelGeneVar(sce)
top.hvgs <- getTopHVGs(dec, n=2000)
```

### 3. Run scVelo
Use the `scvelo()` function to estimate velocities. By default, it uses the steady-state model.

```r
# Note: scvelo.params is used to specify neighbor settings to match newer scVelo/Scanpy versions
velo.out <- scvelo(
  sce, 
  subset.row = top.hvgs, 
  assay.X = "spliced",
  scvelo.params = list(neighbors = list(n_neighbors = 30L))
)
```

The output `velo.out` is a `SingleCellExperiment` containing:
- `velocity` assay: The estimated velocity vectors.
- `velocity_pseudotime`: Latent time/pseudotime estimates in `colData`.
- `velocity_graph`: Connectivity matrix in `metadata`.

### 4. Visualization
Project velocity vectors onto low-dimensional embeddings (t-SNE, UMAP).

```r
# 1. Calculate embedding (e.g., t-SNE) on the original SCE
library(scater)
sce <- runPCA(sce, subset_row = top.hvgs)
sce <- runTSNE(sce, dimred = "PCA")

# 2. Embed velocity vectors into the t-SNE space
embedded <- embedVelocity(reducedDim(sce, "TSNE"), velo.out)

# 3. Summarize vectors into a grid for cleaner plotting
grid.df <- gridVectors(sce, embedded, use.dimred = "TSNE")

# 4. Plot using ggplot2
library(ggplot2)
plotTSNE(sce, colour_by = "velocity_pseudotime") +
    geom_segment(data = grid.df, mapping = aes(x = start.1, y = start.2, 
        xend = end.1, yend = end.2, colour = NULL), 
        arrow = arrow(length = unit(0.05, "inches")))
```

## Advanced Options

### Reusing Existing PCA
To ensure consistency and save time, pass existing dimensionality reduction results to `scvelo()`.

```r
velo.out <- scvelo(sce, assay.X = "spliced", subset.row = top.hvgs, use.dimred = "PCA")
```

### Using scVelo's Internal Pipeline
To mimic a pure Python workflow (including scVelo's own normalization and filtering), set `use.theirs = TRUE`. Note that this may reduce consistency with other Bioconductor steps.

```r
velo.out <- scvelo(sce, assay.X = 1, use.theirs = TRUE)
```

### Customizing scVelo Parameters
Pass specific arguments to underlying Python functions (e.g., `filter_and_normalize`, `moments`, `recover_dynamics`, `velocity`, `velocity_graph`) via the `scvelo.params` list.

```r
# Example: Changing the number of iterations for dynamical model recovery
velo.out <- scvelo(
    sce, 
    mode = "dynamical",
    scvelo.params = list(recover_dynamics = list(max_iter = 20))
)
```

## Tips and Best Practices
- **Assay Selection**: If a dedicated exonic count matrix is unavailable, the `"spliced"` assay is typically a suitable proxy for `assay.X`.
- **Memory**: RNA velocity calculations can be memory-intensive. For large datasets, consider subsetting cells or genes if resources are limited.
- **Python Environment**: `velociraptor` uses `basilisk` to manage the Python environment automatically. The first run may take time as it installs `scvelo` and dependencies.
- **Neighbor Calculation**: Since `scvelo` v0.4.0, neighbor calculation is handled via Scanpy. Use `scvelo.params = list(neighbors = list(n_neighbors = 30L))` to maintain consistency with older workflows that defaulted to 30 neighbors.

## Reference documentation
- [Computing RNA velocity in a Bioconductor framework](./references/velociraptor.md)