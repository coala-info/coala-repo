---
name: bioconductor-arraymvout
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/arrayMvout.html
---

# bioconductor-arraymvout

name: bioconductor-arraymvout
description: Affymetrix microarray outlier detection using dimension reduction (PCA) and parametric multivariate outlier detection. Use this skill to identify problematic arrays in Affymetrix datasets by analyzing quality control features like background, RLE, NUSE, and RNA degradation.

## Overview

The `arrayMvout` package provides a formalized, automated approach to identifying outlying microarrays. It works by reducing the dimensionality of standard Affymetrix quality metrics (from `simpleaffy`, `affyPLM`, and `AffyRNAdeg`) using Principal Components Analysis (PCA) and then applying multivariate outlier detection to the resulting components. This is particularly useful for large clinical trial datasets where manual inspection of every array is impractical.

## Core Workflow

### 1. Automated Outlier Detection
The primary function is `ArrayOutliers()`. It can take an `AffyBatch` object directly or a pre-computed matrix of QC features.

```R
library(arrayMvout)

# Basic usage with an AffyBatch object
# alpha: significance level for outlier labeling
results <- ArrayOutliers(myAffyBatch, alpha = 0.01)

# View detected outliers
results$outl
```

### 2. Using Pre-computed QC Objects
To save time on large datasets, you can pass pre-computed QC objects from other Bioconductor packages:

```R
# If you already have QC objects from simpleaffy or affyPLM
results <- ArrayOutliers(myAffyBatch, 
                         alpha = 0.05, 
                         qcOut = mySimpleAffyQC, 
                         plmOut = myPLMset, 
                         degOut = myRNAdeg)
```

### 3. Interpreting Results
The output of `ArrayOutliers` is a list containing:
- `outl`: A data frame of features for arrays identified as outliers.
- `kept`: A data frame of features for inlying arrays.
- `allQC`: The full matrix of QC features used for the analysis.
- `pcalist`: Details of the PCA and the specific components where outliers were detected at various alpha levels.

### 4. Visualization
You can visualize the outlier detection results in PCA space:

```R
# Plot the first and third principal components
plot(results, choices = c(1, 3))
```

## QC Features Analyzed
The package typically evaluates the following metrics:
- **avgBG**: Average background.
- **Present**: Percentage of "Present" calls.
- **HSACO7 / GAPDH**: 3'/5' ratios for housekeeping genes.
- **SF**: Scaling Factor.
- **RLE / RLE_IQR**: Relative Log Expression metrics.
- **NUSE**: Normalized Unscaled Standard Error.
- **RNAslope**: Slope of the RNA degradation plot.

## Tips for Analysis
- **Negative Controls**: In a high-quality dataset (like MAQC), `ArrayOutliers` should ideally return "No outliers".
- **Sensitivity**: If `ArrayOutliers` is too conservative, consider comparing results with the `mdqc` package, which uses robust Mahalanobis distance.
- **Data Reduction**: The package uses PCA to handle the correlation between different QC metrics, preventing redundant features from biasing the outlier detection.

## Reference documentation
- [arrayMvout](./references/arrayMvout.md)