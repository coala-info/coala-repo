---
name: bioconductor-cghcall
description: This tool performs preprocessing, segmentation, and statistical calling of copy number aberrations from aCGH data using a mixture model approach. Use when user asks to preprocess aCGH log2 ratios, segment genomic data, call copy number states, or perform cellularity correction for tumor samples.
homepage: https://bioconductor.org/packages/release/bioc/html/CGHcall.html
---


# bioconductor-cghcall

name: bioconductor-cghcall
description: Specialized workflow for calling copy number aberrations (loss, normal, gain, amplification) from aCGH (array Comparative Genomic Hybridization) data. Use this skill when analyzing DNA copy number profiles to perform preprocessing, normalization, segmentation, and statistical calling of aberrations, including cellularity correction for tumor samples.

## Overview

The `CGHcall` package provides a comprehensive pipeline for transforming raw aCGH log2 ratios into discrete copy number states. It is particularly robust for tumor profiles as it can account for varying proportions of normal cell contamination (cellularity) and uses a mixture model approach to assign probabilities to five states: double loss, loss, normal, gain, and amplification.

## Core Workflow

### 1. Data Preparation
Convert your data frame or matrix into a `cghRaw` object. The input should contain genomic coordinates (Chromosome, Start, End) and log2 ratios.

```r
library(CGHcall)
# Assuming 'df' is your data frame
cgh_data <- make_cghRaw(df)
```

### 2. Preprocessing and Normalization
Clean the data by removing invalid positions and imputing missing values, followed by normalization to ensure samples are comparable.

```r
# Preprocess: handle missing values and chromosome filtering
cgh_prepped <- preprocess(cgh_data, maxmiss=30, nchrom=22)

# Normalize: median normalization and outlier smoothing
cgh_norm <- normalize(cgh_prepped, method="median", smoothOutliers=TRUE)
```

### 3. Segmentation
Segment the normalized log2 ratios using the DNAcopy algorithm. This step groups adjacent probes with similar copy numbers.

```r
# clen and undo.SD control the stringency of merging segments
cgh_seg <- segmentData(cgh_norm, 
                       method="DNAcopy", 
                       undo.splits="sdundo", 
                       undo.SD=3, 
                       clen=10, 
                       relSDlong=5)

# Post-segmentation normalization to center the 'zero' level
cgh_postseg <- postsegnormalize(cgh_seg)
```

### 4. Calling Aberrations
Apply the mixture model to call states. If tumor purity is known, provide the `cellularity` vector to improve accuracy.

```r
# Define tumor proportion for each sample (e.g., 75% and 90%)
tumor_prop <- c(0.75, 0.9)

# Call states (nclass=5 includes double loss and amplification)
cgh_calls <- CGHcall(cgh_postseg, nclass=5, cellularity=tumor_prop)

# Expand the result to a full call object
final_result <- ExpandCGHcall(cgh_calls, cgh_postseg)
```

## Visualization and Analysis

### Individual Profiles
Plot log2 ratios and segment calls for a specific sample.
```r
plot(final_result[,1])
```

### Summary and Frequency Plots
Visualize the distribution of aberrations across the entire cohort.
```r
# Summary of probabilities
summaryPlot(final_result)

# Frequency of gains and losses across chromosomes
frequencyPlotCalls(final_result)
```

## Tips for Success
- **Cellularity**: Always provide cellularity estimates if available; the default is 1 (100% tumor), which may lead to under-calling in mixed samples.
- **Memory**: For very large arrays, the `ExpandCGHcall` object can be memory-intensive.
- **Chromosome Handling**: Ensure your chromosome annotations are numeric (1-22) for the `preprocess` function to work correctly with the `nchrom` parameter.

## Reference documentation
- [CGHcall: Calling aberrations for array CGH tumor profiles](./references/CGHcall.md)