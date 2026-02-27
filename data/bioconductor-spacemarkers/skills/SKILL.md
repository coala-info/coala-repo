---
name: bioconductor-spacemarkers
description: This tool identifies molecular interactions between cell groups in spatial transcriptomics data by analyzing gene expression in regions where latent spatial patterns overlap. Use when user asks to identify interacting genes in spatial data, find non-linear expression patterns in overlapping cell types, or analyze spatial hotspots using latent feature analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SpaceMarkers.html
---


# bioconductor-spacemarkers

name: bioconductor-spacemarkers
description: Identify biologically relevant molecular interactions between cell groups in spatial transcriptomics data using latent feature analysis. Use this skill when analyzing Visium or similar spatial data to find genes with non-linear expression patterns in regions where different cell types or latent patterns overlap.

## Overview
SpaceMarkers is a Bioconductor package designed to infer molecular interactions between cell groups by leveraging latent features (e.g., from CoGAPS). It identifies "hotspots" of spatial influence for specific patterns and determines which genes are significantly up-regulated or down-regulated in overlapping regions compared to regions where patterns exist in isolation.

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SpaceMarkers")
library(SpaceMarkers)
```

## Typical Workflow

### 1. Data Preparation
SpaceMarkers requires an expression matrix, spatial coordinates, and latent feature patterns (e.g., CoGAPS sample factors).

```R
# Load Visium expression data
counts_matrix <- load10XExpr(visiumDir = "path/to/data", h5filename = "filtered_feature_bc_matrix.h5")

# Load spatial coordinates
spCoords <- load10XCoords(visiumDir = "path/to/data", resolution = "lowres")

# Combine coordinates with latent patterns (e.g., from a CoGAPS result)
# spPatterns should have columns: barcode, x, y, and Pattern_1, Pattern_2, etc.
spPatterns <- cbind(spCoords, cogaps_sample_factors)
```

### 2. Identify Spatial Parameters
Determine the kernel width (`sigmaOpt`) and outlier threshold (`threshOpt`) for each pattern using Moran's I based optimization.

```R
optParams <- get_spatial_parameters(spPatterns, visiumDir = "path/to/data", resolution = "lowres")
```

### 3. Identify Interacting Genes
The core function `get_pairwise_interacting_genes` identifies genes associated with regions of pattern overlap.

**Modes:**
*   **residual (Default):** Compares expression to a reconstructed matrix to account for confounding linear effects. Requires a `reconstruction` matrix.
*   **DE:** Assesses simple linear interactions directly from expression. Set `reconstruction = NULL`.

**Analysis Types:**
*   **overlap:** Stricter; genes must pass post-hoc tests.
*   **enrichment:** More inclusive; useful for pathway analysis.

```R
# Residual Mode
results <- get_pairwise_interacting_genes(
    data = counts_matrix,
    reconstruction = cogaps_reconstruction_matrix,
    optParams = optParams,
    spPatterns = spPatterns,
    mode = "residual",
    analysis = "overlap"
)

# DE Mode
results_de <- get_pairwise_interacting_genes(
    data = counts_matrix,
    reconstruction = NULL,
    optParams = optParams,
    spPatterns = spPatterns,
    mode = "DE",
    analysis = "overlap"
)
```

### 4. Interpreting Results
The output is a list of data frames containing:
*   `interacting_genes`: Statistics (Kruskal-Wallis and Dunn's test) and the `SpaceMarkersMetric`.
*   `hotspots`: A data frame indicating the regions of influence for the patterns.

**SpaceMarkersMetric:**
*   **Positive:** Gene is highly expressed in the interacting (overlap) region relative to individual patterns.
*   **Negative:** Gene expression is lower in the interacting region.

```R
# View top interacting genes for the first pattern pair
top_genes <- results[[1]]$interacting_genes[[1]]
head(top_genes[order(-top_genes$SpaceMarkersMetric), ])
```

## Visualization
Use the built-in function to overlay gene expression or pattern weights onto the tissue image.

```R
plot_spatial_data_over_image(
    visiumDir = "path/to/data",
    df = cbind(spPatterns, as.matrix(t(counts_matrix))),
    feature_col = "GENE_NAME",
    resolution = "lowres",
    title = "Gene Expression Overlap"
)
```

## Tips
*   **Sparse Data:** Warnings about dropped columns during Kruskal-Wallis tests are common with sparse single-cell/spatial data and usually indicate regions with insufficient non-zero counts for that specific gene.
*   **Memory:** For large datasets, subset the `counts_matrix` to genes of interest or highly variable genes before running the interaction analysis.
*   **Column Names:** Ensure `spPatterns` contains columns explicitly named 'x' and 'y'.

## Reference documentation
- [Inferring Immune Interactions in Breast Cancer](./references/SpaceMarkers_vignette.md)
- [SpaceMarkers Vignette Source](./references/SpaceMarkers_vignette.Rmd)