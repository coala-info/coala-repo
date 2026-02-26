---
name: intervene
description: Intervene automates the identification of overlaps between genomic datasets and generates publication-quality visualizations such as Venn diagrams, UpSet plots, and pairwise heatmaps. Use when user asks to find intersections between genomic regions, compare multiple gene sets, or visualize overlaps across several experimental conditions.
homepage: https://github.com/asntech/intervene
---


# intervene

## Overview

Intervene is a computational tool that automates the process of finding overlaps between genomic datasets and generating publication-quality visualizations. It acts as a high-level wrapper around BedTools for interval logic and R for graphical output. Use this skill to quickly compare ChIP-seq peaks, differentially expressed gene sets, or any interval-based genomic data to identify unique and shared elements across multiple experimental conditions.

## Command Line Usage

Intervene is organized into three primary subcommands based on the desired visualization and the number of input sets.

### 1. Venn Diagrams (`venn`)
Use this for 2 to 6 sets. Beyond 6 sets, the intersections become too complex for a Venn representation.

```bash
# Basic 3-way Venn diagram for BED files
intervene venn -i path/to/file1.bed path/to/file2.bed path/to/file3.bed

# Using wildcards and custom labels
intervene venn -i *.bed --names=A,B,C,D --output results_venn
```

### 2. UpSet Plots (`upset`)
Use this for more than 6 sets or when you need to see the frequency of specific intersection combinations clearly.

```bash
# Generate an UpSet plot for a large number of sets
intervene upset -i data/*.bed --save-overlaps
```

### 3. Pairwise Heatmaps (`pairwise`)
Use this to compare a large number of datasets (N vs N) to identify clusters of similarity.

```bash
# Compute pairwise intersections and show a heatmap
intervene pairwise -i data/*.bed --htype jaccard
```

## Key Parameters and Best Practices

*   **Input Types**: By default, Intervene assumes genomic regions. If you are comparing simple text lists (e.g., gene symbols), you must specify `--type list`.
*   **Naming Sets**: Use the `--names` flag to provide comma-separated labels. If omitted, Intervene uses the filenames, which can clutter the plots.
*   **Saving Data**: Always use the `--save-overlaps` flag if you need to extract the actual genomic coordinates or gene names belonging to specific intersection groups for downstream analysis.
*   **Heatmap Metrics**: In `pairwise` mode, use `--htype` to switch between different similarity metrics:
    *   `count`: Number of overlapping regions.
    *   `jaccard`: Jaccard statistic (intersection over union).
    *   `frac`: Fraction of overlap.
*   **Testing**: If you are unsure about the installation or environment, run `intervene <subcommand> --test` to generate example plots using built-in data.

## Expert Tips

*   **BedTools Dependency**: Intervene requires `bedtools` to be in your system PATH. If intersections fail, verify the installation with `bedtools --version`.
*   **R Dependencies**: Visualizations are generated via R. Ensure the `UpSetR`, `corrplot`, and `Cairo` packages are installed in your R environment to avoid plotting errors.
*   **Large Datasets**: For `pairwise` mode with hundreds of files, the process can be memory-intensive. Consider filtering your BED files to include only high-confidence peaks before running Intervene.

## Reference documentation
- [Intervene GitHub Repository](./references/github_com_asntech_intervene.md)
- [Bioconda Intervene Overview](./references/anaconda_org_channels_bioconda_packages_intervene_overview.md)