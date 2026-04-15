---
name: bioconductor-yamss
description: The yamss package provides tools for preprocessing untargeted metabolomics data using bivariate kernel density estimation to identify and quantify peaks across multiple samples simultaneously. Use when user asks to preprocess mass spectrometry data, perform retention time alignment, call peaks using the bakedpi algorithm, or conduct differential abundance analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/yamss.html
---

# bioconductor-yamss

## Overview

The `yamss` (Yet Another Mass Spectrometry Software) package is designed for the preprocessing of untargeted metabolomics data. Its core algorithm, **bakedpi**, uses bivariate kernel density estimation to identify and quantify peaks. Unlike methods that detect peaks in individual samples and then align them, `yamss` processes all samples together to improve the quality of differential analysis. The workflow typically moves from raw data (`CMSraw`) to processed density estimates (`CMSproc`) to quantified peaks (`CMSslice`), which can then be analyzed for differential abundance using `limma`.

## Workflow and Main Functions

### 1. Loading Raw Data
Data is read from standard mass spectral files (e.g., .mzML) using `readMSdata`. You should provide a `DataFrame` for `colData` to track sample metadata.

```r
library(yamss)
# Define file paths and sample classes
files <- list.files(path, pattern = ".mzML", full.names = TRUE)
colData <- DataFrame(sampClasses = c("A", "A", "B", "B"), ionmode = "pos")

# Read data (mzsubset can be used to limit the M/Z range for speed)
cmsRaw <- readMSdata(files = files, colData = colData, verbose = TRUE)
```

### 2. Preprocessing with bakedpi
The `bakedpi` function performs background correction, retention time alignment, and density estimation.

```r
cmsProc <- bakedpi(cmsRaw, 
                   dbandwidth = c(0.005, 10), # M/Z and scan bandwidths
                   dgridstep = c(0.005, 1),   # M/Z and scan grid spacing
                   dortalign = TRUE,          # Perform retention time alignment
                   outfileDens = "dens.RData") # Optional: save density to disk
```
*   **Tip:** `dbandwidth` components must be $\ge$ `dgridstep` components.
*   **Tip:** Saving the density estimate via `outfileDens` allows you to skip the time-intensive density estimation step if you need to re-run the analysis.

### 3. Peak Calling and Quantification
The `slicepi` function applies a threshold to the density estimate to define peak bounds and calculate intensities.

```r
# Use a data-driven threshold (cutoff = NULL) or a specific value
cmsSlice <- slicepi(cmsProc, cutoff = NULL, verbose = TRUE)

# Access peak information
bounds <- peakBounds(cmsSlice)
intensities <- assays(cmsSlice)$intensity
```

### 4. Differential Analysis
`yamss` provides a wrapper for `limma` to identify metabolites that differ between conditions.

```r
# Returns a topTable-style data frame
dr <- diffrep(cmsSlice, classes = colData$sampClasses)
```

## Data Exploration and Refinement

*   **Visualizing Peaks:** Use `plotDensityRegion` to inspect the density estimate for specific M/Z and scan ranges.
    ```r
    plotDensityRegion(cmsProc, mzrange = c(500, 501), scanrange = c(700, 800))
    ```
*   **Adjusting Thresholds:** If the number of detected peaks is too high or low, you can check density quantiles and re-run `slicepi` with a manual cutoff.
    ```r
    dqs <- densityQuantiles(cmsProc)
    cmsSlice_refined <- slicepi(cmsProc, cutoff = dqs["98.5%"])
    ```
*   **Accessing Density:** The raw density matrix can be retrieved using `densityEstimate(cmsProc)`.

## Reference documentation

- [The yamss User's Guide](./references/yamss.md)
- [yamss Vignette Source](./references/yamss.Rmd)