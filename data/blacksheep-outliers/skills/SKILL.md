---
name: blacksheep-outliers
description: BlackSheep performs differential extreme-value analysis to identify features with outlier signals in specific sample subsets. Use when user asks to binarize metadata, call outliers based on interquartile ranges, or compare groups to find enrichment of extreme biological signals.
homepage: https://github.com/ruggleslab/blackSheep/
metadata:
  docker_image: "quay.io/biocontainers/blacksheep-outliers:0.0.8--py_0"
---

# blacksheep-outliers

## Overview
BlackSheep is a specialized tool for "differential extreme-value analysis." Unlike standard differential expression tools that compare average values across groups, BlackSheep identifies features (like proteins or genes) that show extreme signals in a subset of samples. This is particularly useful in clinical cohorts where a biological signal might be present in only a fraction of the "diseased" group. The tool automates the process of defining outliers based on interquartile ranges (IQR), binarizing metadata for comparison, and performing statistical tests to find enrichment of these outliers in specific groups.

## Core CLI Workflows

### 1. The Full Pipeline (deva)
The most efficient way to run a complete analysis is using the `deva` command, which handles outlier calling and group comparison in one step.

```bash
blacksheep deva values.csv annotations_binarized.tsv \
    --output_prefix my_analysis \
    --write_outlier_table \
    --write_comparison_summaries \
    --make_heatmaps \
    --fdr 0.05
```

### 2. Preparing Annotations (binarize)
BlackSheep requires binary comparisons (e.g., Mutated vs. Wildtype). If your annotation file has columns with multiple categories, use the `binarize` command first.

```bash
blacksheep binarize annotations.tsv --output_prefix annotations_ready
```
*   **Tip**: Avoid including non-categorical columns (like age or weight) in this step, as it will create a column for every unique value.

### 3. Generating Outlier Tables
To call outliers without running the full comparison, use `outliers_table`.

```bash
blacksheep outliers_table values.tsv \
    --output_prefix outliers_up \
    --iqrs 1.5 \
    --up_or_down up
```
*   **Parameters**:
    *   `--iqrs`: Number of IQRs from the median to define an outlier. Default is 1.5.
    *   `--up_or_down`: Choose `up` for over-expression/phosphorylation or `down` for loss of signal.

### 4. Comparing Groups
If you already have an outlier count table, use `compare_groups` to perform the statistical analysis.

```bash
blacksheep compare_groups outliers_table.tsv annotations.tsv \
    --frac_filter 0.3 \
    --fdr 0.05 \
    --write_gene_list \
    --make_heatmaps
```

## Expert Tips and Best Practices

*   **Fraction Filtering**: Use `--frac_filter` (default 0.3) to ensure that a significant result is driven by a minimum percentage of samples in the group. This prevents a single extreme outlier in one sample from creating a false positive.
*   **Site-Level Data**: If working with phosphoproteomics where labels are `Gene-Site` (e.g., `ATM-S365`), use the `--ind_sep` flag to specify the delimiter. BlackSheep can aggregate these sites to the gene level by default.
*   **Visualization**: When using `--make_heatmaps`, you can customize the color scheme using `--red_or_blue`. Use `red` for "up" outliers and `blue` for "down" outliers to follow standard biological conventions.
*   **Missing Values**: BlackSheep handles missing data by propagating nulls through the binarization and comparison steps, ensuring that missing values do not count as "non-outliers."

## Reference documentation
- [BlackSheep GitHub README](./references/github_com_ruggleslab_blackSheep.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_blacksheep-outliers_overview.md)