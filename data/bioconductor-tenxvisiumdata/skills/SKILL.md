---
name: bioconductor-tenxvisiumdata
description: This tool provides access to 10X Genomics Visium spatial gene expression datasets formatted as SpatialExperiment objects. Use when user asks to retrieve spatial transcriptomics data for human or mouse tissues, load pre-processed Visium datasets, or access gene expression counts integrated with spatial coordinates and tissue images.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TENxVisiumData.html
---


# bioconductor-tenxvisiumdata

name: bioconductor-tenxvisiumdata
description: Access and load 10X Genomics Visium spatial gene expression datasets from Bioconductor. Use this skill to retrieve SpatialExperiment (SPE) objects for various human and mouse tissues, including breast cancer, brain, heart, and lymph node data for spatial transcriptomics analysis.

# bioconductor-tenxvisiumdata

## Overview

The `TENxVisiumData` package is a data experiment package that provides a collection of Visium spatial gene expression datasets by 10X Genomics. These datasets are formatted as `SpatialExperiment` objects, which integrate gene expression counts with spatial coordinates and tissue images. This skill guides the retrieval of these datasets for downstream spatial analysis in R.

## Loading Datasets

There are two primary ways to load data from this package: using specific convenience functions or via the `ExperimentHub` interface.

### Method 1: Named Functions (Recommended)

The package provides direct functions named after the datasets.

```r
library(TENxVisiumData)

# Load Human Heart data
spe_heart <- HumanHeart()

# Load Mouse Brain (Coronal) data
spe_mouse <- MouseBrainCoronal()

# Load Human Ovarian Cancer (includes targeted panels)
spe_ovarian <- HumanOvarianCancer()
```

### Method 2: ExperimentHub Interface

Use this method to browse all available versions or search programmatically.

```r
library(ExperimentHub)
eh <- ExperimentHub()
q <- query(eh, "TENxVisium")

# Load by ExperimentHub ID (e.g., EH6695)
spe <- eh[["EH6695"]]
```

## Available Datasets

The package includes datasets for:
- **Human:** Breast Cancer (IDC/ILC), Cerebellum, Colorectal Cancer, Glioblastoma, Heart, Lymph Node, Ovarian Cancer, Spinal Cord.
- **Mouse:** Brain (Coronal, Sagittal Anterior, Sagittal Posterior), Kidney.

## Working with the SpatialExperiment (SPE) Object

Once loaded, the data is contained in a `SpatialExperiment` object. Key components include:

### Spatial Coordinates
Access the x and y pixel coordinates for each spot:
```r
head(spatialCoords(spe))
```

### Image Data
Access the low-resolution or high-resolution tissue images and scale factors:
```r
imgData(spe)
```

### Targeted Panels (altExps)
Some datasets (like `HumanOvarianCancer`) contain targeted panels stored as alternative experiments:
```r
# Check for available panels
altExpNames(spe)

# Access a specific panel (e.g., Immunology)
spe_immuno <- altExp(spe, "TargetedImmunology")
```

### Multi-section Datasets
Datasets with multiple sections (e.g., `MouseBrainSagittalAnterior`) are consolidated. Use the `sample_id` column to differentiate them:
```r
table(spe$sample_id)
```

## Typical Workflow

1. **Load Package:** `library(TENxVisiumData)`
2. **Select Dataset:** Identify the tissue of interest (e.g., `HumanLymphNode()`).
3. **Inspect Object:** Check dimensions and metadata (`dim(spe)`, `colData(spe)`).
4. **Visualize/Analyze:** Use packages like `ggspavis` or `BayesSpace` for downstream analysis using the SPE object.

## Reference documentation

- [TENxVisiumData Vignette (Rmd)](./references/vignette.Rmd)
- [TENxVisiumData Vignette (Markdown)](./references/vignette.md)