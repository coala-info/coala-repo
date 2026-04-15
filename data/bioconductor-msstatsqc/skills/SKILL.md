---
name: bioconductor-msstatsqc
description: MSstatsQC provides longitudinal monitoring and statistical process control for mass spectrometry-based proteomic experiments. Use when user asks to track system performance, monitor sample quality with control charts, identify change points in proteomic data, or visualize quality control metrics across multiple peptides.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsQC.html
---

# bioconductor-msstatsqc

## Overview
`MSstatsQC` is an R package designed for longitudinal monitoring of mass spectrometry-based proteomic experiments. It implements statistical process control (SPC) methods to track system performance (SST) and sample quality (QC) over time. It supports various acquisition types including SRM, DDA, and DIA, and provides robust handling for missing values.

## Typical Workflow

### 1. Data Preparation and Processing
Input data must be in a "long" format. The package is flexible with column naming but requires `AcquiredTime`, `Precursor` (peptide ID), and `Annotations`.

```r
library(MSstatsQC)

# Load example data
data <- MSstatsQC::S9Site54

# Process data to standardize column names and validate format
# MSstatsQC automatically maps common names (e.g., 'rt' to 'BestRetentionTime')
processed_data <- DataProcess(data)
```

### 2. Handling Missing Values
For DDA/DIA datasets with missing observations:
- `MissingDataMap(data)`: Visualizes the pattern of missingness.
- `RemoveMissing(data)`: Cleans the dataset for downstream analysis.
- `XmRChart(..., metric = "missing")`: Monitors the count of missing values as a QC metric itself.

### 3. Individual Control Charts
Use these functions to monitor specific peptides and metrics (e.g., `BestRetentionTime`, `TotalArea`).

**XmR Charts (Individual and Moving Range):**
Best for monitoring the mean and variability of a metric.
```r
# Using a guide set (runs 1 to 20) to define limits
XmRChart(processed_data, 
         peptide = "TAAYVNAIEK", 
         L = 1, U = 20, 
         metric = "BestRetentionTime", 
         type = "mean")

# Using predefined known limits
XmRChart(processed_data, 
         peptide = "LVNELTEFAK", 
         metric = "BestRetentionTime", 
         selectMean = 28.5, 
         selectSD = 0.5)
```

**CUSUM Charts (Cumulative Sum):**
More sensitive to small, persistent shifts in the mean or variability.
```r
CUSUMChart(processed_data, peptide = "TAAYVNAIEK", L = 1, U = 20, metric = "TotalArea")
```

### 4. Change Point Estimation
If a control chart indicates an out-of-control state, use the `ChangePointEstimator` to identify exactly when the shift occurred.
```r
ChangePointEstimator(processed_data, 
                     peptide = "TAAYVNAIEK", 
                     metric = "BestRetentionTime", 
                     type = "mean", 
                     L = 1, U = 20)
```

### 5. Summary Visualizations
Aggregate performance across all peptides and metrics to get a system-wide view.

- **RiverPlot**: Shows trends (increases/decreases) across all analytes over time.
- **RadarPlot**: Identifies which specific peptides are contributing to out-of-control signals.
- **DecisionMap**: A heatmap-style summary that flags "Fail" (Red) or "Warning" (Yellow) based on the percentage of out-of-control peptides.

```r
# Summary of all XmR charts
RiverPlot(processed_data, L = 1, U = 20, method = "XmR")
RadarPlot(processed_data, L = 1, U = 20, method = "XmR")

# Decision map with custom thresholds
DecisionMap(processed_data, method = "XmR", 
            peptideThresholdRed = 0.25, 
            peptideThresholdYellow = 0.10, 
            L = 1, U = 20)
```

## Exporting Results
- **Interactive Plots**: Core charts use `plotly`. Save as HTML using `htmlwidgets::saveWidget(p, "file.html")`.
- **Static Plots**: Summary plots use `ggplot2`. Save using `ggplot2::ggsave("file.png", plot = p)`.

## Reference documentation
- [MSstatsQC: longitudinal system suitability monitoring and quality control for proteomic experiments](./references/MSstatsQC.md)