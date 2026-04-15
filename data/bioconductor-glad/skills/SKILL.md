---
name: bioconductor-glad
description: bioconductor-glad analyzes array Comparative Genomic Hybridization data to detect genomic breakpoints and assign biological statuses such as gains or losses. Use when user asks to segment aCGH data, identify DNA copy number alterations, or visualize genomic profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/GLAD.html
---

# bioconductor-glad

## Overview

The GLAD (Gain and Loss Analysis of DNA) package is designed for the analysis of Array Comparative Genomic Hybridization (aCGH) data. It provides a methodology for detecting breakpoints that delimit altered genomic regions and assigning a biological status (normal, gain, or loss) to each region. The package implements the Adaptive Weights Smoothing (AWS) and HaarSeg algorithms for data segmentation.

## Data Structures

The package uses specific S3 classes to manage aCGH data:

*   **arrayCGH**: Stores raw values after image analysis. It requires a `data.frame` named `arrayValues` (with `Col` and `Row` coordinates) and an `arrayDesign` vector.
*   **profileCGH**: Stores synthetic values for each clone. Compulsory columns include `LogRatio`, `Chromosome`, and `PosOrder`.
*   **profileChr**: A subset of `profileCGH` containing data for only one chromosome.

Use `as.profileCGH()` to convert a data frame into a compatible profile object.

## Analysis Workflow

### Data Preparation
Convert your data frame into a `profileCGH` object before analysis.
```r
library(GLAD)
data(snijders)
# gm13330 is an example dataset
profileCGH <- as.profileCGH(gm13330)
```

### Segmentation and Calling
The package provides two main functions: `glad()` and `daglad()`. Use `daglad()` as it is the improved version that includes DNA copy number calling.

```r
# Recommended: daglad for segmentation and status assignment
res <- daglad(profileCGH, 
              mediancenter = FALSE, 
              smoothfunc = "lawsglad", 
              deltaN = 0.2, 
              forceGL = c(-0.3, 0.3))
```

For faster computation, especially with high-density arrays, use `smoothfunc = "haarseg"`.

### Tuning Parameters
Adjust these parameters to control the sensitivity of breakpoint detection:
*   **lambdabreak**: Penalty for creating a new breakpoint.
*   **lambdacluster**: Penalty for clustering regions within a chromosome.
*   **lambdaclusterGen**: Penalty for clustering regions across the whole genome.
*   **param = c(d = 6)**: For low signal-to-noise ratios, decrease `d` (e.g., `d = 3`) to identify more breakpoints.

### Status Thresholds
In `daglad()`, use these parameters to define biological states:
*   **deltaN**: Range around the normal level (e.g., 0.2).
*   **forceGL**: Thresholds for Gain and Loss (e.g., `c(-0.3, 0.3)`).
*   **amplicon**: Threshold for amplicons.
*   **deletion**: Threshold for deletions.

## Visualization

### Genomic Profiles
Visualize the segmented data across the whole genome or specific chromosomes.

```r
# Plot whole genome with cytogenetic banding
plotProfile(res, unit = 3, Bkp = TRUE, Smoothing = "Smoothing", cytoband = cytoband)

# Plot specific chromosome (e.g., Chromosome 1)
plotProfile(res, Chromosome = 1, unit = 3, Bkp = TRUE, labels = TRUE)
```

### Spatial Array Plots
Examine potential spatial biases on the physical array.

```r
# Spatial image of the array
arrayPlot(arrayObj, "Log2Rat", bar = "none")

# 3D perspective view
arrayPersp(arrayObj, "Log2Rat", box = FALSE, theta = 110, phi = 40)
```

## Reference documentation

- [GLAD](./references/GLAD.md)