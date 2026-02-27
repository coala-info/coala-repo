---
name: bioconductor-twoddpcr
description: This tool analyzes two-channel Bio-Rad Droplet Digital PCR data by importing QuantaSoft CSV files and classifying droplets into clusters. Use when user asks to classify ddPCR droplets, identify rain using Mahalanobis distance, or calculate Poisson-based concentrations and fractional abundance.
homepage: https://bioconductor.org/packages/release/bioc/html/twoddpcr.html
---


# bioconductor-twoddpcr

name: bioconductor-twoddpcr
description: Analysis of Bio-Rad Droplet Digital PCR (ddPCR) data. Use this skill to import QuantaSoft CSV files, classify droplets (NN, NP, PN, PP) using various algorithms (threshold, k-means, k-NN), handle "rain" (ambiguous droplets), and calculate Poisson-based concentrations and fractional abundance.

## Overview

The `twoddpcr` package provides a suite of tools for the analysis of two-channel Droplet Digital PCR data. It centers around the `ddpcrPlate` object, which stores droplet amplitudes and their classifications. The package is particularly useful for automating the classification of clusters that may not be perfectly aligned with axes, using statistical methods like k-means and Mahalanobis distance to define "rain."

## Core Workflow

### 1. Data Import
Load droplet amplitude CSV files exported from Bio-Rad QuantaSoft.

```r
library(twoddpcr)

# Load from a directory containing QuantaSoft CSVs
# Files should be named: <Plate>_<Well>_Amplitude.csv
plate <- ddpcrPlate(well="path/to/csv_directory")

# Or use the built-in example data
plate <- ddpcrPlate(wells=KRASdata)
```

### 2. Visualization
Inspect the raw data to identify cluster patterns.

```r
# Standard scatter plot
dropletPlot(plate)

# Density/Heat map (useful for large numbers of droplets)
heatPlot(plate)

# View individual wells side-by-side
facetPlot(plate)

# Plot a specific well by name
dropletPlot(plate[["A01"]])
```

### 3. Classification Methods
Classify droplets into four clusters: NN (Negative/Negative), NP (Negative/Positive), PN (Positive/Negative), and PP (Positive/Positive).

**Manual Thresholding:**
```r
plate <- thresholdClassify(plate, ch1Threshold=6000, ch2Threshold=3000)
```

**K-means Clustering (Recommended):**
Automatically finds clusters; more robust to "leaning" or "lifting" clusters.
```r
plate <- kmeansClassify(plate)
```

**K-Nearest Neighbors (k-NN):**
Requires a training set (e.g., a well with clear classification).
```r
plate <- knnClassify(plate, trainData=trainAmplitudes, cl=trainLabels, k=3)
```

### 4. Defining "Rain"
Rain refers to droplets that do not clearly belong to any cluster.

**Mahalanobis Rain:**
Uses the Mahalanobis distance from cluster centers.
```r
# maxDistances can be a single value or a list per cluster
plate <- mahalanobisRain(plate, cMethod="kmeans", maxDistances=35)
```

**Standard Deviation Rain:**
```r
plate <- sdRain(plate, cMethod="kmeans", errorLevel=5)
```

### 5. Results and Summary
Calculate concentrations (copies/µL) and fractional abundance using Poisson statistics.

```r
# Check available classification methods in the object
commonClassificationMethod(plate)

# Generate summary table
stats <- plateSummary(plate, cMethod="kmeansMahRain")

# Key columns in output:
# MtConcentration: Mutant copies per 1uL
# WtConcentration: Wild-type copies per 1uL
# FracAbun: Fractional abundance (%)
```

## Tips and Best Practices
- **Well Selection:** Access individual wells using list syntax: `plate[["B04"]]`.
- **Custom Classification:** You can manually assign classes to a `ddpcrPlate` object by ensuring the classification is a factor with levels: `c("NN", "NP", "PN", "PP", "Rain", "N/A")`.
- **Interactive Analysis:** If working in a local interactive session, use `shinyVisApp()` to launch a GUI for threshold setting.
- **Data Cleaning:** If you encounter "duplicate row.names" errors during import, check for trailing commas or empty columns in the QuantaSoft CSV files.

## Reference documentation
- [twoddpcr: A package for Droplet Digital PCR analysis](./references/twoddpcr.md)
- [twoddpcr Vignette Source](./references/twoddpcr.Rmd)