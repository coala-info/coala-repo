---
name: bioconductor-weberdivechalcdata
description: This package provides access to spatially-resolved transcriptomics and single-nucleus RNA-sequencing data from the human locus coeruleus. Use when user asks to load the WeberDivechaLCdata dataset, retrieve Visium spatial experiment objects, or access single-nucleus gene expression data for brain analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/WeberDivechaLCdata.html
---


# bioconductor-weberdivechalcdata

name: bioconductor-weberdivechalcdata
description: Access and use spatially-resolved transcriptomics (Visium) and single-nucleus RNA-sequencing (snRNA-seq) data from the human locus coeruleus (LC). Use this skill to load the WeberDivechaLCdata dataset into R as SpatialExperiment or SingleCellExperiment objects for downstream analysis of gene expression in the brain.

# bioconductor-weberdivechalcdata

## Overview

The `WeberDivechaLCdata` package provides a comprehensive gene expression landscape of the human locus coeruleus (LC). It contains two primary datasets:
1. **Visium SRT**: Spatially-resolved transcriptomics data (16 samples).
2. **snRNA-seq**: Single-nucleus RNA-sequencing data (20,191 nuclei).

These datasets are formatted as standard Bioconductor containers (`SpatialExperiment` and `SingleCellExperiment`), making them compatible with various spatial and single-cell analysis workflows.

## Loading the Data

The package provides two main accessor functions to retrieve the data objects.

```r
library(WeberDivechaLCdata)
library(SpatialExperiment)
library(SingleCellExperiment)

# Load the Visium SpatialExperiment object
spe <- WeberDivechaLCdata_Visium()

# Load the snRNA-seq SingleCellExperiment object
sce <- WeberDivechaLCdata_singleNucleus()
```

### Alternative: ExperimentHub Access
You can also retrieve the data using `ExperimentHub` IDs if you need to query metadata or specific versions.

```r
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "WeberDivechaLCdata")

# Retrieve by ID
spe <- eh[["EH7737"]]
sce <- eh[["EH7738"]]
```

## Data Structure and Exploration

### Visium Spatial Data (`spe`)
The `SpatialExperiment` object contains gene expression counts, spatial coordinates, and histology image metadata.

- **Assays**: `counts` (raw) and `logcounts` (normalized).
- **Spatial Coordinates**: Access using `spatialCoords(spe)`.
- **Histology Images**: Access image metadata using `imgData(spe)`.
- **Metadata**: `colData(spe)` contains sample IDs, donor IDs, and tissue/spot annotations.

```r
# View spatial coordinates
head(spatialCoords(spe))

# Check available images
imgData(spe)
```

### snRNA-seq Data (`sce`)
The `SingleCellExperiment` object contains single-nucleus expression data with extensive cell-type annotations.

- **Cell Annotations**: `colData(sce)` includes `label_merged` (cell types like inhibitory, oligodendrocytes, etc.) and specific markers for Noradrenaline (NE) and Serotonin (5HT) neurons.
- **Dimensionality Reduction**: Pre-computed `PCA` and `UMAP` are available in `reducedDims(sce)`.

```r
# View cell type labels
table(sce$label_merged)

# Access UMAP coordinates
head(reducedDim(sce, "UMAP"))
```

## Typical Workflow

1. **Installation**: Ensure `BiocManager` is used to install the package.
2. **Loading**: Call the accessor functions to load the data into the R environment.
3. **Subsetting**: Use standard R/Bioconductor subsetting (e.g., `spe[, spe$donor_id == "Br6522"]`) to focus on specific donors or samples.
4. **Visualization**: Use packages like `ggspavis` for spatial data or `scater` for single-cell data to visualize expression patterns.

## Reference documentation

- [WeberDivechaLCdata](./references/WeberDivechaLCdata.md)