---
name: nanoplotter
description: Nanoplotter is a Python library used to create high-quality visualizations and statistical plots for Oxford Nanopore sequencing data. Use when user asks to visualize read length distributions, create bivariate scatter plots of sequencing metrics, generate temporal throughput plots, or produce spatial heatmaps of flowcell activity.
homepage: https://github.com/wdecoster/nanoplotter
metadata:
  docker_image: "quay.io/biocontainers/nanoplotter:1.10.0--py_0"
---

# nanoplotter

## Overview

nanoplotter is a specialized Python library designed for the visualization of Oxford Nanopore Technologies (ONT) sequencing data. It serves as the underlying plotting engine for the NanoPack suite (including NanoPlot and NanoComp). The tool allows for the creation of high-quality, publication-ready graphics such as N50 bar charts, bivariate scatter plots with marginal distributions (hexbins or KDE), and spatial heatmaps that represent activity across a flowcell.

## Functional Usage and Best Practices

### Core Plotting Functions

The library is primarily used as a Python module. Below are the primary functions and their expected inputs:

*   **Length Distributions (`lengthPlots`)**: Generates histograms and density curves for read lengths.
    *   *Parameters*: `array` (list of lengths), `name` (label), `path` (output prefix), `n50` (calculated N50 value), `color`, `format`.
    *   *Tip*: Set `log=True` when dealing with highly variable read lengths to better visualize the distribution.

*   **Bivariate Analysis (`scatter`)**: Creates plots comparing two variables (e.g., Read Length vs. Basecall Quality).
    *   *Parameters*: `x`, `y`, `names` (axis labels), `path`, `color`, `format`, `plots` (type of plot: 'dot', 'hex', or 'kde').
    *   *Tip*: Use `hex` or `kde` for large datasets to avoid overplotting issues common with standard scatter (dot) plots.

*   **Temporal Analysis (`timePlots`)**: Evaluates throughput and quality over the duration of a sequencing run.
    *   *Parameters*: `df` (a pandas DataFrame containing sequencing metadata), `path`, `color`, `format`.
    *   *Requirement*: The DataFrame must contain time-stamped information for each read.

*   **Flowcell Spatial Heatmaps (`spatialHeatmap`)**: Visualizes the number of reads per channel to identify physical issues on the flowcell.
    *   *Workflow*: First generate the layout using `makeLayout()`, then pass the resulting array to `spatialHeatmap(array, title, path, color, format)`.

### Validation and Configuration

Before executing plotting commands, use the built-in validation functions to prevent runtime errors:

*   **Color Validation**: Use `checkvalidColor(color)` to ensure the string is a valid matplotlib color.
*   **Format Validation**: Use `checkvalidFormat(format)` to verify the output extension (e.g., 'png', 'pdf', 'svg', 'html').

### Expert Tips

1.  **Integration with NanoPack**: Since nanoplotter is the engine for NanoPlot, ensure your input data (arrays or DataFrames) is pre-processed using `nanoget` or similar tools to match the expected schemas.
2.  **Output Management**: The `path` argument in most functions acts as a prefix. Ensure the directory exists before calling the function, as the library may not create missing directories automatically.
3.  **Memory Efficiency**: For extremely large datasets, prefer `hex` plots over `kde` in the `scatter` function, as Kernel Density Estimation is computationally expensive and memory-intensive.

## Reference documentation

- [nanoplotter - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_nanoplotter_overview.md)
- [wdecoster/nanoplotter: Plotting functions of Oxford Nanopore sequencing data](./references/github_com_wdecoster_nanoplotter.md)