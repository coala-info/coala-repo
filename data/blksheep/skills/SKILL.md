---
name: blksheep
description: blksheep (BlackSheep) is a specialized tool for detecting differential outliers in high-dimensional data.
homepage: https://github.com/ruggleslab/blackSheep/
---

# blksheep

## Overview
blksheep (BlackSheep) is a specialized tool for detecting differential outliers in high-dimensional data. While standard differential expression tools focus on shifts in the mean, blksheep identifies features that are "extreme" in a subset of samples. This is particularly useful in cancer proteogenomics to find hyper-phosphorylated sites or over-expressed proteins that characterize specific patient subgroups. The tool provides a complete workflow from data binarization and outlier counting to statistical enrichment testing and visualization.

## Installation
The package can be installed via conda or pip:
```bash
conda install -c bioconda blksheep
# OR
pip install blksheep
```

## Command Line Interface (CLI) Patterns

### 1. Full Pipeline (deva)
The `deva` command runs the entire workflow (outlier detection, comparison, and visualization) in one step.
```bash
blacksheep deva values.csv annotations.tsv --output_prefix my_analysis \
  --write_outlier_table \
  --write_comparison_summaries \
  --make_heatmaps \
  --fdr 0.05
```

### 2. Step-by-Step Workflow
For more control, execute the components individually:

**Step A: Binarize Annotations**
Converts multi-class categorical metadata into binary (0/1) columns.
```bash
blacksheep binarize annotations.tsv --output_prefix annotations_bin
```
*Tip: Ensure the input table only contains categorical columns you want binarized to avoid creating an unwieldy table.*

**Step B: Create Outlier Table**
Converts raw values into a table of outlier counts based on Interquartile Range (IQR).
```bash
blacksheep outliers_table values.tsv --output_prefix outliers --iqrs 1.5 --up_or_down up
```
*   `--iqrs`: Number of IQRs from the median to define an outlier (default 1.5).
*   `--up_or_down`: Choose `up` for over-expression/hyper-phosphorylation or `down` for under-expression.

**Step C: Compare Groups**
Performs statistical tests to find features enriched for outliers in specific groups.
```bash
blacksheep compare_groups outliers_table.tsv annotations_bin.tsv --output_prefix results --frac_filter 0.3
```
*   `--frac_filter`: Minimum fraction of samples in a group that must have an outlier for the feature to be considered (default 0.3). This prevents single-sample outliers from driving false positives.

**Step D: Visualize Results**
Generates heatmaps for significant findings.
```bash
blacksheep visualize comparison_qvalues.csv annotations.tsv visualization_table.csv comparison_name
```

## Expert Tips and Best Practices
*   **Site-to-Gene Aggregation**: If your data contains site-level information (e.g., `ATM-S365`), use the `--ind_sep` flag (default `-`) to allow blksheep to aggregate outliers to the gene level. Use `--do_not_aggregate` if you wish to keep sites separate.
*   **Handling Missing Values**: blksheep propagates null values during binarization. Ensure your input `values` file is properly pre-processed, as extreme missingness can affect median/IQR calculations.
*   **Fraction Filter**: If you have very small groups (e.g., n=3), you may need to lower the `--frac_filter` from the default 0.3 to ensure you don't filter out all potentially interesting features.
*   **Visualization Colors**: Use `--red_or_blue` to match the biological context (typically `red` for "up" outliers and `blue` for "down" outliers).

## Reference documentation
- [BlackSheep GitHub Repository](./references/github_com_ruggleslab_blackSheep.md)
- [Bioconda blksheep Overview](./references/anaconda_org_channels_bioconda_packages_blksheep_overview.md)