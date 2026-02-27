---
name: bioconductor-standr
description: This tool provides a comprehensive toolkit for the quality control, normalization, and batch correction of spatial transcriptomics data, specifically optimized for NanoString GeoMx DSP platforms. Use when user asks to load GeoMx data, perform gene or ROI-level quality control, visualize spatial metadata, normalize spatial expression data, or apply RUV4-based batch correction.
homepage: https://bioconductor.org/packages/release/bioc/html/standR.html
---


# bioconductor-standr

name: bioconductor-standr
description: Analysis of spatial transcriptomics data using the standR package. Use this skill for data inspection, quality control (QC), normalization, and batch correction of NanoString GeoMx DSP data or other spatial transcriptomics datasets stored in SpatialExperiment objects.

## Overview
The `standR` package provides a comprehensive toolkit for the analysis of spatial transcriptomics data, specifically optimized for NanoString GeoMx DSP platforms. It utilizes the `SpatialExperiment` class to ensure compatibility with the Bioconductor ecosystem. Key functionalities include metadata visualization, gene and ROI-level QC, data normalization (TMM, CPM, etc.), and RUV4-based batch correction.

## Core Workflow

### 1. Data Loading
Load GeoMx data using `readGeoMx`. This function requires count data, sample annotation, and optionally feature annotation.
```r
library(standR)
# spe is a SpatialExperiment object
spe <- readGeoMx(countFile, sampleAnnoFile, featureAnnoFile = featureAnnoFile, rmNegProbe = TRUE)
```

### 2. Quality Control (QC)
Perform QC at both the gene and ROI (Region of Interest) levels.
- **Metadata Visualization**: Use `plotSampleInfo` to visualize the distribution of samples across experimental variables.
- **Gene QC**: Use `addPerROIQC` to calculate metrics and `plotGeneQC` to visualize expression distributions and identify lowly expressed genes.
- **ROI QC**: Use `plotROIQC` to identify low-quality samples based on library size and nuclei count.
```r
# Add QC metrics
spe <- addPerROIQC(spe, rm_genes = TRUE)

# Visualize Gene QC
plotGeneQC(spe, ordannots = "condition")

# Visualize ROI QC and filter
plotROIQC(spe, y_threshold = 50000)
spe <- spe[, colData(spe)$lib_size > 50000]
```

### 3. Data Inspection
Before normalization, inspect the data for technical variations using Relative Log Expression (RLE) and Principal Component Analysis (PCA).
```r
# RLE plot
plotRLExpr(spe, ordannots = "SlideName", assay = 2)

# PCA plot
drawPCA(spe, assay = 2, col = SlideName, shape = regions)
```

### 4. Normalization
The `geomxNorm` function supports multiple methods: "TMM", "CPM", "upperquartile", "sizefactor", "TPM", and "RPKM".
```r
# TMM Normalization
spe_tmm <- geomxNorm(spe, method = "TMM")
```

### 5. Batch Correction
Use RUV4 to remove batch effects (e.g., slide-to-slide variation). This requires identifying Negative Control Genes (NCGs).
```r
# Find NCGs (least variable genes across batches)
spe <- findNCGs(spe, batch_name = "SlideName", top_n = 500)

# Apply RUV4 correction
# 'factors' should be the biological variation you want to preserve
spe_ruv <- geomxBatchCorrection(spe, factors = "biology_group", 
                                NCGs = metadata(spe)$NCGs, k = 5)

# Inspect corrected data
plotPairPCA(spe_ruv, assay = 2, color = disease_status)
```

## Tips for Success
- **Collinearity**: When creating biological factors for batch correction, merge relevant annotations (e.g., tissue type + disease status) to avoid collinearity issues in the RUV4 model.
- **NCGs**: The `findNCGs` function is essential for RUV4. Ensure the `batch_name` parameter correctly identifies the source of technical variation (usually `SlideName`).
- **Assay Selection**: Many plotting functions require the `assay` index. Typically, `assay = 1` is raw counts and `assay = 2` is log-transformed counts (logCPM).

## Reference documentation
- [A quick start guide to the standR package](./references/Quick_start.md)