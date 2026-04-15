---
name: bioconductor-msstatsqcgui
description: MSstatsQCgui provides a Shiny-based graphical user interface for the longitudinal statistical monitoring of liquid chromatography-mass spectrometry proteomic experiments. Use when user asks to monitor instrument performance over time, perform change point analysis on QC metrics, or generate statistical process control charts for mass spectrometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/MSstatsQCgui.html
---

# bioconductor-msstatsqcgui

## Overview

`MSstatsQCgui` is a Bioconductor package that provides a Shiny-based graphical user interface (GUI) for the longitudinal statistical monitoring of proteomic experiments. It implements modern statistical process control (SPC) methods—such as simultaneous and time-weighted control charts and change point analysis—specifically tailored for LC-MS workflows. It allows users to monitor metrics like Retention Time, Total Peak Area, and Mass Accuracy over time to identify instrument drift or sudden shifts in performance.

## Installation and Startup

To use the package, it must be installed via `BiocManager` and launched from an active R session.

```r
# Install the package
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("MSstatsQCgui")

# Load and launch the GUI
library(MSstatsQCgui)
RunMSstatsQC()
```

## Data Preparation

The package requires input data in a "long" format (CSV), typically exported from tools like Skyline or Panorama AutoQC.

### Required Columns
- **AcquiredTime**: Date/time of the run (Format: `MM/DD/YYYY HH:MM:SS AM/PM` or European format).
- **Precursor**: Unique identifier for the peptide/precursor. Analysis is performed separately for each unique label.
- **Annotations**: Free-text notes regarding specific runs (e.g., "column changed").
- **Metrics**: One or more columns containing numeric QC values (e.g., `RetentionTime`, `TotalPeakArea`, `MassAccuracy`, `FWHM`). The tool can analyze up to 20 metrics simultaneously.

## Workflow in the GUI

1. **Data Import**: Use the "Data import" tab to upload your CSV. You can use the "Run with sample data" button to explore the tool using CPTAC Study 9.1 data.
2. **Options**: Define your "Guide Set." This is a range of runs (e.g., observations 1 to 20) that represent the instrument in a "stable" state. The mean and standard deviation from this set are used to calculate control limits for future observations.
3. **Control Charts**:
   - **XmR Charts**: Individual (X) and Moving Range (mR) charts to monitor mean shifts and variability.
   - **CUSUM Charts**: Cumulative Sum charts (CUSUMm for mean, CUSUMv for variance) which are more sensitive to small, persistent shifts.
   - **Change Point Analysis**: Detects the specific point in time where a statistical shift occurred.
4. **Metric Summary**: View "River" and "Radar" plots to see a high-level overview of performance across multiple metrics and peptides simultaneously.
5. **Decision Maps**: Use heatmaps to quickly identify which runs or metrics are failing statistical thresholds.

## Tips for Analysis

- **Interactive Plots**: All charts are generated using `plotly`. You can hover over points to see the `Annotations` or specific values, and use the plotly toolbar to export images.
- **Guide Set Selection**: Ensure your guide set is truly representative of optimal performance. If the guide set contains outliers, your control limits will be too wide, making the tool less sensitive to real issues.
- **Multiple Metrics**: Use the "Metric summary" tab if you are tracking many variables; it helps distinguish between a single-metric failure (e.g., a specific mass calibration issue) and a system-wide failure (e.g., a pump leak affecting all retention times).

## Reference documentation

- [MSstatsQCgui](./references/MSstatsQCgui.md)