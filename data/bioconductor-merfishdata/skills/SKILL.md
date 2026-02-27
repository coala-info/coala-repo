---
name: bioconductor-merfishdata
description: This package provides access to curated MERFISH spatial transcriptomics datasets from Bioconductor and loads them into SpatialExperiment objects. Use when user asks to load MERFISH datasets, retrieve spatial transcriptomics data for mouse colon, hypothalamus, or ileum, and perform spatial analysis or benchmarking.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MerfishData.html
---


# bioconductor-merfishdata

name: bioconductor-merfishdata
description: Access and analyze MERFISH (Multiplexed Error-Robust Fluorescence in situ Hybridization) spatial transcriptomics datasets from Bioconductor. Use this skill to load curated datasets (Mouse Colon IBD, Hypothalamus, and Ileum) into SpatialExperiment objects for benchmarking, spatial analysis, and visualization.

# bioconductor-merfishdata

## Overview
The `MerfishData` package provides a streamlined interface to high-quality MERFISH datasets stored on Bioconductor's ExperimentHub. It converts raw spatial transcriptomics data into `SpatialExperiment` objects, which integrate count matrices, cell metadata (like cell types and sample conditions), and spatial coordinates (x, y, z).

## Installation and Setup
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("MerfishData")

library(MerfishData)
library(SpatialExperiment)
library(ExperimentHub)
```

## Loading Datasets
The package provides dedicated functions to retrieve specific datasets. These functions return a `SpatialExperiment` object.

### Mouse Colon IBD (Cadinu et al., 2024)
Profiles 943 genes across 1.35 million cells in a mouse colitis model.
```r
spe_colon <- MouseColonIbdCadinu2024()
```

### Mouse Hypothalamus (Moffitt et al., 2018)
Profiles 161 genes in the preoptic region, including sex and behavior metadata.
```r
spe_hypo <- MouseHypothalamusMoffitt2018()
```

### Mouse Ileum (Petukhov et al., 2021)
Focuses on cell segmentation benchmarking (Baysor vs. Cellpose).
```r
# Load with specific segmentation method
spe_ileum <- MouseIleumPetukhov2021(segmentation = "baysor")
```

## Working with SpatialExperiment Objects
Once loaded, use standard Bioconductor accessors to explore the data:

*   **Counts:** `counts(spe)` or `assay(spe, "counts")`
*   **Spatial Coordinates:** `spatialCoords(spe)` (returns x, y, and sometimes z)
*   **Cell Metadata:** `colData(spe)` (contains cell types, sample IDs, etc.)
*   **Gene Metadata:** `rowData(spe)`

## Common Workflows

### Visualizing Spatial Distribution
Use `ggplot2` to plot cell types in their physical tissue context.
```r
library(ggplot2)
df <- as.data.frame(cbind(colData(spe_colon), spatialCoords(spe_colon)))

ggplot(df, aes(x = x, y = y, color = tier1)) +
    geom_point(size = 0.5) +
    theme_bw() +
    labs(title = "Spatial Organization of Cell Types")
```

### Comparing Segmentation Methods
For the Ileum dataset, you can compare how different algorithms (Baysor vs. Cellpose) assigned transcripts to cells.
```r
spe_b <- MouseIleumPetukhov2021(segmentation = "baysor")
spe_c <- MouseIleumPetukhov2021(segmentation = "cellpose")

# Compare cell counts
ncol(spe_b) # Baysor
ncol(spe_c) # Cellpose
```

### Accessing Molecule-Level Data
Some datasets include the exact coordinates of every detected mRNA molecule (not just cell centroids).
```r
# For Ileum
eh <- ExperimentHub()
mol_data <- eh[["EH7543"]] 

# For Hypothalamus (stored in assays)
mol_list <- assay(spe_hypo, "molecules")
```

## Reference documentation
- [Import and representation of MERFISH mouse colon IBD data](./references/Merfish_mouse_colon_ibd.md)
- [Import and representation of MERFISH mouse hypothalamus data](./references/Merfish_mouse_hypothalamus.md)
- [Import and representation of MERFISH mouse ileum data](./references/Merfish_mouse_ileum.md)