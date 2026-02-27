---
name: bioconductor-qcmetrics
description: The qcmetrics package provides a standardized framework for implementing and managing quality control pipelines across various data types in R. Use when user asks to create individual quality control metrics, bundle metrics into a container, or generate automated HTML and PDF quality control reports.
homepage: https://bioconductor.org/packages/release/bioc/html/qcmetrics.html
---


# bioconductor-qcmetrics

## Overview

The `qcmetrics` package provides a standardized framework for implementing quality control pipelines in R. It is domain-agnostic, meaning it can be applied to proteomics, genomics, or any other data type. The package centers around two main S4 classes:
1. `QcMetric`: Stores data, status (PASS/FAIL/NA), and a specific visualization function for a single metric.
2. `QcMetrics`: A container for multiple `QcMetric` objects, including metadata about the experiment.

## Core Workflow

### 1. Creating Individual Metrics
To create a metric, initialize a `QcMetric` object, assign data to its environment, and define a plotting function.

```r
library(qcmetrics)

# Initialize
qc <- QcMetric(name = "Signal Intensity")

# Assign data (stored in an internal environment)
qcdata(qc, "values") <- rnorm(100)

# Define status (TRUE for pass, FALSE for fail, NA for unevaluated)
status(qc) <- median(qcdata(qc, "values")) > 0

# Define custom plotting behavior
plot(qc) <- function(object, ...) {
    boxplot(qcdata(object, "values"), main = name(object), ...)
}
```

### 2. Bundling Metrics
Combine multiple metrics into a `QcMetrics` object and add experimental metadata.

```r
# Bundle metrics
qcm <- QcMetrics(qcdata = list(qc1, qc2, qc3))

# Add metadata
metadata(qcm) <- list(author = "Researcher Name", 
                      instrument = "Mass Spectrometer X",
                      date = Sys.Date())
```

### 3. Generating Reports
The `qcReport` function automates the creation of a document containing summaries and plots for all metrics.

```r
# Generate an HTML report
qcReport(qcm, reportname = "QC_Report_Project1", type = "html")

# Generate a PDF report (requires LaTeX)
qcReport(qcm, reportname = "QC_Report_Project1", type = "pdf")
```

## Advanced Usage

### Customizing Report Sections
You can customize how each metric is rendered in the report by providing a custom function to the `qcto` argument in `qcReport`. The package provides `Qc2Tex` (for PDF) and `Qc2Rmd` (for HTML) as defaults.

### Reusing Data Environments
If multiple metrics use the same underlying raw data, you can share the data environment to save memory:
```r
qcdata(qc2) <- qcenv(qc1)
```

### Automation
For production pipelines, it is recommended to wrap the metric creation and reporting into a single function that takes a data object (like an `MSnSet` or `SummarizedExperiment`) and returns a `QcMetrics` object.

## Tips for Effective QC
- **Pre-compute**: Store only the data necessary for the plot in `qcdata` rather than the entire raw dataset to keep report generation fast and memory-efficient.
- **Status Logic**: Always define clear thresholds for the `status()` of a metric to allow for "at-a-glance" summary tables in the final report.
- **Custom Show**: You can override the `show` method for a `QcMetric` to print specific summary statistics in the report text.

## Reference documentation
- [Index file for the qcmetrics package vignette](./references/qcmetrics.Rmd)
- [qcmetrics: A framework for Quality Control](./references/qcmetrics.md)