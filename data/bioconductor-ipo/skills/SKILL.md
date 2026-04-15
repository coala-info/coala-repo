---
name: bioconductor-ipo
description: This tool automates the optimization of XCMS peak picking, retention time correction, and grouping parameters using Design of Experiments. Use when user asks to find optimal metabolomics processing parameters, tune centWave or matchedFilter settings, or optimize retention time alignment and grouping.
homepage: https://bioconductor.org/packages/release/bioc/html/IPO.html
---

# bioconductor-ipo

name: bioconductor-ipo
description: Automated optimization of XCMS peak picking, retention time correction, and grouping parameters using Design of Experiments (DoE). Use this skill when you need to find optimal parameters for metabolomics data processing in R, specifically for the centWave or matchedFilter methods in XCMS.

# bioconductor-ipo

## Overview

The `IPO` (XCMS Parameter Optimization) package automates the tedious process of tuning `xcms` parameters. It uses a Response Surface Methodology (RSM) and Design of Experiments (DoE) to iteratively test parameter ranges and identify the settings that maximize the number of reliable peaks and minimize noise.

## Core Workflow

### 1. Peak Picking Optimization

Optimization starts by defining a range for parameters. If a single value is provided instead of a range (vector of two values), that parameter remains fixed.

```r
library(IPO)
library(xcms)

# 1. Define starting parameters for 'centWave' or 'matchedFilter'
peak_params <- getDefaultXcmsSetStartingParams('centWave')

# 2. Customize ranges (lower and upper bounds)
peak_params$min_peakwidth <- c(5, 15)
peak_params$max_peakwidth <- c(20, 40)
peak_params$ppm <- 20 # Fixed value, not optimized

# 3. Run optimization
# Use a subset of files (e.g., QCs) for speed
result_peak <- optimizeXcmsSet(
  files = datafiles[1:2], 
  params = peak_params, 
  nSlaves = 4, 
  plot = TRUE
)

# 4. Retrieve optimized xcmsSet and parameters
optimized_xset <- result_peak$best_settings$xset
best_peak_params <- result_peak$best_settings$parameters
```

### 2. Retention Time and Grouping Optimization

Once peak picking is optimized, use the resulting `xcmsSet` to optimize alignment (`obiwarp`) and correspondence (`density`).

```r
# 1. Define starting parameters
retgroup_params <- getDefaultRetGroupStartingParams()

# 2. Run optimization
result_retgroup <- optimizeRetGroup(
  xset = optimized_xset, 
  params = retgroup_params, 
  nSlaves = 4, 
  plot = TRUE
)

# 3. Retrieve best settings
best_retgroup_params <- result_retgroup$best_settings
```

### 3. Exporting Results

`IPO` can generate a ready-to-use R script containing the optimized parameters for your full dataset processing.

```r
writeRScript(
  result_peak$best_settings$parameters, 
  result_retgroup$best_settings
)
```

## Key Functions

- `getDefaultXcmsSetStartingParams(method)`: Returns default ranges for 'centWave' or 'matchedFilter'.
- `optimizeXcmsSet(...)`: Iteratively executes peak picking DoEs until an optimum is found.
- `getDefaultRetGroupStartingParams()`: Returns default ranges for 'obiwarp' and 'density' methods.
- `optimizeRetGroup(...)`: Optimizes retention time correction and grouping simultaneously.
- `writeRScript(...)`: Prints the optimized XCMS workflow to the console.

## Usage Tips

- **Parallelization**: Use the `nSlaves` argument to speed up the DoE calculations.
- **Parameter Splitting**: For `centWave`, `peakwidth` is split into `min_peakwidth` and `max_peakwidth`. Similarly, `prefilter` is split into `prefilter` and `prefilter_value`.
- **Input Data**: You do not need to use your entire dataset for optimization. Using 2-3 representative samples or Quality Control (QC) samples is usually sufficient and significantly faster.
- **Fixed Parameters**: To exclude a parameter from optimization, set it to a single numeric value in the params list.

## Reference documentation

- [XCMS Parameter Optimization with IPO](./references/IPO.Rmd)
- [XCMS Parameter Optimization with IPO](./references/IPO.md)