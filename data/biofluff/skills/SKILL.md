---
name: biofluff
description: Biofluff (also known as `fluff`) is a specialized suite of Python scripts tailored for the visual exploration of Next-Generation Sequencing (NGS) experiments.
homepage: https://github.com/simonvh/fluff
---

# biofluff

## Overview
Biofluff (also known as `fluff`) is a specialized suite of Python scripts tailored for the visual exploration of Next-Generation Sequencing (NGS) experiments. It excels at identifying patterns in genomic data through clustering and providing high-quality graphical representations. Use this skill when you need to generate clustered heatmaps of epigenetic marks, visualize signal profiles across genomic features, or create summary plots for groups of genomic regions.

## Installation and Setup
The recommended way to install biofluff is via Conda using the bioconda channel:

```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install biofluff
```

Note: Biofluff version 3.0+ requires Python 3.6 or higher.

## Core CLI Commands and Patterns

### 1. Generating Heatmaps (`fluff heatmap`)
Used to create clustered heatmaps from multiple datasets.
*   **Basic Pattern**: `fluff heatmap -f <features.bed> -d <file1.bam file2.bam ...> -o <output_prefix>`
*   **Clustering**: By default, it uses k-means clustering. You can specify the number of clusters with `-k`.
*   **Color Control**: Use the `--no-colorbar` flag to suppress colorbars for individual plots if the figure becomes too crowded.
*   **Expert Tip**: If you encounter issues with cluster labeling when merging mirrored clusters, ensure your input BED file is properly sorted and formatted.

### 2. Signal Profiling (`fluff profile`)
Used to visualize the distribution of sequencing reads over specific genomic regions.
*   **Basic Pattern**: `fluff profile -f <features.bed> -d <data.bam> -o <output_prefix>`
*   **Group Naming**: When working with multiple groups, ensure your feature files are organized to allow for clear group labeling in the resulting profiles.

### 3. Bandplots (`fluff bandplot`)
Used to visualize the mean signal and variance (as a "band") for clusters of genomic features.
*   **Usage**: Typically used after clustering to summarize the behavior of specific groups identified in the heatmap analysis.

## Best Practices
*   **Data Preparation**: Ensure your BAM files are indexed (`.bai` files present) for efficient data access.
*   **Clustering Stability**: Since version 3.0, clustering is performed via `scikit-learn`. For reproducible clusters, check if your specific version supports setting a random seed.
*   **Visualization**: For publication, use the PDF output format to maintain vector graphics quality.
*   **Compatibility**: If using `matplotlib >= 3.7`, be aware of potential compatibility issues with arrow rendering; check for the latest patches if arrows do not appear correctly in profiles.

## Reference documentation
- [github_com_simonvh_fluff.md](./references/github_com_simonvh_fluff.md)
- [anaconda_org_channels_bioconda_packages_biofluff_overview.md](./references/anaconda_org_channels_bioconda_packages_biofluff_overview.md)