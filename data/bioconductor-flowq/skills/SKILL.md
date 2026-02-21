---
name: bioconductor-flowq
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/flowQ.html
---

# bioconductor-flowq

name: bioconductor-flowq
description: Quality assessment (QA) for flow cytometry data using the flowQ package. Use this skill to perform automated QA on flowSets, detect outliers (cell counts, boundary events, time drifts), and generate interactive HTML reports for single or multi-panel experiments.

# bioconductor-flowq

## Overview

The `flowQ` package provides a modular framework for quality assessment of flow cytometry data. It allows researchers to identify problematic samples—such as those with insufficient events, instrument drifts, or abnormal boundary accumulations—before proceeding to gating and analysis. The package is designed to handle both simple single-panel experiments and complex multi-panel designs where aliquots from the same patient are compared across different staining combinations.

## Core Workflow

### 1. Initialization and Data Preparation
Load the library and your flow cytometry data (typically a `flowSet`).
```R
library(flowQ)
library(flowCore)

# Load example data or your own flowSet
data(GvHD)
fs <- GvHD[1:10]
dest <- "QA_Report" # Directory for output
```

### 2. Single-Panel QA Processes
Create `qaProcess` objects for specific quality criteria.

*   **Cell Number**: Check for samples with event counts below a threshold or statistical outliers.
    ```R
    qp_cells <- qaProcess.cellnumber(fs, outdir=dest, cFactor=0.75)
    ```
*   **Boundary Events**: Detect abnormal accumulation of events at the instrument's dynamic range limits.
    ```R
    qp_margin <- qaProcess.marginevents(fs, channels=c("FSC-H", "SSC-H"), outdir=dest)
    ```
*   **Time Anomalies**: Detect instrument drifts or flow rate jumps over the duration of acquisition.
    ```R
    qp_time <- qaProcess.timeline(fs, channel="FL1-H", outdir=dest)
    qp_flow <- qaProcess.timeflow(fs, outdir=dest)
    ```

### 3. Multi-Panel QA Processes
For experiments with aliquots, use functions that compare parameters across different panels for the same patient.

*   **Boundary Plots**: Visualize boundary events across aliquots.
    ```R
    resBoundary <- qaProcess.BoundaryPlot(tData, dyes=c("FSC-A", "CD3"), outdir=dest, cutoff=3)
    ```
*   **Distribution Comparisons**: Use ECDF or Density plots to find inconsistent distributions between aliquots.
    ```R
    resECDF <- qaProcess.ECDFPlot(nData, dyes=c("FSC-A", "SSC-A"), outdir=dest)
    resDensity <- qaProcess.DensityPlot(nData, dyes=c("CD8", "CD27"), outdir=dest)
    ```
*   **Statistical Outliers**: Identify aliquots where mean/median values deviate significantly.
    ```R
    resMean <- qaProcess.2DStatsPlot(nData, dyes=c("FSC-A", "SSC-A", "CD4", "CD8"), func=mean, outdir=dest)
    ```

### 4. Generating the HTML Report
Combine multiple QA processes into a single interactive report.
```R
url <- writeQAReport(fs, processes=list(qp_cells, qp_margin, qp_time, qp_flow), outdir=dest)
browseURL(url)
```

## Advanced Usage: Extending flowQ
You can create custom QA modules by defining new `qaProcess` objects. This requires:
1.  **Aggregators**: Objects like `binaryAggregator` or `numericAggregator` to store the "pass/fail" status.
2.  **qaGraph**: Objects to manage the storage and conversion of diagnostic plots (PDF/PNG).
3.  **qaProcessFrame**: A container for the results of a single frame.
4.  **qaProcess**: The top-level object bundling all frames and summary statistics.

## Tips for Success
*   **Transformation**: Always transform fluorescence channels (e.g., using `asinh` or `logicle`) before running density or ECDF-based QA processes to ensure meaningful distance calculations.
*   **Normalization**: For multi-panel experiments, use `warpSet` (from `flowStats`) to align peaks across aliquots before performing QA to avoid false positive outlier detection.
*   **Output Directory**: Use a consistent `outdir` across all `qaProcess` calls and the final `writeQAReport` to ensure all images are correctly linked in the HTML.

## Reference documentation
- [Quality Assessment of Ungated High Throughput Flow Cytometry Data](./references/DataQualityAssessment.md)
- [Extending flowQ: how to implement QA processes](./references/Extending-flowQ.md)