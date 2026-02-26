---
name: r-ggdendro
description: The r-ggdendro package extracts plot data from R model objects to create dendrograms and tree diagrams using ggplot2. Use when user asks to create customizable dendrograms, extract segment and label data from clustering models, or apply ggplot2 themes to hierarchical and decision tree visualizations.
homepage: https://cloud.r-project.org/web/packages/ggdendro/index.html
---


# r-ggdendro

name: r-ggdendro
description: Create dendrograms and tree diagrams using ggplot2. Use this skill when you need to extract plot data from R model objects (hclust, dendrogram, tree, rpart, agnes, diana) to create customizable visualizations. It is particularly useful for users who want to apply ggplot2 themes, scales, and geoms to hierarchical clustering or decision tree results.

# r-ggdendro

## Overview
The `ggdendro` package provides a general framework to extract plot data for dendrograms and tree diagrams. It separates the data calculation from the rendering, allowing you to use `ggplot2` to create highly customized tree visualizations. It supports objects from `stats` (hclust, dendrogram), `tree`, `rpart`, and `cluster` (agnes, diana).

## Installation
```r
install.packages("ggdendro")
```

## Core Workflow

### 1. Quick Plotting
Use `ggdendrogram()` for a one-line ggplot2-based dendrogram.
```r
library(ggdendro)
library(ggplot2)

hc <- hclust(dist(USArrests), "ave")
# Basic plot
ggdendrogram(hc, rotate = FALSE, size = 2)

# Customizing the quick plot (it returns a ggplot object)
ggdendrogram(hc) + 
  theme_bw() + 
  labs(title = "Dendrogram of USArrests")
```

### 2. Manual Data Extraction (Full Control)
Use `dendro_data()` to extract segments and labels into data frames.
```r
# 1. Extract data
model <- hclust(dist(USArrests), "ave")
ddata <- dendro_data(as.dendrogram(model), type = "rectangle")

# 2. Access components
# segment(ddata) - line segments
# label(ddata)   - text labels
# leaf_label(ddata) - leaf-specific labels

# 3. Plot with ggplot2
ggplot(segment(ddata)) + 
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend)) + 
  geom_text(data = label(ddata), aes(x = x, y = y, label = label), vjust = -0.5) +
  theme_dendro()
```

### 3. Supported Model Types
- **Hierarchical Clustering**: `hclust` and `dendrogram` objects.
- **Regression/Classification Trees**: `tree` and `rpart` objects.
- **Cluster Package**: `agnes` and `diana` objects (convert to dendrogram first using `as.dendrogram()`).

## Key Functions
- `dendro_data(model, ...)`: The primary function to extract plot data.
- `segment()`, `label()`, `leaf_label()`: Accessor functions for the extracted data frames.
- `ggdendrogram()`: A wrapper for `ggplot()` to create a dendrogram quickly.
- `theme_dendro()`: A convenience theme that removes axes and grid lines for a clean tree look.

## Tips
- **Rotation**: Use `coord_flip()` in ggplot2 or the `rotate = TRUE` argument in `ggdendrogram()` to create horizontal trees.
- **Line Types**: When using `dendro_data()`, set `type = "triangle"` for triangular branches instead of the default rectangular ones.
- **Custom Aesthetics**: Since the output of `segment()` is a data frame, you can map variables (like cluster group or node height) to colors or sizes within `geom_segment()`.

## Reference documentation
- [Using 'ggdendro' to plot dendrograms](./references/ggdendro.Rmd)
- [Modifying ggdendogram output](./references/modify_output.Rmd)