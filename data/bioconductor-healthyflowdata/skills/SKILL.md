---
name: bioconductor-healthyflowdata
description: This package provides access to the healthyFlowData Bioconductor experiment data package containing a flowSet of 20 flow cytometry samples from healthy individuals. Use when user asks to load the hd dataset, inspect lymphocyte flow cytometry data, or access example PBMC samples for flowMatch analysis workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/healthyFlowData.html
---


# bioconductor-healthyflowdata

name: bioconductor-healthyflowdata
description: Access and utilize the healthyFlowData Bioconductor experiment data package. Use this skill when you need to load, inspect, or use the 'hd' flowSet dataset, which contains 20 flow cytometry samples from four healthy individuals (PBMC cells) stained for CD3, CD4, CD8, and CD19. This dataset is primarily used for demonstrating flow cytometry analysis workflows, specifically for the flowMatch package.

## Overview

The `healthyFlowData` package provides a standardized flow cytometry dataset (a `flowSet` object) derived from Peripheral Blood Mononuclear Cells (PBMC). The data consists of 20 samples: 4 healthy donors with 5 replicates each. Each sample has been pre-processed (compensated, transformed, and gated for lymphocytes) and includes four protein markers: CD3, CD4, CD8, and CD19.

## Loading and Inspecting Data

To use the dataset, load the library and use the `data()` function to bring the `hd` object into the environment.

```r
# Load the package
library(healthyFlowData)

# Load the healthy donor dataset
data(hd)

# Inspect the flowSet object
print(hd)

# View sample metadata (phenoData)
pData(hd)
```

## Dataset Structure

The dataset is stored as a `flowSet` object named `hd`.

- **Samples**: 20 experiments (labeled A_1 through D_5).
- **Markers/Channels**: CD4, CD8, CD3, and CD19.
- **Metadata Columns**:
    - `subject`: The ID of the healthy individual (A, B, C, or D).
    - `replicate`: The replicate number (1 to 5).
    - `Name`: The sample identifier.

## Common Workflows

### Accessing Individual Samples
Since `hd` is a `flowSet`, you can access individual `flowFrame` objects using standard flowCore syntax:

```r
# Access the first sample
first_sample <- hd[[1]]

# Access by name
sample_A1 <- hd[["A_1"]]
```

### Data Visualization
You can use the `flowViz` package (if installed) to visualize the distributions:

```r
library(flowViz)
# Density plots for CD3 across all samples
densityplot(~CD3, hd)

# Scatter plot of CD4 vs CD8 for a specific donor
xyplot(CD8 ~ CD4, data = hd[1:5])
```

## Usage Tips
- **Pre-processing**: The data is already compensated and transformed. You do not need to apply further variance-stabilizing transformations for basic analysis.
- **Gating**: The samples are already gated on forward and side scatter to identify lymphocytes; the events present are exclusively lymphocyte cells.
- **Purpose**: This package is a "data-only" package. It does not contain analysis functions but serves as a clean, lightweight dataset for testing algorithms in `flowMatch` or other flow cytometry R packages.

## Reference documentation

- [healthyFlowData](./references/healthyFlowData.md)