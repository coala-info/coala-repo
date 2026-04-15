---
name: bioconductor-qualifier
description: This tool performs automated quality control and outlier detection for gated flow cytometry data stored in GatingSet objects. Use when user asks to perform quality assurance on flow cytometry statistics, identify outliers in MFI or cell proportions, or generate HTML quality assessment reports.
homepage: https://bioconductor.org/packages/3.5/bioc/html/QUALIFIER.html
---

# bioconductor-qualifier

name: bioconductor-qualifier
description: Automated quality control and assessment for gated flow cytometry data. Use when analyzing GatingSet objects from flowWorkspace to identify outliers, monitor MFI stability, and generate HTML QA reports. This skill is essential for multi-center or longitudinal flow cytometry studies requiring standardized quality metrics.

# bioconductor-qualifier

## Overview
The QUALIFIER package provides automated quality assurance (QA) for gated flow cytometry data. It interacts with `GatingSet` objects (from `flowWorkspace`) to extract statistics, perform outlier detection based on various statistical distributions, and generate interactive HTML reports.

## Core Workflow

### 1. Initialize the QA Environment
QUALIFIER uses an environment to store statistics and metadata.
```r
library(QUALIFIER)
db <- new.env()
initDB(db)
```

### 2. Data Preprocessing
Load a `GatingSet` and its associated metadata into the database.
```r
# Convenient wrapper for saveToDB and getQAStats
qaPreprocess(db = db, 
             gs = myGatingSet, 
             metaFile = "sample_metadata.csv", 
             fcs.colname = "FCS_Files", 
             date.colname = c("RecdDt"))
```

### 3. Define QA Tasks
QA tasks are typically defined in a CSV file and loaded into the environment.
```r
checkListFile <- system.file("data", "qaCheckList.csv.gz", package="QUALIFIER")
qaTask.list <- read.qaTask(db, checkListFile)
```

### 4. Perform QA Checks
Use `qaCheck` with formulas to identify outliers. The formula syntax is `statistic ~ x_axis | grouping_variables`.
Supported statistics: `MFI`, `proportion`, `count`, `spike`.

```r
# Check for outliers in RBC Lysis based on a fixed lower bound
qaCheck(qaTask.list[["RBCLysis"]],
        formula = proportion ~ RecdDt | Tube,
        outlierfunc = outlier.cutoff,
        lBound = 0.8)

# Check for MFI stability over time using t-distribution
qaCheck(qaTask.list[["MFIOverTime"]],
        outlierfunc = outlier.t,
        alpha = 0.05)
```

### 5. Visualization and Reporting
Visualize specific tasks or generate a comprehensive HTML report.
```r
# Plot a specific task
plot(qaTask.list[["RBCLysis"]])

# Generate HTML report
qaReport(qaTask.list, outDir = "./QA_Report", title = "Study QA Report")
```

## Outlier Detection Functions
- `qoutlier`: IQR-based detection (default `alpha = 1.5`).
- `outlier.norm`: Normal distribution based using Huber M-estimator.
- `outlier.t`: T-distribution based detection.
- `outlier.cutoff`: Simple thresholding using `lBound` and `uBound`.

## Database Management
Save or load the processed QA environment to avoid re-calculating statistics.
```r
save_db(db, path = "./QA_Database")
db <- load_db(path = "./QA_Database")
```

## Tips for Effective QA
- **Formulas**: Use the conditioning part of the formula (after `|`) to group samples by site, batch, or patient to ensure outliers are detected within the appropriate context.
- **MFI Checks**: When checking MFI, ensure the `pop` argument in the `qaTask` correctly matches the node name in your gating hierarchy.
- **Interactive Plots**: The `plot` method can generate SVG files with tooltips if a `dest` path is provided, allowing for deep inspection of individual outliers.

## Reference documentation
- [QUALIFIER Reference Manual](./references/reference_manual.md)