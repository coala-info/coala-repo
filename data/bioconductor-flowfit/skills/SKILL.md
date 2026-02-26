---
name: bioconductor-flowfit
description: This tool analyzes cell proliferation tracking dye data from flow cytometry by fitting Gaussian peaks to fluorescence intensity distributions. Use when user asks to estimate the percentage of cells in each generation, calculate proliferation indices, or fit models to CFSE, CTV, or CPD dye data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/flowFit.html
---


# bioconductor-flowfit

name: bioconductor-flowfit
description: Analysis of cell proliferation tracking dye data (CFSE, CTV, CPD) using flow cytometry. Use this skill to estimate the percentage of cells in each generation and calculate proliferation indices by fitting peaks to fluorescence intensity distributions using the Levenberg-Marquardt algorithm.

# bioconductor-flowfit

## Overview
The `flowFit` package provides a computational framework for analyzing flow cytometry data from experiments using proliferation-tracking dyes. When cells divide, the dye is halved between daughter cells, resulting in a predictable decrease in fluorescence intensity. This skill uses the Levenberg-Marquardt algorithm to fit a series of Gaussian peaks to the histogram of fluorescence, allowing for the quantification of cell generations and the calculation of a Proliferation Index (PI).

## Typical Workflow

### 1. Data Preparation
Load the necessary libraries and data. Data should be in `flowFrame` or `flowSet` format from the `flowCore` package.

```r
library(flowFit)
library(flowCore)
# Example data from flowFitExampleData
# data(QuahAndParish) 
```

### 2. Parent Population Fitting
Before analyzing proliferating cells, you must define the "Parent Population" (labeled but unstimulated cells) to establish the starting peak position and size.

```r
# parentFitting(flowFrame, channel_name)
parent_fit <- parentFitting(QuahAndParish[[1]], "<FITC-A>")

# View results
summary(parent_fit)
plot(parent_fit)
```

### 3. Proliferation Fitting
Fit the model to the stimulated (proliferating) sample using the parameters derived from the parent fitting.

```r
# proliferationFitting(flowFrame, channel, parent_pos, parent_size)
fit_result <- proliferationFitting(QuahAndParish[[2]], 
                                   "<FITC-A>", 
                                   parent_fit@parentPeakPosition, 
                                   parent_fit@parentPeakSize)

# View fitting summary and generation percentages
summary(fit_result)
```

### 4. Visualization
The `plot` function for `proliferationFittingData` objects supports multiple views via the `which` parameter:
- `which=1`: Input data (observed vs smoothed).
- `which=2`: Model data and fitting.
- `which=3`: Fitting with individual generation peaks (most common).
- `which=4`: Barplot of cell percentages per generation.
- `which=5`: Fitting diagnostics (residuals).

```r
plot(fit_result, which=3, main="CFSE Proliferation")
```

### 5. Extracting Results
Retrieve the calculated metrics for further analysis.

```r
# Get percentage of cells in each generation
gen_percents <- fit_result@generations

# Calculate Proliferation Index (PI)
# PI = sum(Ni) / sum(Ni / 2^i)
pi_val <- proliferationIndex(fit_result)
```

## Advanced Usage

### Fixed vs. Dynamic Models
By default, `proliferationFitting` uses a dynamic model where peak position and size can shift slightly to better fit the data. To force the model to respect specific parent parameters:

```r
fit_fixed <- proliferationFitting(sample_frame, 
                                  channel, 
                                  parent_pos, 
                                  parent_size, 
                                  fixedModel=TRUE, 
                                  fixedPars=list(M=parent_pos))
```

### Handling Log Decades
The distance between generations depends on the number of log decades in the FACS instrument. `flowFit` usually estimates this from FCS keywords or data range. If the fit looks shifted, manually specify `logDecades`:

```r
fit_manual <- proliferationFitting(..., logDecades=4)
```

## Tips for Success
- **Transformation**: Ensure your data is properly transformed (usually `log10`) before fitting. `flowFit` expects the data to be on a scale where peak distances are constant.
- **Smoothing**: The algorithm uses the `kza` package for smoothing. If the data is extremely noisy, the fit may fail to converge.
- **Generation Distance**: The function `generationsDistance(c, l)` can be used to manually calculate the expected spacing between peaks based on channels (c) and log decades (l).

## Reference documentation
- [Estimate proliferation in cell-tracking dye studies](./references/HowTo-flowFit.md)