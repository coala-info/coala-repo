---
name: bioconductor-alevinqc
description: alevinQC provides quality control tools and diagnostic reports for single-cell RNA-seq data processed with Salmon/alevin. Use when user asks to generate QC reports, launch interactive Shiny applications for data exploration, or create diagnostic plots for alevin output.
homepage: https://bioconductor.org/packages/release/bioc/html/alevinQC.html
---

# bioconductor-alevinqc

name: bioconductor-alevinqc
description: Quality control for alevin output. Use this skill to generate summary reports (HTML/PDF), launch interactive Shiny applications, and create diagnostic plots for single-cell RNA-seq data processed with Salmon/alevin.

## Overview

The `alevinQC` package provides a suite of tools to assess the quality of single-cell RNA-seq quantification performed by Salmon/alevin. It automates the generation of comprehensive QC reports and provides access to the underlying data structures for custom visualization.

## Core Workflow

### 1. Verify Input Files
Alevin output must maintain its original directory structure. Use `checkAlevinInputFiles()` to ensure all required files (e.g., `featureDump.txt`, `quants_mat.gz`, `meta_info.json`) are present in the base directory.

```r
library(alevinQC)
baseDir <- "path/to/alevin_output"
checkAlevinInputFiles(baseDir = baseDir)
```

### 2. Generate Reports
Create a static HTML or PDF report containing summary statistics and diagnostic plots.

```r
alevinQCReport(baseDir = baseDir, 
               sampleId = "mySample",
               outputFile = "alevinReport.html",
               outputFormat = "html_document",
               outputDir = getwd())
```

### 3. Interactive Exploration
Launch a Shiny application to explore the QC metrics interactively.

```r
app <- alevinQCShiny(baseDir = baseDir, sampleId = "mySample")
shiny::runApp(app)
```

## Data Extraction and Custom Plotting

To perform custom analysis or generate individual plots, read the alevin output into an R object.

### Reading Data
```r
alevin_data <- readAlevinQC(baseDir = baseDir)
# Access the cell barcode table
head(alevin_data$cbTable)
# Access summary statistics
alevin_data$summaryTables$finalWhitelist
```

### Individual Diagnostic Plots
The package provides specific functions for the plots found in the reports:

*   **Knee Plots**: `plotAlevinKneeRaw(alevin_data$cbTable)` and `plotAlevinKneeNbrGenes(alevin_data$cbTable)`
*   **Barcode Collapsing**: `plotAlevinBarcodeCollapse(alevin_data$cbTable)`
*   **Quantification Metrics**: `plotAlevinQuant(alevin_data$cbTable)`

## Tips and Constraints
*   **Alevin Flags**: To generate the full set of QC metrics, alevin must be run with the `--dumpFeatures` flag.
*   **Version Compatibility**: Ensure `alevinQC` is up to date to support output from newer Salmon versions (v0.14+).
*   **Directory Integrity**: Do not rename or move files within the alevin output folder, as the package relies on the standard directory structure.

## Reference documentation
- [alevinQC](./references/alevinqc.md)