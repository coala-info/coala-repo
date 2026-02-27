---
name: bioconductor-medme
description: The MEDME package derives absolute and relative DNA methylation scores from MeDIP enrichment data by fitting a logistic model to account for CpG density bias. Use when user asks to calculate methylation levels from MeDIP-seq or tiling array data, fit a model to calibration samples, or predict absolute and relative methylation scores.
homepage: https://bioconductor.org/packages/release/bioc/html/MEDME.html
---


# bioconductor-medme

## Overview

The `MEDME` package (Model for Experimental Data with MeDIP Enrichment) provides a method to derive absolute and relative DNA methylation scores from MeDIP enrichment data. It addresses the inherent bias where MeDIP signals are sigmoidally related to the density of methylated CpG sites (mCpGs) rather than linearly. The workflow typically involves using a calibration sample (fully methylated DNA) to fit a logistic model, which is then applied to experimental samples to predict methylation levels.

## Core Workflow

### 1. Data Import and Initialization
Data is managed using the `MEDMEset` class. You can read data from GFF or SGR files.

```r
library(MEDME)

# Load example data
data(testMEDMEset)

# Reading from files (GFF recommended for probe names)
# myData <- MEDME.readFiles(path = "path/to/files", format = "GFF")
```

### 2. Data Smoothing
Tiling array data often requires smoothing to improve signal-to-noise ratios before model fitting.

```r
# Apply smoothing with a specific window size (e.g., 1000bp)
testMEDMEset <- smooth(data = testMEDMEset, wsize = 1000, wFunction = 'linear')
```

### 3. Calculating CpG Content
To fit the model, the expected methylation level (CpG count) for each probe must be determined. This requires a `BSgenome` object for the relevant organism.

```r
library(BSgenome.Hsapiens.UCSC.hg18)
testMEDMEset <- CGcount(data = testMEDMEset)
```

### 4. Model Fitting
Fit the logistic model using the calibration sample (usually the first column in the logR slot representing fully methylated DNA).

```r
# sample = 1 indicates the calibration column
MEDMEmodel <- MEDME(data = testMEDMEset, sample = 1)
```

### 5. Predicting Methylation Levels
Apply the fitted model to experimental samples to calculate Absolute Methylation Scores (AMS) and Relative Methylation Scores (RMS).

```r
testMEDMEset <- MEDME.predict(
  data = testMEDMEset, 
  MEDMEfit = MEDMEmodel, 
  MEDMEextremes = c(1, 32), 
  wsize = 1000, 
  wFunction = 'linear'
)
```

## Accessing Results

The `MEDMEset` object stores various stages of the analysis which can be accessed via helper functions:

*   `logR(obj)`: Original log2 enrichment ratios.
*   `smoothed(obj)`: Smoothed enrichment data.
*   `CGcount(obj)`: CpG density per probe.
*   `AMS(obj)`: Absolute Methylation Score (predicted number of methylated CpGs).
*   `RMS(obj)`: Relative Methylation Score (normalized 0 to 1 or similar scale).

## Exporting Data
Results can be exported for visualization in genome browsers (like IGV or UCSC).

```r
# Export to SGR or GFF
MEDME.writeFiles(data = testMEDMEset, output = "results", format = "GFF")
```

## Tips and Best Practices
*   **Calibration:** The model is most accurate when a true fully-methylated calibration sample is used. If using regular genomic DNA as a proxy, be aware that promoter regions (often hypomethylated) may introduce bias.
*   **Genome Versions:** Ensure the `BSgenome` version matches the coordinates of your MeDIP data. Use tools like `liftOver` if coordinates are from an older assembly.
*   **Window Size:** The `wsize` parameter in `smooth` and `MEDME.predict` should generally match the expected fragment size or resolution of your tiling array.

## Reference documentation
- [MEDME overview](./references/MEDME.md)