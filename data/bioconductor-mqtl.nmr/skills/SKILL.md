---
name: bioconductor-mqtl.nmr
description: bioconductor-mqtl.nmr provides a pipeline for preprocessing 1H-NMR metabolomic data and performing metabolic quantitative trait locus mapping. Use when user asks to normalize and align NMR spectra, reduce data dimensionality using SRV, or identify associations between genomic markers and metabolic profiles.
homepage: https://bioconductor.org/packages/3.6/bioc/html/mQTL.NMR.html
---


# bioconductor-mqtl.nmr

## Overview

The `mQTL.NMR` package provides a complete pipeline for analyzing 1H-NMR metabolomic data in the context of genetic mapping. It handles the transition from raw spectral data to quantitative trait locus (QTL) results. Key capabilities include Recursive Segment-wise Peak Alignment (RSPA), Statistical Recoupling of Variables (SRV) for dimensionality reduction, and integration with mapping tools to identify associations between genomic markers and metabolic profiles.

## Core Workflow

### 1. Data Preparation
Format raw data files into the required comma-delimited (csvs) format.
```r
library(mQTL.NMR)
# Load demonstration data if needed
load_datafiles() 
# Format pheno, geno, and other data into clean text files
format_mQTL(phenofile, genofile, physiodat, cleandat, cleangen)
```

### 2. Preprocessing (Normalization & Alignment)
Normalize spectra to account for dilution effects and align peaks to a reference spectrum.
```r
# Normalization (e.g., Constant Sum 'CS')
nmeth <- 'CS'
normalise_mQTL(cleandat, CSnorm, nmeth)

# Alignment using RSPA
align_mQTL(CSnorm, aligdat)
```

### 3. Dimensionality Reduction
Reduce the number of traits using Statistical Recoupling of Variables (SRV) or binning to improve statistical power.
```r
# SRV approach
pre_mQTL(aligdat, reducedF, RedMet="SRV", met="rectangle", corrT=0.9)
```

### 4. mQTL Mapping
Perform the association study between the reduced metabolic traits and genotypes.
```r
results <- process_mQTL(reducedF, cleangen, nperm=0)
```

### 5. Visualization and Summary
```r
# Generate standard plots (3D profiles, LOD scores)
post_mQTL(results)

# Circular genome-metabolome plot
circle_mQTL(results, T=8, spacing=0)

# Summary table of top hits
summary_mQTL(results, rectangle_SRV, T=8)
```

## Troubleshooting and Tips

### Peak Alignment Errors
If `align_mQTL()` fails with "Peak validation threshold exceeds spectrum maximum and minimum value":
1. Try a different normalization method.
2. Adjust the `ampThr` parameter. You can automate this by modifying the `setupRSPA` function in the namespace to use `mQTL.NMR:::getAmpThr`.

### Preprocessing Only
If you do not have genomic data, you can still use the package for NMR preprocessing by calling micro-functions like `normalise()` directly on R data frames or matrices.

### Structural Assignment
Use `SRV.plot()` and `Top_SRV.plot()` to visualize identified clusters on the NMR profile. This assists in identifying the specific metabolites corresponding to significant QTL peaks.

## Reference documentation

- [FAQ](./references/FAQ.md)
- [How to use mQTL.NMR](./references/mQTLUse.md)