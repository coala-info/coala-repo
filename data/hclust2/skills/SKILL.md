---
name: hclust2
description: hclust2 generates publication-quality heatmaps and performs hierarchical clustering on matrix-like data. Use when user asks to create heatmaps, perform hierarchical clustering on rows and columns, or visualize taxonomic and functional profiles.
homepage: https://bitbucket.org/nsegata/hclust2
---


# hclust2

## Overview
hclust2 is a specialized tool designed to produce publication-quality heatmaps from matrix-like data. It automates the process of hierarchical clustering for both rows and columns and provides extensive customization for visual aesthetics, including color schemes, labels, and scaling. It is particularly effective for visualizing taxonomic or functional profiles where identifying patterns across samples is the primary goal.

## Command Line Usage
The basic syntax for hclust2 involves an input file (typically a tab-separated matrix) and an output image file (PNG, PDF, or SVG).

### Basic Heatmap Generation
```bash
hclust2 -i input_abundance.txt -o heatmap.png
```

### Common Visualization Patterns
- **Log Transformation**: Essential for high-dynamic range abundance data.
  ```bash
  hclust2 -i input.txt -o heatmap.pdf --log_scale
  ```
- **Adjusting Clustering Metrics**: Change how similarity is calculated (default is Euclidean).
  ```bash
  hclust2 -i input.txt -o heatmap.png --f_dist_f braycurtis --s_dist_f correlation
  ```
  *Note: `f_dist_f` refers to feature (row) distance; `s_dist_f` refers to sample (column) distance.*

- **Customizing Dimensions and Resolution**:
  ```bash
  hclust2 -i input.txt -o heatmap.png --width 10 --height 8 --dpi 300
  ```

## Expert Tips and Best Practices
- **Data Pre-processing**: Ensure your input file is a tab-separated file with a header row for sample names and a first column for feature names (e.g., species or gene IDs).
- **Color Schemes**: Use the `--colormap` flag to select different color palettes (e.g., `RdYlGn`, `Blues`, `jet`). For publication, divergent scales like `RdBu` are often preferred.
- **Label Management**: If the heatmap is too crowded, use `--max_f8_label_len` to truncate long feature names or `--no_slables` / `--no_flables` to hide sample or feature labels entirely.
- **Clustering Methods**: You can specify the linkage method using `--f_method` and `--s_method` (e.g., `complete`, `average`, `weighted`).
- **Legend Control**: Use `--legend_file` to output the color scale legend to a separate file if the main plot area needs to be maximized.

## Reference documentation
- [hclust2 Overview](./references/anaconda_org_channels_bioconda_packages_hclust2_overview.md)