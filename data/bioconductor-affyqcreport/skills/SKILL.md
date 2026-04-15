---
name: bioconductor-affyqcreport
description: This tool generates comprehensive multi-page PDF quality control reports for Affymetrix GeneChip microarray data. Use when user asks to assess data quality, generate QC reports for AffyBatch objects, analyze signal distributions, or evaluate RNA degradation and array correlation.
homepage: https://bioconductor.org/packages/3.8/bioc/html/affyQCReport.html
---

# bioconductor-affyqcreport

name: bioconductor-affyqcreport
description: Generate comprehensive Quality Control (QC) reports for Affymetrix GeneChip array data. Use this skill when you need to assess the data quality of a batch of Affymetrix arrays (AffyBatch objects) using signal distributions, 3':5' ratios, border element analysis, and array-array correlation heatmaps.

## Overview

The `affyQCReport` package provides a streamlined workflow for creating multi-page PDF QC reports for Affymetrix microarray data. It integrates tools from the `affy` and `simpleaffy` packages to evaluate probe-level intensities, RNA degradation, and spatial uniformity. The package is compatible with both normalized and non-normalized `AffyBatch` objects.

## Typical Workflow

### 1. Load Libraries and Data
The package requires an `AffyBatch` object. You can load example data or read your own CEL files.

```r
library(affyQCReport)
library(affydata)
data(Dilution) # Example AffyBatch object
```

### 2. Generate the Full QC Report
The primary function `QCReport` generates a 6-page PDF document containing all QC metrics.

```r
QCReport(Dilution, file="My_QC_Report.pdf")
```

### 3. Generating Individual Report Pages
If you do not need the full PDF, you can call specific functions to generate individual plots in the R graphics device:

*   **Title Page (Sample Index):** Lists sample names and their assigned index numbers.
    ```r
    titlePage(Dilution)
    ```
*   **Signal Distribution:** Displays boxplots of PM intensities and kernel density estimates.
    ```r
    signalDist(Dilution)
    ```
*   **Simpleaffy QC Plot:** Shows 3':5' ratios for GAPDH and beta-actin, plus % present calls and background levels.
    ```r
    plot(qc(Dilution))
    ```
*   **Border Element Boxplots:** Analyzes positive and negative control elements on the array edges to detect hybridization or gridding issues.
    ```r
    borderQC1(Dilution)
    ```
*   **Center of Intensity (COI):** Plots the spatial "center of mass" for border elements. Outliers (magnitude > 0.5) suggest spatial artifacts like bubbles.
    ```r
    borderQC2(Dilution)
    ```
*   **Correlation Plot:** A heatmap of Spearman rank correlation coefficients between arrays to identify outliers or sample swaps.
    ```r
    correlationPlot(Dilution)
    ```

## Interpretation Tips

*   **Signal Density:** Look for arrays with significantly different shapes or low average intensities; these are suspect.
*   **3':5' Ratios:** GAPDH ratios should be near 1 (red if > 1.25). Beta-actin ratios should be < 3. High ratios indicate RNA degradation.
*   **COI Plot:** If the COI is far from the center (0,0), it indicates non-uniform hybridization or grid misalignment.
*   **Correlation Heatmap:** Arrays with low correlation to their biological replicates may represent failed hybridizations or mislabeled samples.

## Reference documentation

- [affyQCReport: A Package to Generate QC Reports for Affymetrix Array Data](./references/affyQCReport.md)