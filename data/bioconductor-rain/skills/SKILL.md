---
name: bioconductor-rain
description: The bioconductor-rain package provides a robust non-parametric method for detecting rhythmic patterns in time series data, including asymmetric waveforms like sawtooth waves. Use when user asks to detect circadian or rhythmic patterns in omics data, identify periodic oscillations in time series with irregular sampling, or analyze biological rhythms using non-parametric testing.
homepage: https://bioconductor.org/packages/release/bioc/html/rain.html
---

# bioconductor-rain

## Overview

The `rain` package provides a robust non-parametric method for detecting rhythmic patterns in time series data. Unlike methods that assume symmetric sine waves, `rain` tests against "umbrella alternatives," allowing it to detect asymmetric rising and falling patterns (like sawtooth waves) with high sensitivity. It is particularly well-suited for biological "omics" data where sampling might be sparse, irregular, or contain independent replicates.

## Core Workflow

### 1. Data Preparation
The input data must be a matrix or data frame where:
- **Rows** represent time points.
- **Columns** represent different series (e.g., genes, proteins).
- If your data is "wide" (genes as rows), you must transpose it using `t()`.

### 2. Basic Execution
The primary function is `rain()`. At minimum, you must specify the period you are searching for and the sampling interval.

```r
library(rain)

# Example: 24-hour period, sampled every 2 hours
results <- rain(x = my_matrix, 
                period = 24, 
                deltat = 2, 
                peak.border = c(0.3, 0.7))
```

### 3. Handling Replicates and Irregular Sampling
`rain` handles complex experimental designs through specific arguments:

- **Regular Repeats:** If every time point has exactly 2 replicates, set `nr.series = 2`.
- **Irregular Repeats:** If time points have varying numbers of replicates (e.g., 2, 2, 3, 2), use `measure.sequence = c(2, 2, 3, 2)`.
- **Missing Time Points:** If a time point was skipped (e.g., sampled at 0, 4, 12), "regularize" the sequence by inserting a 0 in the `measure.sequence` for the missing interval (e.g., `measure.sequence = c(1, 0, 1, 1)`).

### 4. Key Parameters
- `period`: The target cycle length (e.g., 24 for circadian).
- `period.delta`: Search a range `[period - delta, period + delta]`.
- `peak.border`: A vector `c(min, max)` between 0 and 1 defining the allowed asymmetry. `c(0.5, 0.5)` forces symmetry; `c(0.1, 0.9)` allows extreme asymmetry.
- `method`: 
    - `'independent'`: Use when different samples/animals are used at each time point (standard for most "omics" experiments).
    - `'longitudinal'`: Use when the same individual is sampled repeatedly; this method is more resistant to trends and damping.

## Interpreting Results

The function returns a data frame with the following columns:
- `pVal`: The significance of the rhythmicity.
- `phase`: The time of the peak.
- `peak.shape`: The duration of the falling slope (used to describe the asymmetry).
- `period`: The best-fitting period within the searched range.

## Tips for Success
- **Visualization:** Always visualize top hits using `lattice::xyplot` or `ggplot2` to ensure the detected rhythm matches biological expectations.
- **NA Values:** If your matrix contains `NA`, set `na.rm = TRUE`. Note that this increases computation time as null distributions must be calculated individually for each series.
- **Memory:** For very large datasets, `verbose = TRUE` can help monitor progress.

## Reference documentation
- [Usage of package rain](./references/rain.md)