---
name: bioconductor-plotgrouper
description: plotGrouper is a Bioconductor package that provides a Shiny-based graphical user interface for creating publication-quality plots and performing statistical tests. Use when user asks to generate interactive visualizations from CSV or Excel files, create ggplot2-based graphics without writing code, or perform absolute cell count transformations for flow cytometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/plotGrouper.html
---


# bioconductor-plotgrouper

## Overview

`plotGrouper` is a Bioconductor package designed to simplify the creation of publication-quality graphics. It provides a Shiny-based graphical user interface (GUI) that wraps `ggplot2`, `dplyr`, and `ggpubr`. It is particularly useful for users who want to import data from CSV, TSV, or Excel files and quickly generate plots with integrated statistical tests without writing extensive plotting code. It also supports flow cytometry data analysis, including absolute cell count transformations.

## Installation

To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("plotGrouper")
```

## Typical Workflow

### 1. Data Preparation
For `plotGrouper` to function correctly, your data should be organized in a "long" or "tidy" format with the following column types:
*   **Unique Identifier**: A column where every value is unique (e.g., Sample ID).
*   **Comparisons**: A column containing categorical variables used to group samples (e.g., Species, Treatment, Genotype).
*   **Variables**: One or more columns containing numeric data to be plotted (e.g., Length, Width, Count).

### 2. Launching the App
The primary way to use the package is by launching the interactive Shiny application:

```r
library(plotGrouper)
plotGrouper()
```

### 3. Using the Interface
*   **Data Import**: Load your file (Excel, CSV, or TSV). If using Excel, the sheet name is automatically captured.
*   **Variable Selection**: Choose which numeric columns to plot in the `Variables to plot` window.
*   **Grouping**: Use the `Comparisons` window to define the experimental groups.
*   **Customization**: Use the `Shapes`, `Colors`, and `Fills` selectors to modify the aesthetic mapping. Use the `Lock` checkboxes to prevent settings from resetting when changing variables.
*   **Geoms**: Combine multiple layers such as bar + point, violin + point, or box + crossbar.

### 4. Statistics and Reporting
*   **Statistics**: View and download calculated statistical comparisons (via `ggpubr`) in the `Statistics` tab.
*   **Reports**: Click `Add plot to report` to save the current visualization into a PDF report. You can manage, reload, and update these plots within the `Report` tab.

## Tips for Success
*   **Iris Example**: Upon first launch, click the "iris" button to load the built-in dataset. This demonstrates the required data structure and populates the menus automatically.
*   **Data Transformation**: If working with flow cytometry, ensure you include bead counts and dilution factors if you intend to use the absolute cell number transformation feature.
*   **Saving**: Individual plots can be saved directly from the `Plot` tab, while the `Plot Data` tab allows you to export the specific subset of data used for the current visualization.

## Reference documentation

- [plotGrouper Vignette (Rmd)](./references/plotGrouper-vignette.Rmd)
- [plotGrouper Vignette (Markdown)](./references/plotGrouper-vignette.md)