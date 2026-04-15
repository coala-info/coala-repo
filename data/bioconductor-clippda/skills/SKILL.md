---
name: bioconductor-clippda
description: This tool analyzes clinical proteomic mass spectrometry data with technical replicates to identify biomarkers and calculate required sample sizes. Use when user asks to pre-process repeated peak data, format proteomic data for differential expression analysis, or determine sample sizes for clinical studies while accounting for confounding factors.
homepage: https://bioconductor.org/packages/release/bioc/html/clippda.html
---

# bioconductor-clippda

name: bioconductor-clippda
description: Analysis of clinical proteomic profiling data, specifically for mass spectrometry (SELDI/MALDI) studies with technical replicates. Use this skill to: (1) Pre-process repeated peak data and filter inconsistent replicates, (2) Format proteomic data for differential expression analysis, (3) Create aclinicalProteomicData objects to combine expression and phenotypic data, and (4) Calculate required sample sizes for clinical proteomic studies while adjusting for sample imbalance and confounding factors.

## Overview

The `clippda` package provides tools for the analysis of clinical proteomic data, with a primary focus on mass spectrometry (SELDI-TOF, MALDI-TOF). It addresses the specific challenges of clinical studies, such as technical replicates, sample imbalance (unequal cases/controls), and confounding factors. Its most critical application is determining the sample size required to achieve adequate statistical power for biomarker discovery.

## Core Workflow

### 1. Data Pre-processing and Filtering
Mass spectrometry data often contains technical replicates. `clippda` helps identify mislabeled samples and filters out inconsistent replicates.

```r
library(clippda)

# Check for samples with incorrect number of replicates
# no.peaks: number of detected peaks; no.replicates: intended replicates (usually 2)
checkNo.replicates(liverRawData, no.peaks = 53, no.replicates = 2)

# Pre-process to keep only the two most similar replicates
# threshold: correlation cutoff for replicate consistency
threshold <- 0.80
Data <- preProcRepeatedPeakData(liverRawData, no.peaks = 53, no.replicates = 2, threshold)

# Filter samples with conflicting replicate information
TAGS <- spectrumFilter(Data, threshold, no.peaks = 53)$SampleTag
filteredData <- Data[Data$SampleTag %in% TAGS, ]
```

### 2. Creating aclinicalProteomicData Objects
This class integrates expression data with phenotypic metadata (covariates like age, sex, or tumor stage).

```r
# Initialize the object
OBJECT <- new("aclinicalProteomicsData")

# Assign data to slots
OBJECT@rawSELDIdata <- as.matrix(filteredData)
OBJECT@phenotypicData <- as.matrix(liver_pheno)
OBJECT@covariates <- c("tumor", "sex")
OBJECT@variableClass <- c('numeric', 'factor', 'factor')
OBJECT@no.peaks <- 53

# Access data using accessor functions
exprs <- proteomicsExprsData(OBJECT)
pheno <- proteomicspData(OBJECT)
```

### 3. Sample Size Calculation
The package calculates sample sizes by accounting for biological variance, technical variance, and the heterogeneity correction factor (Z).

```r
# 1. Obtain parameters from pilot data
intraclasscorr <- 0.60
signifcut <- 0.05
params <- sampleSizeParameters(OBJECT, intraclasscorr, signifcut)

# 2. Calculate the heterogeneity correction factor (Z)
# Z = 2 indicates a balanced study; Z > 2 indicates imbalance
Z <- as.vector(fisherInformation(OBJECT)[2,2])/2

# 3. Calculate sample size
# Returns a table of sample sizes for various power (beta) and significance (alpha) levels
ssize <- sampleSize(OBJECT, intraclasscorr, signifcut)
```

### 4. Visualization
Visualizing the relationship between sample size, protein variance, and clinically important differences.

```r
# Contour plots of sample sizes
# observedPara: c(variance, difference) from pilot data
sampleSizeContourPlots(Z = 2.4, m = 2, DIFF = seq(0.1, 0.5, 0.01), 
                       VAR = seq(0.2, 4, 0.1), beta = c(0.9, 0.8, 0.7), 
                       alpha = 1 - c(0.001, 0.01, 0.05)/2, 
                       observedPara = c(1, 0.4), Indicator = 1)

# 3D Scatter plots
sampleSize3DscatterPlots(Z = 2.4, m = 2, DIFF = seq(0.1, 0.5, 0.01), 
                         VAR = seq(0.2, 4, 0.1), beta = c(0.9, 0.8, 0.7), 
                         alpha = 1 - c(0.001, 0.01, 0.05)/2, 
                         observedDIFF = 0.4, observedVAR = 1.0, 
                         observedSampleSize = 80, Angle = 60, Indicator = 1)
```

## Key Functions
- `preProcRepeatedPeakData`: Main wrapper for cleaning raw mass spec data.
- `mostSimilarTwo`: Identifies the pair of replicates with the highest correlation.
- `sampleClusteredData`: Formats data for use with `limma` or other repeated measures tools.
- `sampleSize`: Computes the number of biological samples needed.
- `fisherInformation`: Calculates the expected Fisher information matrix to derive the Z factor.

## Reference documentation
- [clippda](./references/clippda.md)