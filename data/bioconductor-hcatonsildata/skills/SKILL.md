---
name: bioconductor-hcatonsildata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HCATonsilData.html
---

# bioconductor-hcatonsildata

## Overview

The `HCATonsilData` package provides modular access to a comprehensive atlas of the human tonsil, a key secondary lymphoid organ. The dataset includes over 462,000 single-cell transcriptomes and covers multiple modalities: scRNA-seq, scATAC-seq, Multiome (joint RNA+ATAC), CITE-seq (transcriptome + ~200 surface proteins), and Visium Spatial Transcriptomics. The package allows users to load data as `SingleCellExperiment` or `SpatialExperiment` objects and provides a detailed glossary for the 121 identified cell types and states.

## Installation

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HCATonsilData")
```

## Data Retrieval

The primary function for data access is `HCATonsilData()`.

### List Available Subsets
Before downloading, check which cell types or compartments are available for a specific assay:

```r
library(HCATonsilData)
listCellTypes(assayType = "RNA")
# Common compartments: "All", "NBC-MBC", "GCBC", "PC", "CD4-T", "Cytotoxic", "myeloid", "FDC", "epithelial", "PDC"
```

### Load scRNA-seq Data
Retrieve gene expression data as a `SingleCellExperiment` object:

```r
# Load all epithelial cells
sce_epi <- HCATonsilData(assayType = "RNA", cellType = "epithelial")

# Load the full dataset (large)
sce_all <- HCATonsilData(assayType = "RNA", cellType = "All")
```

### Load Spatial Transcriptomics
Retrieve 10X Visium data as a `SpatialExperiment` object:

```r
spe <- HCATonsilData(assayType = "Spatial")
```

## Working with Metadata

The objects contain extensive cell-level and donor-level metadata in the `colData` slot.

### Key Metadata Fields
- `donor_id`: Unique identifier for the 17 donors.
- `age_group`: "kid", "young adult", or "old adult".
- `assay`: "3P" (scRNA-seq) or "multiome".
- `annotation_20230508`: The final high-resolution cell type annotation.
- `annotation_level_1`: Broad compartment (9 main groups).

### Access Donor Metadata
To see clinical and demographic details for the donors:

```r
data("donor_metadata")
head(donor_metadata)
```

## Cell Type Annotations and Glossary

The atlas defines 121 cell types. Use the glossary functions to understand the rationale behind specific annotations.

### Search the Glossary
Retrieve a dataframe of all cell types, descriptions, and marker genes:

```r
glossary <- TonsilData_glossary()
```

### Get Specific Cell Type Info
Get formatted information for a specific cell type (e.g., "Tfr" for T-follicular regulatory cells):

```r
TonsilData_cellinfo("Tfr")

# Generate an HTML report with UMAP plots and references
TonsilData_cellinfo_html("Tfr", display_plot = TRUE)
```

## External Modalities (ATAC, Multiome, CITE-seq)

While RNA and Spatial data are directly accessible via `HCATonsilData()`, other modalities are hosted as Seurat objects on Zenodo due to their size and specific data structures.

### Download Seurat Objects
The vignette provides URLs for these resources. Use `download.file` and `untar` to retrieve them:

- **scATAC-seq**: `https://zenodo.org/record/8373756/files/TonsilAtlasSeuratATAC.tar.gz`
- **Multiome**: `https://zenodo.org/record/8373756/files/TonsilAtlasSeuratMultiome.tar.gz`
- **CITE-seq**: `https://zenodo.org/record/8373756/files/TonsilAtlasSeuratCITE.tar.gz`

## Visualization Tips

Use the package-provided color palettes to match the publication's figures:

```r
data("colors_20230508")
library(scater)

# Example: Plot UMAP for epithelial cells using the official palette
plotUMAP(sce_epi, colour_by = "annotation_20230508") +
  scale_color_manual(values = colors_20230508$epithelial)
```

## Reference documentation

- [HCATonsilData Vignette](./references/HCATonsilData.md)
- [HCATonsilData R Markdown](./references/HCATonsilData.Rmd)