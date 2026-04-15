---
name: bioconductor-scatterhatch
description: scatterHatch is a Bioconductor package that adds textures and hatching patterns to scatterplots to help differentiate overlapping points or numerous categories. Use when user asks to add textures to scatterplots, create hatched plots for spatial transcriptomics, or differentiate data points using patterns instead of just color.
homepage: https://bioconductor.org/packages/release/bioc/html/scatterHatch.html
---

# bioconductor-scatterhatch

## Overview

`scatterHatch` is a Bioconductor package designed to enhance scatterplots by adding textures (hatching) to points. This is especially useful in biological contexts, such as spatial transcriptomics or CyCIF data, where many overlapping points or numerous categories make color-only differentiation difficult. It produces `ggplot2` compatible objects.

## Core Workflow

### 1. Basic Plotting
The primary function is `scatterHatch()`. It requires a data frame and mapping strings for coordinates and grouping.

```r
library(scatterHatch)

# Basic usage
plt <- scatterHatch(
  data = df, 
  x = "Xt", 
  y = "Yt", 
  color_by = "location", 
  legendTitle = "Tissue Type"
)
plot(plt)
```

### 2. Customizing Patterns
You can control the specific texture assigned to each group using the `patternList` argument. This must be a list of lists, with length equal to the number of unique groups in your `color_by` factor.

**Available Pattern Types:**
- `"horizontal"` or `"-"`
- `"vertical"` or `"|"`
- `"positiveDiagonal"` or `"/"`
- `"negativeDiagonal"` or `"\\"`
- `"checkers"` or `"+"`
- `"cross"` or `"x"`
- `"blank"` or `""`

**Example with Custom Aesthetics:**
```r
custom_patterns <- list(
  list(pattern = "/", angle = 70, lineColor = "black"),
  list(pattern = "-", lineType = "dashed"),
  list(pattern = "x", angle = c(45, 135), lineWidth = 0.2),
  list(pattern = "+")
)

plt <- scatterHatch(
  data = pdacData, 
  x = "Xt", 
  y = "Yt", 
  color_by = "location",
  patternList = custom_patterns
)
```

## Key Arguments

| Argument | Description |
| :--- | :--- |
| `data` | Dataframe containing coordinates and factors. |
| `x`, `y` | Strings naming the coordinate columns. |
| `color_by` | String naming the factor/categorical column. |
| `gridSize` | Precision of hatching (default 10000). Increase for higher resolution, decrease for speed. |
| `patternList` | List of lists defining `pattern`, `angle`, `lineWidth`, `lineColor`, and `lineType`. |
| `colorPalette` | Character vector of colors (defaults to color-blind friendly `dittoSeq` colors). |
| `sparsePoints` | Logical vector for outliers; uses internal detector if NULL. |

## Tips for Success
- **Coordinate Orientation:** In spatial biology (like CyCIF), you may need to invert the Y-axis (e.g., `df$Yt <- -df$Yt`) to match the original tissue orientation.
- **Performance:** For very large datasets, the hatching calculation can be intensive. Adjust `gridSize` to balance visual quality and computation time.
- **Layering:** Since the output is a `ggplot` object, you can add standard ggplot2 layers (titles, themes, etc.), but be aware that `scatterHatch` uses a custom geom for the legend.

## Reference documentation
- [Creating a Scatterplot with Texture](./references/vignette.md)