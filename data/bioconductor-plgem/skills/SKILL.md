---
name: bioconductor-plgem
description: This tool implements the Power Law Global Error Model to identify differentially expressed genes or proteins in microarray and proteomics datasets. Use when user asks to model variance-versus-mean dependence, calculate signal-to-noise ratio statistics, or detect differential expression in high-throughput data with few replicates.
homepage: https://bioconductor.org/packages/release/bioc/html/plgem.html
---

# bioconductor-plgem

name: bioconductor-plgem
description: Power Law Global Error Model (PLGEM) for identifying differentially expressed genes (DEG) or proteins in microarray and proteomics datasets. Use this skill when analyzing genome-wide data (ExpressionSet objects) to model variance-versus-mean dependence and improve the detection of differential expression using signal-to-noise ratio (STN) statistics.

# bioconductor-plgem

## Overview

The `plgem` package implements the Power Law Global Error Model, which faithfully models the variance-versus-mean dependence in high-throughput datasets like microarrays (Affymetrix) and proteomics (MudPIT spectral counts). It provides a more robust alternative to standard t-tests by using model-derived spread estimates to calculate signal-to-noise ratios (STN), which is particularly effective for datasets with few replicates.

## Typical Workflow

### 1. Wrapper Mode (Quick Start)
The `run.plgem` function automates the entire pipeline, including model fitting, STN calculation, resampling, and DEG selection.

```r
library(plgem)
data(LPSeset) # Example ExpressionSet
set.seed(123)
# Returns a list of DEGs at default delta = 0.001
LPSdegList <- run.plgem(esdata = LPSeset)
```

### 2. Step-by-Step Mode (Advanced Control)

#### A. Model Fitting
Fit the power law model to a specific experimental condition (usually the one with the most replicates).

```r
# p: number of bins (default 10, should be < 1/10th of total features)
# q: quantile for spread (default 0.5 for median)
LPSfit <- plgem.fit(data = LPSeset, 
                    covariate = 1, 
                    fitCondition = 'C', 
                    p = 10, 
                    q = 0.5, 
                    fittingEval = TRUE)
```

#### B. Calculate Observed STN
Compute the signal-to-noise ratio using the model parameters (slope and intercept) from the fitting step.

```r
LPSobsStn <- plgem.obsStn(data = LPSeset, 
                          covariate = 1, 
                          baselineCondition = 1, 
                          plgemFit = LPSfit)
```

#### C. Resampling for Null Distribution
Generate resampled STN values to estimate the distribution under the null hypothesis.

```r
LPSresampledStn <- plgem.resampledStn(data = LPSeset, 
                                      plgemFit = LPSfit, 
                                      iterations = "automatic")
```

#### D. P-value Calculation and DEG Selection
Calculate empirical p-values and select significant features based on a significance level `delta` (False Positive Rate).

```r
# Calculate p-values
LPSpValues <- plgem.pValue(observedStn = LPSobsStn, 
                           plgemResampledStn = LPSresampledStn)

# Select DEGs
LPSdegList <- plgem.deg(observedStn = LPSobsStn, 
                        plgemPval = LPSpValues, 
                        delta = 0.001)
```

## Key Functions and Parameters

- `plgem.fit`: Fits the model. Set `fittingEval = TRUE` to visualize residuals; a good fit shows a near-normal distribution and horizontal symmetry.
- `plgem.obsStn`: Calculates the observed statistics. The first condition is the default baseline.
- `plgem.deg`: Returns a nested list. Access significant IDs via `LPSdegList$significant[[delta]][[comparison]]`.
- `plgem.write.summary`: Exports the results to the working directory.

## Tips for Proteomics
- For proteomics data with few identified proteins (< 100), set the `p` parameter in `plgem.fit` lower than the default of 10.
- PLGEM is highly effective for spectral count data where traditional variance estimation is difficult.

## Reference documentation

- [An introduction to PLGEM](./references/plgem.md)