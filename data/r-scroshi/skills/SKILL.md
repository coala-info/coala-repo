---
name: r-scroshi
description: R package scroshi (documentation from project home).
homepage: https://cran.r-project.org/web/packages/scroshi/index.html
---

# r-scroshi

## Overview
The `scROSHI` package provides a robust, supervised method for identifying cell types based on gene expression profiles. It utilizes previously defined cell-type-specific gene sets and accounts for the hierarchical relationships between cell types (e.g., major types and their subtypes). It is particularly useful because it does not require annotated training data or model training.

## Installation
Install the package from CRAN:
```R
install.packages("scROSHI")
```

## Core Workflow
The primary function is `scROSHI()`. It requires three specific input components:

1.  **Expression Data (`sce_data`)**: A `SingleCellExperiment` object containing the single-cell expression profiles.
2.  **Marker Gene Lists (`celltype_lists`)**: A list where names are cell types and values are character vectors of marker genes. Alternatively, a path to a `.gmt` or `.gmx` file.
3.  **Hierarchical Config (`type_config`)**: A two-column `data.frame`. 
    *   Column 1: Major cell types.
    *   Column 2: Subtypes (comma-separated if multiple).

### Basic Example
```R
library(scROSHI)
library(SingleCellExperiment)

# Load example data provided by the package
data("test_sce_data")
data("config")
data("marker_list")

# Run the identification
results <- scROSHI(sce_data = test_sce_data,
                   celltype_lists = marker_list,
                   type_config = config)

# The output is a SingleCellExperiment object with results in colData
# 'celltype_final' contains the assigned labels
table(results$celltype_final)
```

## Input Specifications

### Marker Gene List
The `celltype_lists` can be a named list:
```R
marker_list <- list(
  "B-cells" = c("CD19", "CD79A", "MS4A1"),
  "T-cells" = c("CD3D", "CD3E", "CD3G")
)
```

### Configuration Data Frame
The `type_config` defines the hierarchy. If a cell type has no subtypes, the second column can be empty or NA.
```R
config <- data.frame(
  major = c("Lymphocytes", "Myeloid"),
  subtypes = c("B-cells,T-cells,NK-cells", "Monocytes,Dendritic.cells")
)
```

## Tips for Success
*   **Gene Symbols**: Ensure the gene symbols in your marker lists match the rownames of your `SingleCellExperiment` object (e.g., both use HGNC symbols or both use Ensembl IDs).
*   **Uncertain Cells**: The algorithm may label cells as "uncertain" if the expression profile does not strongly match the provided marker sets.
*   **Hierarchical Depth**: While the config supports major types and subtypes, ensure the marker list contains definitions for every label mentioned in the config.

## Reference documentation
- [scROSHI README](./references/README.html.md)
- [scROSHI Home Page](./references/home_page.md)