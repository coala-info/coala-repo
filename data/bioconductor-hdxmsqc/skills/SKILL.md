---
name: bioconductor-hdxmsqc
description: The package builds on the QFeatures and Spectra packages to integrate with other mass-spectrometry data.
homepage: https://bioconductor.org/packages/release/bioc/html/hdxmsqc.html
---

# bioconductor-hdxmsqc

name: bioconductor-hdxmsqc
description: Quality control assessment for hydrogen-deuterium exchange mass-spectrometry (HDX-MS) data. Use this skill to identify outliers in retention time, ion mobility, and intensity, as well as to evaluate missing values, mass errors, monotonicity, charge state correlation, and spectral similarity in HDX-MS datasets.

# bioconductor-hdxmsqc

## Overview

The `hdxmsqc` package provides a suite of tools for automated and manual quality control of HDX-MS data. It integrates with the `QFeatures` and `Spectra` frameworks to analyze data exported from tools like HDExaminer. The package helps practitioners validate data quality by checking for physical and chemical consistency across peptides, charge states, and replicates.

## Core Workflow

### 1. Data Loading and Preprocessing
Data is typically imported from CSV files (e.g., HDExaminer output).

```r
library(hdxmsqc)
library(QFeatures)

# Load raw data
raw_data <- read.csv("path/to/HDExaminer_results.csv")

# Tidy and convert to wide format
# proteinStates defines the experimental conditions
data_wide <- processHDE(HDExaminerFile = raw_data, 
                        proteinStates = c("state1", "state2"))

# Identify deuteration columns (usually containing "X..Deut")
i <- grep(pattern = "X..Deut", x = names(data_wide))

# Create QFeatures object
hdx_obj <- readQFeatures(assayData = data_wide, 
                         quantCols = i, 
                         names = "Deuteration", 
                         fnames = "fnames")
```

### 2. Missing Value Analysis
Identify and handle missing data points.

```r
# Visualize missing values
plotMissing(hdx_obj)

# Filter out data not missing at random (MNAR)
hdx_filtered <- isMissingAtRandom(hdx_obj)

# Impute zero time-points if necessary
hdx_imputed <- impute(hdx_filtered, method = "zero", i = 1)
```

### 3. Quality Control Metrics
Run individual diagnostic tests to identify outliers.

*   **Mass Error:** `computeMassError(hdx_obj)` and `plotMassError(hdx_obj)`.
*   **Intensity Outliers:** `intensityOutliers(hdx_obj)` uses Cook's distance to find spectra with anomalous intensity variance.
*   **Retention Time (RT):** `rTimeOutliers(hdx_obj)` flags peptides outside 1.5 * IQR of the search window.
*   **Ion Mobility (IMS):** `imTimeOutlier(hdx_obj)` performs similar outlier detection for IMS windows.
*   **Monotonicity:** `computeMonotoneStats(hdx_obj, experiment, timepoints)` checks if deuterium uptake increases over time as expected.

### 4. Advanced Consistency Checks
*   **Charge State Correlation:** `chargeCorrelationHdx` ensures different charge states of the same peptide show similar uptake patterns.
*   **Sequence Overlap:** `compatibleUptake` checks if overlapping peptides have uptake values physically compatible with their shared amides.
*   **Spectral Similarity:** `spectraSimilarity` compares observed spectra against theoretical models using cosine similarity.

### 5. Generating a QC Summary
Consolidate all metrics into a single table for reporting.

```r
# Define experimental design
experiment <- c("state1", "state2")
timepoints <- rep(c(0, 15, 60, 600), each = 3) # Example timepoints

qctable <- qualityControl(
    object = hdx_imputed,
    massError = massError_res,
    intensityOutlier = intensity_res,
    retentionOutlier = rt_res,
    monotonicityStat = mono_res,
    mobilityOutlier = ims_res,
    chargeCorrelation = cs_res,
    experiment = experiment,
    timepoints = timepoints
)
```

## Tips for Success
*   **Experimental Design:** Ensure the `timepoints` vector exactly matches the number of columns in your assay.
*   **Visualization:** Most `plot*` functions in this package return `ggplot2` or `patchwork` objects, allowing for further customization (e.g., adding titles or changing themes).
*   **Spectral Comparison:** To use `spectraSimilarity`, you need both the results table and the raw peak data (often from HDsite or similar).

## Reference documentation
- [qc-tidying](./references/qc-streamlined.md)