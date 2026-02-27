---
name: bioconductor-msstatsshiny
description: MSstatsShiny provides a graphical user interface for performing proteomic data processing, normalization, and differential abundance analysis using the MSstats suite. Use when user asks to launch a Shiny application for proteomics, perform statistical analysis on mass spectrometry data, or visualize differential protein abundance.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsShiny.html
---


# bioconductor-msstatsshiny

## Overview
MSstatsShiny is an R-based Shiny application that provides a user-friendly interface for the MSstats suite of packages. It simplifies complex proteomic data analysis workflows—including data cleaning, normalization, and differential abundance testing—making these tools accessible to researchers without extensive R coding experience. It supports various mass spectrometry-based proteomic experiments (DDA, DIA, SRM, TMT).

## Installation
To install the package from Bioconductor, use the following R commands:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MSstatsShiny")
```

## Workflow and Usage

### Launching the Application
The primary way to use this package is by launching the local Shiny GUI. This opens a web browser interface where you can upload data and perform analyses.

```r
library(MSstatsShiny)
launch_MSstatsShiny()
```

### Key Features
- **Data Upload**: Supports output files from various processing tools (e.g., MaxQuant, Skyline, Spectronaut, Proteome Discoverer).
- **Data Processing**: Provides options for protein-level summarization, normalization, and filtering.
- **Statistical Analysis**: Performs differential abundance analysis using the MSstats or MSstatsTMT engines.
- **Visualization**: Generates quality control plots, volcano plots, and heatmaps.
- **Reproducibility**: The application allows users to download the R code used to generate the results, ensuring the analysis can be recreated exactly.

### Usage Tips
- **Console Monitoring**: While the GUI runs in a browser, keep an eye on the R console. Warnings, errors, and processing logs are printed there, which is essential for debugging data format issues.
- **File Size Limits**: For files larger than 250 MB, it is recommended to use the local installation via `launch_MSstatsShiny()` rather than the cloud-hosted version to avoid RAM constraints.
- **Integration**: The package acts as a wrapper for `MSstats`, `MSstatsTMT`, and `MSstatsPTM`. If you need to perform highly customized scripting beyond the GUI's capabilities, you should look into those specific underlying packages.

## Reference documentation
- [MSstatsShiny Launch Instructions](./references/MSstatsShiny_Launch_Instructions.md)