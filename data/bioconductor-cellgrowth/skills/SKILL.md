---
name: bioconductor-cellgrowth
description: This package analyzes cell growth data by fitting non-parametric and parametric models to estimate growth rates and maximum growth. Use when user asks to load growth data from well-plate formats, fit growth curves to time-series OD data, perform automatic bandwidth selection via cross-validation, or visualize growth fits and plate layouts.
homepage: https://bioconductor.org/packages/3.5/bioc/html/cellGrowth.html
---


# bioconductor-cellgrowth

name: bioconductor-cellgrowth
description: Analysis of cell growth data, including fitting non-parametric (local regression) and parametric models to estimate maximum growth rates and maximum growth. Use when Claude needs to: (1) Load and process growth data from well-plate formats (e.g., Tecan) or custom files, (2) Fit growth curves to time-series OD data, (3) Perform automatic bandwidth selection via cross-validation, or (4) Visualize growth fits and plate layouts.

# bioconductor-cellgrowth

## Overview
The `cellGrowth` package provides tools for estimating quantitative measures of growth from time-series data. It favors non-parametric models (local polynomial regression via `locfit`) to capture complex growth behaviors that idealistic parametric models often miss. It is specifically designed to handle high-throughput data from 96-well plates and includes automated bandwidth selection for smoothing.

## Core Workflows

### Fitting a Single Growth Curve
To fit a curve for a single well or sample:
1. Load the data (e.g., using `readYeastGrower` for Tecan files).
2. Transform the Optical Density (OD) data, typically using `log2`.
3. Call `fitCellGrowth` with time (`x`) and transformed OD (`z`).

```r
library(cellGrowth)
# Load data
dat <- readYeastGrower("path/to/data.txt")
# Fit curve for a specific well (e.g., F02)
fit <- fitCellGrowth(
  x = dat$time,
  z = log2(dat$OD[[which(getWellIdsTecan(dat) == "F02")]])
)
# Visualize
plot(fit, xlab="time (hours)")
```

### Extracting Growth Parameters
The fit object stores key metrics as attributes:
- `maxGrowthRate`: The maximum slope of the growth curve.
- `pointOfMaxGrowthRate`: The time point where maximum growth occurs.
- `max`: The maximum growth value reached.
- `pointOfMax`: The time point where maximum growth is reached.

```r
# Access attributes
m_rate <- attr(fit, "maxGrowthRate")
m_val  <- attr(fit, "max")
```

### Handling Multi-Plate Experiments
For experiments involving multiple machine runs and plates:
1. Prepare a **Machine Run file** (columns: `directory`, `filename`, `plate`).
2. Prepare a **Plate Layout file** (columns: `plate`, `well`, and metadata like `strain`).
3. Use `wellDataFrame` to combine these into a single object.
4. Use `fitCellGrowths` to process all curves simultaneously.

```r
# Create well object
well <- wellDataFrame("plateLayout.txt", "machineRun.txt")

# Fit all curves
fits <- fitCellGrowths(well)

# 'fits' is a data frame containing growth parameters for every well
head(fits)
```

### Automatic Bandwidth Selection
The smoothness of the fit depends on the bandwidth (`locfit.h`). Use `bandwidthCV` to find the optimal value via cross-validation.

```r
bw_result <- bandwidthCV(well, bandwidths = seq(1800, 36000, length.out = 20))
# Use the optimal bandwidth in subsequent fits
fit_opt <- fitCellGrowth(x, z, locfit.h = bw_result$best_h)
```

### Custom Data Formats
If data is not in a standard well-plate format, load it into a standard R data frame and pass the columns directly to `fitCellGrowth`.

```r
custom_data <- read.delim("my_data.txt")
fit <- fitCellGrowth(x = custom_data$time, z = log2(custom_data$od))
```

## Tips and Best Practices
- **Log Transformation**: Always log-transform OD data (usually `log2`) before fitting to ensure the growth rate corresponds to doubling time/generations.
- **Time Units**: Ensure time units are consistent. If data is in seconds, you may want to scale to hours for plotting (`scaleX = 1/3600`).
- **Smoothing Control**: If the fit is too sensitive to noise, increase the `locfit.h` parameter. If it underestimates the growth rate by over-smoothing, decrease it.
- **Visualization**: Use `plotPlate(well)` to see an overview of an entire plate's growth curves to identify experimental artifacts or outliers.

## Reference documentation
- [cellGrowth](./references/cellGrowth.md)