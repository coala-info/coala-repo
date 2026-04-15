---
name: bioconductor-vectrapolarisdata
description: This package provides large-scale multiplex immunofluorescence datasets from lung and ovarian cancer formatted as SpatialExperiment objects. Use when user asks to load Vectra Polaris mIF data, access spatial coordinates and cell phenotypes, or perform spatial analysis on multiplexed imaging datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/VectraPolarisData.html
---

# bioconductor-vectrapolarisdata

## Overview

The `VectraPolarisData` package provides large-scale multiplex immunofluorescence (mIF) datasets. These datasets include cell segmentation, phenotyping (via Inform software), and spatial coordinates. Data is structured as `SpatialExperiment` objects, making them compatible with standard Bioconductor workflows for single-cell and spatial analysis.

## Loading Data

The package provides two primary datasets accessible via convenience functions:

```r
library(VectraPolarisData)

# Load Human Lung Cancer (Vectra 3)
spe_lung <- HumanLungCancerV3()

# Load Human Ovarian Cancer (Vectra Polaris)
spe_ovarian <- HumanOvarianCancerVP()
```

Alternatively, use `ExperimentHub` for versioned access:

```r
library(ExperimentHub)
eh <- ExperimentHub()
q <- query(eh, "VectraPolarisData")
spe <- eh[[q$ah_id[1]]] # Load by Accession ID (e.g., EH7311)
```

## Data Structure

The datasets use the `SpatialExperiment` class. Key components include:

*   **Assays**: Access marker intensities using `assays(spe)`.
    *   `intensities`: Mean total cell intensity.
    *   `nucleus_intensities`: Mean intensity within the nucleus.
    *   `membrane_intensities`: Mean intensity within the membrane.
*   **ColData**: Cell-level metadata (e.g., `cell_id`, `phenotype`, `tissue category`).
*   **SpatialCoords**: X and Y coordinates of cell centers. Access via `spatialCoords(spe)`.
*   **Metadata**: Subject-level clinical data (e.g., survival, age, stage). Access via `metadata(spe)$clinical_data`.

## Common Workflows

### Converting to Data Frame
For analysis with `tidyverse` or non-Bioconductor tools, flatten the object:

```r
library(dplyr)

# Extract components
cd <- as.data.frame(colData(spe_ovarian))
coords <- as.data.frame(spatialCoords(spe_ovarian))
clin <- metadata(spe_ovarian)$clinical_data

# Combine cell-level data
cell_df <- cbind(cd, coords)

# Join with clinical data
full_df <- full_join(clin, cell_df, by = "sample_id")
```

### Accessing Specific Markers
Markers vary by dataset:
*   **Lung**: cd3, cd8, cd14, cd19, cd68, ck, dapi, hladr.
*   **Ovarian**: cd3, cd8, cd19, cd68, ck, dapi, ier3, ki67, pstat3.

```r
# Example: Get CD8 intensities
cd8_vals <- assay(spe_lung, "intensities")["cd8", ]
```

## Usage Tips
*   **Tissue Categories**: Most images are segmented into "Stroma" or "Tumor" regions, found in the `tissue category` column of `colData`.
*   **Sample vs. Patient**: In the Ovarian dataset, `sample_id` typically identifies the subject (one image per subject). In the Lung dataset, `slide_id` identifies the patient.
*   **Spatial Analysis**: Use the `spatialCoords` with packages like `spatstat` or `SPIAT` to calculate cell-to-cell distances or neighborhood enrichment.

## Reference documentation
- [VectraPolarisData](./references/VectraPolarisData.md)