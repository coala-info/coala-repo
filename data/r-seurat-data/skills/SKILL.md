---
name: r-seurat-data
description: This tool provides access to the SeuratData R package for loading curated single-cell datasets pre-packaged as Seurat objects. Use when user asks to list available datasets, install specific single-cell data, or load standard datasets like pbmc3k or ifnb for Seurat analysis workflows.
homepage: https://cran.r-project.org/web/packages/seurat-data/index.html
---

# r-seurat-data

name: r-seurat-data
description: Provides access to the SeuratData R package for loading curated single-cell datasets pre-packaged as Seurat objects. Use this skill when you need to load standard datasets (like 'pbmc3k', 'ifnb', or 'panc8') for tutorials, benchmarking, or testing Seurat workflows.

# r-seurat-data

## Overview
The `SeuratData` package is a companion to the Seurat ecosystem that simplifies the acquisition of curated single-cell datasets. It manages the installation and loading of datasets that have been pre-processed into Seurat objects, ensuring that users can immediately begin analysis without manual data formatting.

## Installation
To install the package and its dependencies:
```R
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
remotes::install_github("satijalab/seurat-data")
library(SeuratData)
```

## Workflow and Usage

### 1. List Available Datasets
To see which datasets are available for installation:
```R
AvailableData()
```

### 2. Install a Dataset
Datasets must be installed before they can be loaded. Use the dataset name found in `AvailableData()`.
```R
InstallData("pbmc3k")
# Common datasets: "ifnb", "panc8", "pbmc3k", "thp1.eccite", "bmcite"
```

### 3. Load a Dataset
Once installed, use `LoadData()` to bring the object into the R environment.
```R
# Load the dataset into an object
pbmc <- LoadData("pbmc3k")

# Verify the object
pbmc
```

## Common Datasets and Use Cases
- **pbmc3k**: Standard 2,700 cell PBMC dataset for basic clustering and QC tutorials.
- **ifnb**: Interferon-stimulated vs. control PBMCs, used for integration and differential expression vignettes.
- **panc8**: Pancreatic islet cells from 8 different technologies, used for reference mapping and batch correction.
- **thp1.eccite**: Multimodal ECCITE-seq data for CRISPR perturbation (mixscape) analysis.
- **bmcite**: CITE-seq bone marrow data for multimodal (RNA + ADT) analysis.

## Tips
- **Storage**: Datasets are stored locally after installation. You only need to run `InstallData()` once per environment.
- **Dependencies**: Some datasets may require specific versions of `Seurat` or `SeuratObject`. Always ensure your Seurat installation is up to date.
- **Metadata**: Most `SeuratData` objects come with pre-populated metadata (e.g., `celltype`, `stim`, `tech`) which is useful for validating unsupervised clustering results.

## Reference documentation
- [Home Page](./references/home_page.md)
- [Installation Instructions](./references/install_v5.md)
- [Essential Commands](./references/essential_commands.md)
- [PBMC 3K Tutorial](./references/pbmc3k_tutorial.md)
- [Integration Introduction](./references/integration_introduction.md)
- [Mapping and Annotating Query Datasets](./references/integration_mapping.md)
- [Mixscape Vignette](./references/mixscape_vignette.md)