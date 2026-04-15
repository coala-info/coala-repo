---
name: bioconductor-clevrvis
description: This tool visualizes clonal evolution in cancer through specialized phylogenetic trees and time-course plots. Use when user asks to create shark, dolphin, or plaice plots, visualize clonal prevalence over time, or explore valid phylogenetic trees from cancer cell fraction data.
homepage: https://bioconductor.org/packages/release/bioc/html/clevRvis.html
---

# bioconductor-clevrvis

name: bioconductor-clevrvis
description: Visualization of clonal evolution in cancer using shark, dolphin, and plaice plots. Use this skill to create phylogenetic trees, interpolate time points, estimate therapy effects, and generate allele-aware visualizations of tumor subclone development over time.

# bioconductor-clevrvis

## Overview

The `clevRvis` package provides specialized visualization techniques for clonal evolution in cancer. It transforms mutation clustering data (Cancer Cell Fractions - CCF) and phylogenetic relationships into intuitive plots. The package supports three primary visualization types:
1. **Shark Plots**: Basic phylogenetic trees showing clonal relationships.
2. **Dolphin Plots**: Detailed time-course visualizations showing clonal prevalence (CCF) over time.
3. **Plaice Plots**: Allele-aware visualizations that track healthy allele loss and bi-allelic events.

## Core Workflow

### 1. Data Preparation
To use `clevRvis`, you need three primary inputs:
- `fracTable`: A numeric matrix of CCF estimates (clones as rows, time points as columns).
- `parents`: An integer vector defining the phylogeny (0 for the root/normal cell, or the index of the parental clone).
- `timepoints`: A numeric vector of the measured time points.

### 2. Creating the seaObject
The `seaObject` is the central data structure for all plotting functions.

```r
library(clevRvis)

# Example data
timepoints <- c(0, 50, 100)
parents <- c(0, 1, 1, 3, 0, 5, 6)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                      40,20,15,0,30,10,0,
                      50,25,15,10,40,20,15), ncol = 3)

# Create object with automatic time point interpolation
seaObject <- createSeaObject(fracTable, parents, timepoints, timepointInterpolation = TRUE)

# Optional: Estimate therapy effect between two time points
seaObject_te <- createSeaObject(fracTable, parents, timepoints, therapyEffect = c(50, 100))
```

### 3. Visualization Options

#### Shark Plot (Phylogeny)
Visualizes the clonal tree structure.
```r
sharkPlot(seaObject, showLegend = TRUE, main = "Clonal Tree")
```

#### Dolphin Plot (Evolutionary Dynamics)
Shows the expansion and contraction of clones over time.
```r
dolphinPlot(seaObject, shape = "spline", pos = "center", vlines = timepoints, showLegend = TRUE)
```

#### Combined Plot (Interactive)
Generates a linked view of both the shark and dolphin plots.
```r
combinedPlot(seaObject, showLegend = TRUE, vlines = timepoints)
```

#### Plaice Plot (Allelic Level)
Visualizes bi-allelic events (e.g., double-hits on TP53).
```r
# clonesToFill indicates which clones have bi-allelic events
plaicePlot(seaObject, clonesToFill = c(0,0,1,0,0,6,0), showLegend = TRUE)
```

### 4. Exploring Alternative Trees
If the parental relationships are unknown, use `exploreTrees` to find all valid phylogenies consistent with the CCF data.
```r
valid_trees <- exploreTrees(fracTable, timepoints)
# Returns a list of valid parent vectors
```

## Tips and Best Practices
- **Interpolation**: Always enable `timepointInterpolation = TRUE` (default) for smoother, more biologically plausible dolphin plots, especially when new clones emerge between measured points.
- **Layout**: Use `pos = "bottom"` in `dolphinPlot` for a stacked layout, or `pos = "center"` for a symmetric "river" look.
- **Interactive GUI**: For exploratory analysis, call `clevRvisShiny()` to launch the interactive web interface.
- **Annotations**: Add custom labels to plots by passing a data frame with `x`, `y`, `lab`, and `col` columns to the `annotations` argument.

## Reference documentation
- [clevRvis Vignette](./references/clevRvis.md)
- [clevRvis R Markdown](./references/clevRvis.Rmd)