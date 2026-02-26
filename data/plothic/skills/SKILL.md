---
name: plothic
description: plothic generates high-quality heatmaps for visualizing Hi-C interaction data and genome scaffolding accuracy. Use when user asks to visualize .hic or HiCPro files, generate contact heatmaps, or verify genome assembly quality.
homepage: https://github.com/Jwindler/PlotHiC
---


# plothic

## Overview
plothic is a specialized Python tool designed for generating high-quality heatmaps of Hi-C interaction data. It is primarily used by bioinformaticians to visualize chromosome-level interactions and verify the accuracy of genome scaffolding. The tool provides flexibility in chromosome ordering, color mapping, and resolution selection, making it an essential utility for genome assembly quality control.

## Installation
Ensure you are using Python 3.10 or higher.
```bash
pip install plothic
# OR
conda install -c bioconda plothic
```

## Core CLI Patterns

### 1. Visualizing .hic Files (Juicer/3D-DNA)
To plot a heatmap from a `.hic` file, you must provide a chromosome length file (`chr.txt`). This file should contain three tab-separated columns: `name`, `length` (as defined in Juicebox), and `index` (for ordering).

```bash
# Basic visualization at 100kb resolution
plothic -hic genome.hic -chr chr.txt -r 100000

# Use custom chromosome ordering based on the index column
plothic -hic genome.hic -chr chr.txt -r 100000 --order

# Visualize specific split regions
plothic -hic genome.hic -chr chr.txt -r 100000 --hic-split split.txt
```

### 2. Visualizing HiCPro Output
HiCPro format requires both the matrix file and the absolute BED file.

```bash
# Basic HiCPro visualization
plothic -matrix sample.matrix --abs-bed sample_abs.bed -format png -cmap viridis

# Adjusting color intensity and adding a genome title
plothic -matrix sample.matrix --abs-bed sample_abs.bed --bar-max 10000 -g "MyGenome"

# Applying a specific chromosome order
plothic -matrix sample.matrix --abs-bed sample_abs.bed --abs-order order.txt
```

## Expert Tips and Best Practices

- **Color Scaling**: If the heatmap appears too "washed out" or too dark, use the `--bar-max` parameter to adjust the maximum contact value shown on the color bar. This is the most effective way to improve visual contrast.
- **Chromosome Lengths**: When using `.hic` files, ensure the lengths in your `chr.txt` match the lengths reported in Juicebox/Juicer, which may differ from the actual base pair length of the FASTA sequence.
- **Color Maps**: The default is `YlOrRd`. You can use any standard Matplotlib colormap (e.g., `viridis`, `magma`, `inferno`) via the `-cmap` flag.
- **Resolution Selection**: The `-r` parameter is critical for performance. For whole-genome views, 100kb or 500kb is usually sufficient. Higher resolutions (e.g., 5kb or 10kb) should be reserved for specific split-view plots to avoid excessive memory usage.
- **Split Views**: Use `--hic-split` or `--bed-split` when you need to focus on specific genomic regions or when the whole-genome matrix is too large to render clearly in a single image.

## Reference documentation
- [PlotHiC GitHub Repository](./references/github_com_Jwindler_PlotHiC.md)
- [PlotHiC Wiki](./references/github_com_Jwindler_PlotHiC_wiki.md)