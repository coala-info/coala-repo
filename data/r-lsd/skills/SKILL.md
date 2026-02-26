---
name: r-lsd
description: This tool creates high-density visualizations and colorful heatscatter plots in R to represent data density. Use when user asks to visualize large datasets, create heatscatter plots, prevent overplotting, or explore specialized color palettes for scientific figures.
homepage: https://cran.r-project.org/web/packages/lsd/index.html
---


# r-lsd

name: r-lsd
description: Create high-density visualizations and colorful plots in R. Use this skill when working with large datasets that suffer from overplotting, or when the user needs "heatscatter" plots, density-based visualizations, or specialized color palettes for data depiction.

## Overview
The `lsd` (Lots of Superior Depictions) package is designed to visualize large datasets effectively by using color to represent data density. It prevents information loss in crowded scatter plots and provides a variety of tools for creating aesthetically pleasing and informative scientific figures.

## Installation
To install the package from CRAN:
```R
install.packages("lsd")
```

## Core Functions and Workflows

### Visualizing High-Density Data
The most common use case for `lsd` is creating scatter plots where the color of the points indicates the local density of the data.

- `heatscatter(x, y)`: Generates a scatter plot where colors represent the density of points. This is the primary alternative to standard `plot(x, y)` when dealing with thousands of overlapping points.
- `dynscatter(x, y)`: A faster version of heatscatter for very large datasets.

### Exploring Package Capabilities
If you are unsure which visualization style fits the data, use the built-in tour:
- `demotour()`: Runs an interactive demonstration of the various plotting functions available in the package.

### Color Management
`lsd` provides specialized color palettes designed for scientific visualization.
- `colorpalette()`: Access and preview the various color schemes (e.g., "heat", "revheat", "spectral").
- `disco()`: A function to visualize and choose color palettes interactively.

### Specialized Plots
- `alignplot()`: Useful for aligning multiple plots, often used in genomic or time-series data where different tracks need to share an axis.
- `clusterplot()`: Visualizes clusters in 2D space with density coloring.

## Tips for Effective Use
- **Data Volume**: Use `heatscatter` when $N > 1000$. For smaller datasets, standard plots are usually sufficient.
- **Log Scaling**: For many biological or physical datasets, apply log transformations to $x$ or $y$ before passing them to `heatscatter` to better visualize density gradients.
- **Customization**: Most `lsd` functions accept standard graphical parameters (`main`, `xlab`, `ylab`, `xlim`, `ylim`) passed via `...`.

## Reference documentation
- [LSD Home Page](./references/home_page.md)