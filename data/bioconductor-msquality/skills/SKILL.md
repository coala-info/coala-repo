---
name: bioconductor-msquality
description: This tool calculates and visualizes standardized quality control metrics for mass spectrometry data using the MsQuality package. Use when user asks to calculate QC metrics for Spectra or MsExperiment objects, identify low-quality samples in large-scale datasets, or export quality metrics in mzQC format.
homepage: https://bioconductor.org/packages/release/bioc/html/MsQuality.html
---


# bioconductor-msquality

name: bioconductor-msquality
description: Calculate and visualize quality control (QC) metrics for mass spectrometry data using the MsQuality package. Use this skill when analyzing spectral data (Spectra or MsExperiment objects) to identify low-quality samples, track technical variation, or export metrics in mzQC format.

# bioconductor-msquality

## Overview
MsQuality provides a standardized framework for assessing the quality of mass spectrometry data at the per-sample level. It implements metrics defined by the HUPO-PSI mzQC framework, focusing on low-level information like retention time, m/z values, and intensities. It is specifically optimized for large-scale datasets (e.g., clinical cohorts) where technical variation must be monitored across thousands of samples.

## Installation
Install the package and its dependencies using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("MsQuality")
```

## Data Preparation
MsQuality integrates with the `Spectra` and `MsExperiment` ecosystems.

*   **Spectra Objects**: Create from raw files (mzML, mzXML, CDF) using `Spectra(files, backend = MsBackendMzR())`.
*   **MsExperiment Objects**: Use as a container to link sample metadata (`sampleData`) with spectral data. MsQuality iterates over samples automatically when an `MsExperiment` is provided.

## Calculating Quality Metrics
The primary interface for QC calculation is the `calculateMetrics` function.

### Basic Workflow
```r
library(MsQuality)

# List all available metrics for an object
available <- qualityMetrics(sps_object)

# Calculate all metrics for MS1 level
qc_df <- calculateMetrics(sps_object, msLevel = 1L)

# Calculate specific metrics with custom parameters
qc_subset <- calculateMetrics(
    object = sps_object,
    metrics = c("numberSpectra", "chromatographyDuration", "areaUnderTic"),
    filterEmptySpectra = TRUE
)
```

### Key Arguments
*   **metrics**: Character vector of metric names. Defaults to all available metrics.
*   **msLevel**: Integer vector specifying which MS levels to process (e.g., `1L`, `2L`).
*   **filterEmptySpectra**: Logical. If `TRUE`, removes zero-intensity or zero-length scans before calculation (matches QuaMeter behavior).
*   **relativeTo**: Used for `ticQuartileToQuartileLogRatio`. Options are `"Q1"` or `"previous"`.
*   **format**: Set to `"data.frame"` (default) for standard R analysis or `"mzQC"` for export using the `rmzqc` package.

## Interpreting Common Metrics
*   **chromatographyDuration**: Total RT range; shorter durations may indicate premature run termination.
*   **msSignal10xChange**: Counts "jumps" or "falls" in TIC; high values suggest ESI instability.
*   **rtIqrRate**: Number of features identified per second in the interquartile RT range; measures sampling efficiency.
*   **ticQuantileRtFraction**: Identifies where signal accumulates; can reveal gaps in the chromatographic run.
*   **ratioCharge1over2**: High ratios of 1+ vs 2+ precursors may indicate inefficient ionization.

## Visualization
MsQuality provides both static and interactive visualization tools.

### Static Plotting
Use `plotMetric` to compare a specific metric across samples:
```r
# qc must be the data.frame returned by calculateMetrics
plotMetric(qc = qc_df, metric = "numberSpectra")
```

### Interactive Browser
Launch a Shiny application to explore all calculated metrics interactively:
```r
shinyMsQuality(qc = qc_df)
```

## Reference documentation
- [MsQuality: Calculation of QC metrics from mass spectrometry data](./references/MsQuality.md)