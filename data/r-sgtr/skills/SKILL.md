---
name: r-sgtr
description: This tool visualizes population genomics results from RADSex and PSASS workflows using Manhattan, Circos, and region-specific plots in R. Use when user asks to create Manhattan plots, generate Circos visualizations, plot marker distributions, or visualize specific genomic regions.
homepage: https://cran.r-project.org/web/packages/sgtr/index.html
---


# r-sgtr

name: r-sgtr
description: Visualizing population genomics results in R using the sgtr package. Use this skill when you need to create Manhattan plots, Circos plots, or region-specific visualizations for genomic data, specifically results from RADSex and PSASS workflows.

## Overview
The `sgtr` package provides low-level and high-level functions to visualize results from population genomics analyses. It is part of the Sex Genomics Toolkit and is designed to handle outputs from tools like RADSex and PSASS, offering specialized plots for marker distribution, depth, and genomic mapping.

## Installation
Install the package from CRAN or GitHub:
```R
# From CRAN
install.packages("sgtr")

# From GitHub (development version)
# install.packages("devtools")
# devtools::install_github("SexGenomicsToolkit/sgtr")
```

## Core Workflows

### RADSex Visualizations
RADSex results are visualized using functions tailored to specific subcommands:

- **Marker Distribution**: Use `radsex_distrib()` to create a tile plot showing how markers are distributed between groups (e.g., males vs. females).
- **Depth Heatmaps**: Use `radsex_markers_depth()` to visualize marker depths with optional clustering.
- **Whole Genome Mapping**:
    - `radsex_map_manhattan()`: Standard Manhattan plot for the entire genome.
    - `radsex_map_circos()`: Circular genome visualization.
- **Region Specifics**: Use `radsex_map_region()` for a linear plot of a specific genomic window.
- **Sample Metrics**: Use `radsex_depth()` for boxplots/barplots of depth metrics and `radsex_freq()` for marker frequency distributions.

### PSASS and General Genomic Data
For PSASS results or general genomic metric files, use the generic plotting functions:

- **Manhattan Plot**: `plot_manhattan(data)`
- **Circos Plot**: `plot_circos(data)`
- **Region Plot**: `plot_region(data, chrom, start, end)`

## Usage Tips
- **Help Access**: Use `?function_name` (e.g., `?radsex_distrib`) to view detailed parameter descriptions and data format requirements.
- **Data Input**: Most high-level functions expect the output files directly from RADSex or PSASS. Ensure your data frames have the expected column headers (typically Chromosome, Position, and the metric of interest).
- **Customization**: Since `sgtr` generates plots using base R or ggplot2-style logic, you can often pass standard graphical parameters to adjust colors, labels, and scales.

## Reference documentation
- [sgtr README](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)