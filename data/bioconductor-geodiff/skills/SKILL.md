---
name: bioconductor-geodiff
description: This tool provides statistical analysis and differential expression modeling for NanoString GeoMx Digital Spatial Profiler data. Use when user asks to model background noise, aggregate probes into targets, normalize spatial profiling data, or perform differential expression analysis with fixed and mixed effects.
homepage: https://bioconductor.org/packages/release/bioc/html/GeoDiff.html
---


# bioconductor-geodiff

name: bioconductor-geodiff
description: Statistical analysis of NanoString GeoMx Digital Spatial Profiler (DSP) data. Use for background modeling (Poisson), target and sample QC, normalization (Poisson threshold), and differential expression analysis (Negative Binomial threshold models) including fixed and mixed effects.

# bioconductor-geodiff

## Overview
The `GeoDiff` package provides a statistical framework for analyzing NanoString GeoMx Digital Spatial Profiler (DSP) data. It addresses the unique challenges of DSP data, such as varying background levels and technical noise, by using Poisson and Negative Binomial models. Key capabilities include background modeling using negative probes, probe aggregation, and robust differential expression (DE) analysis that accounts for complex study designs with random effects.

## Core Workflow

### 1. Data Preparation
`GeoDiff` works with `NanoStringGeoMxSet` objects. Ensure your data is at the **probe level** before starting background modeling.

```r
library(GeoDiff)
library(GeomxTools)

# Load data (example using internal kidney dataset)
data("kidney")
kidney <- updateGeoMxSet(kidney)

# Check if data is at probe level
featureType(kidney) # Should return "Probe"
```

### 2. Background Modeling
Fit a Poisson background model using negative probes to estimate feature factors for probes and size factors for Regions of Interest (ROIs).

```r
# Fit model
kidney <- fitPoisBG(kidney)

# Optional: Fit by group (e.g., slide) if batch effects are suspected
kidney <- fitPoisBG(kidney, groupvar = "slide name")

# Diagnose dispersion (values > 2 suggest over-dispersion/outliers)
kidney_diag <- diagPoisBG(kidney, split = TRUE)
notes(kidney_diag)$disper_sp
```

### 3. Probe Aggregation and Target QC
Filter and aggregate probes into targets. `aggreprobe` handles filtering based on correlation or score tests.

```r
# Aggregate probes to targets
kidney <- aggreprobe(kidney, use = "cor")

# Background Score Test to find targets expressed above background
kidney <- BGScoreTest(kidney, split = TRUE)
sum(fData(kidney)$pvalues < 1e-3, na.rm = TRUE)
```

### 4. Normalization
Use the Poisson threshold model for normalization. This method is often more robust than Q3 normalization for low-signal data.

```r
# Estimate signal size factors
kidney <- fitNBth(kidney, split = TRUE)

# Perform normalization (adds 'normmat' to assayData)
bgMean <- mean(fData(kidney)$featfact, na.rm = TRUE)
ROIs_high <- sampleNames(kidney) # Or subset based on QC
kidney <- fitPoisthNorm(kidney, split = TRUE, ROIs_high = ROIs_high, threshold_mean = bgMean)

# Access normalized data (log2 scale)
norm_data <- assayDataElement(kidney, "normmat_sp")
```

### 5. Differential Expression (DE)
`GeoDiff` provides Negative Binomial threshold models for DE.

**Fixed Effect Model:**
```r
NBthDEmod <- fitNBthDE(form = ~region, object = kidney, split = FALSE)
```

**Mixed Effect Model (Random Intercept/Slope):**
Use when multiple ROIs come from the same slide or patient.
```r
# Random slope model: ~ fixed_effect + (random_effect | grouping_factor)
NBthmDEmod <- fitNBthmDE(object = kidney, 
                         form = ~ region + (1 + region | `slide name`),
                         ROIs_high = ROIs_high,
                         features_all = features_subset)
```

**Extracting Results:**
```r
# Generate inference results
coeff <- coefNBth(NBthDEmod)

# Create DE table for a specific variable
DE_table <- DENBth(coeff, variable = "regiontubule")
head(DE_table)
```

## Key Functions
- `fitPoisBG`: Fits the Poisson background model.
- `diagPoisBG`: Diagnostic tool for the background model.
- `aggreprobe`: Aggregates probes into targets with optional filtering.
- `BGScoreTest`: Statistical test for expression above background.
- `fitNBth`: Estimates technical size factors for signal.
- `fitPoisthNorm`: Performs Poisson threshold normalization.
- `fitNBthDE` / `fitNBthmDE`: Fits DE models (fixed/mixed effects).
- `coefNBth` / `DENBth`: Extracts coefficients and formats DE tables.

## Reference documentation
- [Workflow_WTA_kidney.Rmd](./references/Workflow_WTA_kidney.Rmd)
- [Workflow_WTA_kidney.md](./references/Workflow_WTA_kidney.md)