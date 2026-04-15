---
name: bioconductor-flowspecs
description: The flowSpecs package provides tools for processing, unmixing, and correcting raw spectral cytometry data. Use when user asks to calculate spectral unmixing matrices, perform spectral unmixing, correct unmixing artifacts, or convert flow data into long-format dataframes.
homepage: https://bioconductor.org/packages/release/bioc/html/flowSpecs.html
---

# bioconductor-flowspecs

## Overview
The `flowSpecs` package provides tools for processing raw spectral cytometry data. It extends `flowCore` functionality to handle the unique requirements of spectral instruments (like the Cytek Aurora). Its primary workflows include calculating spectral unmixing matrices from control samples, performing the unmixing (decomposition), correcting for minor unmixing artifacts using a secondary correction matrix, and converting flow data into long-format dataframes for non-flow applications.

## Core Workflow

### 1. Data Loading
`flowSpecs` uses `flowFrame` and `flowSet` objects from the `flowCore` package.
```r
library(flowSpecs)
library(flowCore)

# Load your data (usually via flowCore::read.FCS or read.flowSet)
data("unmixCtrls") # Example flowSet of controls
data("fullPanel")  # Example flowFrame of fully stained sample
```

### 2. Calculating the Spectral Unmixing Matrix
Use `specMatCalc` to generate the matrix from single-stained controls. You must identify groups of samples (e.g., Beads, Cells) and an unstained control for autofluorescence.
```r
# groupNames identifies the prefix for single-stained controls
# autoFluoName identifies the specific file for autofluorescence
specMat <- specMatCalc(unmixCtrls, 
                       groupNames = c("Beads_", "Dead_"), 
                       autoFluoName = "PBMC_unstained.fcs")
```

### 3. Spectral Unmixing
Apply the calculated matrix to your fully stained samples using least squares regression.
```r
fullPanelUnmix <- specUnmix(fullPanel, specMat)
```

### 4. Data Transformation
Spectral data requires transformation (typically arcsinh) for visualization and clustering. `arcTrans` provides an automated way to apply this, with defaults for flow or mass cytometry.
```r
# Identify columns to transform (usually the unmixed fluorochrome channels)
channels_to_transform <- colnames(fullPanelUnmix)[6:18]
fullPanelTrans <- arcTrans(fullPanelUnmix, transNames = channels_to_transform)
```

### 5. Identifying and Correcting Artifacts
Spectral unmixing often leaves minor artifacts (e.g., false negative correlations).
*   **Visualize**: Use `oneVsAllPlot` to find "over-unmixed" or "under-unmixed" populations.
*   **Correct**: Create a correction matrix and apply it to the **unmixed (but non-transformed)** data.

```r
# 1. Visualize a specific marker against all others
oneVsAllPlot(fullPanelTrans, "AF647_IgM", saveResult = FALSE)

# 2. Create empty correction matrix
corrMat <- corrMatCreate(specMat)

# 3. Add correction (e.g., -0.03 means 3% negative correction)
# If marker A bleeds into marker B, adjust corrMat["A", "B"]
corrMat["BV650_CD56", "AF647_IgM"] <- -0.03

# 4. Apply correction (automatically re-transforms for convenience)
fullPanelCorr <- correctUnmix(fullPanelUnmix, corrMat)
```

### 6. Exporting to Dataframes
To use data in non-flow R packages (e.g., for custom ggplot2 or general ML), convert the `flowSet` to a long-format dataframe.
```r
# idInfo uses regex to extract metadata from filenames into columns
fullPanelDf <- flowSet2LongDf(fullPanelFs, idInfo = list(
  "Tissue" = "|_full_panel_..\\.fcs", 
  "Donor" = "...._full_panel_|\\.fcs"
))
```

## Tips and Best Practices
*   **Autofluorescence**: Always use an unstained control of the same cell type as your samples for the `autoFluoName` parameter in `specMatCalc`.
*   **Transformation Cofactors**: While `arcTrans` is convenient, manually checking cofactors is recommended to ensure no artifactual populations are created around zero.
*   **Correction Logic**: The correction matrix is symmetric and secondary. It is applied to unmixed data to "nudge" populations that are biologically unlikely (e.g., a "slanted" negative population).
*   **Integration**: Since `flowSpecs` outputs `flowCore` objects, you can immediately pipe results into `flowViz` for plotting or `OpenCyto` for gating.

## Reference documentation
- [Example workflow for processing of raw spectral cytometry files](./references/flowSpecs_vinjette.md)
- [flowSpecs Vignette Source](./references/flowSpecs_vinjette.Rmd)