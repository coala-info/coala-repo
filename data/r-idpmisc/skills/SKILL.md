---
name: r-idpmisc
description: The r-idpmisc tool provides R utilities for density-based visualization of large datasets, signal processing, and environmental data conversions. Use when user asks to create image-scatter plots to handle overplotting, detect peaks in spectra, fit robust baselines, plot circular data, or perform humidity calculations.
homepage: https://cran.r-project.org/web/packages/idpmisc/index.html
---


# r-idpmisc

name: r-idpmisc
description: Use when working with the IDPmisc R package for high-level graphics of large datasets, circular data visualization, peak detection in spectra, robust baseline fitting, and environmental data conversions. This skill is ideal for handling overplotting in scatterplots, finding local maxima, and performing humidity calculations.

## Overview
The `IDPmisc` package provides utilities developed by the Institute of Data Analyses and Process Design (ZHAW). It excels in three main areas:
1. **Visualizing Large Datasets**: Using density-based plotting (image-scatter plots) to manage overplotting.
2. **Spectroscopy & Environmental Science**: Tools for baseline correction, peak finding, and humidity conversion.
3. **Data Manipulation**: Specialized functions for handling NAs and irregular values.

## Installation
To install the package from CRAN:
```R
install.packages("IDPmisc")
```

## Main Functions and Workflows

### Visualizing Large Datasets
When scatterplots become unreadable due to thousands of points, use density-based alternatives:
- `iplot(x, y)`: Creates an image-scatter plot where color represents point density.
- `ipairs(data)`: Produces a matrix of density-based scatterplots (similar to `pairs`).
- `IDPcolorRamp(n)`: Generates the default color scheme used in IDP plots, optimized for density visualization.

### Spectroscopy and Signal Processing
- `peaks(x, y)`: Identifies local maxima in a series. Use `span` to control the window size for peak definition.
- `rfbaseline(x, y)`: Fits a robust baseline to a spectrum using a local regression approach. Essential for removing background noise before peak quantification.

### Circular Data
- `rose(data)`: Plots circular data (e.g., wind direction, time of day) in a "rose" diagram. It is highly flexible regarding sectors and scaling.

### Data Cleaning and Manipulation
- `as.na(x, na)`: Replaces specific values (like -999 or "Unknown") with `NA`.
- `na.it(x, ...)`: A utility to omit observations with irregular values.
- `na.lof(x)`: Performs "Last Observation Carried Forward" to fill gaps in time-series data.

### Environmental Utilities
- `hum.conv(temp, relHum)`: Converts between different measures of humidity (e.g., relative humidity to dew point or absolute humidity).

## Tips for Effective Usage
- **Handling Overplotting**: If `plot()` results in a solid black mass, immediately switch to `iplot()`. It uses a grid-based density estimation that is much faster and more informative for large N.
- **Peak Finding**: Always plot the results of `peaks()` over your original data to verify the `span` parameter is appropriate for your signal's noise level.
- **Color Palettes**: Use `IDPcolorRamp` when you need a high-contrast palette that transitions logically from low to high density.

## Reference documentation
- [IDPmisc Home Page](./references/home_page.md)