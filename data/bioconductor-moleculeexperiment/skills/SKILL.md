---
name: bioconductor-moleculeexperiment
description: The bioconductor-moleculeexperiment package provides a standardized framework for analyzing and visualizing molecule-level spatial transcriptomics data using the MoleculeExperiment class. Use when user asks to load raw spatial data from Xenium, CosMx, or Merscope platforms, create MoleculeExperiment objects from custom dataframes, subset spatial data by coordinates, or aggregate molecule data into SpatialExperiment objects for cell-level analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/MoleculeExperiment.html
---

# bioconductor-moleculeexperiment

name: bioconductor-moleculeexperiment
description: Analysis of molecule-based spatial transcriptomics data (Xenium, CosMx, Merscope) using the MoleculeExperiment class. Use this skill to create ME objects from raw vendor outputs or dataframes, perform molecule-level visualizations, subset spatial data by extent, and aggregate molecule data into SpatialExperiment objects for cell-level analysis.

# bioconductor-moleculeexperiment

## Overview

The `MoleculeExperiment` package provides a standardized framework for handling molecule-level spatial transcriptomics data. Unlike traditional cell-centric approaches, it stores individual transcript coordinates and segmentation boundaries (cells, nuclei, or custom regions) in a memory-efficient hierarchical list structure. This allows for analysis independent of initial cell segmentation and facilitates easy transition to `SpatialExperiment` objects for downstream cell-level workflows.

## Core Workflow

### 1. Loading Data

The package provides convenience functions for major spatial platforms.

```r
library(MoleculeExperiment)

# Xenium (10X Genomics)
me <- readXenium("path/to/xenium_out", keepCols = "essential", addBoundaries = "cell")

# CosMx (Nanostring)
me <- readCosmx("path/to/cosmx_out", addBoundaries = "cell")

# Merscope (Vizgen)
me <- readMerscope("path/to/merscope_out", addBoundaries = "cell")
```

### 2. Manual Construction

If working with custom dataframes, use `dataframeToMEList` to format data before calling the constructor.

```r
# Convert molecules dataframe
molList <- dataframeToMEList(df_mol, dfType = "molecules", assayName = "detected", 
                             sampleCol = "sample_id", factorCol = "gene", 
                             xCol = "x", yCol = "y")

# Convert boundaries dataframe
boundList <- dataframeToMEList(df_bound, dfType = "boundaries", assayName = "cell", 
                               sampleCol = "sample_id", factorCol = "cell_id", 
                               xCol = "vertex_x", yCol = "vertex_y")

# Create object
me <- MoleculeExperiment(molecules = molList, boundaries = boundList)
```

### 3. Data Access and Manipulation

Use getters and setters to interact with the slots. Note that `molecules()` and `boundaries()` return large lists; use `show*` functions for summaries.

*   **View Summary:** `showMolecules(me)`, `showBoundaries(me)`
*   **Get Flattened Data:** `molecules(me, assayName = "detected", flatten = TRUE)`
*   **Get IDs:** `features(me)`, `segmentIDs(me, "cell")`
*   **Add Boundaries:** 
    ```r
    boundaries(me, "nucleus") <- nucleiMEList
    ```
*   **Subsetting:** Use `subset_by_extent()` with a named vector `c(xmin, xmax, ymin, ymax)`.

### 4. Visualization

The package integrates with `ggplot2` via specific geom layers.

```r
ggplot_me() +
  geom_polygon_me(me, assayName = "cell", fill = "grey", alpha = 0.3) +
  geom_point_me(me, assayName = "detected", byColour = "feature_id", 
                selectFeatures = c("GeneA", "GeneB")) +
  coord_cartesian(xlim = c(100, 200), ylim = c(100, 200))
```

### 5. Aggregation to SpatialExperiment

To move to cell-level analysis, aggregate molecules within boundaries.

```r
# Counts molecules within cell boundaries
spe <- countMolecules(me, boundariesAssay = "cell")

# Resulting 'spe' is a standard SpatialExperiment object
```

## Tips and Best Practices

*   **Memory Efficiency:** The hierarchical list structure is designed to reduce redundancy. Avoid flattening the entire object into a dataframe unless working with a small subset.
*   **Coordinate Alignment:** When adding external segmentation (e.g., from `readSegMask`), ensure the `extent` matches the molecule coordinates.
*   **Essential Columns:** Use `keepCols = "essential"` during import to minimize memory usage if vendor-specific metadata (like quality scores) is not required for your analysis.

## Reference documentation

- [An introduction to the MoleculeExperiment Class](./references/MoleculeExperiment.md)