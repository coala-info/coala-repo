---
name: bioconductor-hd2013sgi
description: This package provides tools and data for analyzing multiparametric genetic interaction screens in human cancer cells. Use when user asks to access data from the Laufer et al. (2013) study, perform image segmentation and feature extraction, normalize phenotypic data, or calculate pi-scores for genetic interactions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HD2013SGI.html
---


# bioconductor-hd2013sgi

name: bioconductor-hd2013sgi
description: Analysis of multiparametric genetic interaction screens in human cancer cells using RNAi. Use this skill to access and process the data from the Laufer et al. (2013) study, including image segmentation, feature extraction, normalization, and calculation of pi-scores for genetic interactions.

## Overview
The `HD2013SGI` package provides the data and analysis pipeline for a large-scale genetic interaction screen in human cells. It uses multiparametric phenotyping (measuring cell shape, nucleus size, texture, etc.) rather than just cell viability. The package contains raw feature data, pre-computed interaction scores (pi-scores), and functions to reproduce the statistical analysis from the original publication.

## Data Access
The package contains several key datasets representing different stages of the analysis pipeline.

```r
library(HD2013SGI)

# Main genetic interaction data (pi-scores and p-values)
data("Interactions", package="HD2013SGI")
# Interactions$piscore: 6D array [target, design, query, design, phenotype, replicate]
# Interactions$padj: 5D array of adjusted p-values

# Other intermediate datasets
data("featuresPerWell", package="HD2013SGI") # Raw screen data
data("datamatrix", package="HD2013SGI")      # QC-filtered phenotype data
data("mainEffects", package="HD2013SGI")     # Single knockdown effects
```

## Typical Workflow

### 1. Image Processing and Feature Extraction
While the full 5.6TB dataset is not in the package, you can run the segmentation pipeline on example images.
```r
# Load example images
fnch1 = system.file("images/image-DAPI.tif", package="HD2013SGI")
Img1 = readImage(fnch1)

# Nuclei segmentation
nucleusThresh = thresh(Img1, w = 10, h = 10, offset = 0.0001)
nucleusOpening = opening(nucleusThresh, kern=makeBrush(3, shape="disc"))
nucleusSeed = bwlabel(nucleusOpening)

# Feature extraction
F1 = computeFeatures(nucleusRegions, Img1, xname="nuc", refnames="nuc")
```

### 2. Normalization and Transformation
Phenotypic features are transformed using a generalized logarithm (glog) to stabilize variance and then normalized to account for plate effects.
```r
# Generalized log transform
# c is typically the 3% quantile of the feature distribution
glog_data = log((x + sqrt(x^2 + c^2)) / 2)

# Center and scale
scaled_data = (data - median(data)) / mad(data)
```

### 3. Calculating Interaction Scores (pi-scores)
The package uses a robust linear model to estimate interaction terms.
```r
# Calculate main effects and pi-scores
# TargetNeg specifies indices of negative control siRNAs
MP = HD2013SGImaineffects(D_matrix, TargetNeg = neg_indices)

# Access results
pi_scores = MP$pi
target_effects = MP$targetMainEffect
```

### 4. Feature Selection
To reduce redundancy among the hundreds of extracted features, a stability-based selection is used.
```r
# Select non-redundant features
stabilitySelection = HD2013SGIselectByStability(data_list, preselect = "count")
selected_features = stabilitySelection$selected[stabilitySelection$ratioPositive >= 0.5]
```

## Visualization
The package includes specialized functions for visualizing high-dimensional interaction data.
```r
# Screen plots (mapping scores back to plate layout)
plotScreen(plate_list, ncol=2, zrange=c(-3,3))

# Heatmaps with specific color scales for pi-scores
cuts = c(-Inf, seq(-6, -2, length.out=10), 0, seq(2, 6, length.out=10), Inf)
HD2013SGIHeatmapHuman(x = PI_array, cuts = cuts)
```

## Reference documentation
- [HD2013SGI](./references/HD2013SGI.md)