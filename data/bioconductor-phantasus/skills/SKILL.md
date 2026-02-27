---
name: bioconductor-phantasus
description: Phantasus provides a web-based interface for interactive gene expression analysis and visualization by integrating Morpheus heatmaps with R-based statistical methods. Use when user asks to perform interactive differential expression analysis, visualize gene expression heatmaps, load datasets from GEO, or execute pathway enrichment analysis through a browser-based UI.
homepage: https://bioconductor.org/packages/release/bioc/html/phantasus.html
---


# bioconductor-phantasus

## Overview
Phantasus is a Bioconductor package that provides a web-based interface for interactive gene expression analysis. It integrates the Morpheus heatmap visualization tool with R-based analysis methods. It allows users to load data from GEO, perform log-transformation, quantile normalization, collapse probes, and execute advanced statistical workflows like limma differential expression and FGSEA pathway enrichment directly through a browser-based UI or by serving the application locally.

## Core Functions
- `servePhantasus()`: Launches the Phantasus web application.
- `updateARCHS4()`: Downloads and updates ARCHS4 gene expression counts for RNA-seq support.
- `getPhantasusConfig()`: Retrieves current configuration settings.

## Typical Workflow

### 1. Starting the Application
To begin an interactive session, load the library and call the server function:
```r
library(phantasus)
servePhantasus(port = 8000, host = "0.0.0.0", openInBrowser = TRUE)
```

### 2. Data Loading and Preparation
- **GEO Datasets**: In the UI, use "Choose a file..." > "GEO Datasets" and enter a GSE ID (e.g., `GSE53986`).
- **Normalization**: Navigate to `Tools > Adjust`. Common steps include `Log 2` and `Quantile normalize`.
- **Collapsing Probes**: For microarrays, use `Tools > Collapse` (e.g., "Maximum Median Probe") to map multiple probes to a single Gene ID.
- **Filtering**: Use `Tools > Create Calculated Annotation` to find mean expression, then `Tools > Filter` to remove lowly expressed genes.

### 3. Analysis Methods
- **PCA**: `Tools > Plots > PCA Plot` to visualize sample clustering and identify outliers.
- **Differential Expression**: `Tools > Differential Expression > limma`. Select the annotation field (e.g., "treatment") and define the comparison classes.
- **Pathway Analysis**: 
    - `Tools > Pathway Analysis > Perform FGSEA` for rank-based enrichment.
    - `Tools > Pathway Analysis > Submit to Enrichr` for external web-based enrichment.
- **Clustering**: Use `Tools > Clustering > k-means` or `Hierarchical clustering` to group genes or samples.

### 4. Programmatic Preloading
You can serve Phantasus with specific datasets pre-processed in R:
```r
# Create an ExpressionSet
library(GEOquery)
gse <- getGEO("GSE14308")[[1]]
ess <- list(my_dataset = gse)

# Save to a directory
preloadedDir <- tempdir()
save(ess, file = file.path(preloadedDir, "my_data.rda"))

# Serve with preloaded data
servePhantasus(preloadedDir = preloadedDir)
```

## Tips for Success
- **Outlier Removal**: After identifying outliers via PCA or Hierarchical clustering, select the "good" samples in the heatmap and use `Ctrl+X` (or `Tools > New Heat Map`) to create a clean subset for downstream analysis.
- **RNA-seq Support**: To enable RNA-seq loading from GEO, ensure you have the ARCHS4 h5 files by running `updateARCHS4()`.
- **Persistence**: Use `File > Save Dataset` to download a GCT file of your current state, or `File > Get link to a dataset` to share the session.

## Reference documentation
- [Using Phantasus application](./references/phantasus-tutorial.Rmd)
- [Using Phantasus application](./references/phantasus-tutorial.md)