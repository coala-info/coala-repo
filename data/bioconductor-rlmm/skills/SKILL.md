---
name: bioconductor-rlmm
description: This tool performs genotype calling for Affymetrix SNP arrays using a supervised learning algorithm based on Mahalanobis distance. Use when user asks to normalize probe intensity data, calculate allele-specific summary measures, or classify genotypes from Affymetrix 100K-Xba SNP data.
homepage: https://bioconductor.org/packages/release/bioc/html/RLMM.html
---


# bioconductor-rlmm

name: bioconductor-rlmm
description: Genotype calling for Affymetrix SNP arrays using the Robust Linear Model with Mahalanobis Distance (RLMM) classifier. Use this skill when performing supervised classification of Affymetrix 100K-Xba SNP data to obtain genotype calls (AA, AB, BB) from probe-level intensity data.

## Overview

RLMM is a supervised learning algorithm for genotype calling. It utilizes a training set (based on HapMap CEPH individuals) to perform multi-chip, multi-SNP classification. The workflow transforms raw probe intensities into normalized values, calculates allele-specific summary measures (theta A and theta B), and finally classifies SNPs based on Mahalanobis distance from known genotype clusters.

## Workflow and Functions

### 1. Data Preparation
RLMM requires ASCII format probe data (.raw files). If you have binary CEL files, they must be converted to .raw format using external Affymetrix tools before processing in R.

### 2. Normalization
Use `normalize_Rawfiles` to scale your data to the training set. This creates `.norm` files in your directory.
```r
library(RLMM)
# cqvfile is a required internal reference file (e.g., "Xba.CQV")
normalize_Rawfiles(cqvfile = "Xba.CQV", probefiledir = ".")
```

### 3. Allele Summarization
Calculate theta estimates (summary measures of probe intensities for Allele A and Allele B) using `create_Thetafile`.
```r
# start/end specify the range of SNPs; end = -1 processes all SNPs
create_Thetafile(start = 1, end = -1, thetafile = "Xba.theta", probefiledir = ".")
```

### 4. Genotype Classification
Perform the final classification using the `Classify` function. This requires a regions file (e.g., `Xba.regions`) containing the cluster centers and variance-covariance matrices from the training data.
```r
Classify(genotypefile = "Xba.rlmm", 
         regionsfile = "Xba.regions", 
         thetafile = "Xba.theta", 
         callrate = 100)
```
*   **Call Rate:** You can specify call rates (80, 82, ..., 100). Lower call rates typically result in higher accuracy for the calls that are made.

### 5. Visualization
To visually inspect the clustering of genotypes for specific SNPs, use `plot_theta`.
```r
# snpsfile is a text file containing a list of SNP IDs to plot
plot_theta(genotypefile = "Xba.rlmm", 
           thetafile = "Xba.theta", 
           plotfile = "plots.ps", 
           snpsfile = "snps.lst")
```

## Important Considerations
*   **Internal Files:** The algorithm depends on specific internal files (`Xba.CQV` and `Xba.regions`). These must be present in your working directory.
*   **Array Support:** This package is specifically designed for the Affymetrix Mapping 100K - Xba set.
*   **File Locations:** If your `.raw` or `.norm` files are not in the current R working directory, you must explicitly provide the path via the `probefiledir` argument.

## Reference documentation
- [RLMM - Robust Linear Model with Mahalanobis Distance Classifier](./references/RLMM.md)