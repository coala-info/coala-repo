---
name: bioconductor-ggcyto
description: This tool provides specialized visualization of flow cytometry data using ggplot2 syntax. Use when user asks to create publication-quality plots for cytometry data structures, visualize gating hierarchies, apply flow-specific transformations, or add population statistics to plots.
homepage: https://bioconductor.org/packages/release/bioc/html/ggcyto.html
---

# bioconductor-ggcyto

name: bioconductor-ggcyto
description: Specialized visualization of cytometry data using ggplot2 syntax. Use this skill when you need to create publication-quality plots for flow cytometry data structures (flowFrame, flowSet, GatingHierarchy, GatingSet). It supports automated gating visualization, in-line transformations (logicle, biexponential), and complex layouts for gating hierarchies.

## Overview

The `ggcyto` package extends `ggplot2` to handle flow cytometry data objects. It provides three levels of interface: `autoplot` (quick, automated), `ggcyto` (medium flexibility, cytometry-specific), and `ggplot` (low-level, maximum customization). It simplifies the plotting of gates, population statistics, and axis transformations specific to flow data.

## Core Workflows

### 1. Quick Visualization with autoplot
Use `autoplot` for rapid data exploration. It automatically chooses geoms based on the number of dimensions.

```r
library(ggcyto)

# Plot a flowSet (1D density or 2D hex)
autoplot(fs, x = "CD4")
autoplot(fs, x = "CD4", y = "CD8", bins = 64)

# Plot a GatingSet with specific gates
autoplot(gs, c("CD3", "CD19"))
```

### 2. Flexible Plotting with ggcyto
The `ggcyto` constructor allows for more control while still handling cytometry-specific logic like marker/channel matching.

```r
# Initialize plot for a specific population (subset)
p <- ggcyto(gs, aes(x = CD4, y = CD8), subset = "CD3+") + 
     geom_hex(bins = 64)

# Add gates and statistics
p + geom_gate("CD4") + geom_stats()

# Apply instrument limits and marker labels
p + ggcyto_par_set(limits = "instrument") + labs_cyto("marker")
```

### 3. Transformations and Scales
`ggcyto` provides specialized scales for flow data. Use `axis_x_inverse_trans()` to display raw values on a transformed axis.

```r
p <- autoplot(fr, "FL1-H")
p + scale_x_logicle() # Logicle scale
p + scale_x_flowJo_biexp() # FlowJo-style biexponential
p + axis_x_inverse_trans() # Show raw values on labels
```

### 4. Complex Layouts
For `GatingHierarchy` objects, use `autoplot` to visualize the entire gating tree or specific nodes.

```r
gh <- gs[[1]]
nodes <- gs_get_pop_paths(gh, path = "auto")[3:6]
p <- autoplot(gh, nodes)

# Arrange multiple plots
gt <- ggcyto_arrange(p, nrow = 1)
plot(gt)
```

## Key Functions and Tips

- **`geom_gate()`**: Automatically renders rectangle, polygon, or ellipsoid gates. If no gate is provided, it attempts to find the gate associated with the current subset.
- **`geom_stats()`**: Adds population percentages or counts. Use `type = "count"` for absolute numbers.
- **`geom_overlay()`**: Overlays a different population on the current plot (e.g., overlaying "CD8" events on a "CD3" plot).
- **`as.ggplot()`**: Converts a `ggcyto` object to a standard `ggplot` object. This is necessary if you want to use standard ggplot2 features that are not explicitly supported by the `ggcyto` wrapper.
- **`ggcyto_par_set()`**: A unified way to set limits, facets, and themes.

## Reference documentation
- [Top features of ggcyto](./references/Top_features_of_ggcyto.md)
- [Quick plot for cytometry data](./references/autoplot.md)
- [Visualize GatingSet with ggcyto](./references/ggcyto.GatingSet.md)
- [Visualize flowSet with ggcyto](./references/ggcyto.flowSet.md)