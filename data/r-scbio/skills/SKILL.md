---
name: r-scbio
description: R package scbio (documentation from project home).
homepage: https://cran.r-project.org/web/packages/scbio/index.html
---

# r-scbio

## Overview
The `scBio` package provides tools for understanding cellular variability within tissues by combining single-cell genomics with bulk genomics data. Its primary method, **CPM (Cell Population Mapping)**, uses computational deconvolution to identify cell population maps. Unlike traditional deconvolution that only estimates cell type proportions, CPM focuses on cell alterations within each cell type, allowing for the modeling of cell changes across trajectories and specific cell subtypes.

## Installation
Install the package from CRAN:
```R
install.packages("scBio")
library(scBio)
```

## Core Workflow: CPM (Cell Population Mapping)
The `CPM` function is the primary tool for deconvolution. It can be used in relative or absolute modes.

### Mandatory Inputs
- `SCData`: Single-cell RNA-seq matrix (genes x cells). For large datasets, use a random sample of cells to reduce computation time.
- `SCLabels`: Vector of labels for each cell in `SCData`.
- `BulkData`: Heterogeneous RNA-seq matrix (genes x samples).
- `cellSpace`: The cell state space (1D vector or 2D matrix). This should represent similarities within cell types (e.g., coordinates from a trajectory or embedding).

### Key Parameters
- `neighborhoodSize`: Size of cell neighborhood (default: 10). Must be smaller than the smallest cell type count.
- `modelSize`: Reference subset size per iteration (default: 50).
- `no_cores`: Number of CPU cores (default: total - 1).
- `quantifyTypes`: Set to `TRUE` to predict cell-type quantities (recommended only for homogeneous cell types).

### Relative Prediction (Comparison Mode)
Use this when comparing a test group (e.g., disease) against a control group (e.g., healthy).
1. Ensure data is in **log-scale**.
2. Subtract the mean of the control group from the test group.
3. Run CPM:
```R
# Example: Subtracting control mean
BulkFluReduced = BulkFlu - rowMeans(BulkFlu[, control_indices])
BulkFluReduced = BulkFluReduced[, test_indices]

res = CPM(SCData = SCFlu, SCLabels = SCLabels, BulkData = BulkFluReduced, cellSpace = SCCellSpace)
```

### Absolute Prediction
Use this for direct abundance estimation.
1. Ensure data is in **linear-scale**.
2. Run CPM:
```R
resAbs = CPM(SCData = SCFluAbs, SCLabels = SCLabels, BulkData = BulkFluAbs, cellSpace = SCCellSpace)
```

### Cell Type Prediction
To use CPM for standard cell-type deconvolution:
1. Set `quantifyTypes = TRUE`.
2. Use a homogeneous cell space (e.g., based on low-variance genes).
3. If using absolute data, set `typeTransformation = TRUE` to get fractions.

## Tips and Best Practices
- **Large Datasets**: CPM is iterative and computationally intensive. If the single-cell reference is very large, downsample the cells randomly before running.
- **Cell Space**: The `cellSpace` does not require separation between different cell types, as CPM handles overlapping types by dividing the space into fragments.
- **Neighborhood Size**: In version 0.1.5+, the package automatically alters the neighborhood size if a cell type has a limited number of cells.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)