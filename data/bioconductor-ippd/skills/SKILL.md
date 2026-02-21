---
name: bioconductor-ippd
description: The package provides functionality to extract isotopic peak patterns from raw mass spectra. This is done by fitting a large set of template basis functions to the raw spectrum using either nonnegative least squares or least absolute deviation fittting. The package offers a flexible function which tries to estimate model parameters in a way tailored to the peak shapes in the data. The package also provides functionality to process LCMS runs.
homepage: https://bioconductor.org/packages/3.6/bioc/html/IPPD.html
---

# bioconductor-ippd

## Overview

The `IPPD` package automates the extraction of isotopic patterns from raw protein mass spectrometry data. It decomposes complex spectra—including overlapping patterns and multiple charge states—into a list of monoisotopic peaks. The package uses a template-based approach where basis functions (averagine model) are fitted to the data using non-negative least squares (L2) or least absolute deviation (L1) fitting.

## Core Workflow

### 1. Data Preparation
Load mass spectrometry data consisting of m/z channels and intensities.

```r
library(IPPD)
data(myo500)
x <- myo500[,"mz"]
y <- myo500[,"intensities"]
```

### 2. Peak Shape Parameter Estimation
Before deconvolution, estimate the peak shape parameters (width $\sigma$, skewness $\alpha$, and shift $\mu$) as a function of m/z.

*   **Gaussian Model:** Best for symmetric peaks.
*   **EMG (Exponentially Modified Gaussian) Model:** Best for peaks with right-side tails.

```r
# Fit EMG model parameters as a linear function of m/z
fitEMG <- fitModelParameters(mz = x, intensities = y, 
                             model = "EMG", 
                             fitting = "model",
                             formula.alpha = formula(~mz),
                             formula.sigma = formula(~mz),
                             formula.mu = formula(~1),
                             control = list(window = 6, threshold = 200))

# Visualize the fit
visualize(fitEMG, type = "peak")
visualize(fitEMG, type = "model", modelfit = TRUE, parameters = c("sigma", "alpha"))
```

### 3. Peak Deconvolution (Template Fitting)
Use `getPeaklist` to perform the actual deconvolution. This function identifies template locations and estimates their abundances.

```r
# Generate peak list using the fitted EMG model
EMGlist <- getPeaklist(mz = x, intensities = y, 
                       model = "EMG",
                       model.parameters = fitEMG,
                       loss = "L2", 
                       control.basis = list(charges = c(1, 2)),
                       control.postprocessing = list(ppm = 200))

# Apply signal-to-noise thresholding
final_peaks <- threshold(EMGlist, threshold = 3, refit = TRUE)
show(final_peaks)
```

### 4. Visualization of Results
Inspect specific m/z regions to validate the deconvolution, especially in cases of overlapping peaks.

```r
visualize(EMGlist, x, y, lower = 963, upper = 973,
          fit = FALSE, 
          fittedfunction = TRUE, 
          localnoise = TRUE,
          cutoff.functions = 3)
```

## Processing LC-MS Runs

For Liquid Chromatography-Mass Spectrometry (LC-MS) data, `IPPD` provides a sweep-line algorithm to aggregate peaks across multiple retention time scans.

```r
# Read mzXML data
data_lcms <- read.mzXML("path/to/file.mzXML")

# Analyze the full run
result_lcms <- analyzeLCMS(data_lcms,
                           arglist.getPeaklist = list(control.basis = list(charges = c(1,2,3))),
                           arglist.threshold = list(threshold = 10),
                           arglist.sweepline = list(minboxlength = 20))

# Access aggregated peak boxes
boxes <- result_lcms$boxes
```

## Key Parameters and Tips

*   **Loss Function:** Use `loss = "L2"` for standard least squares. Use `loss = "L1"` (Least Absolute Deviation) if the data contains many outliers or significant model misfit, as it is more robust.
*   **Local Noise Level (LNL):** Templates are only placed where intensities exceed the LNL by a `factor.place` (default is often 2-4).
*   **Postprocessing:** The `ppm` parameter in `control.postprocessing` is critical for merging "split peaks" where multiple templates might fit a single broad peak.
*   **Averagine Model:** The package automatically calculates relative isotope abundances based on the averagine model; ensure your m/z range is appropriate for protein/peptide data.

## Reference documentation

- [IPPD](./references/IPPD.md)