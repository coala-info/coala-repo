---
name: r-buencolors
description: R package buencolors (documentation from project home).
homepage: https://cran.r-project.org/web/packages/buencolors/index.html
---

# r-buencolors

## Overview
The `buencolors` package provides a collection of curated color palettes and plotting utilities designed for genomic data visualization. It includes over 100 color palettes (inspired by the `wesanderson` package) and standardized color mappings for common hematopoietic cell types (e.g., HSC, CMP, GMP).

## Installation
To install the package from GitHub:
```R
# install.packages("devtools")
devtools::install_github("caleblareau/BuenColors")
```

## Core Functions

### Color Palettes
Use `jdb_palette()` to access discrete or continuous color vectors.
```R
library(BuenColors)

# View a palette
jdb_palette("FantasticFox")

# Get a continuous scale
jdb_palette("aqua_brick", type = "continuous")
```

### Standardized Cell Type Mapping
The package maintains a consistent color paradigm for biological features using `jdb_color_map`.
```R
# Get hex code for a specific cell type
jdb_color_map(c("HSC", "CMP"))

# Use the full named vector in ggplot2
# Note: Use 'jdb_color_maps' (with an 's') for the named vector
ggplot(df, aes(x = x, y = y, color = cell_type)) +
  geom_point() +
  scale_color_manual(values = jdb_color_maps)
```

### Plotting Utilities
- `pretty_plot()`: A ggplot2 theme wrapper for cleaner publication-ready figures.
- `get_density(x, y)`: Calculates local density for points in a scatter plot.
- `shuf(data.frame)`: Randomly shuffles the rows of a dataframe to prevent overplotting bias (e.g., in t-SNE or UMAP).

## Common Workflows

### Discrete ggplot2 Scale
```R
library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point() + 
  pretty_plot() +
  scale_color_manual(values = jdb_palette("brewer_spectra"))
```

### Continuous Gradient Scale
```R
ggplot(df, aes(x = x, y = y, color = value)) +
  geom_point() +
  scale_color_gradientn(colors = jdb_palette("flame_light")) +
  pretty_plot()
```

### Density-Colored Scatter Plot
```R
dat$density <- get_density(dat$x, dat$y)
ggplot(dat, aes(x, y, color = density)) +
  geom_point() +
  scale_color_gradientn(colors = jdb_palette("solar_extra")) +
  pretty_plot()
```

## Reference documentation
- [README.Rmd](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Project Home](./references/home_page.md)