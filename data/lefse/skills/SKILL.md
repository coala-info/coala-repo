---
name: lefse
description: LEfSe identifies statistically significant biomarkers and estimates their effect sizes in biological datasets using Kruskal-Wallis, Wilcoxon rank-sum, and Linear Discriminant Analysis tests. Use when user asks to format microbiome data, identify differentially abundant features between classes, calculate LDA scores, or generate cladograms and LDA bar plots.
homepage: https://github.com/SegataLab/lefse
metadata:
  docker_image: "quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0"
---

# lefse

## Overview

LEfSe (Linear Discriminant Analysis Effect Size) is a specialized algorithm for discovering biomarkers in biological datasets, most commonly used in microbiome research. It identifies features that are statistically different among biological classes and performs additional tests to ensure these differences are consistent across provided subclasses. The tool follows a three-step statistical process:
1. **Kruskal-Wallis test**: Identifies features with significant differential abundance among classes.
2. **Wilcoxon rank-sum test**: Ensures biological consistency by checking if the trend is maintained across subclasses.
3. **LDA (Linear Discriminant Analysis)**: Estimates the effect size of each differentially abundant feature.

## Core CLI Workflow

The standard LEfSe pipeline consists of four primary scripts executed in sequence.

### 1. Data Formatting
Convert a tabular text file (rows as features, columns as samples) into the LEfSe internal format.
```bash
lefse_format_input.py input_data.txt output.in -c 1 -s 2 -u 3 -o 1000000
```
*   `-c [1-N]`: Row number for the **Class** (e.g., Disease vs. Healthy).
*   `-s [1-N]`: Row number for the **Subclass** (e.g., Male vs. Female within classes). Optional.
*   `-u [1-N]`: Row number for the **Subject** (Sample ID).
*   `-o 1000000`: Normalization value (scales data to 1M; recommended for relative abundance).

### 2. Statistical Analysis
Run the core LEfSe algorithm on the formatted file.
```bash
run_lefse.py output.in results.res -l 2.0
```
*   `-l`: LDA score threshold (default is 2.0). Higher values (e.g., 3.0 or 4.0) yield more stringent biomarker selection.
*   `-a`: Alpha value for the Kruskal-Wallis test (default 0.05).
*   `-w`: Alpha value for the Wilcoxon test (default 0.05).

### 3. Visualization: LDA Bar Plot
Generate a horizontal bar chart showing the LDA scores for significant features.
```bash
lefse_plot_res.py results.res plot_bars.png --format png --dpi 300
```
*   `--feature_font_size`: Adjust if taxon names are overlapping.
*   `--width`: Adjust the width of the output image.

### 4. Visualization: Cladogram
Generate a circular hierarchical tree (cladogram) representing the taxonomic distribution of biomarkers.
```bash
lefse_plot_cladogram.py results.res cladogram.pdf --format pdf
```
*   `--clade_sep`: Adjust the distance between clades.
*   `--label_font_size`: Adjust for readability of taxonomic levels.

## Expert Tips and Best Practices

*   **Taxonomic Hierarchy**: Ensure feature names use a consistent separator (usually `|` or `.`) to represent hierarchy (e.g., `k__Bacteria|p__Firmicutes|c__Clostridia`). This is required for `lefse_plot_cladogram.py` to correctly map the tree.
*   **Subclass Importance**: Use the subclass parameter (`-s`) to avoid "false" biomarkers that are driven by a confounding factor (like gender or age) rather than the primary class.
*   **Handling Small Sample Sizes**: If the number of samples is very small, the Wilcoxon test may be too stringent. You can skip the subclass check by not providing the `-s` argument during formatting.
*   **Output Formats**: For publication-quality figures, always output to `.pdf` or `.svg` to allow for vector-based editing of colors and labels.
*   **Biom Compatibility**: If working with BIOM files, use `lefsebiom` utilities to convert data before formatting.

## Reference documentation

- [LEfSe GitHub Repository](./references/github_com_SegataLab_lefse.md)
- [Bioconda LEfSe Package Overview](./references/anaconda_org_channels_bioconda_packages_lefse_overview.md)