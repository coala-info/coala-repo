---
name: bioconductor-seqcombo
description: This tool visualizes genetic reassortment events by creating hybrid plots that illustrate the flow of gene segments between viral strains. Use when user asks to create reassortment diagrams, visualize viral evolution, or generate publication-quality hybrid plots for influenza A viruses.
homepage: https://bioconductor.org/packages/release/bioc/html/seqcombo.html
---


# bioconductor-seqcombo

name: bioconductor-seqcombo
description: Visualizing genetic reassortment events, particularly for influenza A viruses. Use this skill to create publication-quality hybrid plots (reassortment diagrams) that illustrate the flow of gene segments between different viral strains over time or space.

# bioconductor-seqcombo

## Overview

The `seqcombo` package is designed to visualize genetic reassortment, a process where different viral strains exchange genetic material. It provides the `hybrid_plot` function, which automatically generates diagrams that were previously drawn manually. These diagrams represent viruses as hexagons, with internal segments colored to represent their genetic origin, and arrows (flows) indicating the evolutionary relationships between strains.

## Typical Workflow

### 1. Data Preparation
The package requires two main `tibble` or `data.frame` objects:

**Virus Information (`virus_info`):**
- `id`: Unique identifier for each virus.
- `x`, `y`: Coordinates for plotting (often representing time/year and a categorical or spatial axis).
- `segment_color`: A list column where each element is a vector of colors representing the origin of each gene segment (e.g., 8 segments for Influenza A).
- `label` (optional): Text or emoji to display.
- `label_position` (optional): Position of the label ('left', 'right', 'below', 'upper').
- `virus_size` (optional): Numeric value to scale the hexagon size.

**Flow Information (`flow_info`):**
- `from`: The `id` of the source virus.
- `to`: The `id` of the recipient virus.

### 2. Basic Plotting
Use `hybrid_plot` to generate the visualization:

```r
library(seqcombo)
library(tibble)

# Example plot
hybrid_plot(virus_info, flow_info)
```

### 3. Customizing Appearance
- **Colors:** Use `v_color` for the hexagon border and `v_fill` for the background. These can be mapped to variables using tilde notation (e.g., `v_color = ~Host`).
- **Aspect Ratio:** Use `asp` to adjust the shape of the hexagons (e.g., `asp = 2` for tall/thin).
- **Layouts:** If coordinates are unknown, use `set_layout(virus_info, flow_info, layout = "layout.kamada.kawai")` to automatically calculate positions using `igraph` algorithms.
- **Emojis:** Set `parse = 'emoji'` in `hybrid_plot` to render emoji labels (requires appropriate system fonts).

### 4. Refining with ggplot2
Since `hybrid_plot` returns a `ggplot` object, you can extend it with standard `ggplot2` functions:

```r
library(ggplot2)

hybrid_plot(virus_info, flow_info, v_color = ~Host) +
    scale_color_manual(values = my_colors) +
    theme_minimal() +
    labs(title = "Viral Reassortment Map")
```

## Tips and Best Practices
- **Segment Consistency:** Ensure the `segment_color` vectors have a consistent length across all viruses in your dataset to maintain a uniform hexagon appearance.
- **Coordinate Mapping:** Using years for the `x` axis is a standard way to show temporal evolution.
- **Layering:** Use `scale_y_reverse()` or `scale_x_reverse()` if you need to flip the orientation of the reassortment flow (e.g., for top-down diagrams).

## Reference documentation
- [seqcombo for visualizing genetic reassortment](./references/seqcombo.md)