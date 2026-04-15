---
name: bioconductor-yaqcaffy
description: This tool performs automated quality control and reproducibility analysis for Affymetrix GeneChip expression data. Use when user asks to calculate Affymetrix QC metrics, identify outlier arrays, or compare Human Genome U133 Plus 2.0 data against MAQC reference datasets.
homepage: https://bioconductor.org/packages/3.6/bioc/html/yaqcaffy.html
---

# bioconductor-yaqcaffy

name: bioconductor-yaqcaffy
description: Quality control and reproducibility analysis for Affymetrix GeneChip expression data. Use this skill to automate Affymetrix QC metrics (scale factors, background, noise, present calls, internal controls) and compare Human Genome U133 Plus 2.0 arrays against MAQC reference datasets.

# bioconductor-yaqcaffy

## Overview

The `yaqcaffy` package extends the capabilities of `affy` and `simpleaffy` to provide automated quality control (QC) for Affymetrix expression arrays. It calculates standard Affymetrix metrics and allows for reproducibility testing against Microarray Quality Consortium (MAQC) reference datasets. It is primarily used to identify outlier arrays before downstream analysis.

## Core Workflow

### 1. Data Preparation and Object Generation
The primary function is `yaqc()`, which performs MAS5 normalization and extracts QC metrics from an `AffyBatch` object.

```r
library(yaqcaffy)
library(affydata)

# Load data (example using Dilution dataset)
data(Dilution)

# Generate the YAQCStats object
yqc <- yaqc(Dilution)

# View summary of metrics
show(yqc)
```

### 2. Quality Control Analysis
The package provides visual and programmatic methods to identify poor-quality arrays.

*   **Visualizing QC Metrics:** Use `plot()` to generate a multi-panel figure containing scale factors, background/noise, percentage of present calls, and internal control intensities (BioB, BioC, BioD, etc.).
*   **Identifying Outliers:** Outliers are defined as samples lying outside the mean +/- 2 standard deviations (or specific Affymetrix thresholds for scale factors).

```r
# Plot all QC metrics
plot(yqc)

# Retrieve specific outliers (e.g., scale factors 'sfs' or average background 'avbg')
getOutliers(yqc, "sfs")

# Summary of all outliers across all metrics
summary(yqc)
```

### 3. Reproducibility with MAQC Datasets
For Human Genome U133 Plus 2.0 arrays, you can compare your data against high-quality reference subsets (A, B, C, or D) from the MAQC project.

```r
library(MAQCsubsetAFX)
# Compare a sample 'd' against Reference RNA A
# Normalization options: "rma" (default), "gcrma", "mas5", or "none"
reprodPlot(d, "refA", normalize="rma")
```

## Advanced Usage

### Custom Control Probe Selection
If the automatic probe selection fails or if using non-standard arrays, you can manually define control probes.

```r
# Launch the graphical interface to select probes
# This saves a 'YaqcControlProbes' object to the global environment
probeSelectionInterface(Dilution)

# Use the custom probes in the yaqc function
yqc_custom <- yaqc(Dilution, myYaqcControlProbes = yaqcControlProbes)
```

### Merging Results
You can combine multiple `YAQCStats` objects for comparative analysis.

```r
yqc_combined <- merge(yqc1, yqc2)
```

## Key Metrics Explained
*   **Scale Factors:** Should be within 3-fold of each other. `yaqcaffy` sets limits at mean/2 and mean*1.5.
*   **Background/Noise:** Should be comparable across all arrays in a study.
*   **Internal Controls:** BioB, BioC, and BioD should be present in increasing concentrations. BioB is at the limit of sensitivity and may be "Absent" in up to 50% of good arrays.
*   **RNA Degradation:** GAPDH and β-Actin 3'/5' ratios should generally be < 3.

## Reference documentation
- [yaqcaﬀy: Aﬀymetrix expression GeneChips quality control and reproducibility with MAQC datasets](./references/yaqcaffy.md)