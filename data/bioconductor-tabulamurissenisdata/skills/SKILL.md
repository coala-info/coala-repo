---
name: bioconductor-tabulamurissenisdata
description: This package provides access to the Tabula Muris Senis aging mouse atlas containing bulk and single-cell RNA-seq data. Use when user asks to download SingleCellExperiment objects for specific mouse tissues, list available datasets from the atlas, or prepare aging mouse data for analysis and visualization.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TabulaMurisSenisData.html
---

# bioconductor-tabulamurissenisdata

name: bioconductor-tabulamurissenisdata
description: Access and use the Tabula Muris Senis dataset, a comprehensive aging mouse atlas containing bulk and single-cell RNA-seq data (FACS and Droplet). Use this skill to download SingleCellExperiment objects for specific tissues or the entire atlas, list available tissues, and prepare data for downstream analysis or interactive visualization with iSEE.

## Overview

The `TabulaMurisSenisData` package provides access to processed RNA-seq data from the *Tabula Muris Senis* project, which characterizes aging across multiple mouse tissues. Data is provided as `SingleCellExperiment` objects, making it compatible with standard Bioconductor workflows. It includes three main data types:
1. **Bulk RNA-seq**: Data from 17 organs across the mouse lifespan.
2. **Droplet SC-RNA-seq**: 10x Genomics droplet-based single-cell data.
3. **FACS SC-RNA-seq**: Smart-seq2 FACS-sorted single-cell data (higher sensitivity/coverage).

## Basic Workflow

### 1. Load the Package
```r
library(TabulaMurisSenisData)
library(SingleCellExperiment)
```

### 2. List Available Tissues
Before downloading single-cell data, check which tissues are available for each platform.
```r
# For Droplet data
listTabulaMurisSenisTissues(dataset = "Droplet")

# For FACS data
listTabulaMurisSenisTissues(dataset = "FACS")
```

### 3. Download Data
You can download data for all tissues or specific ones. Use `infoOnly = TRUE` to check the file size before downloading.

**Bulk Data:**
```r
tms_bulk <- TabulaMurisSenisBulk()
```

**Droplet Data:**
```r
# Download specific tissues
tms_droplet <- TabulaMurisSenisDroplet(tissues = c("Liver", "Kidney"))

# Download the entire atlas (large file)
tms_all_droplet <- TabulaMurisSenisDroplet(tissues = "All")$All
```

**FACS Data:**
```r
# Download with processed logcounts included
tms_facs <- TabulaMurisSenisFACS(tissues = "Heart", processedCounts = TRUE)
```

### 4. Explore the Data
The returned objects are `SingleCellExperiment` (SCE) objects.
```r
sce <- tms_facs$Heart

# View metadata (age, cell type, tissue, etc.)
colData(sce)

# View available assays (counts, logcounts)
assayNames(sce)

# View reduced dimensions (PCA, UMAP)
reducedDimNames(sce)
```

## Visualization and Analysis

### Plotting UMAP
The datasets come with pre-computed UMAP coordinates.
```r
library(ggplot2)
plot_data <- as.data.frame(reducedDim(sce, "UMAP"))
plot_data$cell_ontology_class <- colData(sce)$cell_ontology_class

ggplot(plot_data, aes(x = UMAP1, y = UMAP2, color = cell_ontology_class)) +
  geom_point(size = 0.5) +
  theme_minimal()
```

### Interactive Exploration with iSEE
The `iSEE` package is the recommended way to interactively explore these large SCE objects.
```r
library(iSEE)
# Ensure logcounts are present for better visualization
sce <- TabulaMurisSenisFACS(tissues = "Skin", processedCounts = TRUE)$Skin
iSEE(sce)
```

## Usage Tips
- **Memory Management**: The "All" datasets for Droplet and FACS are very large (>600MB download, several GB in RAM). If memory is limited, download only the specific tissues of interest.
- **Caching**: Data is downloaded via ExperimentHub and cached locally. Subsequent calls to the same function will load the data from the cache.
- **Processed Counts**: By default, `TabulaMurisSenisFACS` and `TabulaMurisSenisDroplet` may only return raw counts. Set `processedCounts = TRUE` to retrieve normalized `logcounts` if available.

## Reference documentation
- [TabulaMurisSenisData](./references/TabulaMurisSenisData.md)