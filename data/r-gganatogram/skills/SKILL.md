---
name: r-gganatogram
description: R package gganatogram (documentation from project home).
homepage: https://cran.r-project.org/web/packages/gganatogram/index.html
---

# r-gganatogram

name: r-gganatogram
description: Create modular anatograms and tissue visualizations using ggplot2. Use this skill when you need to generate anatomical diagrams for humans, mice, cells, or other organisms (plants/animals) where specific organs or structures are highlighted by color or value.

# r-gganatogram

## Overview
`gganatogram` is an R package designed to create modular visualizations of anatograms based on `ggplot2`. It allows users to plot anatomical structures for various organisms, including humans (male/female), mice (male/female), cellular structures, and several "tier 2" organisms (e.g., cow, chicken, arabidopsis). It is particularly useful for visualizing gene expression, proteomics, or any organ-specific data.

## Installation
```R
# Install from GitHub using devtools
devtools::install_github("jespermaag/gganatogram")
```

## Core Workflow
To create an anatogram, you must provide a data frame containing at least an `organ` column.

### 1. Data Preparation
The input data frame should follow this structure:
- `organ`: Character string matching the package's internal naming (e.g., "heart", "liver").
- `colour`: (Optional) Character string for specific colors.
- `value`: (Optional) Numeric value for heatmaps/gradients.
- `type`: (Optional) Used for grouping or faceting (e.g., "circulation", "Normal").

Example:
```R
organPlot <- data.frame(
  organ = c("heart", "liver", "brain"),
  colour = c("red", "orange", "purple"),
  value = c(10, 2, 8),
  stringsAsFactors = FALSE
)
```

### 2. Basic Plotting
Use the `gganatogram()` function. Key arguments:
- `data`: Your data frame.
- `organism`: 'human', 'mouse', 'cell', or others (e.g., 'bos_taurus').
- `sex`: 'male' or 'female'.
- `fill`: Column name to use for filling ('colour' or 'value').
- `outline`: Boolean; whether to show the body outline.
- `fillOutline`: Color for the body outline.

```R
library(gganatogram)
library(ggplot2)

gganatogram(data=organPlot, organism='human', sex='male', fill="colour") + 
  theme_void()
```

### 3. Heatmaps (Value-based filling)
To map numeric values to a color gradient:
```R
gganatogram(data=organPlot, organism='human', sex='male', fill="value") + 
  theme_void() +
  scale_fill_gradient(low = "white", high = "red")
```

### 4. Faceting and Comparisons
Since the output is a `ggplot` object, you can use `facet_wrap` to compare groups (e.g., Control vs. Treatment).
```R
gganatogram(data=compareGroups, organism='human', sex='male', fill="value") + 
  theme_void() + 
  facet_wrap(~type)
```

## Available Organisms and Keys
The package provides pre-defined keys to help you identify valid organ names:
- **Human**: `hgMale_key`, `hgFemale_key`
- **Mouse**: `mmMale_key`, `mmFemale_key`
- **Cell**: `cell_key[['cell']]`
- **Others**: `other_key` (a list containing keys for species like `bos_taurus`, `gallus_gallus`, `arabidopsis_thaliana`, etc.)

## Tips and Tricks
- **Coordinate Fixed**: Use `+ coord_fixed()` to ensure the anatomy maintains its correct aspect ratio.
- **Subsetting**: You can filter the keys (e.g., `hgMale_key %>% filter(type == 'nervous system')`) to see which organs are available for a specific system.
- **Cellular Plots**: For `organism='cell'`, you can visualize organelles. If you want a background, ensure the `cytosol` organ is included in your data.
- **Mouse Brain**: Use `organism="mus_musculus.brain"` for detailed brain region visualization.

## Reference documentation
- [README.md](./references/README.md)
- [README.rmd.md](./references/README.rmd.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)