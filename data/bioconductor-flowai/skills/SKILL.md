---
name: bioconductor-flowai
description: "The package is able to perform an automatic or interactive quality control on FCS data acquired using flow cytometry instruments. By evaluating three different properties: 1) flow rate, 2) signal acquisition, 3) dynamic range, the quality control enables the detection and removal of anomalies."
homepage: https://bioconductor.org/packages/release/bioc/html/flowAI.html
---

# bioconductor-flowai

name: bioconductor-flowai
description: Automated and interactive quality control (QC) for flow cytometry data (FCS files) using the flowAI R package. Use this skill to detect and remove anomalies in flow rate, signal acquisition, and dynamic range. It is applicable for cleaning individual flowFrame objects or entire flowSet collections before downstream analysis.

# bioconductor-flowai

## Overview
The `flowAI` package provides a standardized, objective approach to quality control for flow cytometry data. It evaluates three specific properties of FCS data to identify technical artifacts:
1.  **Flow Rate**: Detects surges or shifts in the fluidics system over time.
2.  **Signal Acquisition**: Identifies shifts in signal mean or variance (e.g., laser instability or clogs) using changepoint detection.
3.  **Dynamic Range**: Removes events at the instrument's upper limit (saturation) or anomalous negative outliers.

## Core Workflows

### 1. Automatic Quality Control
The primary function is `flow_auto_qc()`. It can process a single `flowFrame`, a `flowSet`, or a vector of file paths.

```r
library(flowAI)
library(flowCore)

# Load example data
data(Bcells)

# Run QC on a flowSet (returns a cleaned flowSet)
res_set <- flow_auto_qc(Bcells)

# Run QC on a single flowFrame
res_frame <- flow_auto_qc(Bcells[[1]])

# Run QC on file paths directly
fcs_files <- list.files(pattern = "*.fcs")
res_files <- flow_auto_qc(fcs_files)
```

### 2. Handling Large Datasets
To prevent memory saturation when processing many large FCS files, process data in batches.

```r
# Example: 2GB batch limit
GbLimit <- 2
fcs_files <- list.files(pattern = "*.fcs")
size_fcs <- file.size(fcs_files)/1024^3
groups <- ceiling(sum(size_fcs)/GbLimit)
batches <- cut(cumsum(size_fcs), groups)

for(i in 1:groups){
    # output = 0 saves results to disk without returning objects to R memory
    flow_auto_qc(fcs_files[batches == levels(batches)[i]], output = 0)
}
```

### 3. Customizing QC Parameters
You can restrict QC to specific properties or adjust sensitivity:
- `remove_from`: Choose from "all", "none", or a combination of "FlowRate", "FlowSignal", "FlowMargin".
- `second_fractionFR`: Adjust the time step for flow rate (default is 0.1s).
- `alphaFR`: Significance level for flow rate outlier detection.
- `Ch_no_FR` / `Ch_no_FS`: Exclude specific channels from flow rate or signal check.

```r
# Example: Only check Flow Rate and Dynamic Range (Margins)
res_partial <- flow_auto_qc(Bcells[[1]], remove_from = c("FlowRate", "FlowMargin"))
```

### 4. Interactive Quality Control
For difficult files where automatic detection fails, use the Shiny-based interactive tool.

```r
# Launches a web browser interface
flow_iQC()
```

## Interpreting Results
- **Reports**: By default, `flow_auto_qc` generates a folder named `check` containing PDF reports and mini-plots for every file.
- **Flagging vs. Removal**: 
    - By default, it generates new FCS files with high-quality events only.
    - If `fcs_export = "flag"`, it adds a new parameter where anomalies are flagged with high values (similar to flowClean).
- **Summary**: The function prints a summary to the console including the percentage of anomalies detected (e.g., "Anomalies Detected in total: 23%").

## Reference documentation
- [Quality control with flowAI](./references/flowAI.md)