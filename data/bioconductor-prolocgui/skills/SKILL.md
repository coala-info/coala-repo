---
name: bioconductor-prolocgui
description: The bioconductor-prolocgui package provides interactive Shiny applications for the visualization and analysis of spatial proteomics data. Use when user asks to explore protein localization, compare experimental conditions side-by-side, or visualize the aggregation of peptides into protein groups.
homepage: https://bioconductor.org/packages/release/bioc/html/pRolocGUI.html
---


# bioconductor-prolocgui

## Overview
The `pRolocGUI` package provides a suite of interactive Shiny applications designed for the visualization and analysis of spatial proteomics data. It builds upon the `MSnSet` data structure from the `MSnbase` package and the analytical methods in `pRoloc`. The package is primarily used to explore protein localization, compare experimental conditions (e.g., control vs. treated), and validate the quality of feature aggregation from peptides to proteins.

## Core Workflows

### 1. Loading the Environment
To use `pRolocGUI`, you must load the package along with `pRolocdata` if you wish to use example datasets.

```r
library("pRolocGUI")
library("pRolocdata")

# Load example data (e.g., mouse embryonic stem cells)
data(hyperLOPIT2015)
```

### 2. The `pRolocVis` Function
The primary entry point for all applications is the `pRolocVis` function. It takes an `object` (MSnSet or MSnSetList) and an `app` argument to specify the interface.

#### A. Exploratory Analysis (`app = "explore"`)
Used for searching specific proteins, zooming into PCA clusters, and viewing protein profiles.
```r
# Default app is "explore"
pRolocVis(object = hyperLOPIT2015, fcol = "markers")
```
*   **Features**: Interactive PCA/t-SNE plots, searchable data tables, and "Profiles" tabs showing relative abundances across fractions.
*   **Interactivity**: Double-click points on the plot or click rows in the table to select proteins. Use the "Zoom/reset" button after brushing an area.

#### B. Comparative Analysis (`app = "compare"`)
Used to compare two replicates or two different experimental conditions side-by-side.
```r
data(hyperLOPIT2015ms3r1)
data(hyperLOPIT2015ms3r2)
mydata <- MSnSetList(list(hyperLOPIT2015ms3r1, hyperLOPIT2015ms3r2))

# Launch side-by-side comparison
pRolocVis(mydata, app = "compare", fcol = "markers")
```
*   **Note**: If the feature columns differ between datasets, provide a vector: `fcol = c("markers", "final.assignment")`.

#### C. Aggregation Analysis (`app = "aggregate"`)
Used to visualize the relationship between low-level features (PSMs/peptides) and their aggregated protein groups.
```r
data("hyperLOPIT2015ms2psm")

# Visualize PSMs grouped by Protein Accession
pRolocVis(hyperLOPIT2015ms2psm, 
          app = "aggregate", 
          fcol = "markers", 
          groupBy = "Protein.Group.Accessions")
```
*   **Aggvar Plot**: Displays the distance between features within a group. High distance may indicate mis-identified peptides or outliers.

## Key Function Arguments
*   **object**: An `MSnSet` (for explore/aggregate) or `MSnSetList` of length 2 (for compare).
*   **fcol**: The feature metadata column used for color-coding (default is "markers").
*   **groupBy**: (Aggregate app only) The `fData` column used to group low-level features.
*   **method**: (Explore app) The dimensionality reduction method, e.g., "PCA" (default), "t-SNE", or "MDS".

## Tips for Interactive Use
*   **Stopping the App**: To return to the R console, press `Esc`, `Ctrl-C`, or the "Stop" button in RStudio.
*   **Exporting Data**: Use the "Save selection" button in the sidebar to download a CSV of the currently selected protein IDs.
*   **Visuals**: High-resolution PDFs of the current view can be generated via the "Download Plot" button.
*   **Customization**: Use the "Table Selection" tab to hide/show specific metadata columns and the "Colour Picker" to modify class colors.

## Reference documentation
- [pRolocGUI - Interactive visualisation of spatial proteomics data](./references/pRolocGUI.md)