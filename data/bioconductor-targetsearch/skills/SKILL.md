---
name: bioconductor-targetsearch
description: TargetSearch performs pre-processing and targeted metabolite identification for GC-MS data using retention index correction. Use when user asks to import NetCDF files, perform baseline correction, detect peaks, align retention indices, or search metabolite libraries.
homepage: https://bioconductor.org/packages/release/bioc/html/TargetSearch.html
---


# bioconductor-targetsearch

name: bioconductor-targetsearch
description: Pre-processing and targeted metabolite identification for GC-MS data using retention index (RI) correction. Use this skill when analyzing GC-MS metabolomics data in R, specifically for importing NetCDF files, performing baseline correction, peak detection, RI alignment, and library searching against metabolite databases.

## Overview

TargetSearch is a Bioconductor package designed for the targeted analysis of GC-MS data. It automates the search for specific metabolites in chromatograms by converting retention times (RT) to retention indices (RI) using markers (e.g., alkanes or FAMEs). This allows for robust metabolite identification across different runs and instruments.

## Core Workflow

### 1. Data Import and Setup

TargetSearch requires three main inputs: NetCDF files, a sample description file, and a RI marker definition file.

```r
library(TargetSearch)
library(TargetSearchData)

# Define paths
cdf_path <- tsd_data_path()
sample_file <- tsd_file_path("samples.txt")

# Import samples
samples <- ImportSamples(sample_file, CDFpath = cdf_path, RIpath = ".")

# Import RI marker settings (e.g., FAMEs)
rim_file <- tsd_file_path("rimLimits.txt")
rimLimits <- ImportFameSettings(rim_file, mass = 87)
```

### 2. Pre-processing and RI Correction

It is highly recommended to convert CDF files to the TargetSearch CDF4 format for faster access and to perform baseline correction if the raw data is not already corrected.

```r
# Convert to CDF4 and perform baseline correction (optional but recommended)
samples <- ncdf4Convert(samples, path=".", baseline=TRUE, bsline_method="quantiles")

# Peak detection and RI marker identification
# Returns a matrix of RI marker retention times
RImatrix <- RIcorrect(samples, rimLimits, IntThreshold = 100, pp.method = "ppc", Window = 15)

# Check for RI marker outliers
outliers <- FAMEoutliers(samples, RImatrix, threshold = 3)
```

### 3. Library Search and Metabolite Profiling

Metabolite identification is performed using a reference library containing expected RIs and selective masses.

```r
# Import reference library
lib_file <- tsd_file_path("library.txt")
lib <- ImportLibrary(lib_file, RI_dev = c(2000, 1000, 200))

# Step 1: Update library RIs based on median observed RIs
lib <- medianRILib(samples, lib)

# Step 2: Search for selective masses and correlate profiles
cor_RI <- sampleRI(samples, lib, r_thres = 0.95, method = "dayNorm")

# Step 3: Find all library masses in the samples
peakData <- peakFind(samples, lib, cor_RI)

# Create metabolite profile
MetabProfile <- Profile(samples, lib, peakData, r_thres = 0.95, method = "dayNorm")

# Clean up redundancy (grouping similar metabolites)
finalProfile <- ProfileCleanUp(MetabProfile, timeSplit = 500, r_thres = 0.95)
```

## Specialized Scenarios

### External RI Markers
If RI markers were injected separately from biological samples (alternating runs), use the `fixRI` function to map the marker times from the standard runs to the biological samples. See [RICorrection.md](./references/RICorrection.md) for the specific mapping logic.

### Untargeted Search
While targeted, you can perform an untargeted search by creating a "dummy" library with evenly spaced RIs and a broad range of masses, then refining the library based on correlating masses found.

## Visualization

```r
# Compare sample spectrum to library reference (head-tail plot)
plotSpectra(lib, peakData, libID = 3, type = "ht")

# Plot chromatographic peak for a specific metabolite
plotPeak(samples, lib, MetabProfile, rawpeaks, which.smp=1, which.met=3)
```

## Reference documentation

- [RI Correction Extra](./references/RICorrection.md)
- [The TargetSearch Package](./references/TargetSearch.md)