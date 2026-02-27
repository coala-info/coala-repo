---
name: bioconductor-mops
description: Bioconductor-mops identifies and characterizes periodic fluctuations in time series data using model-based screening. Use when user asks to detect periodic patterns, estimate period parameters like phase and length, rank features by periodicity score, or visualize fitted periodic time courses.
homepage: https://bioconductor.org/packages/3.5/bioc/html/MoPS.html
---


# bioconductor-mops

name: bioconductor-mops
description: Model-based Periodicity Screening (MoPS) for identifying and characterizing periodic fluctuations in time series data, such as gene expression profiles. Use this skill when you need to: (1) Detect periodic patterns in noisy time series, (2) Estimate period length (lambda), phase (phi), and synchrony loss (sigma), (3) Rank features by periodicity score, or (4) Predict and visualize fitted periodic time courses.

# bioconductor-mops

## Overview

MoPS (Model-based Periodicity Screening) is an R package designed to identify periodic signals in time series datasets. It uses a likelihood ratio statistic to compare periodic fits against non-periodic models, providing a periodicity score for ranking. It is particularly effective for biological data (like yeast cell cycle expression) where synchrony loss or signal attenuation might occur over time.

## Core Workflow

### 1. Data Preparation
Input data should be a numeric matrix where rows represent features (e.g., genes) and columns represent consecutive measurements.

```r
library(MoPS)
# Example: 10 time series with 41 measurements
data(basic) 
# Define timepoints if they are not simple indices
timepoints <- seq(5, 205, 5)
```

### 2. Fitting Periodic Models
The `fit.periodic` function is the primary tool. It performs an exhaustive search over a parameter grid.

```r
# Basic fit with default parameters
res <- fit.periodic(basic)

# Advanced fit with custom parameter grids
phi_grid <- seq(5, 80, 5)      # Phase (peak time)
lambda_grid <- seq(40, 80, 5)  # Period length
sigma_grid <- seq(4, 8, 1)     # Synchrony loss/attenuation

res <- fit.periodic(basic, 
                    timepoints = timepoints, 
                    phi = phi_grid, 
                    lambda = lambda_grid, 
                    sigma = sigma_grid)
```

### 3. Extracting Results
Convert the result object into a readable data frame to analyze scores and parameters.

```r
res_df <- result.as.dataframe(res)
# Columns: ID, score, phi, lambda, sigma, mean, amplitude
# score > 0 indicates a better fit for periodic vs non-periodic
```

### 4. Prediction and Visualization
Generate the fitted time courses based on the best parameters found during screening.

```r
# Predict fitted values
fitted_mat <- predictTimecourses(res)

# Plot original vs fitted
plot(timepoints, basic[1,], type="l", main="Feature 1")
points(timepoints, fitted_mat[1,], type="l", col="limegreen", lwd=2)
```

## Advanced Features

### Flexible Waveforms (psi)
The `psi` parameter allows for deforming the sine wave to fit more complex periodic shapes. Increasing `psi` improves fit quality but increases computation time.

```r
res_shape <- fit.periodic(basic, psi = 2)
```

### Global Parameter Estimation
In biological systems, features often share a global period. A common strategy is:
1. Run an initial screening to find features with `score > 0`.
2. Calculate the median `lambda` and `sigma` from these features.
3. Re-run `fit.periodic` on the subset, fixing `lambda` and `sigma` to these global medians while refining `phi` and `psi`.

```r
# Fixing global parameters
lambda_global <- median(res_df$lambda[res_df$score > 0])
sigma_global <- median(res_df$sigma[res_df$score > 0])

res_refined <- fit.periodic(subset_data, 
                            lambda = lambda_global, 
                            sigma = sigma_global, 
                            phi = seq(5, 80, 2.5), 
                            psi = 2)
```

## Tips for Success
- **Parameter Grids**: The exhaustive search is sensitive to the resolution of your `phi` and `lambda` grids. Use coarser grids for initial screening and finer grids for characterization.
- **Weights**: If measurement error is known, pass a vector of regression weights to `fit.periodic` to improve robustness.
- **Score Interpretation**: The periodicity score is a log-likelihood ratio. While higher is better, it is primarily a ranking tool rather than a direct p-value.

## Reference documentation
- [MoPS - Model-based Periodicity Screening](./references/MoPS.md)