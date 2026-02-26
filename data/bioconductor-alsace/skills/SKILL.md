---
name: bioconductor-alsace
description: This tool analyzes HPLC-DAD data using Multivariate Curve Resolution and Alternating Least Squares to decompose complex chemical mixtures into pure components. Use when user asks to perform baseline correction, smooth spectral data, align peaks across samples, or generate peak tables for metabolomics.
homepage: https://bioconductor.org/packages/3.8/bioc/html/alsace.html
---


# bioconductor-alsace

name: bioconductor-alsace
description: Analysis of HPLC-DAD data using Multivariate Curve Resolution (MCR) and Alternating Least Squares (ALS). Use this skill to decompose complex chemical mixtures into pure components, perform baseline correction, smooth spectral data, align peaks across samples, and generate peak tables for metabolomics.

## Overview

The `alsace` package provides a high-throughput framework for Multivariate Curve Resolution (MCR) using Alternating Least Squares (ALS). It is specifically designed for HPLC-DAD (High-Performance Liquid Chromatography with Photo-Diode Array detection) data. It decomposes a data matrix $X$ into concentration profiles $C$ and pure spectra $S$ ($X = CS^T + E$).

## Typical Workflow

### 1. Data Preparation
Data should be organized as a list of matrices where rows represent time points (retention time) and columns represent wavelengths.

```R
# Load data (example using csv files)
allf <- list.files("data_dir", pattern = "csv", full.names = TRUE)
mydata <- lapply(allf, read.csv)

# Preprocess: smoothing, baseline subtraction, and interpolation
# dim2 specifies the target wavelengths
new.lambdas <- seq(260, 500, by = 2)
tea <- lapply(mydata, preprocess, dim2 = new.lambdas)
```

### 2. Initializing Components
Before running ALS, you must estimate the number of components and provide initial guesses for the spectra using Orthogonal Projection Approach (OPA).

```R
# Estimate 4 components using OPA
tea.opa <- opa(tea, 4)

# Plot initial spectra guesses
matplot(new.lambdas, tea.opa, type = "l")
```

### 3. Running ALS
The `doALS` function is a wrapper that enforces non-negativity and normalizes spectra to unit length.

```R
# Run the ALS algorithm
tea.als <- doALS(tea, tea.opa)

# Check model fit
summary(tea.als)

# Visualize results (spectra and concentration profiles)
plot(tea.als)
```

### 4. Model Refinement
Evaluate if components are redundant or too small.

- `smallComps(tea.als, Ithresh = 10)`: Identifies components that never reach a specific intensity.
- `removeComps(tea.als, toRemove)`: Removes specific components and refits the model.
- `combineComps(tea.als, list(c(1, 2)))`: Merges highly correlated components.

### 5. Peak Table Generation
Convert the resolved concentration profiles into a structured peak table.

```R
# 1. Identify peaks in concentration profiles
pks <- getAllPeaks(tea.als$CList, span = 5)

# 2. Align peaks across samples using Parametric Time Warping (PTW)
warping.models <- correctRT(tea.als$CList, reference = 1, what = "models")
pks.corrected <- correctPeaks(pks, warping.models)

# 3. Group peaks and create final table
pkTab <- getPeakTable(pks.corrected, response = "height")
```

## Advanced Features

### Divide-and-Conquer for Large Data
For large datasets, split the time axis into windows to save memory and improve speed.

```R
# Split into windows with overlap
tea.split <- splitTimeWindow(tea, c(12, 14), overlap = 10)

# Run ALS on each window (can use mclapply for parallelization)
tea.alslist <- lapply(tea.split, function(Xl) {
  Xl.opa <- opa(Xl, 4)
  doALS(Xl, Xl.opa)
})

# Merge windows back together
tea.merged <- mergeTimeWindows(tea.alslist)
```

### Visualization of Residuals
Use `showALSresult` to inspect the quality of the fit across multiple samples.

```R
showALSresult(tea.als, tea.als$resid, mat.idx = 1:2)
```

## Reference documentation
- [alsace](./references/alsace.md)