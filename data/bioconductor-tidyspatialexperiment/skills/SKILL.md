---
name: bioconductor-tidyspatialexperiment
description: This tool provides a tidyverse-compatible interface for SpatialExperiment objects, allowing users to manipulate spatial transcriptomics data using familiar dplyr and tidyr verbs. Use when user asks to apply tidy data manipulations to spatial experiments, join gene expression with spot metadata, select cells using geometric shapes or interactive gating, and aggregate data for pseudobulk analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/tidySpatialExperiment.html
---

# bioconductor-tidyspatialexperiment

## Overview

`tidySpatialExperiment` is a bridge between the `SpatialExperiment` Bioconductor class and the `tidyverse` ecosystem. It provides a "tibble abstraction" for spatial transcriptomics data, where cells (spots) are treated as rows and metadata/spatial coordinates are treated as columns. This allows for seamless data manipulation, filtering, and visualization without losing the underlying formal S4 structure required for Bioconductor workflows.

## Core Workflows

### 1. Initialization and Abstraction
Loading the library automatically activates the tibble abstraction. The object will print like a tibble, showing `colData` and `spatialCoords` as integrated columns.

```r
library(tidySpatialExperiment)
# Assuming 'spe' is a SpatialExperiment object
spe
```

### 2. Tidy Manipulation
You can use standard `dplyr` and `tidyr` verbs directly on the `SpatialExperiment` object.

*   **Filtering and Mutating:** Filter spots based on tissue location or metadata, and create new metrics.
    ```r
    spe_filtered <- spe |>
      filter(in_tissue == TRUE) |>
      mutate(is_high_col = array_col > 50)
    ```
*   **Nesting:** Group data by sample or condition for batch processing.
    ```r
    spe_nested <- spe |> nest(data = -sample_id)
    ```

### 3. Joining Feature Data
To analyze specific gene expression alongside spot metadata, use `join_features()`.

*   **Wide format (preserves SPE object):** Useful for further tidy filtering or ggplot2.
    ```r
    spe |> join_features(features = c("ENSMUSG00000025915"), shape = "wide")
    ```
*   **Long format (returns a tibble):** Best for complex plotting where genes are mapped to aesthetics.
    ```r
    spe |> join_features(features = c("GeneA", "GeneB"), shape = "long")
    ```

### 4. Spatial Selection Utilities
The package provides geometric helpers to select cells based on their spatial coordinates (`pxl_col_in_fullres`, `pxl_row_in_fullres` or `array_col`, `array_row`).

*   **Geometric Shapes:**
    ```r
    # Select cells in an ellipse
    spe |> mutate(in_center = ellipse(array_col, array_row, center = c(20, 40), radius = c(10, 10)))
    
    # Select cells in a rectangle
    spe |> filter(rectangle(array_col, array_row, c(10, 20), c(30, 40)))
    ```
*   **Interactive Gating:** Use `gate()` to launch a Shiny/Plotly interface for manual selection.
    ```r
    spe_gated <- spe |> gate()
    # Results are stored in the .gated column
    ```

### 5. Aggregation (Pseudobulk)
Aggregate cell-level data into sample-level or group-level summaries for differential expression.
```r
spe_aggregated <- spe |> aggregate_cells(sample_id, assays = "counts")
```

## Special Column Behavior

*   **Protected Columns:** `sample_id`, `pxl_col_in_fullres`, and `pxl_row_in_fullres` are protected. They cannot be easily removed or modified in ways that break the `SpatialExperiment` structure.
*   **Key Column:** The `.cell` column is the primary key. Removing it via `select()` will cause the object to downgrade from a `SpatialExperiment` to a standard `tibble`.

## Reference documentation

- [Overview](./references/overview.md)